package com.multi.mini6.librarypage.controller;

import com.multi.mini6.librarypage.vo.LibraryVO;
import com.multi.mini6.librarypage.service.LibraryService;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Log4j2
@RequestMapping("librarypage")
public class LibraryController {
    @Autowired
    LibraryService libraryService;

    @RequestMapping("/library_one")
    public void one(LibraryVO libraryVO, Model model) throws Exception {
        //System.out.println(libraryVO);
        LibraryVO bag = libraryService.library_one(libraryVO);
        log.info("one bag 출력 >> " + bag);
        model.addAttribute("bag", bag);
    }

    @RequestMapping("/library_insert")
    public void insert(LibraryVO libraryVO, Model model) {
        int result = libraryService.library_insert(libraryVO);
        System.out.println(result);
        model.addAttribute("result", result);
    }




}
