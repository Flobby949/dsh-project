package com.nh.dsh.admin.controller;

import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.common.result.Result;
import com.nh.dsh.admin.model.dto.ForumDTO;
import com.nh.dsh.admin.model.query.ForumQuery;
import com.nh.dsh.admin.model.vo.ForumVO;
import com.nh.dsh.admin.service.ForumService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-20 09:47
 **/

@Tag(name = "论坛融合管理")
@AllArgsConstructor
@RestController
@RequestMapping("/forum")
public class ForumController {
    private final ForumService forumService;

    @PostMapping("page")
    @PreAuthorize("hasAuthority('sys:forum:view')")
    public Result<PageResult<ForumVO>> page(@RequestBody ForumQuery query, @RequestHeader("Authorization") String authorization) {
        return Result.ok(forumService.page(query, authorization));
    }

    @PostMapping("save")
    @PreAuthorize("hasAuthority('sys:forum:add')")
    public Result<String> save(@RequestBody @Valid ForumDTO dto) {
        forumService.save(dto);
        return Result.ok();
    }

    @PostMapping("update")
    @PreAuthorize("hasAuthority('sys:forum:edit')")
    public Result<String> update(@RequestBody @Valid ForumDTO dto) {
        forumService.update(dto);
        return Result.ok();
    }

    @PostMapping("/delete")
    @Operation(summary = "删除")
    @PreAuthorize("hasAuthority('sys:forum:remove')")
    public Result<String> delete(@RequestBody List<Integer> ids) {
        forumService.deleteInBatch(ids);
        return Result.ok();
    }
}
