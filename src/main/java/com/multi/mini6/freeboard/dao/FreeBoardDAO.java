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
  public int freeBoardFileInsert(FreeBoardAttachVO boardAttachVO) {
    return sqlSession.insert("freeBoardFileInsert", boardAttachVO);
  }

  // 게시글 목록 조회
  public List<FreeBoardVO> list(FreeBoardPageVO freeboardPageVO){
    return sqlSession.selectList("freeBoardList", freeboardPageVO);
  };

  // 게시글 총 개수
  public int freeBoardCount(FreeBoardPageVO freeboardPageVO){
    return sqlSession.selectOne("freeBoardCount", freeboardPageVO);
  };

  // 게시글 상세 보기
  public FreeBoardVO freeBoardOne(int board_id) {
    return sqlSession.selectOne("freeBoardOne", board_id);
  }

  // 게시글 상세보기 - 첨부파일조회
  public List<FreeBoardAttachVO> findByBoardId(int board_id){
    return sqlSession.selectList("freeBoardFileID", board_id);
  }

  // 게시글 클릭시 조회수 증가
  public void freeBoardViewsCount(FreeBoardVO freeBoardVO) {
    sqlSession.update("freeBoardViewsCount", freeBoardVO);
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
  public  void freeBoardFileDelete(int board_id){
    sqlSession.delete("freeBoardFileDelete", board_id);
  }


  // 게시글 수정시 첨부파일 삭제
  public  void freeBoardFileChange(String board_uuid){
    sqlSession.delete("freeBoardFileChange", board_uuid);
  }


  // 댓글 저장
  public void freeBoardCommentInsert(FreeBoardCommentVO freeBoardCommentVO) {
    sqlSession.insert("freeBoardCommentInsert", freeBoardCommentVO);
  }

  // 댓글리스트 가져오기
  public List<FreeBoardCommentVO>freeBoardCommentList (int board_id) {
    return sqlSession.selectList("freeBoardCommentList", board_id);
  }

  // 댓글 수정
  public int freeBoardCommentUpdate(FreeBoardCommentVO freeBoardCommentVO) {
    return sqlSession.update("freeBoardCommentUpdate",freeBoardCommentVO);
  }

  // 댓글 삭제
  public int freeBoardCommentDelete(int  bocm_id) {
    return sqlSession.update("freeBoardCommentDelete",bocm_id);
  }

  // 대댓글 입력
  public void freeBoardCommentReply(FreeBoardCommentVO freeBoardCommentVO) {
    sqlSession.insert("freeBoardCommentReply", freeBoardCommentVO);
  }











}
