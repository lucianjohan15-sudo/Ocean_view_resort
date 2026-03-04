package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewReservation")
public class ViewReservationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ReservationDAO dao = new ReservationDAO();

        // Always load all booked reservations
        List<Reservation> allReservations = dao.getAllReservations();
        request.setAttribute("allReservations", allReservations);

        // Optional single search by reservation number
        String reservationNo = request.getParameter("reservationNo");

        if (reservationNo != null && !reservationNo.trim().isEmpty()) {
            Reservation reservation = dao.getReservationByNo(reservationNo.trim());
            if (reservation != null) {
                request.setAttribute("reservation", reservation);
            } else {
                request.setAttribute("error", "Reservation not found.");
            }
        }

        request.getRequestDispatcher("viewReservation.jsp").forward(request, response);
    }
}