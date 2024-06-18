package com.nh.dsh.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.model.dto.UserDTO;
import com.nh.dsh.admin.model.entity.UserEntity;
import com.nh.dsh.admin.model.query.UserQuery;
import com.nh.dsh.admin.model.vo.UserVO;

import java.util.List;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-18 15:07
 **/

public interface UserService extends IService<UserEntity> {

    void save(UserDTO dto);

    void update(UserDTO dto);

    void deleteInBatch(List<Integer> ids);

    PageResult<UserVO> page(UserQuery query);
}
