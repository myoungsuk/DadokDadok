package com.multi.mini6.reviewboard.service;


import com.multi.mini6.reviewboard.dao.ReviewDAO;
import com.multi.mini6.reviewboard.vo.PageVo;
import com.multi.mini6.reviewboard.vo.ReviewAttachVO;
import com.multi.mini6.reviewboard.vo.ReviewVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class ReviewService {

@Autowired
ReviewDAO reviewDAO;

    @Transactional
    public int insert(ReviewVO reviewVO){
        int result = reviewDAO.insert(reviewVO);

        if(reviewVO.getAttachVO() == null || reviewVO.getAttachVO().size() <= 0){
            return result;
        }

        reviewVO.getAttachVO().forEach(attach -> {
            attach.setReview_id(reviewVO.getReview_id()); // 첨부파일에 게시글 ID 설정
            reviewDAO.fileInsert(attach);
        });

        return result;
    }

    public void review_insert(ReviewVO reviewVO){


         reviewDAO.insert(reviewVO);
    }

    public int review_update(ReviewVO reviewVO){
        return  reviewDAO.update(reviewVO);

    }
    public int review_delete(ReviewVO reviewVO){

        return reviewDAO.delete(reviewVO);
    }
    public List<ReviewVO> review_list3(PageVo pageVO){

        return reviewDAO.list(pageVO);
    }
    public int delete(ReviewVO reviewVO){

        return reviewDAO.delete(reviewVO);
    }

    public ReviewVO one(ReviewVO reviewVO) throws Exception {

        return reviewDAO.one(reviewVO);
    }
    public int count() {
        return reviewDAO.count();
    }

    public List<ReviewVO> search(PageVo pageVo) {
        return reviewDAO.search(pageVo);
    }

    public int searchCount(PageVo pageVo) {
        return reviewDAO.searchCount(pageVo);
    }
    @Transactional
    public int increaseViews(int reviewId) {
        return reviewDAO.increaseViews(reviewId);
    }

    public void file_insert(ReviewAttachVO reviewAttachVO) {
        reviewDAO.fileInsert(reviewAttachVO);
    }
    // 게시글 상세보기 - 첨부파일조회
    public List<ReviewAttachVO> getAttachList(int review_id){
        return reviewDAO.findByBoardId(review_id);
    }

    // 게시글 삭제시 첨부파일 삭제
    public void fileDelete(int review_id){
        reviewDAO.fileDelete(review_id);
    }
    // 게시글 첨부파일 수정
    public void Fileupdate(int boardId, List<ReviewAttachVO> fileList) {

        // 데이터베이스에서 현재 board_id에 해당하는 첨부 파일 목록을 조회
        List<ReviewAttachVO> fileInfo = reviewDAO.findByBoardId(boardId);

        if (fileList != null) {
            // fileList의 UUID 목록을 생성
            List<String> fileUuid = new ArrayList<>();
            for (ReviewAttachVO file : fileList) {
                fileUuid.add(file.getReview_uuid());
            }

            // 데이터베이스에 있는 파일 중 fileList에 없는 파일을 삭제
            for (ReviewAttachVO existingFile : fileInfo) {
                if (!fileUuid.contains(existingFile.getReview_uuid())) {
                    reviewDAO.fileChange(existingFile.getReview_uuid());
                }
            }
        }
        // fileList 중에서 데이터베이스에 없는 새 파일을 추가
        for (ReviewAttachVO file : fileList) {
            boolean exists = false;
            for (ReviewAttachVO existingFile : fileInfo) {
                if (existingFile.getReview_uuid().equals(file.getReview_uuid())) {
                    exists = true;
                    break;
                }
            }
            if (!exists) {
                reviewDAO.fileInsert(file);
            }
        }
    }
}

