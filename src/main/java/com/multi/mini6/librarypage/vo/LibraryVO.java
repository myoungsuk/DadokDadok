package com.multi.mini6.librarypage.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor // 기본 생성자 자동 생성
@AllArgsConstructor // 모든 필드를 매개변수로 받는 생성자 자동 생성
public class LibraryVO extends LibraryPageVO {

    private String lib_code; //111287
    private String lib_name; //가슴따뜻한작은도서관
//    private String lib_region; //서울특별시 ->lib_address에서 추출
//    private String lib_dtl_region; //서대문구 -> lib_address에서 추출
    private String lib_address; //서울특별시 서대문구 응암로1길 10
    private String lib_tel; //02-330-8652
    private String lib_fax; //053-257-2284
    private double lib_latitude; //37.5814481
    private double lib_longitude; //126.9111617
    private String lib_homepage; //http://lib.sdm.or.kr
    private String lib_closed; //휴관중 (2023.1.1.~ 현재) / 2025년 재개관 예정
    private String lib_operating_time; //화~금 09:00~18:00 / 토일 09:00~17:00
    private int lib_bookcount; //6495

    private String keyword;
    private int search_count;
    private String search;

    public String getLib_code() {
        return lib_code;
    }

    public void setLib_code(String lib_code) {
        this.lib_code = lib_code;
    }

    public String getLib_name() {
        return lib_name;
    }

    public void setLib_name(String lib_name) {
        this.lib_name = lib_name;
    }

    public String getLib_address() {
        return lib_address;
    }

    public void setLib_address(String lib_address) {
        this.lib_address = lib_address;
    }

    public String getLib_tel() {
        return lib_tel;
    }

    public void setLib_tel(String lib_tel) {
        this.lib_tel = lib_tel;
    }

    public String getLib_fax() {
        return lib_fax;
    }

    public void setLib_fax(String lib_fax) {
        this.lib_fax = lib_fax;
    }

    public double getLib_latitude() {
        return lib_latitude;
    }

    public void setLib_latitude(double lib_latitude) {
        this.lib_latitude = lib_latitude;
    }

    public double getLib_longitude() {
        return lib_longitude;
    }

    public void setLib_longitude(double lib_longitude) {
        this.lib_longitude = lib_longitude;
    }

    public String getLib_homepage() {
        return lib_homepage;
    }

    public void setLib_homepage(String lib_homepage) {
        this.lib_homepage = lib_homepage;
    }

    public String getLib_closed() {
        return lib_closed;
    }

    public void setLib_closed(String lib_closed) {
        this.lib_closed = lib_closed;
    }

    public String getLib_operating_time() {
        return lib_operating_time;
    }

    public void setLib_operating_time(String lib_operating_time) {
        this.lib_operating_time = lib_operating_time;
    }

    public int getLib_bookcount() {
        return lib_bookcount;
    }

    public void setLib_bookcount(int lib_bookcount) {
        this.lib_bookcount = lib_bookcount;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public int getSearch_count() {
        return search_count;
    }

    public void setSearch_count(int search_count) {
        this.search_count = search_count;
    }

    public String getSearch() {
        return search;
    }

    public void setSearch(String search) {
        this.search = search;
    }
}
