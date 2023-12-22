package com.multi.mini6.bookpage.domain;

import lombok.Data;

@Data
public class UserVO {
    private Long id;
    private String name;
    private String username;
    private String email;
    private String password;
    private String address;
    private String phone;
    private String website;
    private String company;
}
