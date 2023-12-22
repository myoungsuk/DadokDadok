//package com.multi.mini6;
//
//
//import com.multi.mini6.bookpage.controller.MovieController;
//import com.multi.mini6.bookpage.domain.MovieVO;
//import com.multi.mini6.bookpage.domain.PageVO;
//import com.multi.mini6.bookpage.mapper.MovieMapper;
//import com.multi.mini6.bookpage.service.MovieService;
//import lombok.extern.log4j.Log4j;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.junit.MockitoJUnitRunner;
//import org.springframework.test.context.ContextConfiguration;
//import org.springframework.test.web.servlet.MockMvc;
//
////@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//@RunWith(MockitoJUnitRunner.class)
//@Log4j
//public class SimpleTests {
//
//    @Mock
//    MockMvc mockMvc;
//    @InjectMocks
//    private MovieController movieController;
//    @Mock
//    private MovieService movieService;
//
//    @Mock
//    private MovieVO movieVO;
//    @Mock
//    private MovieMapper movieMapper;
//    @Mock
//    private PageVO pageVO;
//
//
//    @Test
//    public void test1() {
//        log.info("test1...............");
//        log.info(movieService);
//        log.info(movieVO);
//        log.info(movieMapper);
//    }
//
//    @Test
//    public void getMovieCount() {
//        log.info("getMovieCount...............");
//        log.info(movieService.getMovieCount());
//    }
//
//    @Test
//    public void getMovieList() {
//        log.info("getMovieList...............");
//        log.info(movieService.getPagedMovieList(pageVO));
//    }
//
//    @Test
//    public void getMovieListControllerTest(){
//
//
//    }
//}
