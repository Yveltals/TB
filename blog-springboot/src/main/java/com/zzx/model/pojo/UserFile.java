package com.zzx.model.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Accessors(chain = true)
public class UserFile {
    private Integer id;
    private String Name;
    private String path;
    private String size;
    private String type;
    private String uploadTime;
    private Integer userId;
}
