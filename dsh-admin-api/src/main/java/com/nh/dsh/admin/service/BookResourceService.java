package com.nh.dsh.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.model.dto.BookResourceDTO;
import com.nh.dsh.admin.model.entity.BookResourceEntity;
import com.nh.dsh.admin.model.query.BookResourceQuery;
import com.nh.dsh.admin.model.vo.BookResourceVO;

import java.util.List;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-18 09:48
 **/

public interface BookResourceService extends IService<BookResourceEntity> {

    void save(BookResourceDTO dto);

    void update(BookResourceDTO dto);

    void deleteInBatch(List<Integer> ids);

    PageResult<BookResourceVO> page(BookResourceQuery query);
}
