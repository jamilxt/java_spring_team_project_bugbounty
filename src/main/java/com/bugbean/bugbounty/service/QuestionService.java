package com.bugbean.bugbounty.service;

import com.bugbean.bugbounty.dto.AnswerDto;
import com.bugbean.bugbounty.dto.LikeDto;
import com.bugbean.bugbounty.dto.QuestionDto;
import com.bugbean.bugbounty.model.Answer;
import com.bugbean.bugbounty.model.Like;
import com.bugbean.bugbounty.model.Question;
import com.bugbean.bugbounty.model.User;
import com.bugbean.bugbounty.repository.AnswerRepository;
import com.bugbean.bugbounty.repository.LikeRepository;
import com.bugbean.bugbounty.repository.QuestionRepository;
import com.bugbean.bugbounty.request.AnswerRequest;
import com.bugbean.bugbounty.request.QuestionRequest;
import com.bugbean.bugbounty.request.QuestionHomepageRequest;
import org.ocpsoft.prettytime.PrettyTime;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class QuestionService extends BaseService {
    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private AnswerRepository answerRepository;
    @Autowired
    private LikeRepository likeRepository;

    public Page<Question> showAll(
            Optional<Integer> page,
            Optional<String> sortBy) {
        return questionRepository.findAll(
                PageRequest.of(page.orElse(0), 10,
                        Sort.Direction.DESC, sortBy.orElse("questionId")));
    }

    public Page<Question> getQuestionByUser(User user,
                                            Optional<Integer> page,
                                            Optional<String> sortBy) {
        return questionRepository.findByUser(user,
                PageRequest.of(page.orElse(0), 10,
                        Sort.Direction.DESC, sortBy.orElse("questionId")));
    }

    public List<QuestionRequest> getQuestionByUserRest(User user,
                                                       Optional<Integer> page,
                                                       Optional<String> sortBy) {
        List<QuestionRequest> questionRequests = new ArrayList<>();
        for (Question question : questionRepository.findByUser(user,
                PageRequest.of(page.orElse(0), 10,
                        Sort.Direction.DESC, sortBy.orElse("questionId")))) {
            QuestionRequest questionRequest = new QuestionRequest();
            questionRequest.setAttachments(question.getAttachments());
            questionRequest.setQuestionId(question.getQuestionId());
            questionRequest.setCommentCount(totalAnswersOfQuestion(question));
            questionRequest.setLikeCount(totalLikesOfQuestion(question));
            questionRequests.add(questionRequest);
        }
        return questionRequests;
    }

    public List<QuestionHomepageRequest> getAllQuestion(
            Optional<Integer> page,
            Optional<String> sortBy) {
        List<QuestionHomepageRequest> questionHomepageRequests = new ArrayList<>();
        for (Question question : questionRepository.findAll(PageRequest.of(page.orElse(0), 10,
                Sort.Direction.DESC, sortBy.orElse("questionId")))) {
            QuestionHomepageRequest questionHomepageRequest = new QuestionHomepageRequest();
            questionHomepageRequest.setQuestionId(question.getQuestionId());
            questionHomepageRequest.setTitle(question.getTitle());
            questionHomepageRequest.setAnswerCount(totalAnswersOfQuestion(question));
            questionHomepageRequest.setLikeCount(totalLikesOfQuestion(question));
            questionHomepageRequest.setViewCount(Integer.parseInt(String.valueOf(question.getViews())));
            questionHomepageRequest.setUsername(question.getUser().getUsername());
            questionHomepageRequest.setPropic(question.getUser().getPropic());
            questionHomepageRequest.setCreated_at(new PrettyTime().format(new Date(Timestamp.valueOf(question.getCreated_at()).getTime())));
            questionHomepageRequests.add(questionHomepageRequest);
        }
        return questionHomepageRequests;
    }


    public void save(QuestionDto questionDto, User user) {
        var questionEntity = new Question();
        BeanUtils.copyProperties(questionDto, questionEntity);
        questionEntity.setUser(user);
        questionRepository.save(questionEntity);
    }

    public void deleteQuestion(Long id) {
        questionRepository.deleteById(id); // will be converted to soft delete
    }

    public int totalQuestionsOfUser(User user) {
        return questionRepository.countQuestionsByUser(user);
    }

    public Optional<Question> singleQuestion(Long id) {
        return questionRepository.findById(id);
    }

    public AnswerRequest addComment(AnswerDto answerDto) {
        var answerEntity = new Answer();
        BeanUtils.copyProperties(answerDto, answerEntity);
        Answer answer = answerRepository.save(answerEntity);

        AnswerRequest answerRequest = new AnswerRequest();
        answerRequest.setAnswerId(answer.getAnswerId());
        answerRequest.setAnswerText(answer.getAnswerText());
        answerRequest.setCreated_at(new PrettyTime().format(new Date(Timestamp.valueOf(answer.getCreated_at()).getTime())));
        answerRequest.setUsername(answer.getUser().getUsername());
        answerRequest.setPropic(answer.getUser().getPropic());

        return answerRequest;
    }

    public int totalAnswersOfQuestion(Question question) {
        return answerRepository.countAnswersByQuestion(question);
    }

    public List<AnswerRequest> getCommentByQuestion(Question question,
                                                    Optional<Integer> page,
                                                    Optional<String> sortBy) {
        List<AnswerRequest> answerRequests = new ArrayList<>();
        for (Answer answer :
                answerRepository.findByQuestion(question,
                        PageRequest.of(page.orElse(0), 10,
                                Sort.Direction.DESC, sortBy.orElse("answerId")))) {
            AnswerRequest answerRequest = new AnswerRequest();
            answerRequest.setAnswerId(answer.getAnswerId());
            answerRequest.setUsername(answer.getUser().getUsername());
            answerRequest.setAnswerText(answer.getAnswerText());
            answerRequest.setPropic(answer.getUser().getPropic());

            PrettyTime p = new PrettyTime();
            String created_at = p.format(new Date(Timestamp.valueOf(answer.getCreated_at()).getTime()));
            answerRequest.setCreated_at(created_at);
            answerRequests.add(answerRequest);
        }
        return answerRequests;
    }

    public int totalLikesOfQuestion(Question question) {
        return likeRepository.countLikesByQuestion(question);
    }

    public void addLike(LikeDto likeDto) {
        likeDto.setUser(getLoggedInUser());
        var likeEntity = new Like();
        BeanUtils.copyProperties(likeDto, likeEntity);
        likeRepository.save(likeEntity);
    }

    public Long isAlreadyLikedWithLikeId(Question question) {
        long likeId = 0;
        User user = getLoggedInUser();
        if (likeRepository.findByQuestionAndUser(question, user).isPresent()) {
            Like like = likeRepository.findByQuestionAndUser(question, user).get();
            likeId = like.getLikeId();
        }
        return likeId;
    }

    public void removeLike(Long likeId) {
        likeRepository.deleteById(likeId);
    }

    public List<Question> relatedQuestion(User user, Long except) {
        return questionRepository.findByUserAndQuestionIdIsNot(user, except, PageRequest.of(0, 6,
                Sort.Direction.DESC, "questionId")).getContent();
    }

    public void increaseViews(Long id) {
        Question question = singleQuestion(id).get();
        question.setViews(question.getViews() + 1);
        questionRepository.save(question);
    }

}
