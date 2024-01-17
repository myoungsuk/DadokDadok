package com.multi.mini6.librarypage.service;

import com.multi.mini6.librarypage.vo.LibraryVO;
import com.multi.mini6.librarypage.dao.LibraryDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LibraryService {

    @Autowired
    LibraryDAO libraryDAO;

    public int library_insert(LibraryVO libraryVO){
        // 전처리
        return libraryDAO.insert(libraryVO);
    }



    public LibraryVO library_one(LibraryVO libraryVO) throws Exception {
        return libraryDAO.one(libraryVO);
    }

}
