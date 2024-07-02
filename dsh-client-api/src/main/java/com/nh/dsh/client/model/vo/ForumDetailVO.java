package com.nh.dsh.client.model.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

/**
 * @author : Flobby
 * @program : dsh-client-api
 * @description :
 * @create : 2024-07-02 11:40
 **/

@Data
public class ForumDetailVO {
    @Schema(description = "主键")
    private Integer id;

    @Schema(description = "用户id")
    private Integer userId;

    @Schema(description = "用户名")
    private String username;

    @Schema(description = "论坛名称")
    private String name;

    @Schema(description = "书本id")
    private Integer bookId;

    @Schema(description = "书本名称")
    private String bookName;

    @Schema(description = "书本简介")
    private String bookIntroduction;

    @Schema(description = "封面")
    private String cover;

    private long followCount;

    private boolean isFollow;

    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
}
