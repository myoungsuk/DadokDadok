package com.multi.mini6.reviewboard.controller;

import net.coobird.thumbnailator.Thumbnailator;
import com.multi.mini6.reviewboard.vo.PageVo;
import com.multi.mini6.reviewboard.vo.ReviewAttachVO;
import com.multi.mini6.reviewboard.vo.ReviewCommentVO;
import com.multi.mini6.reviewboard.vo.ReviewVO;
import com.multi.mini6.reviewboard.service.ReviewCommentService;
import com.multi.mini6.reviewboard.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import lombok.extern.slf4j.Slf4j;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletContext;

@Controller
@RequestMapping("/reviewboard")
@Slf4j
public class ReviewController {
    @Autowired
    ReviewService reviewService;

    @Autowired
    ReviewCommentService reviewCommentService;

    @Autowired
    ServletContext servletContext;


    @RequestMapping("/review_insert_move")
    public String insert_move() {
        return "reviewboard/review_insert";
    }


    @GetMapping("/review_insert")
    public void review_insert_page() {
    }

    @PostMapping("/review_insert")
    public String reviwe_insert(ReviewVO reviewVO, @RequestParam(value = "file", required = false) MultipartFile file, Model model) {

        reviewService.review_insert(reviewVO);

        return "redirect:/reviewboard/review_list3?page=1";
    }

