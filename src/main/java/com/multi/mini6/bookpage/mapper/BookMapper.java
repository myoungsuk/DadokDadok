package com.multi.mini6.bookpage.mapper;

import com.multi.mini6.bookpage.domain.BookVO;
import com.multi.mini6.bookpage.domain.PageVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BookMapper {

    // 책 정보 삽입
    int insertOne(BookVO bookVO);

    // ISBN으로 책 정보 조회
    BookVO selectOneByISBN(String bookISBN);

    // 책 이름으로 책 정보 조회
    BookVO selectOneByName(String bookName);

    // 모든 책 정보 조회
    List<BookVO> selectAll();

    // 총 책 개수 조회
    int getBookCount();

    // 도서 정보 페이징 처리 리스트
    List<BookVO> getPagedBooks(PageVO pageVO);

    // 책 정보 업데이트
    int updateOne(BookVO bookVO);

    // 책 정보 삭제
    int deleteOne(String bookISBN);

    // 책 검색
    List<BookVO> searchBook(String keyword);


}
