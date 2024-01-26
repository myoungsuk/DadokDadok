package com.multi.mini6.freeboard.controller;

import com.multi.mini6.freeboard.vo.FreeBoardAttachVO;
import com.multi.mini6.freeboard.vo.FreeBoardCommentVO;
import com.multi.mini6.freeboard.vo.FreeBoardPageVO;
import com.multi.mini6.freeboard.vo.FreeBoardVO;
import com.multi.mini6.freeboard.service.FreeBoardService;

import java.io.*;
import java.net.URLDecoder;
import java.security.Principal;
import java.util.*;


import com.multi.mini6.loginpage.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/freeboard")
@Slf4j
public class FreeBoardController {

  @Autowired
  private FreeBoardService freeBoardService;

  @Autowired
  ServletContext servletContext;

  @GetMapping("/board_insert")
  public void getInsert() {
  }

  // 자유게시판 글작성
  @PostMapping("/board_insert")
  public String insert(FreeBoardVO freeBoardVO){

    freeBoardService.insert(freeBoardVO);
    log.info("freeBoardVO board_title {}", freeBoardVO.getBoard_title());

    // 데이터 수집되었는지 확인
    if(freeBoardVO.getAttachList() != null) {
        freeBoardVO.getAttachList().forEach(attach -> log.info("attach: {}", attach));
    }

    return "redirect:/freeboard/board_list"; // 글작성 후 board_list로 이동
  }

  // 파일첨부 - 확장자 확인
  private String getFileType(File file, FreeBoardAttachVO attachVO) {

    String fileName = file.getName();
    String fileType = "";

    int dotIndex = fileName.lastIndexOf('.');
    if (dotIndex > 0) {
      fileType = fileName.substring(dotIndex + 1).toLowerCase();
    }

    // 파일 타입을 FreeBoardAttachVO 객체에 저장
    attachVO.setBoard_file_type(fileType);

    return fileType;


  }

