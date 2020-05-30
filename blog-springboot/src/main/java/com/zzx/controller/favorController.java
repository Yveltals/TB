package com.zzx.controller;

import com.zzx.model.entity.Result;
import com.zzx.model.entity.StatusCode;
import com.zzx.service.FavorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping("/favor")
public class favorController {

    @Autowired
    private FavorService favorService;
    /**
     * 点赞记录
     */
    @GetMapping("/user")
    public Result getFavor() throws IOException {
        return Result.create(StatusCode.OK, "查询成功", favorService.getFavor());
    }
}
