package com.nh.dsh.client.model.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * @author : Flobby
 * @program : dsh-client-api
 * @description :
 * @create : 2024-07-02 11:36
 **/

@Data
public class ForumListItemVO {

    @Schema(description = "主键")
    private Integer id;

    @Schema(description = "论坛名称")
    private String name;

    @Schema(description = "封面")
    private String cover;

    private long followCount;
}
