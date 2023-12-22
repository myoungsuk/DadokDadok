package com.multi.mini6.bookpage.mapper;

import com.multi.mini6.bookpage.domain.MovieVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MovieMapper {

//    public void insert(MovieVO movieVO) {
//        my.insert("movie.insert", movieVO);
//    }
//
//    public List<MovieVO> getPagedMovieList(PageVO pageVO) {
//        Map<String, Integer> map = new HashMap<>();
//        map.put("offset", pageVO.getOffset());
//        map.put("pageSize", pageVO.getPageSize());
//        return my.selectList("movie.getPagedMovieList", map);
//    }
//
//    public int getMovieCount() {
//        return my.selectOne("movie.getMovieCount");
//    }
//
//    public MovieVO selectMovieById(int movie_id) {
//        return my.selectOne("movie.selectMovieById", movie_id);
//    }

    int insert(MovieVO movieVO);

    List<MovieVO> getPagedMovieList(Map<String, Integer> pageVO);

    int getMovieCount();

    MovieVO selectMovieById(int movie_id);
}
