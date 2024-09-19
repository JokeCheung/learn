package com.example;

import com.mysql.cj.jdbc.ClientPreparedStatement;
import org.example.pojo.Place;
import org.junit.jupiter.api.Test;

import java.io.*;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.DriverManager;


import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PlaceDataDB {

    final String filePath = "C:\\Users\\abc\\Downloads\\adcode.csv";
    final List<Place> placeData = new ArrayList<>();
//    ^\d{6}：匹配以六位数字开头的部分
//    [\u4e00-\u9fa5()]{2,50}：匹配逗号后 2 到 50 个汉字的城市名称+加上带括号特殊情况
//    \d{3}\.\d{6}：匹配逗号后 3 位整数和 6 位小数的经度
//    \d{2}\.\d{6}$：匹配逗号后 2 位整数和 6 位小数的纬度，并以此结尾
    String regex = "(^\\d{6}),([\\u4e00-\\u9fa5()]{2,50}),(\\d{1,3}\\.\\d{1,10}),(\\d{1,2}\\.\\d{1,10})$";

    @Test
    public void start() throws IOException {
        File readFile = new File(filePath);
        if (readFile.exists()) {
            InputStream input = new FileInputStream(readFile);
            BufferedReader reader = new BufferedReader(new InputStreamReader(input));
            String inputLine;
            while ((inputLine = reader.readLine()) != null) {
                Pattern pattern = Pattern.compile(regex);
                Matcher matcher = pattern.matcher(inputLine);
                if (matcher.matches()) {
                    String adcode=matcher.group(1);
                    String formatted_address=matcher.group(2);
                    String lng=matcher.group(3);
                    String lat=matcher.group(4);
                    placeData.add(new Place(adcode,formatted_address,lng,lat));
                }
            }
        } else {
            System.out.println("文件不存在");
        }

//        driver-class-name: com.mysql.cj.jdbc.Driver
//        url: jdbc:mysql://localhost:3306/big_event
//        username: root
//        password: 1234
        String url = "jdbc:mysql://localhost:3306/big_event";
        String user = "root";
        String password = "1234";


//建表语句
//        String addTablePlace = "CREATE TABLE place(adcode int NOT NULL," +
//                "formatted_address varchar(255) NOT NULL," +
//                "lng varchar(255)," +
//                "lat varchar(255)," +
//                "PRIMARY KEY (adcode)" +
//                ")";


        //插入数据语句
        String insertPlace = "INSERT INTO place (adcode, formatted_address, lng,lat) VALUES (?, ?, ?,?)";
        StringBuilder command = new StringBuilder();
        //
        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            PreparedStatement pstmt = conn.prepareStatement(insertPlace);

            long start = System.currentTimeMillis();
            //方式1：执行n次PreparedStatement.executeUpdate方法
//            for (Place place : placeData) {
//                // 设置参数
//                pstmt.setInt(1, Integer.parseInt(place.adcode));
//                pstmt.setString(2, place.formatted_address);
//                pstmt.setString(3, place.lng);
//                pstmt.setString(4, place.lat);
//
//                int rowsInserted = pstmt.executeUpdate();
//                if (rowsInserted > 0) {
//                    System.out.println("数据库操作成功"+i++);
//                }
//                String regex = "(.+):(.+)";
//                Pattern pattern = Pattern.compile(regex);
//                Matcher matcher = pattern.matcher(pstmt.toString());
//                if (matcher.matches()) {
//                    String adcode=matcher.group(2);
//                    command.append(adcode+"\n");
//                }else{
//                    System.out.println("匹配失败");
//                }
//            }

            //方式2：执行1次PreparedStatement.executeUpdate方法
            for (Place place : placeData) {
                pstmt.setInt(1, Integer.parseInt(place.getAdcode()));
                pstmt.setString(2, place.getFormatted_address());
                pstmt.setString(3, place.getLocation().getLng());
                pstmt.setString(4, place.getLocation().getLat());
                pstmt.addBatch();
            }
            pstmt.executeBatch();
            long end = System.currentTimeMillis();
            System.out.println("数据库操作成功！耗时：" + (end - start) + "ms");

        } catch (Exception e) {
            e.printStackTrace();
//            System.out.println("数据库操作失败！");
        }
    }



}
