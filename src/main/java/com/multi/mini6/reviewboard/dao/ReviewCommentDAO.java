package com.multi.mini6.reviewboard.dao;

import com.multi.mini6.reviewboard.vo.ReviewCommentVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReviewCommentDAO {


    @Autowired
    SqlSessionTemplate my;

    public int insert(ReviewCommentVO reviewCommentVO) {
        return my.insert("review_comment_insert", reviewCommentVO);
    }

    public int update(ReviewCommentVO reviewCommentVO) {
        return my.update("review_comment_update", reviewCommentVO);
    }

    public int delete(ReviewCommentVO reviewCommentVO) {
        return my.delete("review_comment_delete", reviewCommentVO);
    }
    public List<ReviewCommentVO> list(int reviewCommentVO) {
        return my.selectList("list",reviewCommentVO);
    }
    }
