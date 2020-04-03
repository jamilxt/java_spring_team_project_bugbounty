package com.bugbean.bugbounty.repository;

import com.bugbean.bugbounty.model.Question;
import com.bugbean.bugbounty.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Repository
public interface QuestionRepository extends JpaRepository<Question, Long> {

    Page<Question> findByUser(User user, Pageable pageable);

    int countQuestionsByUser(User user);

    Page<Question> findByUserAndQuestionIdIsNot(User user, Long id, Pageable pageable);

    Page<Question> findAll(Pageable pageable);


}
