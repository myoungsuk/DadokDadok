package com.multi.mini6.reviewboard.vo;

import java.util.Arrays;

public class ReviewAttachVO {
    private int review_attach_id;
    private int review_id;
    private String review_uuid;
    private String review_file_name;

    private String review_file_type;

    private byte[] review_file_data;

    public int getReview_attach_id() {
        return review_attach_id;
    }
    public void setReview_attach_id(int review_attach_id) {
        this.review_attach_id = review_attach_id;
    }
    public int getReview_id() {
        return review_id;
    }
    public void setReview_id(int review_id) {
        this.review_id = review_id;
    }
    public String getReview_uuid() {
        return review_uuid;
    }
    public void setReview_uuid(String review_uuid) {
        this.review_uuid = review_uuid;
    }
    public String getReview_file_name() {
        return review_file_name;
    }
    public void setReview_file_name(String review_file_name) {
        this.review_file_name = review_file_name;
    }
    public String getReview_file_type() {
        return review_file_type;
    }
    public void setReview_file_type(String review_file_type) {
        this.review_file_type = review_file_type;
    }

    public byte[] getReview_file_data() {
        return review_file_data;
    }
    public void setReview_file_data(byte[] review_file_data) {
        this.review_file_data = review_file_data;
    }
    @Override
    public String toString() {
        return "ReviewVO [review_attach_id=" + review_attach_id +
                ", review_id=" + review_id +
                ", review_uuid=" + review_uuid +
                ", review_file_name=" + review_file_name +
                ", review_file_type=" + review_file_type +
                ", review_file_data=" + Arrays.toString(review_file_data) + "]";
    }
}




