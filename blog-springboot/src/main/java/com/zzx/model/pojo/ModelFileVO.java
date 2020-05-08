package com.zzx.model.pojo;

import lombok.Data;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

@Data
@ToString
public class ModelFileVO {
//    private String area;
    private MultipartFile[] files;
}
