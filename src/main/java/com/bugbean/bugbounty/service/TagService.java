package com.bugbean.bugbounty.service;

import com.bugbean.bugbounty.config.exception.ResourceAlreadyExistsException;
import com.bugbean.bugbounty.dto.TagDto;
import com.bugbean.bugbounty.model.Tag;
import com.bugbean.bugbounty.repository.TagRepository;
import com.bugbean.bugbounty.response.TagResponse;
import org.ocpsoft.prettytime.PrettyTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class TagService implements Serializable {
    @Autowired
    private TagRepository tagRepository;

    public void save(TagDto tagDto) throws Exception {
        var check = tagRepository.findByTag(tagDto.getTag());
        if (check.isEmpty()) {
            var tag = new Tag();
            tag.setTag(tagDto.getTag());
            tag.setTagDescription(tagDto.getTagDescription());
            tag.setDateTime(LocalDateTime.now());
            tagRepository.save(tag);
        } else {
            throw new ResourceAlreadyExistsException("This tag already used");
        }

    }

    public Page<Tag> show(String search, int pageIndex, int row, String sort) {

        Pageable pageWithElements;
        if (sort.equals("Sort By Name")) {
            pageWithElements = PageRequest.of(pageIndex, row, Sort.by("tag").ascending());
        } else if (sort.equals("Sort By Popularity")) {
            pageWithElements = PageRequest.of(pageIndex, row, Sort.by("totalUsed").descending());
        } else {
            pageWithElements = PageRequest.of(pageIndex, row, Sort.by("dateTime").descending());
        }
        var t = tagRepository.findByTagContaining(search, pageWithElements);
        return t;
    }

    public void delete(Long id) {
        var tag = tagRepository.findById(id).get();
        if (tag.getTotalUsed() > 0) {
            throw new ResourceAlreadyExistsException("This tag is currently using by " + tag.getTotalUsed() + " questions");
        }
        tagRepository.deleteById(id);
    }

    public void edit(TagDto tagDto) {

        var tag = tagRepository.findById(tagDto.getId()).get();
        if (tag.getTotalUsed() > 0) {
            throw new ResourceAlreadyExistsException("This tag is currently using by " + tag.getTotalUsed() + " questions");
        }
        tag.setTagDescription(tagDto.getTagDescription());
        tag.setTag(tagDto.getTag());
        tagRepository.save(tag);
    }

    public String tagString() {
        ArrayList<String> list = new ArrayList<String>();
        tagRepository.findAll().forEach(tag -> {
            list.add(tag.getTag());
        });

        String listString = "";

        for (String s : list) {
            listString += "'" + s + "'" + ",";
        }
        return listString;
    }

}
