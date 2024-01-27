package com.multi.mini6.mainpage.dao;

import com.multi.mini6.freeboard.vo.FreeBoardVO;
import com.multi.mini6.noticeboard.vo.NoticeBoardVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class MainPageDAO {

  @Autowired
  SqlSessionTemplate sqlSession;


  // 자유게시판에서 최신순 5개 가져오기
  public List<FreeBoardVO> freeBoardListFive(FreeBoardVO freeBoardVO) {
    return sqlSession.selectList("freeBoardListFive", freeBoardVO);
  }

  public List<NoticeBoardVO> noticeBoardListFive(NoticeBoardVO noticeBoardVO){
    return sqlSession.selectList("noticeBoardListFive", noticeBoardVO);
  }


}
