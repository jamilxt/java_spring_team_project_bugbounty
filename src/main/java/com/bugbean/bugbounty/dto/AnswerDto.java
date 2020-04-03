package com.bugbean.bugbounty.dto;

import com.bugbean.bugbounty.model.Question;
import com.bugbean.bugbounty.model.User;

public class AnswerDto {
    private String answerText;
    private Question question;
    private User user;

    public AnswerDto(String answerText, Question question, User user) {
        this.answerText = answerText;
        this.question = question;
        this.user = user;
    }

    public String getAnswerText() {
        return answerText;
    }

    public void setAnswerText(String answerText) {
        this.answerText = answerText;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
