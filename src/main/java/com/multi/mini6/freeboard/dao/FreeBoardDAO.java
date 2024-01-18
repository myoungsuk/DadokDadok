package com.multi.mini6.freeboard.dao;

import com.multi.mini6.freeboard.vo.FreeBoardAttachVO;
import com.multi.mini6.freeboard.vo.FreeBoardCommentVO;
import com.multi.mini6.freeboard.vo.FreeBoardPageVO;
import com.multi.mini6.freeboard.vo.FreeBoardVO;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import lombok.extern.slf4j.Slf4j;
@Repository
@Slf4j
public class FreeBoardDAO {
  // 연동처리하는 파일 <-> FreeBoardSQL.xml

  @Autowired
  SqlSessionTemplate sqlSession;

  // 게시글 작성
  public int freeBoardInsert(FreeBoardVO freeBoardVO){
    return sqlSession.insert("freeBoardInsert", freeBoardVO);
  };

  // 게시글 등록 - 파일업로드
  public int fileInsert(FreeBoardAttachVO boardAttachVO) {
    return sqlSession.insert("fileInsert", boardAttachVO);
  }

  // 게시글 목록 조회
  public List<FreeBoardVO> list(FreeBoardPageVO freeboardPageVO){
    return sqlSession.selectList("freeBoardList", freeboardPageVO);
  };

  // 게시글 총 개수
  public int boardCount(FreeBoardPageVO freeboardPageVO){
    return sqlSession.selectOne("boardCount", freeboardPageVO);
  };

  // 게시글 상세 보기
  public FreeBoardVO freeBoardOne(int board_id) {
    return sqlSession.selectOne("freeBoardOne", board_id);
  }

  // 게시글 상세보기 - 첨부파일조회
  public List<FreeBoardAttachVO> findByBoardId(int board_id){
    return sqlSession.selectList("fileID", board_id);
  }

  // 게시글 클릭시 조회수 증가
  public void viewsCount(int board_id) {
    sqlSession.update("viewsCount", board_id);
  }

  // 이전글
  public FreeBoardVO getPreviousPost(int board_id) {
    return sqlSession.selectOne("getPreviousPost", board_id);
  }

  // 다음글
  public FreeBoardVO getNextPost(int board_id) {
    return sqlSession.selectOne("getNextPost", board_id);
  }

  // 게시글 수정
  public void update(FreeBoardVO freeBoardVO) {
    sqlSession.update("freeBoardUpdate", freeBoardVO);
  }

  // 게시글 삭제
  public void delete(int board_id) {
    sqlSession.delete("freeBoardDelete", board_id);
  }

  // 게시글 삭제시 첨부파일 삭제
  public  void fileDelete(int board_id){
    sqlSession.delete("fileDelete", board_id);
  }


  // 게시글 수정시 첨부파일 삭제
  public  void fileChange(String board_uuid){
    sqlSession.delete("fileChange", board_uuid);
  }


  // 댓글 저장
  public void commentInsert(FreeBoardCommentVO freeBoardCommentVO) {
    sqlSession.insert("commentInsert", freeBoardCommentVO);
  }

  // 댓글리스트 가져오기
  public List<FreeBoardCommentVO>findList (int board_id) {
    return sqlSession.selectList("commentList", board_id);
  }

  // 댓글 수정
  public int commentUpdate(FreeBoardCommentVO freeBoardCommentVO) {
    return sqlSession.update("commentUpdate",freeBoardCommentVO);
  }

  // 댓글 삭제
  public int commentDelete(int  bocm_id) {
    return sqlSession.update("commentDelete",bocm_id);
  }

  // 대댓글 입력
  public void commentReply(FreeBoardCommentVO freeBoardCommentVO) {
    sqlSession.insert("commentReply", freeBoardCommentVO);
  }











}
