package com.multi.mini6.librarypage.service;

import com.multi.mini6.librarypage.dao.LibraryPageDAO;
import com.multi.mini6.librarypage.vo.LibraryPageVO;
import com.multi.mini6.librarypage.vo.LibraryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LibraryPageService {
    @Autowired
    LibraryPageDAO libraryPageDAO;

    public int count() {
        return libraryPageDAO.count();
    }

    public List<LibraryVO> list(LibraryPageVO libraryPageVO) {
        return libraryPageDAO.list2(libraryPageVO);
    }

    public List<LibraryVO> list3(LibraryPageVO libraryPageVO) {
        return libraryPageDAO.list3(libraryPageVO);
    }

    public List<LibraryVO> list4(LibraryPageVO libraryPageVO) {
        return libraryPageDAO.list4(libraryPageVO);
    }

    public List<LibraryVO> search_name(LibraryPageVO libraryPageVO) {
        return libraryPageDAO.search_name(libraryPageVO);
    }

    public int search_count(LibraryPageVO libraryPageVO) {
        return libraryPageDAO.search_count(libraryPageVO);
    }
}

