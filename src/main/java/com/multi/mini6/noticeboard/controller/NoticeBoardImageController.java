package com.multi.mini6.noticeboard.controller;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
public class NoticeBoardImageController {

    @GetMapping("/upload_data/temp/{filename:.+}")
    public ResponseEntity<Resource> getImage(@PathVariable String filename) throws IOException {
        // Construct the file path
        Path imagePath = Paths.get("C:/upload_data/temp/", filename);

        // Check if the file exists
        if (Files.exists(imagePath) && Files.isReadable(imagePath)) {
            // Determine the media type based on the file extension
            MediaType mediaType = MediaType.IMAGE_JPEG; // Default to JPEG
            if (filename.toLowerCase().endsWith(".png")) {
                mediaType = MediaType.IMAGE_PNG;
            }

            // Read the image file
            Resource fileResource = new FileSystemResource(String.valueOf(imagePath));
            return ResponseEntity.ok().contentType(mediaType).body(fileResource);
        } else {
            // Return 404 Not Found if the file does not exist
            return ResponseEntity.notFound().build();
        }
    }
}
