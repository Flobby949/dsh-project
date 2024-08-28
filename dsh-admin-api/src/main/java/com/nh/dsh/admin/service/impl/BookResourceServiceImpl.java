package com.nh.dsh.admin.service.impl;

import cn.hutool.extra.qrcode.QrCodeUtil;
import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.read.listener.PageReadListener;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nh.dsh.admin.common.config.CodeConfig;
import com.nh.dsh.admin.common.exception.ServerException;
import com.nh.dsh.admin.common.model.BaseServiceImpl;
import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.convert.BookResourceConvert;
import com.nh.dsh.admin.mapper.BookMapper;
import com.nh.dsh.admin.mapper.BookResourceMapper;
import com.nh.dsh.admin.model.dto.BookResourceDTO;
import com.nh.dsh.admin.model.dto.ResourceImportDTO;
import com.nh.dsh.admin.model.entity.BookEntity;
import com.nh.dsh.admin.model.entity.BookResourceEntity;
import com.nh.dsh.admin.model.query.BookResourceQuery;
import com.nh.dsh.admin.model.vo.AuditResourceVO;
import com.nh.dsh.admin.model.vo.BookResourceVO;
import com.nh.dsh.admin.security.user.SecurityUser;
import com.nh.dsh.admin.service.BookResourceService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-18 09:49
 **/

@Slf4j
@Service
@AllArgsConstructor
public class BookResourceServiceImpl extends BaseServiceImpl<BookResourceMapper, BookResourceEntity> implements BookResourceService {
    private final BookMapper bookMapper;
    private final CodeConfig codeConfig;

    @Override
    public void save(BookResourceDTO dto) {
        BookResourceEntity bookResource = BookResourceConvert.INSTANCE.convert(dto);
        baseMapper.insert(bookResource);
    }

    @Override
    public void update(BookResourceDTO dto) {
        BookResourceEntity bookResource = BookResourceConvert.INSTANCE.convert(dto);
        baseMapper.updateById(bookResource);
    }

    @Override
    public void deleteInBatch(List<Integer> ids) {
        baseMapper.deleteBatchIds(ids);
    }

    @Override
    public PageResult<BookResourceVO> page(BookResourceQuery query) {
        Page<BookResourceEntity> page = getPage(query);
        LambdaQueryWrapper<BookResourceEntity> wrapper = new LambdaQueryWrapper<BookResourceEntity>()
                .eq(BookResourceEntity::getBookId, query.getBookId())
                .orderByDesc(BookResourceEntity::getCreateTime);
        Page<BookResourceEntity> pageResult = baseMapper.selectPage(page, wrapper);
        List<BookResourceVO> vos = BookResourceConvert.INSTANCE.convertList(pageResult.getRecords());
        vos.forEach(item -> item.setSecret(codeConfig.getSecret()));
        return new PageResult<>(vos, pageResult.getTotal());
    }

    @Override
    public ResponseEntity<byte[]> downloadResourcesQrCode(int bookId) {
        Map<String, byte[]> map = new HashMap<>();
        list(new LambdaQueryWrapper<BookResourceEntity>()
                .eq(BookResourceEntity::getBookId, bookId)
                .eq(BookResourceEntity::getValidStatus, 0)
                .eq(BookResourceEntity::getEnabled, 0)
        )
                .stream()
                .forEach(item -> {
            try {
                map.put(item.getResourceName() + item.getId() + ".png",
                        generateQrCode("http://demo.dianhuiyun.com.cn/dsh-client-h5/#/pages/book/resource?resourceId=" + item.getId() + "&secret=" + codeConfig.getSecret()));
            } catch (IOException e) {
                log.info("{} 二维码生成失败, {}", item.getResourceName(), e.getMessage());
            }
        });
        try {
            byte[] zipBytes = generateZip(map);
            HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=qrcodes.zip");
            return new ResponseEntity<>(zipBytes, headers, HttpStatus.OK);
        } catch (IOException e) {
            log.error("二维码生成失败", e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void importResources(Integer bookId, MultipartFile file) {
        List<BookResourceEntity> partialImportList = new ArrayList<>();
        try {
            EasyExcel.read(file.getInputStream(), ResourceImportDTO.class, new PageReadListener<ResourceImportDTO>(dataList -> {
                partialImportList.addAll(dataList.stream().map(item -> {
                    BookResourceEntity resource = new BookResourceEntity();
                    resource.setBookId(bookId);
                    // 判断url是否是网络链接
                    if (!item.getUrl().startsWith("http")) {
                        throw new ServerException("资源链接有误");
                    }
                    resource.setLink(item.getUrl());
                    resource.setResourceName(item.getDesc());
                    resource.setUserId(SecurityUser.getManagerId());
                    resource.setValidStatus(0);
                    return resource;
                }).toList());
            })).sheet().doRead();
        } catch (IOException e) {
            log.error("导入失败", e);
            throw new ServerException("导入失败");
        }
        this.saveBatch(partialImportList);
    }

    @Override
    public PageResult<AuditResourceVO> auditResourcePage(BookResourceQuery query) {
        Page<BookResourceEntity> page = getPage(query);
        LambdaQueryWrapper<BookResourceEntity> wrapper = new LambdaQueryWrapper<BookResourceEntity>()
                .orderByDesc(BookResourceEntity::getCreateTime);
        baseMapper.selectPage(page, wrapper);
        List<AuditResourceVO> result = page.getRecords().stream().map(item -> {
            AuditResourceVO vo = BookResourceConvert.INSTANCE.convert(item);
            BookEntity bookEntity = bookMapper.selectById(item.getBookId());
            vo.setBookName(bookEntity.getBookName());
            vo.setBookCover(bookEntity.getBookCover());
            vo.setIsChanged(item.getValidStatus());
            return vo;
        }).sorted(Comparator.comparingInt(AuditResourceVO::getIsChanged).reversed()).toList();
        return new PageResult<>(result, page.getTotal());
    }

    @Override
    public void resourceEnabled(BookResourceDTO dto) {
        BookResourceEntity entity = BookResourceConvert.INSTANCE.convert(dto);
        entity.setEnabled(1);
        baseMapper.updateById(entity);
    }

    private byte[] generateQrCode(String resource) throws IOException {
        BufferedImage bufferedImage = QrCodeUtil.generate(resource, 300, 300);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(bufferedImage, "png", baos);
        return baos.toByteArray();
    }

    private byte[] generateZip(Map<String, byte[]> resources) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ZipOutputStream zos = new ZipOutputStream(baos);

        for (Map.Entry<String, byte[]> entry : resources.entrySet()) {
            zos.putNextEntry(new ZipEntry(entry.getKey()));
            zos.write(entry.getValue());
            zos.closeEntry();
        }

        zos.close();
        return baos.toByteArray();
    }
}
