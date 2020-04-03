package com.bugbean.bugbounty.service;

import com.bugbean.bugbounty.model.User;
import org.springframework.security.core.context.SecurityContextHolder;

public abstract class BaseService {

    protected User getLoggedInUser() {

        return (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

    }

}
