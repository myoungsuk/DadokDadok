package com.multi.mini6.mainpage.controller;

import com.multi.mini6.freeboard.vo.FreeBoardVO;
import com.multi.mini6.mainpage.service.MainPageService;
import com.multi.mini6.noticeboard.vo.NoticeBoardVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequestMapping("/mainpage")
public class MainPageController {

  @Autowired
  private MainPageService mainPageService;


  @GetMapping("/index")
  public String home(Model model, FreeBoardVO freeBoardVO, NoticeBoardVO noticeBoardVO) {

    // 자유게시판에서 글 최신순 5개 가져오기
    List<FreeBoardVO> freeBoardList = (List<FreeBoardVO>) mainPageService.getFreeBoardList(freeBoardVO);

    model.addAttribute("freeBoardList", freeBoardList); // 자유게시판

    // 공지게시판에서 글 최신순 5개 가져오기
    List<NoticeBoardVO> noticeBoardList = (List<NoticeBoardVO>)mainPageService.getNoticeBoardList(noticeBoardVO);
    model.addAttribute("noticeBoardList", noticeBoardList);

    return "mainpage/index";
  }

}
