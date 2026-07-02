<%@ page import="com.g2hotel.dao.UserDao,java.util.*"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    Object currentRole = session.getAttribute("role");
    if (!"ADMIN".equals(currentRole)) {
        session.setAttribute("adminErr", "Chỉ tài khoản admin mới được tạo và xem danh sách nhân viên.");
        response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
        return;
    }
%>

<!doctype html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Nhân viên</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">

</head>

<body>

    <%@ include file="adminHeader.jspf" %>

    <h1>Tạo tài khoản cho nhân viên</h1>

    <%@ include file="adminMessages.jspf" %>

    <form class="form"
          method="post"
          action="${pageContext.request.contextPath}/admin/create-employee">

        <label>Họ tên</label>
        <input name="name" required>

        <label>Email</label>
        <input type="email"
               name="email"
               pattern="[A-Za-z0-9._%+-]+@gmail\.com"
               title="Email bắt buộc phải kết thúc bằng @gmail.com"
               placeholder="ví dụ: nhanvien@gmail.com"
               required>

        <label>Số điện thoại</label>
        <input name="phone"
               inputmode="numeric"
               maxlength="11"
               pattern="0[0-9]{0,10}"
               title="Số điện thoại chỉ được nhập số, bắt đầu bằng số 0 và tối đa 11 số"
               oninput="this.value=this.value.replace(/[^0-9]/g,'').slice(0,11)"
               required>

        <label>Mật khẩu</label>
        <input type="password"
               name="password"
               maxlength="8"
               title="Mật khẩu tối đa 8 ký tự"
               required>

        <button class="btn">
            Tạo nhân viên
        </button>

    </form>

    <h2>Danh sách nhân viên</h2>

    <table>

        <tr>
            <th>Mã</th>
            <th>Họ tên</th>
            <th>Email</th>
            <th>Số điện thoại</th>
            <th>Mật khẩu mới</th>
            <th>Trạng thái</th>
            <th>Lưu sửa</th>
        </tr>

        <% for(Map<String,Object> u : new UserDao().employees()){
               String active = String.valueOf(u.get("status"));
               String formId = "empForm" + u.get("id");
        %>

        <tr>
            <td>#<%=u.get("id")%></td>
            <td><input form="<%=formId%>" name="name" value="<%=u.get("full_name")%>" required></td>
            <td><input form="<%=formId%>" type="email" name="email" value="<%=u.get("email")%>" pattern="[A-Za-z0-9._%+-]+@gmail\.com" title="Email phải kết thúc bằng @gmail.com" required></td>
            <td><input form="<%=formId%>" name="phone" value="<%=u.get("phone")%>" maxlength="11" pattern="0[0-9]{0,10}" oninput="this.value=this.value.replace(/[^0-9]/g,'').slice(0,11)" required></td>
            <td><input form="<%=formId%>" type="password" name="password" maxlength="8" placeholder="Để trống nếu không đổi"></td>
            <td>
                <select form="<%=formId%>" name="status">
                    <option value="1" <%=active.equals("1") ? "selected" : ""%>>Đang hoạt động</option>
                    <option value="0" <%=active.equals("1") ? "" : "selected"%>>Đã khóa</option>
                </select>
            </td>
            <td>
                <form id="<%=formId%>" method="post" action="${pageContext.request.contextPath}/admin/update-employee">
                    <input type="hidden" name="employeeId" value="<%=u.get("id")%>">
                    <button class="btn" type="submit">Lưu sửa</button>
                </form>
            </td>
        </tr>

        <% } %>

    </table>

    <%@ include file="adminFooter.jspf" %>

</body>

</html>