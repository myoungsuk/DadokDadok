package com.multi.mini6.bookpage.service;//package com.multi.mini6.service;
//
//import com.multi.mini6.dao.UserDAO;
//import com.multi.mini6.vo.UserVO;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//
//@Service
//public class UserService {
//
//    @Autowired
//    private UserDAO userDAO;
//
//    private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//
//    public List<UserVO> getUserList() {
//        return userDAO.getUserList();
//    }
//
//    public UserVO getUserById(Long id) {
//        return userDAO.getUserById(id);
//    }
//
//    public UserVO getUserByEmail(String email) {
//        return userDAO.getUserByEmail(email);
//    }
//
//    public void signup(UserVO userVo) { // 회원 가입
//        if (!userVo.getUsername().equals("") && !userVo.getEmail().equals("")) {
//            userVo.setPassword(passwordEncoder.encode(userVo.getPassword()));
//            userDAO.insertUser(userVo);
//        }
//    }
//
//    public void edit(UserVO userVo) { // 회원 정보 수정
//        userVo.setPassword(passwordEncoder.encode(userVo.getPassword()));
//        userDAO.updateUser(userVo);
//    }
//
//    public void withdraw(Long id) { // 회원 탈퇴
//        userDAO.deleteUser(id);
//    }
//
//    public PasswordEncoder passwordEncoder() {
//        return this.passwordEncoder;
//    }
//
//}
