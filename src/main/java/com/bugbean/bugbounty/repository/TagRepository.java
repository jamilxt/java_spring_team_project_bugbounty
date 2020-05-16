package com.bugbean.bugbounty.repository;

import com.bugbean.bugbounty.model.Question;
import com.bugbean.bugbounty.model.Tag;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public interface TagRepository extends JpaRepository<Tag, Long> {
    Optional<Tag> findByTag(String tag);

    List<Tag> findByQuestions(Question question);
    Page<Tag> findByTagContaining(String name, Pageable pageable);
}
