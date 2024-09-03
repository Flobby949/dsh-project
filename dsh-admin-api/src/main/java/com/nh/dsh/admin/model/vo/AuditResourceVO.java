package com.nh.dsh.admin.model.vo;

import lombok.Data;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-07-24 17:36
 **/

@Data
public class AuditResourceVO {
    private Integer id;
    private Integer bookId;
    private String bookName;
    private String bookCover;
    private String resourceName;
    private String link;
    private Integer isChanged;
    private Integer enabled;
}
