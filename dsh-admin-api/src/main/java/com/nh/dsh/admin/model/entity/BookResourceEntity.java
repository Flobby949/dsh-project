package com.nh.dsh.admin.model.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-18 09:45
 **/

@Data
@TableName("book_resource")
@Schema(description = "书籍资源对象")
public class BookResourceEntity extends BaseEntity {
    @Schema(description = "书本id")
    private Integer bookId;

    @Schema(description = "用户id")
    private Integer userId;

    @Schema(description = "资源名")
    private String resourceName;

    @Schema(description = "链接")
    private String link;

    @Schema(description = "二维码")
    private String codeCover;

    private Integer validStatus;
}
