package com.multi.mini6.bookpage.service;

import com.multi.mini6.bookpage.domain.BookVO;
import com.multi.mini6.bookpage.domain.PageVO;
import com.multi.mini6.bookpage.mapper.BookMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
@RequiredArgsConstructor
@Log4j2
public class BookService {

	@Autowired
	private BookMapper bookMapper;


	//select문
	public List<BookVO> getAllBooks() {

		return bookMapper.selectAll();
	}

	public BookVO getBookByISBN(String bookISBN) {
		return bookMapper.selectOneByISBN(bookISBN);
	}

	public BookVO getBookByName(String bookName) {
		return bookMapper.selectOneByName(bookName);
	}

	public List<BookVO> getBookByAll(String AllBookThing) {
		return bookMapper.searchBook(AllBookThing);
	}

	public List<BookVO> getPagedBooks(PageVO pageVO) {
		return bookMapper.getPagedBooks(pageVO);
	}

	public int getBookCount() {
		return bookMapper.getBookCount();
	}



	//insert문
	public int addBook(BookVO bookVO) {
		return bookMapper.insertOne(bookVO);
	}

	//update문
	public int updateBook(BookVO bookVO) {
		return bookMapper.updateOne(bookVO);
	}

	//delete문
	public int deleteBook(String bookISBN) {
		return bookMapper.deleteOne(bookISBN);
	}


}
