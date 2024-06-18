package com.nh.dsh.admin.controller;

import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.common.result.Result;
import com.nh.dsh.admin.model.dto.BookDTO;
import com.nh.dsh.admin.model.dto.BookResourceDTO;
import com.nh.dsh.admin.model.query.BookQuery;
import com.nh.dsh.admin.model.query.BookResourceQuery;
import com.nh.dsh.admin.model.vo.BookResourceVO;
import com.nh.dsh.admin.model.vo.BookVO;
import com.nh.dsh.admin.security.cache.TokenStoreCache;
import com.nh.dsh.admin.service.BookResourceService;
import com.nh.dsh.admin.service.BookService;
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
 * @create : 2024-06-17 13:00
 **/

@Tag(name = "书本管理接口")
@AllArgsConstructor
@RestController
@RequestMapping("/book")
public class BookController {
    private final BookService bookService;
    private final BookResourceService bookResourceService;
    private final TokenStoreCache tokenStoreCache;

    @PostMapping("page")
    @PreAuthorize("hasAuthority('sys:book:view')")
    public Result<PageResult<BookVO>> page(@RequestBody BookQuery query) {
        return Result.ok(bookService.page(query));
    }

    @PostMapping("save")
    @PreAuthorize("hasAuthority('sys:book:add')")
    public Result<String> save(@RequestBody @Valid BookDTO dto) {
        bookService.saveBook(dto);
        return Result.ok();
    }

    @PostMapping("update")
    @PreAuthorize("hasAuthority('sys:book:edit')")
    public Result<String> update(@RequestBody @Valid BookDTO dto) {
        bookService.updateBook(dto);
        return Result.ok();
    }

    @PostMapping("/delete")
    @Operation(summary = "删除")
    @PreAuthorize("hasAuthority('sys:book:remove')")
    public Result<String> delete(@RequestBody List<Integer> ids) {
        bookService.deleteBookInBatch(ids);
        return Result.ok();
    }

    @PostMapping("resource/save")
    @Operation(summary = "新增资源")
    @PreAuthorize("hasAuthority('sys:book:add')")
    public Result<String> saveResource(@RequestBody @Valid BookResourceDTO dto, @RequestHeader("Authorization")String authorization) {
        dto.setUserId(tokenStoreCache.getUser(authorization).getPkId());
        bookResourceService.save(dto);
        return Result.ok();
    }

    @PostMapping("resource/update")
    @Operation(summary = "修改资源")
    @PreAuthorize("hasAuthority('sys:book:add')")
    public Result<String> updateResource(@RequestBody @Valid BookResourceDTO dto) {
        bookResourceService.update(dto);
        return Result.ok();
    }

    @PostMapping("resource/page")
    @Operation(summary = "资源列表")
    @PreAuthorize("hasAuthority('sys:book:view')")
    public Result<PageResult<BookResourceVO>> resourcePage(@RequestBody BookResourceQuery query) {
        PageResult<BookResourceVO> page = bookResourceService.page(query);
        return Result.ok(page);
    }

    @PostMapping("resource/delete")
    @Operation(summary = "删除资源")
    @PreAuthorize("hasAuthority('sys:book:add')")
    public Result<String> saveResource(@RequestBody List<Integer> ids) {
        bookResourceService.deleteInBatch(ids);
        return Result.ok();
    }
}
