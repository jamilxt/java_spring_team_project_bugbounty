package com.bugbean.bugbounty.service;

import com.bugbean.bugbounty.dto.AnswerDto;
import com.bugbean.bugbounty.dto.LikeDto;
import com.bugbean.bugbounty.dto.QuestionDto;
import com.bugbean.bugbounty.model.*;
import com.bugbean.bugbounty.repository.AnswerRepository;
import com.bugbean.bugbounty.repository.LikeRepository;
import com.bugbean.bugbounty.repository.QuestionRepository;
import com.bugbean.bugbounty.repository.TagRepository;
import com.bugbean.bugbounty.request.AnswerRequest;
import com.bugbean.bugbounty.request.QuestionHomepageRequest;
import com.bugbean.bugbounty.request.QuestionRequest;
import org.ocpsoft.prettytime.PrettyTime;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class QuestionService extends BaseService {
    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private AnswerRepository answerRepository;
    @Autowired
    private LikeRepository likeRepository;
    @Autowired
    private TagRepository tagRepository;

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
            questionRequest.setQuestionId(question.getQuestionId());
            questionRequest.setTitle(question.getTitle());
            questionRequest.setUsername(question.getUser().getUsername());
            questionRequest.setPropic(question.getUser().getPropic());
            questionRequest.setCreated_at(new PrettyTime().format(new Date(Timestamp.valueOf(question.getCreated_at()).getTime())));
            List<String> tags = new ArrayList<>();
            for (Tag tag : tagRepository.findByQuestions(question)) {
                tags.add(tag.getTag());
            }
            questionRequest.setTags(tags);
            questionRequest.setLikeCount(totalLikesOfQuestion(question));
            questionRequest.setAnswerCount(totalAnswersOfQuestion(question));
            questionRequest.setViewCount(question.getViews());

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
            List<String> tags = new ArrayList<>();
            for (Tag tag : tagRepository.findByQuestions(question)) {
                tags.add(tag.getTag());
            }
            questionHomepageRequest.setTags(tags);
            questionHomepageRequest.setUsername(question.getUser().getUsername());
            questionHomepageRequest.setPropic(question.getUser().getPropic());
            questionHomepageRequest.setCreated_at(new PrettyTime().format(new Date(Timestamp.valueOf(question.getCreated_at()).getTime())));
            questionHomepageRequest.setAnswerCount(totalAnswersOfQuestion(question));
            questionHomepageRequest.setLikeCount(totalLikesOfQuestion(question));
            questionHomepageRequest.setViewCount(Integer.parseInt(String.valueOf(question.getViews())));
            questionHomepageRequests.add(questionHomepageRequest);
        }
        return questionHomepageRequests;
    }


    public Long save(QuestionDto questionDto, User user) {
        var questionEntity = new Question();
        BeanUtils.copyProperties(questionDto, questionEntity);
        var tags = new ArrayList<String>(Arrays.asList(questionDto.getTag().split(", ")));
        var tagSet = new HashSet<String>();
        var tagList = new ArrayList<Tag>();
        for (var t :
                tags) {
            tagSet.add(t);
        }

        for (var s :
                tagSet) {
            var tag = tagRepository.findByTag(s);
            if (tag.isPresent()) {
                tag.get().setTotalUsed(tag.get().getTotalUsed() + 1);
                tagRepository.save(tag.get());
                tagList.add(tag.get());
            } else if (!s.isEmpty()) {
                var newTag = new Tag();
                newTag.setTotalUsed(1);
                newTag.setDateTime(LocalDateTime.now());
                newTag.setTag(s);
                tagList.add(newTag);
                tagRepository.save(newTag);
            }
        }
        questionEntity.setUser(user);
        questionEntity.setTags(tagList);
        Question savedQuestion = questionRepository.save(questionEntity);
        return savedQuestion.getQuestionId();
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

    public List<Tag> totalTagsOfQuestion(Question question) {
        var tags = tagRepository.findByQuestions(question);
        return tags;
    }

}
