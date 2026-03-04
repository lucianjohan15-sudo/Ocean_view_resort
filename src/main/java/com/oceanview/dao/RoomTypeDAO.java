package com.oceanview.dao;

import com.oceanview.model.RoomType;
import com.oceanview.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomTypeDAO {
    public List<RoomType> getAllRoomTypes() {
        List<RoomType> list = new ArrayList<>();
        String sql = "SELECT * FROM room_types ORDER BY room_type_name";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                RoomType r = new RoomType();
                r.setRoomTypeId(rs.getInt("room_type_id"));
                r.setRoomTypeName(rs.getString("room_type_name"));
                r.setRatePerNight(rs.getBigDecimal("rate_per_night"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}