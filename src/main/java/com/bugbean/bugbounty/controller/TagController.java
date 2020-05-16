package com.bugbean.bugbounty.controller;

import com.bugbean.bugbounty.config.exception.ResourceAlreadyExistsException;
import com.bugbean.bugbounty.dto.TagDto;
import com.bugbean.bugbounty.model.Tag;
import com.bugbean.bugbounty.repository.TagRepository;
import com.bugbean.bugbounty.request.TagRequest;
import com.bugbean.bugbounty.response.TagResponse;
import com.bugbean.bugbounty.service.TagService;
import org.ocpsoft.prettytime.PrettyTime;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

@Controller
public class TagController implements Serializable {
    @Autowired
    private TagService tagService;

    @Autowired
    private TagRepository tagRepository;

    @GetMapping("/createTag")
    public String createTag(Model model) {
        model.addAttribute("pageTitle", "Create new Tag");
        model.addAttribute("tagRequest", new TagRequest());
        return "tag/create";
    }

    @PostMapping("/createTag")
    public String createTag(@ModelAttribute TagRequest tagRequest, Model model) throws Exception {
        var tagDto = new TagDto();
        BeanUtils.copyProperties(tagRequest, tagDto);
        tagService.save(tagDto);
        model.addAttribute("message", "New tag created successfully");
        return "redirect:/tag/show-all";
    }

    @GetMapping("/tag/show-all")
    public String showAllTag(Model model,
                             @RequestParam(name = "_search") String search,
                             @RequestParam(name = "_pageIndex") int pageIndex,
                             @RequestParam(name = "_row") int row,
                             @RequestParam(name = "_sort") String sort) {
        var tagContent = new ArrayList<TagResponse>();
        Page<Tag> t = tagService.show(search, pageIndex, row, sort);

        t.getContent().forEach(tag -> {
            var tagResponse = new TagResponse();
            tagResponse.setId(tag.getId());
            tagResponse.setCreated_at(new PrettyTime().format(new Date(Timestamp.valueOf(tag.getDateTime()).getTime())));
            tagResponse.setTag(tag.getTag());
            tagResponse.setTagDescription(tag.getTagDescription());
            tagResponse.setTotalUsed(tag.getTotalUsed());
            tagContent.add(tagResponse);
        });
        model.addAttribute("pageTitle", "Showing all Tags");
        model.addAttribute("tagResponse", tagContent);
        model.addAttribute("totalPage", t.getTotalPages());
        model.addAttribute("totalElement", t.getTotalElements());
        model.addAttribute("first", t.isFirst());
        model.addAttribute("last", t.isLast());
        model.addAttribute("number", t.getNumber());
        model.addAttribute("search", search);
        model.addAttribute("sort",sort);
        return "tag/show_all";
    }

    @GetMapping("/tag/delete")
    public String deleteTag(@RequestParam Long id, Model model) {
        tagService.delete(id);
        model.addAttribute("message", "Tag deleted successfully");
        return "redirect:/tag/show-all";
    }

    @GetMapping("/tag/edit")
    public String editTag(Model model, @RequestParam Long id) {
        var tag = tagRepository.findById(id).get();
        if (tag.getTotalUsed() > 0) {
            throw new ResourceAlreadyExistsException("This tag is currently using by " + tag.getTotalUsed() + " questions");
        }
        model.addAttribute("tagRequest", new TagRequest());
        model.addAttribute("id", id);
        model.addAttribute("pageTitle", "Update existing Tag");
        return "tag/edit";
    }

    @PostMapping("/tag/edit")
    public String editTag(@ModelAttribute TagRequest tagRequest) {
        var tagDto = new TagDto();
        BeanUtils.copyProperties(tagRequest, tagDto);
        tagService.edit(tagDto);
        return "redirect:/tag/show-all";
    }

}
