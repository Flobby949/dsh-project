package com.nh.dsh.admin.service.impl;

import cn.hutool.crypto.SecureUtil;
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
import com.nh.dsh.admin.model.vo.BookExchangeVO;
import com.nh.dsh.admin.service.BookExchangeService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
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
    public PageResult<BookExchangeVO> page(BookExchangeQuery query) {
        Page<BookExchangeEntity> page = new Page<>(query.getPage(), query.getLimit());
        LambdaQueryWrapper<BookExchangeEntity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(BookExchangeEntity::getBookId, query.getBookId());
        Page<BookExchangeEntity> result = this.page(page, wrapper);
        List<BookExchangeVO> resultList = result.getRecords().stream().map(item -> {
            BookExchangeVO exchange = new BookExchangeVO();
            BeanUtils.copyProperties(item, exchange);
            exchange.setQrCodeLink(generateQrCodeLink(item));
            return exchange;
        }).toList();
        return new PageResult<>(resultList, result.getTotal());
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
                String link = generateQrCodeLink(item);
                map.put(item.getId() + ".png", generateQrCode(link));
            } catch (IOException e) {
                log.error("{} 二维码生成失败, {}", item.getId(), e.getMessage());
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
    public void downloadExchangeXlsx(Integer bookId, HttpServletResponse response) {
        LambdaQueryWrapper<BookExchangeEntity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(BookExchangeEntity::getBookId, bookId);
        wrapper.eq(BookExchangeEntity::getStatus, 0);
        List<BookExchangeVO> resultList = list(wrapper).stream().map(item -> {
            BookExchangeVO exchange = new BookExchangeVO();
            BeanUtils.copyProperties(item, exchange);
            exchange.setQrCodeLink(generateQrCodeLink(item));
            return exchange;
        }).toList();

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setCharacterEncoding("utf-8");

        String fileName = URLEncoder.encode("书链兑换表", StandardCharsets.UTF_8).replaceAll("\\+", "%20");
        response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");
        try {
            EasyExcel.write(response.getOutputStream(), BookExchangeVO.class)
                    .sheet("sheet1")
                    .doWrite(resultList);
        } catch (IOException e) {
            log.error("导出失败", e);
            throw new ServerException(e.getMessage());
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

    private String generateQrCodeLink(BookExchangeEntity bookExchange) {
        String cardNum = new SecureUtil()
                .aes("dianhuiyun123456".getBytes())
                .encryptBase64(String.format("%s&%s", bookExchange.getBookLink(), bookExchange.getId()));
        String link = String
                .format("http://demo.dianhuiyun.com.cn/dsh-client-h5/#/pages/exchange/exchange?cardNum=%s", cardNum);
        if (StringUtils.isNotBlank(bookExchange.getVerifyCode())) {
            link += "&verifyCode=" + bookExchange.getVerifyCode();
        }
        return link;
    }

    // public static void main(String[] args) {
    //     System.out.println(new SecureUtil()
    //             .aes("dianhuiyun123456".getBytes())
    //             .encryptBase64("123456"));
    // }
}
