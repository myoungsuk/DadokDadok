package com.multi.mini6.bookpage.service;//package com.multi.mini6.dao;
//
//
//import com.multi.mini6.vo.BookVO;
//import com.multi.mini6.vo.UserVO;
//import org.mybatis.spring.SqlSessionTemplate;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Repository;
//
//import java.util.List;
//
//@Repository
//public class UserDAO {
//
//    @Autowired
//    SqlSessionTemplate my;
//
//    //User리스트 가져오기
//    public List<UserVO> getUserList() {
//        return my.selectList("user.getUserList");
//    }
//
//    //Id 값으로 유저 정보가저오기
//    public UserVO getUserById(Long id) {
//        return my.selectOne("user.getUserById", id);
//    }
//
//    //Email 값으로 유저 정보가저오기
//    public UserVO getUserByEmail(String email) {
//        return my.selectOne("user.getUserByEmail", email);
//    }
//
//    //회원 가입
//    public void insertUser(UserVO userVo) {
//        my.insert("user.insertUser", userVo);
//    }
//
//    //회원 정보 수정
//    public void updateUser(UserVO userVo) {
//        my.update("user.updateUser", userVo);
//    }
//
//    //회원 탈퇴
//    public void deleteUser(Long id) {
//        my.delete("user.deleteUser", id);
//    }
//
//}
