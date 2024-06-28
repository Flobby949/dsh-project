package com.nh.dsh.client.controller;

import com.nh.dsh.client.service.CommonService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author Flobby
 */
@Slf4j
@Tag(name = "基础服务")
@RestController
@RequestMapping("/common")
@AllArgsConstructor
public class CommonController {
    private final CommonService commonService;

    @PostMapping("/wxLogin")
    public String wxLogin(@RequestParam String code) {
        log.info("wxLogin: {}", code);
        return commonService.wxLogin(code);
    }
}