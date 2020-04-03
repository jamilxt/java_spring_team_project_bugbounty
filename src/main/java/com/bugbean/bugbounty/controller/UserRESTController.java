package com.bugbean.bugbounty.controller;

import com.bugbean.bugbounty.request.FollowerRequest;
import com.bugbean.bugbounty.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1")
public class UserRESTController {

    @Autowired
    UserService serviceUser;

    @PostMapping("/user/follow")
    public ResponseEntity<?> followUnfollow(@RequestParam(name = "username") String username) {

        FollowerRequest followerRequest = new FollowerRequest();

        boolean isAlreadyFollowing = serviceUser.followUser(username);

        followerRequest.setAlreadyFollowing(isAlreadyFollowing);
        followerRequest.setFollowingOrNot(isAlreadyFollowing ? "Following" : "Follow");
        followerRequest.setTotalFollowers(serviceUser.totalFollowersOfUser(username));


        return new ResponseEntity<>(followerRequest, HttpStatus.OK);
    }
}
