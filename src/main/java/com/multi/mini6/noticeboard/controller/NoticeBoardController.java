package com.multi.mini6.noticeboard.controller;

import com.multi.mini6.noticeboard.service.NoticeBoardService;
import com.multi.mini6.noticeboard.vo.NoticeBoardPageVO;
import com.multi.mini6.noticeboard.vo.NoticeBoardVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("noticeboard")
public class NoticeBoardController {

    @Autowired
    @Inject
    NoticeBoardService noticeBoardService;

    @RequestMapping("/noticeboard")
    public void getNotices(Model model,
                           NoticeBoardPageVO noticeBoardPageVO,
                           @RequestParam(defaultValue = "1") int page,
                           @RequestParam(defaultValue = "5") int pageSize) throws Exception {
        int totalItemCount = noticeBoardService.getNoticeBoardCount();
        noticeBoardPageVO = new NoticeBoardPageVO(page, pageSize, totalItemCount);
        List<NoticeBoardVO> noticeboard = noticeBoardService.getPagedNoticeBoard(noticeBoardPageVO);
        int totalPages = noticeBoardPageVO.getTotalPages();
        int count = noticeBoardService.getNoticeBoardCount();
        log.info("noticeboard: " + noticeboard);
        model.addAttribute("noticeboard", noticeboard);
        model.addAttribute("noticeBoardPageVO", noticeBoardPageVO);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("count", count);
    }

    @RequestMapping(value = "/noticeboard_write")
    public String write() throws Exception{
        return "noticeboard/noticeboard_write";
    }

    @PostMapping("/noticeboard_insert")
    public String insertNotice(@RequestParam("file") MultipartFile file, @RequestParam("notc_title") String notc_title, @RequestParam("notc_content") String notc_content, RedirectAttributes redirectAttributes) {
        try {
            if (!file.isEmpty()) {
                String fileName = file.getOriginalFilename();
                String uuid = UUID.randomUUID().toString();
                Path filePath = Paths.get("C:/Users/yuumi/Downloads/apache-tomcat-8.5.96/bin/upload-dir/" + uuid + "_" + fileName);
                Files.write(filePath, file.getBytes());

                NoticeBoardVO noticeBoardVO = new NoticeBoardVO();
                noticeBoardVO.setNotc_title(notc_title);
                noticeBoardVO.setNotc_content(notc_content);
                noticeBoardVO.setNotice_uuid(uuid);
                noticeBoardVO.setNotice_file_name(fileName);

                noticeBoardService.insertNotice(noticeBoardVO);

                redirectAttributes.addFlashAttribute("successMessage", "Notice inserted successfully");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "File is empty");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to insert notice");
        }

        return "redirect:noticeboard";
    }

    @GetMapping("/noticeboard_update/{notc_id}")
    public String showUpdateForm(@PathVariable("notc_id") int notc_id, Model model) {
        NoticeBoardVO existingNotice = noticeBoardService.getNoticeBoardById(notc_id);

        model.addAttribute("existingNotice", existingNotice);

        return "noticeboard/noticeboard_update";
    }

    @PostMapping("/noticeboard_update/{notc_id}")
    public String handleUpdateForm(@PathVariable("notc_id") int notc_id,
                                   @ModelAttribute("existingNotice") NoticeBoardVO existingNotice,
                                   @RequestParam("file") MultipartFile file,
                                   RedirectAttributes redirectAttributes) {
        try {
            noticeBoardService.updateNotice(existingNotice, file);
            return "redirect:/noticeboard/noticeboard_one?notc_id=" + notc_id;
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update notice");
            return "redirect:/noticeboard/noticeboard_one?notc_id=" + notc_id;
        }
    }

    @DeleteMapping("/noticeboard_delete/{notc_id}")
    public String deleteNotice(@PathVariable("notc_id") int notc_id, RedirectAttributes redirectAttributes) {
        try {
            noticeBoardService.deleteNotice(notc_id);
            redirectAttributes.addFlashAttribute("successMessage", "Notice deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to delete notice");
        }
        return "redirect:/noticeboard";
    }

    @GetMapping("/noticeboard_one")
    public String viewNotice(@RequestParam("notc_id") int notc_id, Model model) {
        try {
            NoticeBoardVO noticeBoardVO = noticeBoardService.getNoticeBoardById(notc_id);
            if (noticeBoardVO != null) {
                noticeBoardService.updateViewCount(notc_id);

                model.addAttribute("noticeBoardVO", noticeBoardVO);
                return "noticeboard/noticeboard_one";
            } else {
                return "noticeboard/notice_not_found";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

}
