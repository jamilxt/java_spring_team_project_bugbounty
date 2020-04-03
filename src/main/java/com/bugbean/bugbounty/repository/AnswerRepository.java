package com.bugbean.bugbounty.repository;

import com.bugbean.bugbounty.model.Answer;
import com.bugbean.bugbounty.model.Question;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Repository
public interface AnswerRepository extends JpaRepository<Answer, Long> {

    int countAnswersByQuestion(Question question);

    Page<Answer> findByQuestion(Question question, Pageable pageable);

}
