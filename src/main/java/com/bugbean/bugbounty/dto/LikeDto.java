package com.bugbean.bugbounty.dto;

import com.bugbean.bugbounty.model.Question;
import com.bugbean.bugbounty.model.User;

public class LikeDto {
    private Question question;
    private User user;

    public LikeDto(Question question) {
        this.question = question;
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
