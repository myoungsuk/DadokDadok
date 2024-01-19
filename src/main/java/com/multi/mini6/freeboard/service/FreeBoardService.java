package com.multi.mini6.freeboard.service;

import com.multi.mini6.freeboard.dao.FreeBoardDAO;
import com.multi.mini6.freeboard.vo.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lombok.extern.slf4j.Slf4j;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Slf4j
public class FreeBoardService {

  @Autowired
  private FreeBoardDAO freeBoardDAO;


  // 게시글 작성
  @Transactional
  public int insert(FreeBoardVO freeBoardVO){
    int result = freeBoardDAO.freeBoardInsert(freeBoardVO);

    if(freeBoardVO.getAttachList() == null || freeBoardVO.getAttachList().size() <= 0){
      return result;
    }

    freeBoardVO.getAttachList().forEach(attach -> {
      attach.setBoard_id(freeBoardVO.getBoard_id()); // 첨부파일에 게시글 ID 설정
      freeBoardDAO.freeBoardFileInsert(attach);
    });

    return result;
  }

  // 게시글 목록
  public List<FreeBoardVO> freeBoardList(FreeBoardPageVO freeboardPageVO) {
    return freeBoardDAO.list(freeboardPageVO);
  }

  // 전체 게시물 수
  public int boardCount(FreeBoardPageVO freeboardPageVO) {
    return  freeBoardDAO.freeBoardCount(freeboardPageVO);
  }

  // 게시글 상세보기
  public FreeBoardVO freeBoardOne(int board_id) {
    return freeBoardDAO.freeBoardOne(board_id);
  }

  // 게시글 상세보기 - 첨부파일조회
  public List<FreeBoardAttachVO> getAttachList(int board_id){
    return freeBoardDAO.findByBoardId(board_id);
  }

  // 게시글 클릭시 조회수 증가
  public void viewsCount(FreeBoardVO freeBoardVO) {
    freeBoardDAO.freeBoardViewsCount(freeBoardVO);
  }

  // 이전글
  public FreeBoardVO getPreviousPost(int board_id) {
    return freeBoardDAO.getPreviousPost(board_id);
  }

  //다음글
  public FreeBoardVO getNextPost(int board_id) {
    return freeBoardDAO.getNextPost(board_id);
  }

  // 게시글 삭제시 첨부파일 삭제
  public void fileDelete(int board_id){
    freeBoardDAO.freeBoardFileDelete(board_id);
  }

  // 게시글 삭제
  public void delete(int board_id) {
    freeBoardDAO.delete(board_id);
  }

  // 게시글 수정
  public void update(FreeBoardVO freeBoardVO){
    freeBoardDAO.update(freeBoardVO);
  }


  // 게시글 첨부파일 수정
  public void Fileupdate(int boardId, List<FreeBoardAttachVO> fileList) {

    // 데이터베이스에서 현재 board_id에 해당하는 첨부 파일 목록을 조회
    List<FreeBoardAttachVO> fileInfo = freeBoardDAO.findByBoardId(boardId);

    if (fileList != null) {
      // fileList의 UUID 목록을 생성
      List<String> fileUuid = new ArrayList<>();
      for (FreeBoardAttachVO file : fileList) {
        fileUuid.add(file.getBoard_uuid());
      }

      // 데이터베이스에 있는 파일 중 fileList에 없는 파일을 삭제
      for (FreeBoardAttachVO existingFile : fileInfo) {
        if (!fileUuid.contains(existingFile.getBoard_uuid())) {
          freeBoardDAO.freeBoardFileChange(existingFile.getBoard_uuid());
        }
      }
    }

    if(fileList != null) {
      // fileList 중에서 데이터베이스에 없는 새 파일을 추가
      for (FreeBoardAttachVO file : fileList) {
        boolean exists = false;
        for (FreeBoardAttachVO existingFile : fileInfo) {
          if (existingFile.getBoard_uuid().equals(file.getBoard_uuid())) {
            exists = true;
            break;
          }
        }
        if (!exists) {
          freeBoardDAO.freeBoardFileInsert(file);
        }
      }
    }
  }




  // 댓글 저장
public void commentInsert(FreeBoardCommentVO freeBoardCommentVO){
    freeBoardDAO.freeBoardCommentInsert(freeBoardCommentVO);
}

// 댓글 리스트 가져오기
  public Map<Integer, List<FreeBoardCommentVO>> findList(int board_id ){
     // 댓글 정보 가져오기
      List<FreeBoardCommentVO> commentInfo =  freeBoardDAO.freeBoardCommentList(board_id);

      Map<Integer, List<FreeBoardCommentVO>> groupedComments = new HashMap<>();
      // 댓글 정보를 그룹별로 분류
      for (FreeBoardCommentVO comment : commentInfo) {
          // 현재 댓글의 그룹 ID를 가져옵니다.
          int groupId = comment.getCm_group();

          // 해당 그룹 ID의 댓글 리스트를 조회합니다.
          List<FreeBoardCommentVO> group = groupedComments.get(groupId);

          // 리스트가 없으면 새로 생성하고 맵에 추가합니다.
          if (group == null) {
              group = new ArrayList<>();
              groupedComments.put(groupId, group);
          }

          // 현재 댓글을 그룹 리스트에 추가합니다.
          group.add(comment);
      }
      return groupedComments;
  }


  // 댓글 수정
  public void commentUpdate(FreeBoardCommentVO freeBoardCommentVO) {
    freeBoardDAO.freeBoardCommentUpdate(freeBoardCommentVO);
  }

  // 댓글삭제
  public void commentDelete(int bocm_id){
    freeBoardDAO.freeBoardCommentDelete(bocm_id);
  }

  // 대댓글 입력
  public void commentReply(FreeBoardCommentVO freeBoardCommentVO){
    freeBoardDAO.freeBoardCommentReply(freeBoardCommentVO);
  }









}


