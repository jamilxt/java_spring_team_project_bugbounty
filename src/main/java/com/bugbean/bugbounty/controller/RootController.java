package com.bugbean.bugbounty.controller;

import com.bugbean.bugbounty.dto.UserDto;
import com.bugbean.bugbounty.model.Authority;
import com.bugbean.bugbounty.model.User;
import com.bugbean.bugbounty.repository.UserRepository;
import com.bugbean.bugbounty.service.AuthorityService;
import com.bugbean.bugbounty.service.BaseService;
import com.bugbean.bugbounty.service.QuestionService;
import com.bugbean.bugbounty.service.UserService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@Controller
public class RootController extends BaseService {

    private final UserRepository userRepository;
    private final AuthorityService authorityService;
    private final PasswordEncoder passwordEncoder;
    private final QuestionService serviceQuestion;

    @Autowired
    UserService serviceUser;

    public RootController(UserRepository userRepository, PasswordEncoder passwordEncoder, AuthorityService authorityService, QuestionService serviceQuestion) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.authorityService = authorityService;
        this.serviceQuestion = serviceQuestion;
    }

    @GetMapping("/")
    public String root(Model model) {
        model.addAttribute("pageTitle", "Homepage");
        model.addAttribute("authUser", getLoggedInUser());
        return "index";
    }

    @GetMapping("/login")
    public String login(Model model,
                        @RequestParam(name = "error", required = false) String error,
                        @RequestParam(name = "success", required = false) String success) {
        generateRoles();
        generateUsers();
        model.addAttribute("pageTitle", "Login");
        model.addAttribute("error", error);
        model.addAttribute("success", success);
        return "/login";
    }

    @GetMapping("/signup")
    public String signup(Model model,
                         @ModelAttribute("user") com.bugbean.bugbounty.request.User user,
                         @RequestParam(name = "error", required = false) String error) {
        model.addAttribute("pageTitle", "Sign up");
        model.addAttribute("user", user);
        model.addAttribute("error", error);
        return "/signup";
    }    

    @RequestMapping(value = "/signup-processing", method = RequestMethod.POST)
    public String signupPOST(Model model, @ModelAttribute("user") com.bugbean.bugbounty.request.User user, BindingResult result) {
        var userDto = new UserDto();
        BeanUtils.copyProperties(user, userDto);
        serviceUser.addUser(userDto);
        return "redirect:/";

    }

    @GetMapping("/403")
    public String _403() {
        return "403";
    }

    @GetMapping("/{username}")
    public String userProfile(Model model, @PathVariable(value = "username") String username) {
        model.addAttribute("pageTitle", "@" + username + "'s Profile");
        User user = (User) serviceUser.loadUserByUsername(username);
        model.addAttribute("user", user);
        model.addAttribute("totalPosts", serviceQuestion.totalQuestionsOfUser(user));
        model.addAttribute("totalFollowers", serviceUser.totalFollowersOfUser(username));
        model.addAttribute("totalFollowing", serviceUser.totalFollowingOfUser(username));
        model.addAttribute("isAlreadyFollowing", serviceUser.isFollowing(user) > 0);
        return "profile";
    }

    private void generateRoles() {
        authorityService.create(new Authority(System.nanoTime(), "ROLE_ADMIN"));
        authorityService.create(new Authority(System.nanoTime(), "ROLE_USER"));
    }

    private void generateUsers() {

        if (userRepository.findByUsername("admin").isEmpty()) {
            var user = new User();
            user.setUsername("admin");
            user.setPassword(passwordEncoder.encode("secret"));
            user.setFullName("Admin");
            user.setGender("M");
            user.setEmail("admin@gmail.com");
            user.setXp(50);
            user.setPropic("noavatar.jpg");
            user.setEnabled(true);
            user.setDob(LocalDate.now());
            Set<Authority> authorities = new HashSet<>();
            authorities.add(authorityService.findByRoleName("ROLE_ADMIN"));
            user.setAuthorities(authorities);
            userRepository.save(user);
        }

        if (userRepository.findByUsername("user").isEmpty()) {
            var user = new User();
            user.setUsername("user");
            user.setPassword(passwordEncoder.encode("secret"));
            user.setFullName("User");
            user.setGender("M");
            user.setEmail("user@gmail.com");
            user.setXp(50);
            user.setPropic("noavatar.jpg");
            user.setEnabled(true);
            user.setDob(LocalDate.now());
            Set<Authority> authorities = new HashSet<>();
            authorities.add(authorityService.findByRoleName("ROLE_USER"));
            user.setAuthorities(authorities);
            userRepository.save(user);
        }
    }

}
