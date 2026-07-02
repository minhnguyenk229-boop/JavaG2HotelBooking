package com.g2hotel.dao;

import java.sql.*;
import java.util.*;

public class RoomDao{

    public List<Map<String,Object>> all(String status){

        List<Map<String,Object>> list = new ArrayList<>();

        String sql =
            "SELECT * FROM rooms"
            + (status != null && !status.isBlank()
                ? " WHERE status=?"
                : "")
            + " ORDER BY room_number";

        try(Connection c = DBUtil.getConnection();
            PreparedStatement ps = c.prepareStatement(sql)){

            if(status != null && !status.isBlank()) {
                ps.setString(1, status);
            }

            try(ResultSet rs = ps.executeQuery()){

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

                    list.add(m);
                }
            }

            return list;

        } catch(SQLException e) {

            throw new RuntimeException(e);
        }
    }

    public Map<String,Object> find(int id){

        try(Connection c = DBUtil.getConnection();
            PreparedStatement ps =
                c.prepareStatement(
                    "SELECT * FROM rooms WHERE id=?"
                )){

            ps.setInt(1, id);

            try(ResultSet rs = ps.executeQuery()){

                if(rs.next()){

                    Map<String,Object> m = new HashMap<>();

                    for(int i = 1;
                        i <= rs.getMetaData().getColumnCount();
                        i++) {

                        m.put(
                            rs.getMetaData().getColumnLabel(i),
                            rs.getObject(i)
                        );
                    }

                    return m;
                }
            }

        } catch(SQLException e) {

            throw new RuntimeException(e);
        }

        return null;
    }

    public boolean update(int id,
                          String type,
                          double price,
                          String status,
                          String image,
                          String description){

        String sql =
            "UPDATE rooms SET type=?,price=?,status=?,image=?,description=? WHERE id=?";

        try(Connection c = DBUtil.getConnection();
            PreparedStatement ps = c.prepareStatement(sql)){

            ps.setString(1, type);
            ps.setDouble(2, price);
            ps.setString(3, status);
            ps.setString(4, image);
            ps.setString(5, description);
            ps.setInt(6, id);

            return ps.executeUpdate() > 0;

        } catch(SQLException e) {

            throw new RuntimeException(e);
        }
    }

    public boolean setStatus(int id,
                             String status){

        try(Connection c = DBUtil.getConnection();
            PreparedStatement ps =
                c.prepareStatement(
                    "UPDATE rooms SET status=? WHERE id=?"
                )){

            ps.setString(1, status);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;

        } catch(SQLException e) {

            throw new RuntimeException(e);
        }
    }
}