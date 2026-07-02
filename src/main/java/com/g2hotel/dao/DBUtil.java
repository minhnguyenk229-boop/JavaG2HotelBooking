package com.g2hotel.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    private static final String LOCAL_URL =
        "jdbc:mysql://localhost:3306/java_hotel_booking"
        + "?useUnicode=true"
        + "&characterEncoding=UTF-8"
        + "&connectionCollation=utf8mb4_unicode_ci"
        + "&serverTimezone=Asia/Ho_Chi_Minh";

    private static final String LOCAL_USER = "root";
    private static final String LOCAL_PASS = "123456";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Không tìm thấy MySQL JDBC Driver", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        String url = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String pass = System.getenv("DB_PASSWORD");

        if (url == null || url.isBlank()) {
            url = LOCAL_URL;
        }

        if (user == null || user.isBlank()) {
            user = LOCAL_USER;
        }

        if (pass == null) {
            pass = LOCAL_PASS;
        }

        return DriverManager.getConnection(url, user, pass);
    }
}