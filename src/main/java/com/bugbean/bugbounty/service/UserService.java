package com.bugbean.bugbounty.service;

import com.bugbean.bugbounty.config.exception.ResourceAlreadyExistsException;
import com.bugbean.bugbounty.config.exception.ResourceNotFoundException;
import com.bugbean.bugbounty.dto.UserDto;
import com.bugbean.bugbounty.model.Authority;
import com.bugbean.bugbounty.model.Follower;
import com.bugbean.bugbounty.model.User;
import com.bugbean.bugbounty.repository.FollowerRepository;
import com.bugbean.bugbounty.repository.UserRepository;
import com.bugbean.bugbounty.request.UserSearchRequest;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class UserService extends BaseService implements UserDetailsService {

    @Autowired
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthorityService authorityService;
    private final FollowerRepository followerRepository;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder, AuthorityService authorityService, FollowerRepository followerRepository) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.authorityService = authorityService;
        this.followerRepository = followerRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        User userEntity = userRepository.findByUsername(s)
                .orElseThrow(() -> new ResourceNotFoundException("No user found with this username"));
        return userEntity;
    }

    public List<User> showAll() {
        return userRepository.findAllByActiveIsTrue();
    }

    public void addUser(UserDto userDto) {
        if (userRepository.findByUsername(userDto.getUsername()).isEmpty()) {
            var userEntity = new User();
            BeanUtils.copyProperties(userDto, userEntity);
            userEntity.setPassword(passwordEncoder.encode(userDto.getPassword()));
            Set<Authority> authorities = new HashSet<Authority>();
            authorities.add(authorityService.findByRoleName("ROLE_USER"));
            userEntity.setAuthorities(authorities);
            userRepository.save(userEntity);
        } else {
            throw new ResourceAlreadyExistsException("Username is unavailable");
        }
    }

    public void deleteUser(Long userId) {
        userRepository.deleteById(userId); // will be converted to soft delete
    }

    public boolean isUsernameAvailable(String username) {
        return userRepository.findByUsername(username).isEmpty();
    }

    public List<UserSearchRequest> findUser(String query) {
        var users = this.userRepository.getUsersByQueryString(query);
        var userRequests = new ArrayList<UserSearchRequest>();
        for (var user : users) {
            var userRequest = new UserSearchRequest();
            BeanUtils.copyProperties(user, userRequest);
            userRequests.add(userRequest);
        }
        return userRequests;
    }

    public boolean followUser(String username) {
        User to = (User) loadUserByUsername(username);
        User from = getLoggedInUser();
        Follower follower = new Follower();
        follower.setFrom(from);
        follower.setTo(to);
        long followerId = isFollowing(to);
        if (followerId > 0) {
            unFollowUser(followerId);
            return false;
        } else {
            followerRepository.save(follower);
            return true;
        }
    }

    public void unFollowUser(Long followerId) {
        followerRepository.deleteById(followerId);
    }

    public Long isFollowing(User to) {
        User from = getLoggedInUser();
        long followerId = 0;
        if (followerRepository.findByFromAndTo(from, to).isPresent()) {
            Follower follower = followerRepository.findByFromAndTo(from, to).get();
            followerId = follower.getFollowerId();
        }
        return followerId;
    }

    public int totalFollowersOfUser(String username) {
        User user = (User) loadUserByUsername(username);
        return followerRepository.countFollowerByTo(user);
    }

    public int totalFollowingOfUser(String username) {
        User user = (User) loadUserByUsername(username);
        return followerRepository.countFollowerByFrom(user);
    }

}