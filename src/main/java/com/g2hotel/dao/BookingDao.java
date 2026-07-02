package com.g2hotel.dao;

import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.*;

public class BookingDao{

    public int create(int userId,
                      int roomId,
                      String checkIn,
                      String checkOut,
                      String note,
                      String customerName,
                      String customerPhone,
                      String customerEmail,
                      String paymentMethod){

        if(checkIn == null || checkOut == null || checkIn.isBlank() || checkOut.isBlank()) {
            throw new RuntimeException("Vui lòng chọn ngày nhận và ngày trả phòng.");
        }

        if(checkOut.compareTo(checkIn) <= 0) {
            throw new RuntimeException("Ngày trả phòng phải sau ngày nhận phòng.");
        }

        if(customerName == null || customerName.isBlank()) {
            throw new RuntimeException("Vui lòng nhập họ tên người đặt phòng.");
        }

        if(customerPhone == null || !customerPhone.matches("0\\d{9,10}")) {
            throw new RuntimeException("Số điện thoại phải bắt đầu bằng số 0 và có tối đa 11 số.");
        }

        if(customerEmail == null || !customerEmail.matches("^[A-Za-z0-9._%+-]+@gmail\\.com$")) {
            throw new RuntimeException("Email không hợp lệ. Email phải kết thúc bằng @gmail.com.");
        }

        if(paymentMethod == null || paymentMethod.isBlank()) {
            paymentMethod = "Chuyển khoản ngân hàng";
        }

        String sql = "INSERT INTO bookings(user_id,room_id,check_in,check_out,note,status,payment_status,customer_name,customer_phone,customer_email,payment_method,total_amount) VALUES(?,?,?,?,?,'Chờ xác nhận','Chờ thanh toán',?,?,?,?,?)";

        try(Connection c = DBUtil.getConnection()){
            c.setAutoCommit(false);

            double price;
            try(PreparedStatement ck = c.prepareStatement("SELECT status,price FROM rooms WHERE id=? FOR UPDATE")){
                ck.setInt(1, roomId);
                ResultSet rs = ck.executeQuery();
                if(!rs.next() || !"Trống".equals(rs.getString("status"))) {
                    throw new RuntimeException("Phòng này đã được đặt hoặc không khả dụng.");
                }
                price = rs.getDouble("price");
            }

            long nights = ChronoUnit.DAYS.between(LocalDate.parse(checkIn), LocalDate.parse(checkOut));
            if(nights <= 0) {
                throw new RuntimeException("Ngày trả phòng phải sau ngày nhận phòng.");
            }
            double total = price * nights;

            int id;
            try(PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
                ps.setInt(1, userId);
                ps.setInt(2, roomId);
                ps.setString(3, checkIn);
                ps.setString(4, checkOut);
                ps.setString(5, note);
                ps.setString(6, customerName);
                ps.setString(7, customerPhone);
                ps.setString(8, customerEmail);
                ps.setString(9, paymentMethod);
                ps.setDouble(10, total);
                ps.executeUpdate();
                ResultSet keys = ps.getGeneratedKeys();
                keys.next();
                id = keys.getInt(1);
            }

            try(PreparedStatement up = c.prepareStatement("UPDATE rooms SET status='Đã đặt' WHERE id=?")){
                up.setInt(1, roomId);
                up.executeUpdate();
            }

            c.commit();
            return id;
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Map<String,Object>> all(Integer userId){
        List<Map<String,Object>> l = new ArrayList<>();
        String sql = "SELECT b.*,r.room_number,r.type,r.price,r.image,u.full_name,u.phone,u.email FROM bookings b JOIN rooms r ON b.room_id=r.id JOIN users u ON b.user_id=u.id"
            + (userId != null ? " WHERE b.user_id=?" : "")
            + " ORDER BY b.created_at DESC";
        try(Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql)){
            if(userId != null) ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) l.add(row(rs));
            return l;
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Map<String,Object> find(int bookingId, Integer userId){
        String sql = "SELECT b.*,r.room_number,r.type,r.price,r.image,r.description,u.full_name,u.phone,u.email FROM bookings b JOIN rooms r ON b.room_id=r.id JOIN users u ON b.user_id=u.id WHERE b.id=?"
            + (userId != null ? " AND b.user_id=?" : "");
        try(Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql)){
            ps.setInt(1, bookingId);
            if(userId != null) ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if(!rs.next()) throw new RuntimeException("Không tìm thấy đơn đặt phòng.");
            return row(rs);
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private Map<String,Object> row(ResultSet rs) throws SQLException{
        Map<String,Object> m = new HashMap<>();
        ResultSetMetaData md = rs.getMetaData();
        for(int i=1;i<=md.getColumnCount();i++){
            m.put(md.getColumnLabel(i), rs.getObject(i));
        }
        return m;
    }

    public boolean update(int bookingId, String status, String pay, int roomId){
        try(Connection c = DBUtil.getConnection()){
            c.setAutoCommit(false);
            try{
                int rows;
                try(PreparedStatement ps = c.prepareStatement("UPDATE bookings SET status=?,payment_status=? WHERE id=?")){
                    ps.setString(1, status);
                    ps.setString(2, pay);
                    ps.setInt(3, bookingId);
                    rows = ps.executeUpdate();
                }
                if(rows == 0){ c.rollback(); return false; }
                String roomStatus = ("Đã hủy".equals(status) || "Đã trả phòng".equals(status)) ? "Trống" : "Đã đặt";
                try(PreparedStatement p = c.prepareStatement("UPDATE rooms SET status=? WHERE id=?")){
                    p.setString(1, roomStatus);
                    p.setInt(2, roomId);
                    p.executeUpdate();
                }
                c.commit();
                return true;
            } catch(SQLException ex) { c.rollback(); throw ex; }
        } catch(SQLException e) { throw new RuntimeException(e); }
    }

    public void cancelByCustomer(int bookingId, int userId, int roomId){
        try(Connection c = DBUtil.getConnection()){
            c.setAutoCommit(false);
            try(PreparedStatement ps = c.prepareStatement("UPDATE bookings SET status='Đã hủy',payment_status='Chờ thanh toán' WHERE id=? AND user_id=? AND status IN('Chờ xác nhận','Đã xác nhận')")){
                ps.setInt(1, bookingId);
                ps.setInt(2, userId);
                if(ps.executeUpdate() == 0) throw new RuntimeException("Không thể hủy đơn này.");
            }
            try(PreparedStatement p = c.prepareStatement("UPDATE rooms SET status='Trống' WHERE id=?")){
                p.setInt(1, roomId);
                p.executeUpdate();
            }
            c.commit();
        } catch(SQLException e) { throw new RuntimeException(e); }
    }

    public double totalRevenue(){
        String sql = "SELECT COALESCE(SUM(COALESCE(b.total_amount, r.price * DATEDIFF(b.check_out,b.check_in))),0) AS total "
            + "FROM bookings b JOIN rooms r ON b.room_id=r.id "
            + "WHERE b.payment_status='Đã thanh toán' AND b.status <> 'Đã hủy'";
        try(Connection c = DBUtil.getConnection();
            PreparedStatement ps = c.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getDouble("total");
        } catch(SQLException e){
            throw new RuntimeException(e);
        }
    }

    public int bookingCount(){
        try(Connection c = DBUtil.getConnection();
            PreparedStatement ps = c.prepareStatement("SELECT COUNT(*) AS total FROM bookings")){
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getInt("total");
        } catch(SQLException e){
            throw new RuntimeException(e);
        }
    }

    public int paidBookingCount(){
        try(Connection c = DBUtil.getConnection();
            PreparedStatement ps = c.prepareStatement("SELECT COUNT(*) AS total FROM bookings WHERE payment_status='Đã thanh toán' AND status <> 'Đã hủy'")){
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getInt("total");
        } catch(SQLException e){
            throw new RuntimeException(e);
        }
    }


    public double totalRevenueBetween(String fromDate, String toDate){
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COALESCE(SUM(COALESCE(b.total_amount, r.price * GREATEST(DATEDIFF(b.check_out,b.check_in),1))),0) AS total ");
        sql.append("FROM bookings b JOIN rooms r ON b.room_id=r.id ");
        sql.append("WHERE b.payment_status='Đã thanh toán' AND b.status <> 'Đã hủy' ");
        if(fromDate != null && !fromDate.isBlank()) sql.append("AND DATE(b.created_at) >= ? ");
        if(toDate != null && !toDate.isBlank()) sql.append("AND DATE(b.created_at) <= ? ");

        try(Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql.toString())){
            int i = 1;
            if(fromDate != null && !fromDate.isBlank()) ps.setString(i++, fromDate);
            if(toDate != null && !toDate.isBlank()) ps.setString(i++, toDate);
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getDouble("total");
        } catch(SQLException e){
            throw new RuntimeException(e);
        }
    }

    public int paidBookingCountBetween(String fromDate, String toDate){
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) AS total FROM bookings b ");
        sql.append("WHERE b.payment_status='Đã thanh toán' AND b.status <> 'Đã hủy' ");
        if(fromDate != null && !fromDate.isBlank()) sql.append("AND DATE(b.created_at) >= ? ");
        if(toDate != null && !toDate.isBlank()) sql.append("AND DATE(b.created_at) <= ? ");

        try(Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql.toString())){
            int i = 1;
            if(fromDate != null && !fromDate.isBlank()) ps.setString(i++, fromDate);
            if(toDate != null && !toDate.isBlank()) ps.setString(i++, toDate);
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getInt("total");
        } catch(SQLException e){
            throw new RuntimeException(e);
        }
    }

