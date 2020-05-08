package com.zzx.controller;

import java.io.*;
import java.net.URLEncoder;
import com.zzx.model.entity.Result;
import com.zzx.model.entity.StatusCode;
import com.zzx.model.pojo.UserFile;
import com.zzx.service.UserFileService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletResponse;


@CrossOrigin
@RestController
@RequestMapping("/file")
public class FileController {

    @Autowired
    private UserFileService userFileService;

    /**
     * 展示文件
     */
    @ApiOperation(value = "上传文件", notes = "上传文件")
    @GetMapping("/showAll")
    public Result findAll(){

        return Result.create(StatusCode.OK, "查询成功", userFileService.findByUserId());

    }

    /**
     *  文件上传
     */
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public Result upload(@RequestParam("file") MultipartFile file) {
        try {
            //打印绝对路径
            //System.out.println(ResourceUtils.getURL("classpath:").getPath());
            //获取文件信息
            String Name = file.getOriginalFilename();
            double siz = (double)file.getSize();
            String size = "";
            if((siz/1048576) >= 1) size = String.format("%.2f", siz/1048576)+" Mb";
            else size = String.format("%.1f",siz/1024)+" kb";
            String typ = file.getContentType();
            String type = typ.substring(typ.lastIndexOf("/")+1);
            String path="/home/zero/Blog-basic-dev/blog-springboot/file/";
            //写入文件
            InputStream inputStream = file.getInputStream();
            File file1 = new File(path + Name);
            if(!file1.getParentFile().exists()){
                file1.getParentFile().mkdirs();
            }
            file.transferTo(file1);
            //将文件信息放入数据库
            UserFile userFile = new UserFile();
            userFile.setName(Name).setType(type).setSize(size)
                    .setPath(path + Name);
            userFileService.save(userFile);
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        return Result.create(StatusCode.OK, "查询成功",null);
    }



    /**
     * 文件下载
     */
    @RequestMapping("/download")
    public void download(Integer id,HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        //获取文件信息，更新下载次数
        UserFile userFile = userFileService.findById(id);
        String filename = userFile.getName();
        String FilePath = userFile.getPath();
        System.out.println("< FilePath > ----> "+id+" : "+userFile);
        // 以流的形式下载文件
        try {
            InputStream fis = new BufferedInputStream(new FileInputStream(FilePath));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            response.reset();// 清空response
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8"));
            toClient.write(buffer);
            toClient.flush();
            toClient.close();
        } catch (IOException ex) {
            ex.printStackTrace();
        }

    }


    /**
     * 删除文件
     */
    @RequestMapping("delete")
    public Result delete(Integer id) throws FileNotFoundException {
        UserFile userFile = userFileService.findById(id);
        String realPath = userFile.getPath();
        System.out.println("< RealPath > ----> "+realPath);
        File file = new File(realPath);
        if(file.exists()) file.delete();
        userFileService.delete(id);
        return Result.create(StatusCode.OK, "查询成功", null);
    }

}
