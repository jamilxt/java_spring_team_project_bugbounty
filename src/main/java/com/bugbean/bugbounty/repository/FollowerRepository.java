package com.bugbean.bugbounty.repository;

import com.bugbean.bugbounty.model.Follower;
import com.bugbean.bugbounty.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Transactional
@Repository
public interface FollowerRepository extends JpaRepository<Follower, Long> {

    int countFollowerByFrom(User user);

    int countFollowerByTo(User user);

    Optional<Follower> findByFromAndTo(User from, User to);

}
