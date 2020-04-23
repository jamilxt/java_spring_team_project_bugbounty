package com.bugbean.bugbounty.controller;

import com.bugbean.bugbounty.config.util.Constants;
import com.bugbean.bugbounty.dto.QuestionDto;
import com.bugbean.bugbounty.model.Question;
import com.bugbean.bugbounty.model.User;
import com.bugbean.bugbounty.service.BaseService;
import com.bugbean.bugbounty.service.QuestionService;
import com.bugbean.bugbounty.service.TagService;
import com.bugbean.bugbounty.service.UserService;
import org.ocpsoft.prettytime.PrettyTime;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
public class QuestionController extends BaseService {

    @Autowired
    ServletContext context;
    @Autowired
    private QuestionService serviceQuestion;
    @Autowired
    private UserService serviceUser;
    @Autowired
    private TagService tagService;

    // LIST OF QUESTIONS

    @GetMapping("/questions")
    public String getQuestions(Model model,
                               @RequestParam(value = "username") Optional<String> username,
                               @RequestParam(value = "page") Optional<Integer> page,
                               @RequestParam(value = "sortBy") Optional<String> sortBy) {
        model.addAttribute("pageTitle", "All Questions");
        if (username.isPresent()) {
            User userEntity = (User) serviceUser.loadUserByUsername(username.get());
            model.addAttribute("questions", serviceQuestion.getQuestionByUser(userEntity, page, sortBy));
        } else {
            model.addAttribute("questions", serviceQuestion.showAll(page, sortBy));
        }
        return "question/list";
    }

    // CREATE QUESTION

    @GetMapping("/questions/ask")
    public String showAddQuestion(Model model) {
        model.addAttribute("pageTitle", "Ask a public question");
        model.addAttribute("tagList", tagService.tagString());
        model.addAttribute("question", new QuestionDto());
        return "question/add";
    }

    @PostMapping("/questions/ask")
    public String postQuestion(@ModelAttribute("question") QuestionDto questionDto, @RequestParam("files") List<MultipartFile> multipartFiles) {
        User userEntity = getLoggedInUser();
        List<String> questionAttachments = new ArrayList<>();
        for (MultipartFile file :
                multipartFiles) {
            if (!file.isEmpty()) {
                try {
                    byte[] bytes = file.getBytes();
                    String absoluteFilePath = context.getRealPath(Constants.UPLOADED_FOLDER);
                    Path path = Paths.get(absoluteFilePath + file.getOriginalFilename());
                    Files.write(path, bytes);
                    questionAttachments.add(file.getOriginalFilename());
                } catch (IOException e) {
                    throw new RuntimeException(e.getMessage());
                }
            }
        }
        questionDto.setAttachments(questionAttachments);
        Long savedQuestionId = serviceQuestion.save(questionDto, userEntity);
        return "redirect:/questions/" + savedQuestionId;
    }

    // SINGLE QUESTION

    @GetMapping("/questions/{questionId}")
    public String singleQuestion(Model model, @PathVariable(value = "questionId") String questionId) {
        model.addAttribute("questionId", questionId);
        Question question = serviceQuestion.singleQuestion(Long.parseLong(questionId)).get();
        model.addAttribute("pageTitle", question.getTitle());
        serviceQuestion.increaseViews(Long.parseLong(questionId));
        model.addAttribute("singleQuestion", question);
        PrettyTime p = new PrettyTime();
        String postedAt = p.format(new Date(Timestamp.valueOf(question.getCreated_at()).getTime()));
        model.addAttribute("postedAt", postedAt);
        model.addAttribute("totalAnswers", serviceQuestion.totalAnswersOfQuestion(question));
        model.addAttribute("totalLikes", serviceQuestion.totalLikesOfQuestion(question));
        model.addAttribute("isAlreadyLiked", serviceQuestion.isAlreadyLikedWithLikeId(question) > 0);
        model.addAttribute("relatedQuestions", serviceQuestion.relatedQuestion(question.getUser(), question.getQuestionId()));
        model.addAttribute("tags", serviceQuestion.totalTagsOfQuestion(question));
        return "question/view";
    }

    // DELETE QUESTION

    @GetMapping("/questions/{questionId}/delete")
    public String deleteQuestion(Model model, @PathVariable("questionId") long questionId) {
        serviceQuestion.deleteQuestion(questionId);
        model.addAttribute("message", "Question deleted successfully");
        return "redirect:/questions";
    }

}
