package com.multi.mini6.noticeboard.service;

import com.multi.mini6.noticeboard.dao.NoticeBoardDAO;
import com.multi.mini6.noticeboard.vo.NoticeBoardPageVO;
import com.multi.mini6.noticeboard.vo.NoticeBoardVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Log4j2
public class NoticeBoardService {

    @Autowired
    NoticeBoardDAO noticeBoardDAO;

    public void insertNotice(NoticeBoardVO noticeBoardVO) {
        noticeBoardDAO.insertNotice(noticeBoardVO);
    }

    public void updateNotice(NoticeBoardVO noticeBoardVO, MultipartFile file) throws IOException {
        if (!file.isEmpty()) {
            String fileName = file.getOriginalFilename();
            String uuid = UUID.randomUUID().toString();
            String filePath = "C:/Users/yuumi/Downloads/apache-tomcat-8.5.96/bin/upload-dir/" + uuid + "_" + fileName;

            File newFile = new File(filePath);
            file.transferTo(newFile);

            noticeBoardVO.setNotice_uuid(uuid);
            noticeBoardVO.setNotice_file_name(fileName);
        }

        noticeBoardDAO.updateNotice(noticeBoardVO);
    }

    public void deleteNotice(int notc_id) {
        noticeBoardDAO.deleteNotice(notc_id);
    }

    public List<NoticeBoardVO> noticeboard_list() throws Exception{
        return noticeBoardDAO.listNotice();
    }

    public NoticeBoardVO noticeboard_one(int noticeBoardVO) throws Exception{
        return noticeBoardDAO.oneNotice(noticeBoardVO);
    }

    public NoticeBoardVO getNoticeBoardById(int notc_id) {
        return noticeBoardDAO.getNoticeBoardById(notc_id);
    }

    public void updateViewCountNotice(int notc_id) {
        noticeBoardDAO.updateViewCountNotice(notc_id);
    }

    public List<NoticeBoardVO> getAllNotices(){
        return noticeBoardDAO.selectNoticeAll();
    }

    public List<NoticeBoardVO> getPagedNoticeBoard(NoticeBoardPageVO noticeBoardPageVO) {
        return noticeBoardDAO.getPagedNoticeBoard(noticeBoardPageVO);
    }

    public int getNoticeBoardCount() {
        return noticeBoardDAO.getNoticeBoardCount();
    }

    public NoticeBoardVO moveNoticeBoardPage(int notc_id) throws Exception {
        return noticeBoardDAO.moveNoticeBoardPage(notc_id);
    }

    public List<NoticeBoardVO> searchNoticeBoard(NoticeBoardPageVO noticeBoardPageVO) {
        // Implement the logic to search based on pageVO, including type and keyword
        // Example:
        return noticeBoardDAO.searchNoticeBoard(noticeBoardPageVO);
    }

//    public List<NoticeBoardVO> searchNoticeBoard(NoticeBoardCriteriaVO criteria) {
//        return noticeBoardDAO.searchNoticeBoard(criteria);
//    }

}
