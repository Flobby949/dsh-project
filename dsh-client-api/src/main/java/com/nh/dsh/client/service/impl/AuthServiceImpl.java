package com.nh.dsh.client.service.impl;

import com.nh.dsh.client.service.AuthService;
import org.springframework.stereotype.Service;

/**
 * @author : Flobby
 * @program : dsh-client-api
 * @description :
 * @create : 2024-06-28 10:09
 **/

@Service
public class AuthServiceImpl implements AuthService {
    @Override
    public boolean checkUserEnabled(Integer pkId) {
        return false;
    }
}
