package com.multi.mini6.librarypage.dao;

import java.util.List;

import com.multi.mini6.librarypage.vo.LibraryVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LibraryDAO {
    @Autowired
    SqlSessionTemplate my;

    //도서관 정보 삽입
    public int insert(LibraryVO libraryVO){
        return my.insert("library.insert", libraryVO);
    }

    // 리스트 중에서 선택한 도서관 하나 보기
    public LibraryVO one(LibraryVO libraryVO) throws Exception {
        return my.selectOne("one", libraryVO);
    }




}
