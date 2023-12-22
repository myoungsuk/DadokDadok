package com.multi.mini6.bookpage.service;

import com.multi.mini6.bookpage.domain.MovieVO;
import com.multi.mini6.bookpage.domain.PageVO;
import com.multi.mini6.bookpage.mapper.MovieMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
@Transactional
@RequiredArgsConstructor
@Log4j2
public class MovieService {

	@Autowired
	private MovieMapper movieMapper;

	public void insertMovie(MovieVO movieVO) {
		movieMapper.insert(movieVO);
	}

	public List<MovieVO> getPagedMovieList(PageVO pageVO) {
		Map<String, Integer> map = new HashMap<>();
		map.put("offset", pageVO.getOffset());
		map.put("pageSize", pageVO.getPageSize());
		return movieMapper.getPagedMovieList(map);
	}

	public int getMovieCount() {
		return movieMapper.getMovieCount();
	}

	public MovieVO selectMovieById(int movie_id) {
		return movieMapper.selectMovieById(movie_id);
	}
}
