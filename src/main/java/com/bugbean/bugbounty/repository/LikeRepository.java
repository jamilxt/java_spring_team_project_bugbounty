package com.bugbean.bugbounty.repository;

import com.bugbean.bugbounty.model.Like;
import com.bugbean.bugbounty.model.Question;
import com.bugbean.bugbounty.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Transactional
@Repository
public interface LikeRepository extends JpaRepository<Like, Long> {

    int countLikesByQuestion(Question question);

    Optional<Like> findByQuestionAndUser(Question question, User user);

}
