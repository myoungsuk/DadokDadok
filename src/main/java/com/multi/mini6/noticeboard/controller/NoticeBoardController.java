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
                           @RequestParam(defaultValue = "10") int pageSize) throws Exception {
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
    public String insertNotice(@RequestParam(value = "file", required = false) MultipartFile file, @RequestParam("notc_title") String notc_title, @RequestParam("notc_content") String notc_content, RedirectAttributes redirectAttributes) {
        try {
            NoticeBoardVO noticeBoardVO = new NoticeBoardVO();
            noticeBoardVO.setNotc_title(notc_title);
            noticeBoardVO.setNotc_content(notc_content);

            if (file != null && !file.isEmpty()) {
                String fileName = file.getOriginalFilename();
                String uuid = UUID.randomUUID().toString();
                Path filePath = Paths.get("C:/Users/yuumi/Downloads/apache-tomcat-8.5.96/bin/upload-dir/" + uuid + "_" + fileName);
                Files.write(filePath, file.getBytes());

                noticeBoardVO.setNotice_uuid(uuid);
                noticeBoardVO.setNotice_file_name(fileName);
            }

            noticeBoardService.insertNotice(noticeBoardVO);

            redirectAttributes.addFlashAttribute("successMessage", "Notice inserted successfully");
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

    @RequestMapping(value = "/noticeboard_one", method = RequestMethod.GET)
    public String viewNotice(@RequestParam("notc_id") int notc_id, Model model) {
        try {
            NoticeBoardVO noticeBoardVO = noticeBoardService.getNoticeBoardById(notc_id);

            if (noticeBoardVO != null) {
                model.addAttribute("noticeBoardVO", noticeBoardVO);

                noticeBoardService.updateViewCountNotice(notc_id);

                model.addAttribute("move", noticeBoardService.moveNoticeBoardPage(noticeBoardVO.getNotc_id()));

                return "noticeboard/noticeboard_one";
            } else {
                return "noticeboard/notice_not_found";
            }
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred while processing your request.");
            return "error";
        }
    }

    @GetMapping("/noticeboard_search")
    public String searchNotice(@RequestParam(value = "searchType", required = false) String searchType,
                               @RequestParam(value = "keyword", required = false) String keyword,
                               @RequestParam(value = "page", defaultValue = "1") int page,
                               @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                               Model model) {
        if (searchType == null || keyword == null || searchType.isEmpty() || keyword.isEmpty()) {
            // Handle invalid or missing search parameters
            // For example, you can add an error message to the model and return to the search page with the error message displayed
            model.addAttribute("error", "Search type and keyword are required.");
            return "noticeboard/search_error";
        }

        try {
            int totalItemCount = noticeBoardService.getNoticeBoardCount(); // Get the total count of items
            NoticeBoardPageVO pageVO = new NoticeBoardPageVO(page, pageSize, totalItemCount); // Create a NoticeBoardPageVO with pagination parameters
            pageVO.setType(searchType);
            pageVO.setKeyword(keyword);
            pageVO.calculateOffset(); // Calculate the offset based on the current page and page size
            pageVO.setStartEnd(); // Set the start and end indices for the current page

            List<NoticeBoardVO> searchResults = noticeBoardService.searchNoticeBoard(pageVO); // Pass the pageVO to the service method for search
            model.addAttribute("searchResults", searchResults);
            model.addAttribute("noticeBoardPageVO", pageVO); // Add the pageVO to the model for pagination
            return "noticeboard/noticeboard_search";
        } catch (Exception e) {
            // Handle exceptions, such as database errors or service failures
            // For example, you can add an error message to the model and return to the search page with the error message displayed
            model.addAttribute("error", "An error occurred while processing your search.");
            return "noticeboard/search_error";
        }
    }



//    @GetMapping("/noticeboard_search")
//    public String searchNoticeBoard(@RequestParam("searchType") String searchType,
//                                    @RequestParam("keyword") String keyword,
//                                    Model model) {
//        NoticeBoardCriteriaVO criteria = new NoticeBoardCriteriaVO();
//        criteria.setSearchType(searchType);
//        criteria.setKeyword(keyword);
//
//        List<NoticeBoardVO> searchResults = noticeBoardService.searchNoticeBoard(criteria);
//        model.addAttribute("searchResults", searchResults);
//
//        return "noticeboard/noticeboard_search";
//    }



}
