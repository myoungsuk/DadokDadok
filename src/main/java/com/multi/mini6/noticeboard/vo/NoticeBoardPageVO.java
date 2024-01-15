package com.multi.mini6.noticeboard.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NoticeBoardPageVO {
    private int page; // Current page number
    private int pageSize; // Number of items per page
    private int totalItemCount; // Total number of items
    private int totalPages; // Total number of pages
    private int offset; // Offset for pagination
    private int start; // Start index for current page
    private int end; // End index for current page

    public NoticeBoardPageVO(int page, int pageSize, int totalItemCount) {
        this.page = page;
        this.pageSize = pageSize > 0 ? pageSize : 5; // Set a default page size of 10 if pageSize is less than or equal to 0
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
            this.pageSize = 5; // Ensure that the page size is always positive
        }
        int offset = (this.page - 1) * this.pageSize; // Calculate the offset
        this.start = offset + 1; // Set the start index
        this.end = Math.min(offset + this.pageSize, this.totalItemCount); // Set the end index
    }
}
