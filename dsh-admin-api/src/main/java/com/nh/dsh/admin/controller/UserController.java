package com.nh.dsh.admin.controller;

import com.nh.dsh.admin.common.result.Result;
import com.nh.dsh.admin.service.UserService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-20 10:11
 **/

@Tag(name = "用户管理")
@AllArgsConstructor
@RestController
@RequestMapping("/user")
public class UserController {
    private final UserService userService;

    @GetMapping("list")
    public Result<List<Map<String, Object>>> selectedList() {
        return Result.ok(userService.selectedList());
    }
}
