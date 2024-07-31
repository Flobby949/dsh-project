package com.nh.dsh.admin.service.impl;

import cn.hutool.extra.qrcode.QrCodeUtil;
import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.read.listener.PageReadListener;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nh.dsh.admin.common.exception.ServerException;
import com.nh.dsh.admin.common.model.BaseServiceImpl;
import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.mapper.BookExchangeMapper;
import com.nh.dsh.admin.model.dto.BookExchangeDTO;
import com.nh.dsh.admin.model.entity.BookExchangeEntity;
import com.nh.dsh.admin.model.query.BookExchangeQuery;
import com.nh.dsh.admin.service.BookExchangeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
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
 * @create : 2024-06-30 15:38
 **/

@Slf4j
@Service
public class BookExchangeServiceImpl extends BaseServiceImpl<BookExchangeMapper, BookExchangeEntity> implements BookExchangeService {

    @Override
    public PageResult<BookExchangeEntity> page(BookExchangeQuery query) {
        Page<BookExchangeEntity> page = new Page<>(query.getPage(), query.getLimit());
        LambdaQueryWrapper<BookExchangeEntity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(BookExchangeEntity::getBookId, query.getBookId());
        Page<BookExchangeEntity> result = this.page(page, wrapper);
        return new PageResult<>(result.getRecords(), result.getTotal());
    }

    @Override
    public void exchange(Integer id) {
        BookExchangeEntity bookExchange = baseMapper.selectById(id);
        if (bookExchange == null) {
            throw new ServerException("兑换不存在");
        }
        if (bookExchange.getStatus() != 0) {
            throw new ServerException("该资源已被兑换");
        }
        bookExchange.setStatus(1);
        bookExchange.setExchangeTime(new Date());
        baseMapper.updateById(bookExchange);
    }

    @Override
    public void deleteInBatch(List<Integer> ids) {
        baseMapper.deleteBatchIds(ids);
    }

    @Override
    public void bookLinkImport(Integer bookId, MultipartFile file) {
        List<BookExchangeEntity> partialImportList = new ArrayList<>();
        try {
            EasyExcel.read(file.getInputStream(), BookExchangeDTO.class, new PageReadListener<BookExchangeDTO>(dataList -> {
                partialImportList.addAll(dataList.stream().map(item -> {
                    BookExchangeEntity exchange = new BookExchangeEntity();
                    exchange.setBookId(bookId);
                    // 判断url是否是网络链接
                    if (!item.getBookLink().startsWith("http")) {
                        throw new ServerException("资源链接有误");
                    }
                    exchange.setBookLink(item.getBookLink());
                    exchange.setVerifyCode(item.getCardNum());
                    exchange.setStatus(0);
                    return exchange;
                }).toList());
            })).sheet().doRead();
        } catch (IOException e) {
            log.error("导入失败", e);
            throw new ServerException("导入失败");
        }
        this.saveBatch(partialImportList);
    }

    @Override
    public ResponseEntity<byte[]> downloadExchangeQrCode(int bookId) {
        Map<String, byte[]> map = new HashMap<>();
        list(new LambdaQueryWrapper<BookExchangeEntity>().eq(BookExchangeEntity::getBookId, bookId))
                .stream()
                .forEach(item -> {
            try {
                String verifyCode = item.getVerifyCode();
                String link = String.format("http://demo.dianhuiyun.com.cn/dsh-client-h5/#/pages/exchange/exchange?cardNum=%s", verifyCode);
                map.put(verifyCode + ".png", generateQrCode(link));
            } catch (IOException e) {
                log.info("{} 二维码生成失败, {}", item.getVerifyCode(), e.getMessage());
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
