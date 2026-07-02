package com.g2hotel.servlet;

import com.g2hotel.dao.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.*;

@WebServlet({
    "/login",
    "/register",
    "/logout",
    "/change-password",
    "/admin/create-employee",
    "/admin/customer-status",
    "/admin/delete-customer",
    "/admin/update-customer",
    "/admin/update-employee"
})
public class AuthServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws IOException, ServletException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String path = req.getServletPath();

        UserDao dao = new UserDao();

        try {

            if ("/register".equals(path)) {

                validateAccountInput(
                    req.getParameter("email"),
                    req.getParameter("phone"),
                    req.getParameter("password")
                );

                dao.registerCustomer(
                    req.getParameter("name"),
                    req.getParameter("email"),
                    req.getParameter("phone"),
                    req.getParameter("password")
                );

                req.getSession().setAttribute(
                    "flashMsg",
                    "Tài khoản khách hàng đã được tạo. Vui lòng đăng nhập để đặt phòng."
                );

                String next = req.getParameter("next");

                String url =
                    req.getContextPath()
                    + "/login.jsp"
                    + ((next != null && !next.isBlank())
                        ? "?next=" + URLEncoder.encode(
                            next,
                            StandardCharsets.UTF_8
                        )
                        : "");

                resp.sendRedirect(url);

                return;
            }

            if ("/login".equals(path)) {

                String next = req.getParameter("next");

                try (Connection c = DBUtil.getConnection();
                     ResultSet rs = dao.loginRaw(
                         c,
                         req.getParameter("email"),
                         req.getParameter("password")
                     )) {

                    if (rs.next()) {

                        if (rs.getInt("status") != 1) {

                            resp.sendRedirect(
                                req.getContextPath()
                                + "/login.jsp?err="
                                + URLEncoder.encode(
                                    "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ G2 Hotel.",
                                    StandardCharsets.UTF_8
                                )
                            );

                            return;
                        }

                        HttpSession s = req.getSession();

                        s.setAttribute("userId", rs.getInt("id"));
                        s.setAttribute("name", rs.getString("full_name"));
                        s.setAttribute("email", rs.getString("email"));
                        s.setAttribute("phone", rs.getString("phone"));
                        s.setAttribute("role", rs.getString("role"));

                        String role = rs.getString("role");

                        if ("CUSTOMER".equals(role)) {

                            resp.sendRedirect(
                                req.getContextPath()
                                + ((next != null && !next.isBlank())
                                    ? next
                                    : "/rooms.jsp")
                            );

                        } else {

                            resp.sendRedirect(
                                req.getContextPath()
                                + "/admin/dashboard.jsp"
                            );
                        }

                    } else {

                        resp.sendRedirect(
                            req.getContextPath()
                            + "/login.jsp?err="
                            + URLEncoder.encode(
                                "Sai email hoặc mật khẩu",
                                StandardCharsets.UTF_8
                            )
                        );
                    }

                    return;
                }
            }

            if ("/change-password".equals(path)) {

                Integer userId = (Integer) req.getSession().getAttribute("userId");
                if (userId == null) {
                    throw new RuntimeException("Vui lòng đăng nhập để đổi mật khẩu.");
                }

                String oldPassword = req.getParameter("oldPassword");
                String newPassword = req.getParameter("newPassword");
                String confirmPassword = req.getParameter("confirmPassword");

                validatePasswordOnly(newPassword);

                if (!newPassword.equals(confirmPassword)) {
                    throw new RuntimeException("Mật khẩu xác nhận không khớp.");
                }

                if (!dao.changePassword(userId, oldPassword, newPassword)) {
                    throw new RuntimeException("Mật khẩu hiện tại không đúng.");
                }

                req.getSession().setAttribute("flashMsg", "Đổi mật khẩu thành công.");

                Object role = req.getSession().getAttribute("role");
                resp.sendRedirect(
                    req.getContextPath()
                    + (("ADMIN".equals(role) || "EMPLOYEE".equals(role))
                        ? "/admin/change-password.jsp"
                        : "/change-password.jsp")
                );

                return;
            }

            if ("/admin/create-employee".equals(path)) {

                requireAdmin(req);

                validateAccountInput(
                    req.getParameter("email"),
                    req.getParameter("phone"),
                    req.getParameter("password")
                );

                dao.createEmployee(
                    req.getParameter("name"),
                    req.getParameter("email"),
                    req.getParameter("phone"),
                    req.getParameter("password")
                );

                req.getSession().setAttribute(
                    "adminMsg",
                    "Tạo tài khoản cho nhân viên thành công."
                );

                resp.sendRedirect(
                    req.getContextPath()
                    + "/admin/employees.jsp"
                );

                return;
            }

            if ("/admin/customer-status".equals(path)) {

                requireStaff(req);

                int id = Integer.parseInt(
                    req.getParameter("customerId")
                );

                boolean active =
                    "1".equals(req.getParameter("status"));

                if (!dao.setCustomerStatus(id, active)) {

                    throw new RuntimeException(
                        "Không tìm thấy tài khoản khách hàng cần cập nhật."
                    );
                }

                req.getSession().setAttribute(
                    "adminMsg",
                    active
                        ? "Mở khóa tài khoản khách hàng thành công."
                        : "Khóa tài khoản khách hàng thành công."
                );

                resp.sendRedirect(
                    req.getContextPath()
                    + "/admin/customers.jsp"
                );

                return;
            }

            if ("/admin/update-customer".equals(path)) {

                requireStaff(req);

                int id = Integer.parseInt(req.getParameter("customerId"));

                validateAccountInput(
                    req.getParameter("email"),
                    req.getParameter("phone"),
                    req.getParameter("password"),
                    true
                );

                Integer status = null;
                if(req.getParameter("status") != null){
                    status = Integer.parseInt(req.getParameter("status"));
                }

                if(!dao.updateUserByRole(
                    id,
                    "CUSTOMER",
                    req.getParameter("name"),
                    req.getParameter("email"),
                    req.getParameter("phone"),
                    req.getParameter("password"),
                    status
                )){
                    throw new RuntimeException("Không tìm thấy tài khoản khách hàng cần sửa.");
                }

                req.getSession().setAttribute("adminMsg", "Cập nhật thông tin khách hàng thành công.");
                resp.sendRedirect(req.getContextPath() + "/admin/customers.jsp");
                return;
            }

            if ("/admin/update-employee".equals(path)) {

                requireAdmin(req);

                int id = Integer.parseInt(req.getParameter("employeeId"));

                validateAccountInput(
                    req.getParameter("email"),
                    req.getParameter("phone"),
                    req.getParameter("password"),
                    true
                );

                Integer status = null;
                if(req.getParameter("status") != null){
                    status = Integer.parseInt(req.getParameter("status"));
                }

                if(!dao.updateUserByRole(
                    id,
                    "EMPLOYEE",
                    req.getParameter("name"),
                    req.getParameter("email"),
                    req.getParameter("phone"),
                    req.getParameter("password"),
                    status
                )){
                    throw new RuntimeException("Không tìm thấy tài khoản nhân viên cần sửa.");
                }

                req.getSession().setAttribute("adminMsg", "Cập nhật thông tin nhân viên thành công.");
                resp.sendRedirect(req.getContextPath() + "/admin/employees.jsp");
                return;
            }

            if ("/admin/delete-customer".equals(path)) {

                requireStaff(req);

                int id = Integer.parseInt(
                    req.getParameter("customerId")
                );

                if (!dao.deleteCustomer(id)) {

                    throw new RuntimeException(
                        "Không tìm thấy tài khoản khách hàng cần xóa."
                    );
                }

                req.getSession().setAttribute(
                    "adminMsg",
                    "Xóa tài khoản khách hàng thành công."
                );

                resp.sendRedirect(
                    req.getContextPath()
                    + "/admin/customers.jsp"
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
                    e.getMessage()
                );

                String page =
                    (path.contains("customer")
                        ? "/admin/customers.jsp"
                        : (path.contains("employee") || path.contains("create-employee")
                            ? "/admin/employees.jsp"
                            : "/admin/dashboard.jsp"));

                resp.sendRedirect(
                    req.getContextPath()
                    + page
                );

            } else if ("/change-password".equals(path)) {

                req.getSession().setAttribute("flashErr", e.getMessage());
                Object role = req.getSession().getAttribute("role");
                resp.sendRedirect(
                    req.getContextPath()
                    + (("ADMIN".equals(role) || "EMPLOYEE".equals(role))
                        ? "/admin/change-password.jsp"
                        : "/change-password.jsp")
                );

            } else if ("/register".equals(path)) {

                String next = req.getParameter("next");

                resp.sendRedirect(
                    req.getContextPath()
                    + "/register.jsp?err="
                    + URLEncoder.encode(
                        e.getMessage(),
                        StandardCharsets.UTF_8
                    )
                    + ((next != null && !next.isBlank())
                        ? "&next=" + URLEncoder.encode(
                            next,
                            StandardCharsets.UTF_8
                          )
                        : "")
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

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws IOException {

        String path = req.getServletPath();

        if ("/logout".equals(path)) {

            req.getSession().invalidate();

            resp.sendRedirect(
                req.getContextPath()
                + "/index.jsp"
            );

        } else if ("/admin/create-employee".equals(path)) {

            Object role = req.getSession().getAttribute("role");
            resp.sendRedirect(
                req.getContextPath()
                + ("ADMIN".equals(role)
                    ? "/admin/employees.jsp"
                    : "/admin/dashboard.jsp")
            );

        } else if ("/login".equals(path)) {

            resp.sendRedirect(
                req.getContextPath()
                + "/login.jsp"
            );

        } else if ("/register".equals(path)) {

            resp.sendRedirect(
                req.getContextPath()
                + "/register.jsp"
            );

        } else {

            resp.sendRedirect(
                req.getContextPath()
                + "/index.jsp"
            );
        }
    }

    private void validateAccountInput(String email,
                                      String phone,
                                      String password) {
        validateAccountInput(email, phone, password, false);
    }

    private void validateAccountInput(String email,
                                      String phone,
                                      String password,
                                      boolean allowBlankPassword) {

        if (email == null ||
            !email.matches("^[A-Za-z0-9._%+-]+@gmail\\.com$")) {

            throw new RuntimeException(
                "Email không hợp lệ. Email bắt buộc phải kết thúc bằng @gmail.com."
            );
        }

        if (phone == null ||
            !phone.matches("^0\\d{0,10}$")) {

            throw new RuntimeException(
                "Số điện thoại không hợp lệ. Số điện thoại chỉ được nhập số, phải bắt đầu bằng số 0 và tối đa 11 số."
            );
        }

        if(!allowBlankPassword || (password != null && !password.isBlank())){
            validatePasswordOnly(password);
        }
    }

    private void validatePasswordOnly(String password) {

        if (password == null || password.isBlank() || password.length() > 8) {

            throw new RuntimeException(
                "Mật khẩu không hợp lệ. Mật khẩu không được để trống và tối đa 8 ký tự."
            );
        }
    }

    private void requireAdmin(HttpServletRequest req) {

        Object role = req.getSession().getAttribute("role");

        if (!"ADMIN".equals(role)) {

            throw new RuntimeException(
                "Chỉ tài khoản admin mới được tạo nhân viên."
            );
        }
    }

    private void requireStaff(HttpServletRequest req) {

        Object role = req.getSession().getAttribute("role");

        if (!"ADMIN".equals(role) &&
            !"EMPLOYEE".equals(role)) {

            throw new RuntimeException(
                "Bạn không có quyền thực hiện chức năng này."
            );
        }
    }
}