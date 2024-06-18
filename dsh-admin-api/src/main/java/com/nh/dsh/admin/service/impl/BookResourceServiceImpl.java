package com.nh.dsh.admin.service.impl;

import cn.hutool.extra.qrcode.QrCodeUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nh.dsh.admin.common.model.BaseServiceImpl;
import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.convert.BookResourceConvert;
import com.nh.dsh.admin.mapper.BookResourceMapper;
import com.nh.dsh.admin.model.dto.BookResourceDTO;
import com.nh.dsh.admin.model.entity.BookResourceEntity;
import com.nh.dsh.admin.model.query.BookResourceQuery;
import com.nh.dsh.admin.model.vo.BookResourceVO;
import com.nh.dsh.admin.service.BookResourceService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
public class BookResourceServiceImpl extends BaseServiceImpl<BookResourceMapper, BookResourceEntity> implements BookResourceService {

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
        return new PageResult<>(vos, pageResult.getTotal());
    }

    @Override
    public ResponseEntity<byte[]> downloadResourcesQrCode(int bookId) {
        Map<String, byte[]> map = new HashMap<>();
        list(new LambdaQueryWrapper<BookResourceEntity>().eq(BookResourceEntity::getBookId, bookId)).stream().forEach(item -> {
            try {
                map.put(item.getResourceName() + item.getId() + ".png", generateQrCode(item.getLink()));
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
