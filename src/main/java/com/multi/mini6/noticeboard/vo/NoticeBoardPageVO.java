package com.multi.mini6.noticeboard.vo;

import lombok.*;

@Data
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class NoticeBoardPageVO {
    private int page; // Current page number
    private int pageSize; // Number of items per page
    private int totalItemCount; // Total number of items
    private int totalPages; // Total number of pages
    private int offset; // Offset for pagination
    private int start; // Start index for current page
    private int end; // End index for current page
    private String keyword; // 검색 키워드
    private String type; // 검색 타입
    private String[] typeArr;
    private String searchType; // search type ( title , content , titleContent )

    public NoticeBoardPageVO(int page, int pageSize, int totalItemCount) {
        this.page = page;
        this.pageSize = pageSize > 0 ? pageSize : 10; // Set a default page size of 10 if pageSize is less than or equal to 0
        this.totalItemCount = totalItemCount;
        this.totalPages = (int) Math.ceil((double) totalItemCount / pageSize); // Calculate the total number of pages
        calculateOffset(); // Calculate the offset based on the current page and page size
        setStartEnd(); // Set the start and end indices for the current page
    }

    public void calculateOffset() {
        // Calculate the offset based on the current page and page size
        this.offset = Math.max((this.page - 1) * this.pageSize, 0);
    }

    public void setStartEnd() {
        // Set the start and end indices for the current page
        if (this.page < 1) {
            this.page = 1; // Ensure that the page number is always positive
        }
        if (this.pageSize < 1) {
            this.pageSize = 10; // Ensure that the page size is always positive
        }
        int offset = (this.page - 1) * this.pageSize; // Calculate the offset
        this.start = offset + 1; // Set the start index
        this.end = Math.min(offset + this.pageSize, this.totalItemCount); // Set the end index
    }

    public NoticeBoardPageVO() {
        this(1, 10); // 아래쪽 전달값 2개 생성자 호출.
    }

    public NoticeBoardPageVO(int pageNum, int amount) {
        this.page = pageNum;
        this.pageSize = amount;
    }

    public void setType(String type) {
        this.type = type;
        this.typeArr = type.split("");
    }

    public int getOffset() {
        return (page - 1) * pageSize;
    }

    public int getLimit() {
        return pageSize;
    }

}
