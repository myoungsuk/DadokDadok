package com.multi.mini6.reviewboard.service;

import com.multi.mini6.reviewboard.dao.ReviewCommentDAO;
import com.multi.mini6.reviewboard.vo.ReviewCommentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewCommentService {
    @Autowired
    ReviewCommentDAO reviewCommentDAO;


    public int insert(ReviewCommentVO reviewCommentVO){

        return reviewCommentDAO.insert(reviewCommentVO);


    }

    public int update(ReviewCommentVO reviewCommentVO){
        return  reviewCommentDAO.update(reviewCommentVO);
    }

   public List<ReviewCommentVO> list(int review_id){
        return  reviewCommentDAO.list(review_id);
    }
    public int delete(ReviewCommentVO reviewCommentVO) {
        return reviewCommentDAO.delete(reviewCommentVO);
    }



}
