package com.multi.mini6.bookpage.controller;//package com.multi.mini6.controller;
//
//import com.multi.mini6.service.UserService;
//import com.multi.mini6.vo.UserVO;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.dao.DuplicateKeyException;
//import org.springframework.security.authentication.AnonymousAuthenticationToken;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import javax.servlet.http.HttpSession;
//
//@Controller
//public class UserController {
//
//    @Autowired
//    private UserService userService;
//
//
////    @GetMapping("/")
////    public String home(Model model) {
////        Long id = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
////        UserVO userVo = userService.getUserById(id);
////        userVo.setPassword(null);
////        model.addAttribute("user", userVo);
////
////        return "home";
////    }
//
//    @GetMapping("/userList")
//    public String getUserList(Model model) {
//        model.addAttribute("list", userService.getUserList());
//
//        return "userListPage";
//    }
//
//    @GetMapping("/login")
//    public String loginPage() {
//        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//        if(authentication instanceof AnonymousAuthenticationToken)
//            return "loginPage";
//
//        return "redirect:/userList";
//    }
//
//    @GetMapping("/signup") //회원 가입 페이지
//    public String signupPage() {
//        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//        if(authentication instanceof AnonymousAuthenticationToken)
//            return "signupPage";
//
//        return "redirect:/";
//    }
//
//    @PostMapping("/signup") //회원가입
//    public String signup(UserVO userDto) {
//        try{
//            userService.signup(userDto);
//        } catch (DuplicateKeyException e) {
//            return "redirect:/signup?error_code=-1";
//        } catch (Exception e) {
//            return "redirect:/signup?error_code=-99";
//        }
//        return "redirect:/login";
//    }
//
//    @GetMapping("/update") //회원 정보 수정 페이지
//    public String editPage(Model model) {
//        Long id = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        UserVO userVo = userService.getUserById(id);
//        model.addAttribute("user", userVo);
//
//        return "editPage";
//    }
//
//    @PostMapping("/update") //회원 정보 수정
//    public String edit(UserVO userDto) {
//        Long id = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        userDto.setId(id);
//        userService.edit(userDto);
//
//        return "redirect:/";
//    }
//
//
//    @PostMapping("/delete") //회원 탈퇴
//    public String withdraw(HttpSession session) {
//        Long id = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        if(id != null) {
//            userService.withdraw(id);
//        }
//        SecurityContextHolder.clearContext();
//
//        return "redirect:/";
//    }
//}