    private String getFileType(File file, ReviewAttachVO reviewAttachVO) {

        String fileName = file.getName();
        String fileType = "";

        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0) {
            fileType = fileName.substring(dotIndex + 1).toLowerCase();
        }
        reviewAttachVO.setReview_file_type(fileType);
        return fileType;
    }

    @PostMapping(value="/uploadAjaxFormAction", produces= MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<ReviewAttachVO>> uploadFormPost(@RequestParam("file") MultipartFile[] files, HttpServletRequest request) {

        List<ReviewAttachVO> list = new ArrayList<>();
        String uploadFolder = request.getSession().getServletContext().getRealPath("/resources/reviewBoardUpload");
        //log.info("uploadFolder: " + uploadFolder);


        File uploadPath = new File(uploadFolder);

        if (!uploadPath.exists()) {
            uploadPath.mkdirs(); // 디렉토리가 없으면 생성
        }

        for (MultipartFile multipartFile : files) {

            ReviewAttachVO attachVO = new ReviewAttachVO();
            String uploadFileName = multipartFile.getOriginalFilename();

            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
            attachVO.setReview_file_name(uploadFileName);

            // UUID 이용해 고유한 이름 적용
            UUID uuid = UUID.randomUUID();
            uploadFileName = uuid.toString() + "_" + uploadFileName;


            try {
                File saveFile = new File(uploadPath, uploadFileName);
                multipartFile.transferTo(saveFile);

                attachVO.setReview_uuid(uuid.toString());

                // 파일 타입
                String fileType = getFileType(saveFile, attachVO);
                // 섬네일 생성
                if (fileType.equals("png") || fileType.equals("jpg") || fileType.equals("jpeg") || fileType.equals("gif")) { // 이미지 파일인지 확인
                    File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
                    try (FileOutputStream thumbnail = new FileOutputStream(thumbnailFile);
                         FileInputStream fis = new FileInputStream(saveFile)) {  // FileInputStream 추가
                        Thumbnailator.createThumbnail(fis, thumbnail, 100, 100);
                        // 이미지 파일을 사용한 후에 해당 파일 스트림을 닫기
                        // Files.deleteIfExists(saveFile.toPath());
                    }catch (Exception e) {
                        e.printStackTrace();
                    }

                }
                list.add(attachVO);
            } catch (Exception e) {
                e.printStackTrace();
            } // try
        } // for

        // JSON형태로 변환된 list를 반환
        return new ResponseEntity<>(list, HttpStatus.OK);
    }


    @RequestMapping("/review_update_move")
    public String update_move() {

        return "reviewboard/review_update";
    }


    @RequestMapping("/review_update")
    public String review_update(ReviewVO reviewVO, Model model) {
        int result = reviewService.review_update(reviewVO);
        System.out.println("result"+ result);
        model.addAttribute("review_update", result);
        System.out.println(result >= 1);
        if (result >= 1) {

            System.out.println("if");
            return "forward:/reviewboard/review_list3?page=1";
        } else {
            System.out.println("else");
            return "reviewboard/review_update";

        }

    }

    @RequestMapping("/review_list3")
    public void review_list(PageVo pageVO, Model model) {
        pageVO.setStartEnd();//start, end계산해주는 메서드
        System.out.println("===> " + pageVO);
        List<ReviewVO> list = reviewService.review_list3(pageVO);
        //전체 페이지수 구하기
        System.out.println(list);
        int count = reviewService.review_count(); //전체게시물 수
        System.out.println("전체 게시물수>> " + count);
        int pages = count / 10;
        if (count % 10 != 0) {
            pages = count / 10 + 1;
        }
        //모델로 views까지 페이지수를 넘겨야 페이지수 버튼을 만들 수 있음.
        System.out.println("페이지당 가지고 온 게시물수>> " + list.size());
        //views의 list3.jsp로 전달
        model.addAttribute("list", list);
        model.addAttribute("pages", pages);
        model.addAttribute("count", count);
    }


    @RequestMapping("/review_delete_move")
    public String rewview_delete1() {
        // BbsDAO dao = new BbsDAO();

        return "reviewboard/review_delete";
    }


    @RequestMapping("/review_delete")
    public String review_delete(ReviewVO reviewVO, Model model) {
        // BbsDAO dao = new BbsDAO();
        int result = reviewService.review_delete(reviewVO);

        model.addAttribute("result", result);

        return "forward:/reviewboard/review_list3?page=1";
    }
    @PostMapping("/deleteFile")
    @ResponseBody
    public ResponseEntity<String> deleteFile(@RequestParam String fileName,@RequestParam String type, HttpServletRequest request) {
        String uploadFolder = request.getSession().getServletContext().getRealPath("/resources/reviewBoardUpload");

        String folder = servletContext.getRealPath("/resources/reviewBoardUpload");
        File file;
        try {
            fileName = fileName.replace("/resources/freeBoardUpload/", "");
            file = new File(folder, URLDecoder.decode(fileName, "UTF-8"));

            file.delete();

            // 이미지 파일인 경우 원본도 삭제
            if (type.equals("image")) {
                String largeFileName = file.getAbsolutePath().replace("s_", "");

                file = new File(largeFileName);

                file.delete();

                // 삭제 실패시 파일 이름 출력
                if(!file.delete()){
                    log.info("Failed to delete " + file);
                }

            }
        } catch (UnsupportedEncodingException e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<String>("deleted", HttpStatus.OK);
    }
    @RequestMapping("/review_one")
    public void review_one(ReviewVO reviewVO, Model model) throws Exception {
        // BbsDAO dao = new BbsDAO();
        System.out.println(reviewVO);
        ReviewVO reviewVO2 = reviewService.review_one(reviewVO);
        List<ReviewCommentVO> list = reviewCommentService.reviewCommentlist(reviewVO.getReview_id());
        System.out.println(reviewVO.getReview_id());
        reviewService.increaseViews(reviewVO.getReview_id());
        model.addAttribute("reviewVO", reviewVO2);
        model.addAttribute("list", list);

    }



    @RequestMapping("/review_search1")
    public void review_search1(PageVo pageVO, Model model, @RequestParam(value = "keyword", required = false) String keyword) {
        int count = 0;

        String result = "";
        System.out.println("page : " + pageVO.getPage());
        System.out.println("keyword" + keyword);
        pageVO.setStartEnd();
        List<ReviewVO> list;
        ReviewVO reviewVO = new ReviewVO();
        reviewVO.setKeyword(keyword);

        if (keyword != null && !keyword.isEmpty()) {
            list = reviewService.review_search(pageVO);
            count = reviewService.searchCount(pageVO);

        } else {
            list = reviewService.review_list3(pageVO);
            count = reviewService.review_count();
        }

        // 전체 게시물 수 및 페이지 계산
        // 전체 게시물 수
        int pages = count / 10;
        if (count % 10 != 0) {
            pages = count / 10 + 1;
        }
        System.out.println("count" + count);
        System.out.println("pages" + pages);

        // 모델에 데이터 전달
        model.addAttribute("list", list);
        model.addAttribute("pages", pages);
        model.addAttribute("count", count);
        model.addAttribute("keyword", keyword);


        System.out.println("list size" + list.size());

    }

    @RequestMapping("/review_search")
    public String listWithSearch(PageVo pageVO, Model model, @RequestParam(value = "keyword", required = false) String keyword) {
        int count = 0;

        String result = "";
        System.out.println("page : " + pageVO.getPage());
        System.out.println("keyword" + keyword);
        pageVO.setStartEnd();
        List<ReviewVO> list;
        ReviewVO reviewVO = new ReviewVO();
        reviewVO.setKeyword(keyword);

        if (keyword != null && !keyword.isEmpty()) {
            list = reviewService.review_search(pageVO);
            count = reviewService.searchCount(pageVO);

        } else {
            list = reviewService.review_list3(pageVO);
            count = reviewService.review_count();

        }

        // 전체 게시물 수 및 페이지 계산
        // 전체 게시물 수
        int pages = count / 10;
        if (count % 10 != 0) {
            pages = count / 10 + 1;
        }
        System.out.println("count" + count);
        System.out.println("pages" + pages);

        // 모델에 데이터 전달
        model.addAttribute("list", list);
        model.addAttribute("pages", pages);
        model.addAttribute("count", count);
        model.addAttribute("keyword", keyword);
        System.out.println("list size" + list.size());
        return "reviewboard/review_list3";
    }

}