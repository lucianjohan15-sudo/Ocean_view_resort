package com.oceanview.dao;

import com.oceanview.model.Reservation;
import com.oceanview.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReservationDAO {

    public boolean addReservation(Reservation r) {
        String sql = "INSERT INTO reservations " +
                "(reservation_no, guest_name, address, contact_number, room_type_id, check_in_date, check_out_date, created_by) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, r.getReservationNo());
            ps.setString(2, r.getGuestName());
            ps.setString(3, r.getAddress());
            ps.setString(4, r.getContactNumber());
            ps.setInt(5, r.getRoomTypeId());
            ps.setDate(6, r.getCheckInDate());
            ps.setDate(7, r.getCheckOutDate());
            ps.setInt(8, r.getCreatedBy());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Reservation getReservationByNo(String reservationNo) {
        String sql = "SELECT r.*, rt.room_type_name, rt.rate_per_night " +
                "FROM reservations r " +
                "JOIN room_types rt ON r.room_type_id = rt.room_type_id " +
                "WHERE r.reservation_no = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, reservationNo);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Reservation r = new Reservation();
                r.setReservationId(rs.getInt("reservation_id"));
                r.setReservationNo(rs.getString("reservation_no"));
                r.setGuestName(rs.getString("guest_name"));
                r.setAddress(rs.getString("address"));
                r.setContactNumber(rs.getString("contact_number"));
                r.setRoomTypeId(rs.getInt("room_type_id"));
                r.setRoomTypeName(rs.getString("room_type_name"));
                r.setRatePerNight(rs.getBigDecimal("rate_per_night"));
                r.setCheckInDate(rs.getDate("check_in_date"));
                r.setCheckOutDate(rs.getDate("check_out_date"));
                return r;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public java.util.List<com.oceanview.model.Reservation> getAllReservations() {
        java.util.List<com.oceanview.model.Reservation> list = new java.util.ArrayList<>();

        String sql = "SELECT r.*, rt.room_type_name, rt.rate_per_night " +
                "FROM reservations r " +
                "JOIN room_types rt ON r.room_type_id = rt.room_type_id " +
                "ORDER BY r.created_at DESC";

        try (java.sql.Connection con = com.oceanview.util.DBConnection.getConnection();
             java.sql.PreparedStatement ps = con.prepareStatement(sql);
             java.sql.ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                com.oceanview.model.Reservation r = new com.oceanview.model.Reservation();
                r.setReservationId(rs.getInt("reservation_id"));
                r.setReservationNo(rs.getString("reservation_no"));
                r.setGuestName(rs.getString("guest_name"));
                r.setAddress(rs.getString("address"));
                r.setContactNumber(rs.getString("contact_number"));
                r.setRoomTypeId(rs.getInt("room_type_id"));
                r.setRoomTypeName(rs.getString("room_type_name"));
                r.setRatePerNight(rs.getBigDecimal("rate_per_night"));
                r.setCheckInDate(rs.getDate("check_in_date"));
                r.setCheckOutDate(rs.getDate("check_out_date"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}