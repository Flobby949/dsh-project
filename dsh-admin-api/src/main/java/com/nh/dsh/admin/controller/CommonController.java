package com.nh.dsh.admin.controller;

import com.nh.dsh.admin.common.result.Result;
import com.nh.dsh.admin.utils.MinioUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-18 10:44
 **/

@Tag(name = "基础接口")
@AllArgsConstructor
@RestController
@RequestMapping("/common")
public class CommonController {
    private final MinioUtils minioUtils;

    @PostMapping("upload/img")
    @Operation(summary = "上传文件")
    public Result<Map<String, Object>> uploadFiles(@RequestParam(defaultValue = "dsh") String bucketName,
                                   @RequestParam(name = "file", required = false) MultipartFile[] file) {
        return Result.ok(minioUtils.uploadFile(bucketName, file));
    }
}
