package org.example.controller;

import org.example.pojo.Result;
import org.example.utils.OSSUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.UUID;

@RestController
public class FileUploadController {

    @PostMapping("/upload")
    public Result<String> upload(MultipartFile file) throws IOException {
        //把文件内容保存到本地磁盘上
        String originalName = file.getOriginalFilename();
        String fileName = UUID.randomUUID() + originalName.substring(originalName.lastIndexOf("."));
//        file.transferTo(new File("C:\\Users\\abc\\Desktop\\测试\\" + fileName));
        String url = OSSUtils.upload(fileName, file.getInputStream());
        return Result.success(url);
    }
}
