package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/addReservation")
public class AddReservationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String reservationNo = request.getParameter("reservationNo");
            String guestName = request.getParameter("guestName");
            String address = request.getParameter("address");
            String contactNumber = request.getParameter("contactNumber");
            int roomTypeId = Integer.parseInt(request.getParameter("roomTypeId"));
            Date checkInDate = Date.valueOf(request.getParameter("checkInDate"));
            Date checkOutDate = Date.valueOf(request.getParameter("checkOutDate"));

            if (!checkOutDate.after(checkInDate)) {
                request.setAttribute("error", "Check-out date must be after check-in date.");
                request.getRequestDispatcher("addReservation.jsp").forward(request, response);
                return;
            }

            Reservation r = new Reservation();
            r.setReservationNo(reservationNo);
            r.setGuestName(guestName);
            r.setAddress(address);
            r.setContactNumber(contactNumber);
            r.setRoomTypeId(roomTypeId);
            r.setCheckInDate(checkInDate);
            r.setCheckOutDate(checkOutDate);
            r.setCreatedBy(user.getUserId());

            ReservationDAO dao = new ReservationDAO();
            boolean success = dao.addReservation(r);

            if (success) {
                request.setAttribute("success", "Reservation added successfully!");
            } else {
                request.setAttribute("error", "Failed to add reservation. Reservation No may already exist.");
            }

            request.getRequestDispatcher("addReservation.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input. Please check the form.");
            request.getRequestDispatcher("addReservation.jsp").forward(request, response);
        }
    }
}