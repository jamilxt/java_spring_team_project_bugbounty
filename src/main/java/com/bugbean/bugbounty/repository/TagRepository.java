package com.bugbean.bugbounty.repository;
import com.bugbean.bugbounty.model.Tag;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.Optional;

@Repository
@Transactional
public interface TagRepository extends JpaRepository<Tag, Long> {
    Optional<Tag> findByTag(String tag);
    /*    @Query(value = "select tagName" +
            " from tbl_tag t" +
            " where t.tagName like %:keyword% "
            , nativeQuery = true)
    List<Tag> getTagByQueryString(@Param("keyword") String query);*/
}
