package com.bugbean.bugbounty.controller;

import com.bugbean.bugbounty.config.exception.ResourceAlreadyExistsException;
import com.bugbean.bugbounty.dto.TagDto;
import com.bugbean.bugbounty.repository.TagRepository;
import com.bugbean.bugbounty.request.TagRequest;
import com.bugbean.bugbounty.service.TagService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.Serializable;

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
    public String showAllTag(Model model) {
        model.addAttribute("pageTitle", "Showing all Tags");
        model.addAttribute("tagResponse", tagService.show());
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
