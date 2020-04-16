package com.bugbean.bugbounty.controller;

import com.bugbean.bugbounty.dto.AnswerDto;
import com.bugbean.bugbounty.dto.LikeDto;
import com.bugbean.bugbounty.model.Question;
import com.bugbean.bugbounty.model.User;
import com.bugbean.bugbounty.request.AnswerRequest;
import com.bugbean.bugbounty.request.LikeRequest;
import com.bugbean.bugbounty.request.QuestionRequest;
import com.bugbean.bugbounty.request.QuestionHomepageRequest;
import com.bugbean.bugbounty.service.BaseService;
import com.bugbean.bugbounty.service.QuestionService;
import com.bugbean.bugbounty.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletContext;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/v1")
public class QuestionRESTController extends BaseService {

    @Autowired
    ServletContext context;
    @Autowired
    QuestionService serviceQuestion;
    @Autowired
    UserService serviceUser;

    // QUESTION

    @GetMapping("/questions/all")
    public List<QuestionHomepageRequest> getQuestions(@RequestParam(value = "page") Optional<Integer> page,
                                                      @RequestParam(value = "sortBy") Optional<String> sortBy) {
        return serviceQuestion.getAllQuestion(page, sortBy);
    }

    @GetMapping("/questions")
    public List<QuestionRequest> getQuestionsByUser(@RequestParam(name = "username") String username,
                                                    @RequestParam(value = "page") Optional<Integer> page,
                                                    @RequestParam(value = "sortBy") Optional<String> sortBy) {
        User user = (User) serviceUser.loadUserByUsername(username);
        return serviceQuestion.getQuestionByUserRest(user, page, sortBy);
    }

    // QUESTION : LIKE_UNLIKE

    @PostMapping("/question/like")
    public ResponseEntity<?> likeUnlike(@RequestParam(name = "questionId") long questionId) {
        Question question = serviceQuestion.singleQuestion(questionId).get();
        LikeRequest likeRequest = new LikeRequest();
        long likeId = serviceQuestion.isAlreadyLikedWithLikeId(question);
        if (likeId == 0) {
            serviceQuestion.addLike(new LikeDto(question));
            likeRequest.setAlreadyLiked(true);
        } else {
            serviceQuestion.removeLike(likeId);
            likeRequest.setAlreadyLiked(false);
        }
        likeRequest.setTotalLikes(serviceQuestion.totalLikesOfQuestion(question));
        return new ResponseEntity<>(likeRequest, HttpStatus.OK);
    }

    // -------------------------------------------------------------------------------------------------------------

    // ANSWER

    @GetMapping("/question/answers")
    public List<AnswerRequest> getAnswersByQuestion(@RequestParam(name = "questionId") long questionId,
                                                    @RequestParam(value = "page") Optional<Integer> page,
                                                    @RequestParam(value = "sortBy") Optional<String> sortBy) {
        Question question = serviceQuestion.singleQuestion(questionId).get();
        return serviceQuestion.getCommentByQuestion(question, page, sortBy);
    }

    @PostMapping("/question/answers/add")
    public ResponseEntity<?> addAnswer(@RequestParam(name = "questionId") long questionId,
                                       @RequestParam(name = "answerText") String answerText) {
        Question question = serviceQuestion.singleQuestion(questionId).get();
        User user = getLoggedInUser();
        AnswerRequest answerRequest = serviceQuestion.addComment(new AnswerDto(answerText, question, user));
        answerRequest.setTotalAnswers(serviceQuestion.totalAnswersOfQuestion(question));
        answerRequest.setTotalLikes(serviceQuestion.totalLikesOfQuestion(question));
        return new ResponseEntity<>(answerRequest, HttpStatus.OK);
    }

}