    public List<Map<String,Object>> revenueDetails(String fromDate, String toDate){
        List<Map<String,Object>> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT b.id,b.created_at,b.check_in,b.check_out,b.status,b.payment_status,b.payment_method, ");
        sql.append("COALESCE(b.total_amount, r.price * GREATEST(DATEDIFF(b.check_out,b.check_in),1)) AS total_amount, ");
        sql.append("COALESCE(NULLIF(b.customer_name,''),u.full_name) AS customer_name, ");
        sql.append("COALESCE(NULLIF(b.customer_phone,''),u.phone) AS customer_phone, ");
        sql.append("COALESCE(NULLIF(b.customer_email,''),u.email) AS customer_email, ");
        sql.append("r.room_number,r.type,r.price ");
        sql.append("FROM bookings b JOIN rooms r ON b.room_id=r.id JOIN users u ON b.user_id=u.id ");
        sql.append("WHERE b.payment_status='Đã thanh toán' AND b.status <> 'Đã hủy' ");
        if(fromDate != null && !fromDate.isBlank()) sql.append("AND DATE(b.created_at) >= ? ");
        if(toDate != null && !toDate.isBlank()) sql.append("AND DATE(b.created_at) <= ? ");
        sql.append("ORDER BY b.created_at DESC");

        try(Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql.toString())){
            int i = 1;
            if(fromDate != null && !fromDate.isBlank()) ps.setString(i++, fromDate);
            if(toDate != null && !toDate.isBlank()) ps.setString(i++, toDate);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) list.add(row(rs));
            return list;
        } catch(SQLException e){
            throw new RuntimeException(e);
        }
    }

}
