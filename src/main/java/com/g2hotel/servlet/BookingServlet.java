package com.g2hotel.servlet;

import com.g2hotel.dao.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet({
    "/book",
    "/cancel-booking",
    "/admin/update-booking"
})
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws IOException, ServletException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String path = req.getServletPath();

        BookingDao dao = new BookingDao();

        try {

            if (path.equals("/book")) {

                HttpSession session = req.getSession();

                if (session.getAttribute("userId") == null) {

                    resp.sendRedirect(
                        req.getContextPath()
                        + "/login.jsp?err="
                        + java.net.URLEncoder.encode(
                            "Vui lòng đăng nhập để đặt phòng",
                            "UTF-8"
                        )
                    );

                    return;
                }

                int bookingId = dao.create(
                    (Integer) session.getAttribute("userId"),
                    Integer.parseInt(req.getParameter("roomId")),
                    req.getParameter("checkIn"),
                    req.getParameter("checkOut"),
                    req.getParameter("note"),
                    req.getParameter("customerName"),
                    req.getParameter("customerPhone"),
                    req.getParameter("customerEmail"),
                    req.getParameter("paymentMethod")
                );

                String paymentMethod = req.getParameter("paymentMethod");

                if ("Thanh toán tại khách sạn".equals(paymentMethod)) {
                    resp.sendRedirect(
                        req.getContextPath()
                        + "/booking-complete.jsp?bookingId="
                        + bookingId
                    );
                } else {
                    resp.sendRedirect(
                        req.getContextPath()
                        + "/payment.jsp?bookingId="
                        + bookingId
                    );
                }

                return;
            }

            if (path.equals("/cancel-booking")) {

                HttpSession session = req.getSession();

                if (session.getAttribute("userId") == null) {

                    resp.sendRedirect(
                        req.getContextPath()
                        + "/login.jsp?err="
                        + java.net.URLEncoder.encode(
                            "Vui lòng đăng nhập",
                            "UTF-8"
                        )
                    );

                    return;
                }

                dao.cancelByCustomer(
                    Integer.parseInt(req.getParameter("bookingId")),
                    (Integer) session.getAttribute("userId"),
                    Integer.parseInt(req.getParameter("roomId"))
                );

                resp.sendRedirect(
                    req.getContextPath()
                    + "/my-bookings.jsp?msg="
                    + java.net.URLEncoder.encode(
                        "Đã hủy đơn đặt phòng",
                        "UTF-8"
                    )
                );

                return;
            }

            if (path.equals("/admin/update-booking")) {

                HttpSession session = req.getSession();

                Object role = session.getAttribute("role");

                if (!"ADMIN".equals(role) &&
                    !"EMPLOYEE".equals(role)) {

                    throw new RuntimeException(
                        "Bạn không có quyền cập nhật đơn đặt phòng."
                    );
                }

                boolean ok = dao.update(
                    Integer.parseInt(req.getParameter("bookingId")),
                    req.getParameter("status"),
                    req.getParameter("payment"),
                    Integer.parseInt(req.getParameter("roomId"))
                );

                if (!ok) {

                    throw new RuntimeException(
                        "Không tìm thấy đơn đặt phòng cần cập nhật."
                    );
                }

                session.setAttribute(
                    "adminMsg",
                    "Cập nhật trạng thái phòng thành công."
                );

                resp.sendRedirect(
                    req.getContextPath()
                    + "/admin/bookings.jsp"
                );

                return;
            }

            resp.sendRedirect(
                req.getContextPath()
                + "/index.jsp"
            );

        } catch (Exception e) {

            if (path.startsWith("/admin/")) {

                req.getSession().setAttribute(
                    "adminErr",
                    "Lỗi: " + e.getMessage()
                );

                resp.sendRedirect(
                    req.getContextPath()
                    + "/admin/bookings.jsp"
                );

            } else {

                req.setAttribute(
                    "error",
                    e.getMessage()
                );

                req.getRequestDispatcher(
                    "/error.jsp"
                ).forward(req, resp);
            }
        }
    }
}