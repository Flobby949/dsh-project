package com.nh.dsh.admin.service.impl;

import com.nh.dsh.admin.common.model.BaseServiceImpl;
import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.mapper.UserMapper;
import com.nh.dsh.admin.model.dto.UserDTO;
import com.nh.dsh.admin.model.entity.UserEntity;
import com.nh.dsh.admin.model.query.UserQuery;
import com.nh.dsh.admin.model.vo.UserVO;
import com.nh.dsh.admin.service.UserService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-18 15:07
 **/

@Service
public class UserServiceImpl extends BaseServiceImpl<UserMapper, UserEntity> implements UserService {

    @Override
    public void save(UserDTO dto) {

    }

    @Override
    public void update(UserDTO dto) {

    }

    @Override
    public void deleteInBatch(List<Integer> ids) {

    }

    @Override
    public PageResult<UserVO> page(UserQuery query) {
        return null;
    }

    @Override
    public List<Map<String, Object>> selectedList() {
        return list().stream().map(item -> {
            Map<String, Object> itemMap = new HashMap<>();
            itemMap.put("label", item.getWxName());
            itemMap.put("value", item.getId());
            return itemMap;
        }).toList();
    }
}
