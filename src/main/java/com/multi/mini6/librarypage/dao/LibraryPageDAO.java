package com.multi.mini6.librarypage.dao;

import com.multi.mini6.librarypage.vo.LibraryVO;
import com.multi.mini6.librarypage.vo.LibraryPageVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LibraryPageDAO {
    @Autowired
    SqlSessionTemplate my;

    public int count() {
        return my.selectOne("library.count");
    }

    public List<LibraryVO> list2(LibraryPageVO libraryPageVO) {
        return my.selectList("library.list2", libraryPageVO);
    }

    public List<LibraryVO> list3(LibraryPageVO libraryPageVO) {
        return my.selectList("library.list3", libraryPageVO);
    }

    public List<LibraryVO> list4(LibraryPageVO libraryPageVO) {
        return my.selectList("library.list4", libraryPageVO);
    }

    // 게시물 이름 검색
    public List<LibraryVO> search_name(LibraryPageVO libraryPageVO){
        return my.selectList("library.search_name", libraryPageVO);
    }

    public int search_count(LibraryPageVO libraryPageVO) {
        return my.selectOne("library.count1", libraryPageVO);
    }


}