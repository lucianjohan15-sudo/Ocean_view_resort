package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.temporal.ChronoUnit;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reservationNo = request.getParameter("reservationNo");

        if (reservationNo != null && !reservationNo.trim().isEmpty()) {
            ReservationDAO dao = new ReservationDAO();
            Reservation r = dao.getReservationByNo(reservationNo.trim());

            if (r != null) {
                long nights = ChronoUnit.DAYS.between(
                        r.getCheckInDate().toLocalDate(),
                        r.getCheckOutDate().toLocalDate()
                );

                BigDecimal total = r.getRatePerNight().multiply(BigDecimal.valueOf(nights));

                request.setAttribute("reservation", r);
                request.setAttribute("nights", nights);
                request.setAttribute("total", total);
            } else {
                request.setAttribute("error", "Reservation not found.");
            }
        }

        request.getRequestDispatcher("bill.jsp").forward(request, response);
    }
}