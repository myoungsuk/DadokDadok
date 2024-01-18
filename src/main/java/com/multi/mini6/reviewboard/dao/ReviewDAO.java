package com.multi.mini6.reviewboard.dao;

import com.multi.mini6.reviewboard.vo.PageVo;
import com.multi.mini6.reviewboard.vo.ReviewAttachVO;
import com.multi.mini6.reviewboard.vo.ReviewVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class ReviewDAO {

    @Autowired
    SqlSessionTemplate my;

    public int insert(ReviewVO reviewVO){
        return my.insert("reviewInsert", reviewVO);
    };
    public int update(ReviewVO reviewVO) {
        return my.update("reviewupdate", reviewVO);
    }

    public int delete(ReviewVO reviewVO) {
        return my.delete("delete", reviewVO);
    }
    public List<ReviewVO> list(PageVo pageVO) {
        return my.selectList("reviewlist", pageVO);
    }
    public ReviewVO one(ReviewVO reviewVO) throws Exception {
        // 3.SQL문 결정/생성
        ReviewVO dto = my.selectOne("one", reviewVO);

        return dto;
    }

    public List<ReviewVO> list1(PageVo pageVO) {
        return my.selectList("list2", pageVO); //==>bbs.html에 있는 bbs를 호출
    }
    public int count() {
        return my.selectOne("reviewcount");
    }
    public List<ReviewVO> search(PageVo pageVo) {
        return my.selectList("search", pageVo);
    }

    public int searchCount(PageVo pageVo) {
        return my.selectOne("searchCount", pageVo);
    }

    public int increaseViews(int reviewId) {
        return my.update("increaseViews", reviewId);
    }
    // 게시글 등록 - 파일업로드
    public int fileInsert(ReviewAttachVO reviewAttachVO) {
        return my.insert("attachInsert", reviewAttachVO);
    }
    // 게시글 상세보기 - 첨부파일조회
    public List<ReviewAttachVO> findByBoardId(int review_id){
        return my.selectList("fileID", review_id);
    }
    // 게시글 삭제시 첨부파일 삭제
    public  void fileDelete(int review_id){
        my.delete("fileDelete", review_id);
    }


    // 게시글 수정시 첨부파일 삭제
    public  void fileChange(String review_uuid){
        my.delete("fileChange", review_uuid);
    }
}
