package com.multi.mini6.bookpage.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@Slf4j
public class SecurityController {

    @GetMapping("/accessError")
    public void accessDenied(Authentication auth, Model model) {
        //Authentication타입의 파라미터를 받도록 설계해서 필요한 경우 사용자의 정보를 확인할 수 있도록 함

        log.info("access Denied" + auth);
        model.addAttribute("msg", "Access Denied");
    }

    @GetMapping("/customLogin")
    public void loginInput(String error, String logout, Model model) {
        log.info("error 여부 : " + error);
        log.info("logout 여부 : "+ logout);

        if(error != null) {
            model.addAttribute("error", "로그인 관련 에러입니다. 계정확인을 다시해주세요.");

        }

        if(logout != null) {
            model.addAttribute("logout", "로그아웃 했습니다!");

        }

    }

    @GetMapping("/customLogout")
    public void logoutGet() {
        log.info("로그아웃 폼으로 이동");
    }

    @PostMapping("/customLogout")
    public String logoutPost(String logout, Model model) {
        log.info("post방식으로 로그아웃 처리 완료");

        log.info("logout 여부 : "+ logout);

        if(logout != null) {
            model.addAttribute("logout", "로그아웃 했습니다!");

        }

        return "redirect:/customLogin";
    }
}