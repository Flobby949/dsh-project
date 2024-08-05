package com.nh.dsh.client.controller;

import com.nh.dsh.client.common.result.Result;
import com.nh.dsh.client.model.dto.CodeDTO;
import com.nh.dsh.client.service.BookExchangeService;
import com.nh.dsh.client.service.BookResourceService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @author : Flobby
 * @program : dsh-client-api
 * @description :
 * @create : 2024-07-30 17:42
 **/

@Slf4j
@Tag(name = "书籍服务")
@RestController
@RequestMapping("/book")
@AllArgsConstructor
public class BookController {
    private final BookExchangeService bookExchangeService;
    private final BookResourceService bookResourceService;

    @PostMapping("/exchange")
    public Result<String> exchangeBookLink(@RequestBody Map<String, String> body) {
        String cardNum = body.get("cardNum");
        String openId = body.get("openId");
        return Result.ok(bookExchangeService.exchangeBookLink(cardNum, openId));
    }

    @PostMapping("/resource")
    public Result<String> resourceBookLink(@RequestBody CodeDTO dto) {
        return Result.ok(bookResourceService.checkBookResource(dto));
    }
}
