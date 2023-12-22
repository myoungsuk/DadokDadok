package com.multi.mini6.bookpage.config;//package com.multi.mini6.config;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
//import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
//import org.springframework.security.web.SecurityFilterChain;
//
//@Configuration
//@EnableWebSecurity(debug = true)
//public class SecurityConfig extends WebSecurityConfigurerAdapter {
//
//    @Override
//    protected void configure(HttpSecurity http) throws Exception {
////        http.csrf().disable(); //일단 jsp 파일 내에서 csrf 처리를 해줬다.
//        http
//            .authorizeRequests()
//                .antMatchers( "/login", "/signup").permitAll()
//                .anyRequest().authenticated();
//
//        http
//            .formLogin()
//                .loginPage("/login")    // GET 요청
//                .permitAll()
//                .loginProcessingUrl("/auth")    // POST 요청
//                .usernameParameter("email")
//                .passwordParameter("password")
//                .defaultSuccessUrl("/");
//
//        http
//            .logout()
//                .logoutUrl("/logout")
//                .logoutSuccessUrl("/");
//
//    }
//}
