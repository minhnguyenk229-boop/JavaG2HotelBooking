<%@ page import="com.g2hotel.dao.UserDao,java.util.*"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý khách hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">
</head>
<body>
    <%@ include file="adminHeader.jspf" %>

    <h1>Quản lý tài khoản khách hàng</h1>
    <%@ include file="adminMessages.jspf" %>

    <p class="muted">Admin và nhân viên có thể khóa/mở khóa, xóa và sửa thông tin khách hàng. Mật khẩu để trống nếu không muốn thay đổi.</p>

    <table>
        <tr>
            <th>Mã</th>
            <th>Họ tên</th>
            <th>Email</th>
            <th>Số điện thoại</th>
            <th>Mật khẩu mới</th>
            <th>Trạng thái</th>
            <th>Lưu sửa</th>
            <th>Khóa / mở khóa</th>
            <th>Xóa</th>
        </tr>

        <%
            for(Map<String,Object> u : new UserDao().customers()) {
                String active = String.valueOf(u.get("status"));
                String formId = "cusForm" + u.get("id");
        %>

        <tr>
            <td>#<%=u.get("id")%></td>
            <td>
                <input form="<%=formId%>" name="name" value="<%=u.get("full_name")%>" required>
            </td>
            <td>
                <input form="<%=formId%>" type="email" name="email" value="<%=u.get("email")%>"
                       pattern="[A-Za-z0-9._%+-]+@gmail\.com" title="Email phải kết thúc bằng @gmail.com" required>
            </td>
            <td>
                <input form="<%=formId%>" name="phone" value="<%=u.get("phone")%>" maxlength="11"
                       pattern="0[0-9]{0,10}" oninput="this.value=this.value.replace(/[^0-9]/g,'').slice(0,11)" required>
            </td>
            <td>
                <input form="<%=formId%>" type="password" name="password" maxlength="8" placeholder="Để trống nếu không đổi">
            </td>
            <td>
                <select form="<%=formId%>" name="status">
                    <option value="1" <%=active.equals("1") ? "selected" : ""%>>Đang hoạt động</option>
                    <option value="0" <%=active.equals("1") ? "" : "selected"%>>Đã khóa</option>
                </select>
            </td>
            <td>
                <form id="<%=formId%>" method="post" action="${pageContext.request.contextPath}/admin/update-customer">
                    <input type="hidden" name="customerId" value="<%=u.get("id")%>">
                    <button class="btn" type="submit">Lưu sửa</button>
                </form>
            </td>
            <td>
                <form method="post" action="${pageContext.request.contextPath}/admin/customer-status">
                    <input type="hidden" name="customerId" value="<%=u.get("id")%>">
                    <input type="hidden" name="status" value="<%=active.equals("1") ? "0" : "1"%>">
                    <button class="btn" type="submit"><%=active.equals("1") ? "Khóa" : "Mở khóa"%></button>
                </form>
            </td>
            <td>
                <form method="post" action="${pageContext.request.contextPath}/admin/delete-customer" onsubmit="return confirm('Bạn chắc chắn muốn xóa tài khoản khách hàng này?');">
                    <input type="hidden" name="customerId" value="<%=u.get("id")%>">
                    <button class="btn dark" type="submit">Xóa</button>
                </form>
            </td>
        </tr>

        <% } %>
    </table>

    <%@ include file="adminFooter.jspf" %>
</body>
</html>