  // 파일업로드
  @PostMapping(value="/uploadAjaxFormAction", produces=MediaType.APPLICATION_JSON_VALUE)
  @ResponseBody
  public ResponseEntity<List<FreeBoardAttachVO>> uploadFormPost(@RequestParam("file") MultipartFile[] files, HttpServletRequest request) {

    List<FreeBoardAttachVO> list = new ArrayList<>();

    String uploadFolder = request.getSession().getServletContext().getRealPath("/resources/freeBoardUpload");
    //log.info("uploadFolder: " + uploadFolder);

    File uploadPath = new File(uploadFolder);

    if (!uploadPath.exists()) {
      uploadPath.mkdirs(); // 디렉토리가 없으면 생성
    }

    for (MultipartFile multipartFile : files) {

      FreeBoardAttachVO attachVO = new FreeBoardAttachVO();
      String uploadFileName = multipartFile.getOriginalFilename();

      uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
      attachVO.setBoard_file_name(uploadFileName);

      // UUID 이용해 고유한 이름 적용
      UUID uuid = UUID.randomUUID();
      uploadFileName = uuid.toString() + "_" + uploadFileName;

      try {
        File saveFile = new File(uploadPath, uploadFileName);
        multipartFile.transferTo(saveFile);

        attachVO.setBoard_uuid(uuid.toString());

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


  // 게시글 작성시 첨부파일삭제
  @PostMapping("/deleteFile")
  @ResponseBody
  public ResponseEntity<String> deleteFile(@RequestParam String fileName,@RequestParam String type, HttpServletRequest request) {
    String uploadFolder = request.getSession().getServletContext().getRealPath("/resources/freeBoardUpload");

    String folder = servletContext.getRealPath("/resources/freeBoardUpload");
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

  //게시글 리스트
@GetMapping("/board_list")
  public String list(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                     @RequestParam(value = "searchType", defaultValue ="") String searchType,
                     @RequestParam(value = "keyword", defaultValue ="" ) String keyword,
                     Model model, FreeBoardPageVO freeboardPageVO, HttpSession session ) {

    // 검색어가 비어있지 않고 , 세션에 저장된 이전검색어와 다른 경우 page를 1로 설정
    // 이렇게 설정하지 않으면 첫번째 검색결과의 3페이지에서 재검색 결과가 3페이지 미만인경우 페이지 이동하지 않으면 보이지 않음
  if (!keyword.isEmpty() && !keyword.equals(session.getAttribute("keyword"))) {
      page = 1;
    }

    // 검색 타입과 검색어 초기 설정
    if (keyword != null && !keyword.isEmpty()) {
      session.setAttribute("searchType", searchType);
      session.setAttribute("keyword", keyword);
    } else {

      session.removeAttribute("searchType");
      session.removeAttribute("keyword");

      searchType = "";
      keyword = "";
    }

    // 검색 타입과 검색어 설정
    freeboardPageVO.setSearchType(searchType);
    freeboardPageVO.setKeyword(keyword);

    // 전체 게시물 수
    int count = freeBoardService.boardCount(freeboardPageVO);

    // 현재 페이지 설정
    freeboardPageVO.setPage(page);

    //한 페이지에서 보여줄 게시글 수(10개)
    int pageSize = freeboardPageVO.getPageSize();

    // 시작, 마지막 페이지 수 가져오기
    freeboardPageVO.setStartEnd();
    // 현재페이지에서 보여줄 글 목록
    List<FreeBoardVO> list = freeBoardService.freeBoardList(freeboardPageVO);

    // totalPage = (전체 게시물 수 + 한 페이지에서 보여줄 게시글 수 - 1)  / 한 페이지에서 보여줄 게시글 수
    // 정수 나눗셈 결과: 정수 반환, 소수부분 버림
    //   --> count / pageSize 결과값이 나머지가 있을 경우를 대비해  pageSize  - 1 해줌
    int totalPage = (count + pageSize - 1) / pageSize;

    model.addAttribute("boardList", list); // 페이지에서 보여줄 글 목록
    model.addAttribute("totalPage", totalPage); // 전체 페이지 수
    model.addAttribute("page", page); // 현재 페이지 번호
    model.addAttribute("count", count); // 전체 게시물 수
    model.addAttribute("searchType", searchType); // 검색 타입
    model.addAttribute("keyword", keyword); // 검색어

    return "/freeboard/board_list";
  }

  // 자유게시판 글 상세보기
  @RequestMapping("/board_one")
  public String one(FreeBoardVO freeBoardVO, FreeBoardPageVO freeboardPageVO,Model model,
                    @RequestParam(value = "page", defaultValue = "1") int page,
                    @RequestParam(value = "searchType", defaultValue ="") String searchType,
                    @RequestParam(value = "keyword", defaultValue ="" ) String keyword, Principal principal, Authentication authentication
                    ) throws Exception {

    // 새로고침시로그인 풀리는 경우 로그인페이지로 이동
     if (principal == null) {
       return "redirect:/loginpage/customLogin";
    }

    // 현재 페이지 설정
    freeboardPageVO.setPage(page);

    // 현재 로그인한 member_id
    CustomUser customUser = (CustomUser) authentication.getPrincipal();
   int userId =  customUser.getMember().getMember_id();
    freeBoardVO.setMember_id(userId);

    // 게시글 정보
    FreeBoardVO result = freeBoardService.freeBoardOne(freeBoardVO.getBoard_id());

    // 현재 로그인한 사용자가 게시글 작성자가 아닌 경우에만 조회수 증가
    if(userId != result.getMember_id()) {
      freeBoardService.viewsCount(freeBoardVO);
    }

    // 이전글, 다음글
    FreeBoardVO previousPost = freeBoardService.getPreviousPost(freeBoardVO.getBoard_id());
    FreeBoardVO nextPost = freeBoardService.getNextPost(freeBoardVO.getBoard_id());

    // 게시글 내용 엔터처리
    String contentEnter = result.getBoard_content().replace("\r\n","<br>");
    result.setBoard_content(contentEnter);

    // 해당 게시글의 댓글 목록 가져오기
    Map<Integer, List<FreeBoardCommentVO>> groupedComments = freeBoardService.findList(freeBoardVO.getBoard_id());

    model.addAttribute("result", result);
    model.addAttribute("previousPost", previousPost);
    model.addAttribute("nextPost", nextPost);
    model.addAttribute("page", page); // 모델에 페이지 번호 추가
    model.addAttribute("keyword", keyword);
    model.addAttribute("searchType", searchType);
    model.addAttribute("groupedComments", groupedComments); // 댓글리스트

  log.info("groupedComments {}", groupedComments);

    return "/freeboard/board_one";
  }


  //게시글 상세보기 - 첨부파일조회
  @GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  @ResponseBody
  public ResponseEntity<List<FreeBoardAttachVO>> getAttachList(@RequestParam("board_id") int board_id){
    List<FreeBoardAttachVO> attachList = freeBoardService.getAttachList(board_id);
    //log.info("getAttachList response: {}" , attachList);
    //log.info("freeBoardService.getAttachList(board_id); {} ", freeBoardService.getAttachList(board_id));
    return new ResponseEntity<>(attachList, HttpStatus.OK);

  }

// 게시글 상세보기 - 파일다운로드
  @GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
  public ResponseEntity<Resource> downloadFile(String fileName, HttpServletRequest request){
   // log.info("fileName file: {}", fileName);

    String uploadFolder = request.getSession().getServletContext().getRealPath("/resources/freeBoardUpload/");

    FileSystemResource resource = new FileSystemResource(uploadFolder +fileName );

    //log.info("resource:{} " , resource);

    String resourceName = resource.getFilename();

    HttpHeaders headers = new HttpHeaders();
    try{
      headers.add("Content-Disposition", "attacgment; filename=" + new String(resourceName.getBytes("UTF-8"), "ISO-8859-1"));
    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    }


    return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
  }


  // 게시글+첨부파일 삭제
  @PostMapping("/fileDelete")
  @ResponseBody
  public ResponseEntity<String> fileDelete ( HttpServletRequest request, @RequestBody ArrayList<FreeBoardAttachVO> fileList ){
      // 삭제 순서: 파일DB삭제  ->  실제 파일 삭제  -> 게시글 삭제

      String uploadFolder = request.getSession().getServletContext().getRealPath("/resources/freeBoardUpload/");
      //log.info("file Delete uploadFolder: {}", uploadFolder);

      try {
           // 첨부파일 개수 만큼 실행
           for (FreeBoardAttachVO attach : fileList) {

              // 파일DB삭제
              freeBoardService.fileDelete(attach.getBoard_id());

              String filePath = uploadFolder + attach.getBoard_uuid() + "_" + URLDecoder.decode(attach.getBoard_file_name(), "UTF-8");
              File file = new File(filePath);

              // 파일삭제
              file.delete();
              //log.info("file: {}", file);

              String fileType = attach.getBoard_file_type();
            // log.info("fileType:{} ", fileType);

             // 이미지 파일인 경우 썸네일도 같이 삭제
              if(fileType.equals("png") || fileType.equals("jpg") || fileType.equals("jpge") || fileType.equals("gif") ) {
                String imgFilePath = uploadFolder + "s_" + attach.getBoard_uuid() + "_" + URLDecoder.decode(attach.getBoard_file_name(), "UTF-8");
                file = new File(imgFilePath);
                log.info("imgFilePath: " + imgFilePath);

                file.delete();
              }


              //게시글 삭제
              freeBoardService.delete(attach.getBoard_id());
           }

      } catch (UnsupportedEncodingException e) {
          e.printStackTrace();
          // 인코딩 문제가 발생한 경우 적절한 HTTP 상태 코드와 함께 에러 응답을 반환
          return ResponseEntity.badRequest().body("Failed to decode file names");
      }

     // 모든 파일 처리 후 성공 응답 반환
     return new ResponseEntity<String>("deleted", HttpStatus.OK);
  }

  // 게시글 삭제
  @PostMapping(value = "/board_delete")
  public ResponseEntity<String> delete( int board_id) {
    freeBoardService.delete(board_id);
    return new ResponseEntity<String>("Board deleted successfully", HttpStatus.OK);
  }

  // 게시글 수정페이지로 이동
  @GetMapping("/board_update")
  public String update(@RequestParam("board_id") int board_id, Model model) {
    FreeBoardVO freeBoardVO = freeBoardService.freeBoardOne(board_id);
    model.addAttribute("freeBoardVO", freeBoardVO);
    return "freeboard/board_update";
  }

  // 게시글 수정
  @PutMapping(value = "/board_update", consumes = "multipart/form-data")
  public ResponseEntity<?> update(@ModelAttribute FreeBoardVO freeBoardVO) {
    // 게시글 업데이트 로직 실행
    freeBoardService.update(freeBoardVO);

    // 첨부 파일 업데이트 로직 실행
    freeBoardService.Fileupdate(freeBoardVO.getBoard_id(), freeBoardVO.getAttachList());
   //log.info("freeBoardVO.getBoard_id() _{} ", freeBoardVO.getBoard_id());
   //log.info("freeBoardVO.getAttachList() _{} ", freeBoardVO.getAttachList());

   // log.info("update freeBoardVO : " + freeBoardVO);
    return ResponseEntity.ok(freeBoardVO.getBoard_id());
  }




  // 댓글 입력
@PostMapping("/comment_insert")
  public @ResponseBody Map<Integer, List<FreeBoardCommentVO>> commentInsert(
          @RequestBody FreeBoardCommentVO freeBoardCommentVO) {
          //log.info("댓글 등록 - freeBoardCommentVO의 :{} " , freeBoardCommentVO);

          // 댓글 등록
          freeBoardService.commentInsert(freeBoardCommentVO);

        // 해당 게시글의 댓글 목록 가져오기
        Map<Integer, List<FreeBoardCommentVO>> groupedComments = freeBoardService.findList(freeBoardCommentVO.getBoard_id());
        //log.info("댓글 등록 - groupedComments :{} " , groupedComments);

      // Jackson 라이브러리가 자동으로 Map의 Integer 키를 JSON 객체의 문자열 키로 변환
        return groupedComments;
  }

  // 댓글수정
  @PutMapping("/comment_update")
  public ResponseEntity<String> commentUpdate(@RequestBody  FreeBoardCommentVO freeBoardCommentVO){
    freeBoardService.commentUpdate(freeBoardCommentVO);
    return new ResponseEntity<>("댓글 수정 성공", HttpStatus.OK);

  }
  // 댓글삭제
  @PostMapping("/comment_delete")
  @ResponseBody
  public ResponseEntity<String> commentDelete(@RequestParam("bocm_id")  int bocm_id) {
      try {
        freeBoardService.commentDelete(bocm_id);
        return new ResponseEntity<>("댓글 삭제 성공", HttpStatus.OK);
      } catch (Exception e) {
        return new ResponseEntity<>("댓글 삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
      }
  }
    // 대댓글 입력
    @PostMapping("/comment_reply")
     public ResponseEntity<String> commentReply(@RequestBody FreeBoardCommentVO freeBoardCommentVO){
      try {
          freeBoardService.commentReply(freeBoardCommentVO);
          return new ResponseEntity<>("대댓글 입력 성공", HttpStatus.OK);
      } catch (Exception e) {
          return new ResponseEntity<>("대댓글 입력 실패", HttpStatus.INTERNAL_SERVER_ERROR);
      }

    }















}
