package com.g2hotel.servlet;

import com.g2hotel.dao.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet({
    "/admin/update-room",
    "/admin/status-room"
})
public class RoomServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws IOException, ServletException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {

            Object role = req.getSession().getAttribute("role");

            if (!"ADMIN".equals(role) &&
                !"EMPLOYEE".equals(role)) {

                throw new RuntimeException(
                    "Bạn không có quyền cập nhật phòng."
                );
            }

            RoomDao dao = new RoomDao();

            int id = Integer.parseInt(
                req.getParameter("id")
            );

            boolean ok;

            if (req.getServletPath().endsWith("status-room")) {

                ok = dao.setStatus(
                    id,
                    req.getParameter("status")
                );

            } else {

                ok = dao.update(
                    id,
                    req.getParameter("type"),
                    Double.parseDouble(
                        req.getParameter("price")
                    ),
                    req.getParameter("status"),
                    req.getParameter("image"),
                    req.getParameter("description")
                );
            }

            if (!ok) {

                throw new RuntimeException(
                    "Không tìm thấy phòng cần cập nhật."
                );
            }

            req.getSession().setAttribute(
                "adminMsg",
                "Cập nhật trạng thái phòng thành công."
            );

            resp.sendRedirect(
                req.getContextPath()
                + "/admin/rooms.jsp"
            );

        } catch (Exception e) {

            req.getSession().setAttribute(
                "adminErr",
                e.getMessage()
            );

            resp.sendRedirect(
                req.getContextPath()
                + "/admin/rooms.jsp"
            );
        }
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws IOException {

        resp.sendRedirect(
            req.getContextPath()
            + "/admin/rooms.jsp"
        );
    }
}