package com.g2hotel.dao;

import java.sql.*;
import java.util.*;

public class UserDao {

    public boolean register(String name,
                            String email,
                            String phone,
                            String password,
                            String role){

        if(role == null ||
           !(role.equals("ADMIN") ||
             role.equals("EMPLOYEE") ||
             role.equals("CUSTOMER"))) {

            role = "CUSTOMER";
        }

        String sql =
            "INSERT INTO users(full_name,email,phone,password,role,status) VALUES(?,?,?,?,?,1)";

        try(Connection c = DBUtil.getConnection();
            PreparedStatement ps = c.prepareStatement(sql)){

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, password);
            ps.setString(5, role);

            return ps.executeUpdate() > 0;

        } catch(SQLException e) {

            if(e.getMessage() != null &&
               e.getMessage().contains("Duplicate")) {

                throw new RuntimeException(
                    "Email này đã tồn tại trong hệ thống."
                );
            }

            throw new RuntimeException(e);
        }
    }

    public ResultSet loginRaw(Connection c,
                              String email,
                              String password) throws SQLException{

        PreparedStatement ps =
            c.prepareStatement(
                "SELECT * FROM users WHERE email=? AND password=?"
            );

        ps.setString(1, email);
        ps.setString(2, password);

        return ps.executeQuery();
    }

    public boolean registerCustomer(String name,
                                    String email,
                                    String phone,
                                    String password){

        return register(
            name,
            email,
            phone,
            password,
            "CUSTOMER"
        );
    }

    public boolean createEmployee(String name,
                                  String email,
                                  String phone,
                                  String password){

        return register(
            name,
            email,
            phone,
            password,
            "EMPLOYEE"
        );
    }

    private List<Map<String,Object>> listByRole(String role){

        List<Map<String,Object>> l = new ArrayList<>();

        String sql =
            "SELECT id,full_name,email,phone,status,created_at FROM users WHERE role=? ORDER BY id DESC";

        try(Connection c = DBUtil.getConnection();
            PreparedStatement ps = c.prepareStatement(sql)){

            ps.setString(1, role);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                Map<String,Object> m = new HashMap<>();

                for(int i = 1;
                    i <= rs.getMetaData().getColumnCount();
                    i++) {

                    m.put(
                        rs.getMetaData().getColumnLabel(i),
                        rs.getObject(i)
                    );
                }

                l.add(m);
            }

            return l;

        } catch(SQLException e) {

            throw new RuntimeException(e);
        }
    }

    public List<Map<String,Object>> employees(){

        return listByRole("EMPLOYEE");
    }

    public List<Map<String,Object>> customers(){

        return listByRole("CUSTOMER");
    }


    public boolean changePassword(int userId,
                                  String oldPassword,
                                  String newPassword){

        String sql =
            "UPDATE users SET password=? WHERE id=? AND password=?";

        try(Connection c = DBUtil.getConnection();
            PreparedStatement ps = c.prepareStatement(sql)){

            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            ps.setString(3, oldPassword);

            return ps.executeUpdate() > 0;

        } catch(SQLException e) {

            throw new RuntimeException(e);
        }
    }

    public boolean updateUserByRole(int id,
                                    String role,
                                    String name,
                                    String email,
                                    String phone,
                                    String password,
                                    Integer status){

        StringBuilder sql = new StringBuilder(
            "UPDATE users SET full_name=?, email=?, phone=?"
        );

        if(password != null && !password.isBlank()){
            sql.append(", password=?");
        }

        if(status != null){
            sql.append(", status=?");
        }

        sql.append(" WHERE id=? AND role=?");

        try(Connection c = DBUtil.getConnection();
            PreparedStatement ps = c.prepareStatement(sql.toString())){

            int i = 1;
            ps.setString(i++, name);
            ps.setString(i++, email);
            ps.setString(i++, phone);

            if(password != null && !password.isBlank()){
                ps.setString(i++, password);
            }

            if(status != null){
                ps.setInt(i++, status);
            }

            ps.setInt(i++, id);
            ps.setString(i, role);

            return ps.executeUpdate() > 0;

        } catch(SQLException e) {

            if(e.getMessage() != null && e.getMessage().contains("Duplicate")){
                throw new RuntimeException("Email này đã tồn tại trong hệ thống.");
            }

            throw new RuntimeException(e);
        }
    }

    public boolean setCustomerStatus(int id,
                                     boolean active){

        try(Connection c = DBUtil.getConnection();
            PreparedStatement ps =
                c.prepareStatement(
                    "UPDATE users SET status=? WHERE id=? AND role='CUSTOMER'"
                )){

            ps.setInt(1, active ? 1 : 0);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;

        } catch(SQLException e) {

            throw new RuntimeException(e);
        }
    }

    public boolean deleteCustomer(int id){

        try(Connection c = DBUtil.getConnection();
            PreparedStatement ps =
                c.prepareStatement(
                    "DELETE FROM users WHERE id=? AND role='CUSTOMER'"
                )){

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch(SQLException e) {

            throw new RuntimeException(
                "Không thể xóa tài khoản này vì đã có dữ liệu đặt phòng liên quan. Bạn có thể khóa tài khoản thay vì xóa."
            );
        }
    }
}