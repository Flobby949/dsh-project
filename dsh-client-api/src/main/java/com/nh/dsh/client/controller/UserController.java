package com.nh.dsh.client.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author : Flobby
 * @program : dsh-client-api
 * @description :
 * @create : 2024-07-02 15:54
 **/

@Slf4j
@Tag(name = "账户服务")
@RestController
@RequestMapping("/user")
@AllArgsConstructor
public class UserController {
}
