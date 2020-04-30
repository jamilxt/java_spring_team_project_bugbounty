package com.bugbean.bugbounty.controller;

import com.bugbean.bugbounty.service.AuthorityService;
import com.bugbean.bugbounty.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletContext;

@Controller
public class UserController {

    @Autowired
    UserService serviceUser;
    @Autowired
    AuthorityService authorityService;
    @Autowired
    ServletContext context;

    @GetMapping(value = "users/is_available")
    public @ResponseBody
    ResponseEntity<?> isUsernameAvailable(@RequestParam(name = "username") String username) {
        var data = serviceUser.isUsernameAvailable(username);
        return new ResponseEntity<>(data, HttpStatus.OK);
    }

    @GetMapping(value = "users/search")
    public @ResponseBody
    ResponseEntity<?> searchUserByUsername(@RequestParam(name = "term") String query) {
        var data = serviceUser.findUser(query);
        return new ResponseEntity<>(data, HttpStatus.OK);
    }

    @GetMapping(value = "users")
    public String usersList(Model model) {
        var users = serviceUser.userList();
        model.addAttribute("users", users);
        return "users";
    }

}
