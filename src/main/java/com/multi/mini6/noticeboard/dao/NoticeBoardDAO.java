package com.multi.mini6.noticeboard.dao;

import com.multi.mini6.noticeboard.vo.NoticeBoardPageVO;
import com.multi.mini6.noticeboard.vo.NoticeBoardVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class NoticeBoardDAO {

    @Autowired
    SqlSessionTemplate my;

    public void insertNotice(NoticeBoardVO noticeBoardVO) {
        my.insert("insertNotice", noticeBoardVO);
    }

    public void updateNotice(NoticeBoardVO noticeBoardVO) {
        my.update("updateNotice", noticeBoardVO);
    }

    public void deleteNotice(int notc_id) {
        my.delete("deleteNotice", notc_id);
    }

    public List<NoticeBoardVO> listNotice() throws Exception{
        return my.selectList("noticeboard.listNotice");
    }

    public NoticeBoardVO oneNotice(int notc_id) throws Exception{
        System.out.println("notc_id : " + notc_id);
        return my.selectOne("oneNotice", notc_id);
    }

    public NoticeBoardVO getNoticeBoardById(int notc_id) {
        return my.selectOne("getNoticeBoardById", notc_id);
    }

    public void updateViewCountNotice(int notc_id) {
        my.update("noticeboard.updateViewCountNotice", notc_id);
    }

    public List<NoticeBoardVO> selectNoticeAll(){
        return my.selectList("selectNoticeAll");

    }

    public int getNoticeBoardCount(){
        return my.selectOne("getNoticeBoardCount");
    }

    public List<NoticeBoardVO> getPagedNoticeBoard(NoticeBoardPageVO noticeBoardPageVO){
        return my.selectList("getPagedNoticeBoard", noticeBoardPageVO);
    }

    public NoticeBoardVO moveNoticeBoardPage(int notc_id) throws Exception{
        return my.selectOne("moveNoticeBoardPage", notc_id);
    }

    public List<NoticeBoardVO> searchNoticeBoard(NoticeBoardPageVO noticeBoardPageVO) {
        // Implement the logic to construct the MyBatis mapper method call
        // Example:
        return my.selectList("searchNoticeBoard", noticeBoardPageVO);
    }

//    public List<NoticeBoardVO> searchNoticeBoard(NoticeBoardCriteriaVO criteria){
//        return my.selectList("searchNoticeBoard", criteria);
//    }

}

