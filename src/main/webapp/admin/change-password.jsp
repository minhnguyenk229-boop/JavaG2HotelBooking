<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">
</head>
<body>
    <%@ include file="adminHeader.jspf" %>

    <h1>Đổi mật khẩu tài khoản</h1>

    <form class="form" method="post" action="${pageContext.request.contextPath}/change-password">
        <%
            String ok = (String) session.getAttribute("flashMsg");
            String err = (String) session.getAttribute("flashErr");
            session.removeAttribute("flashMsg");
            session.removeAttribute("flashErr");
        %>
        <% if(ok != null){ %><div class="alert success"><%=ok%></div><% } %>
        <% if(err != null){ %><div class="alert error"><%=err%></div><% } %>

        <label>Mật khẩu hiện tại</label>
        <input type="password" name="oldPassword" maxlength="8" required>

        <label>Mật khẩu mới</label>
        <input type="password" name="newPassword" maxlength="8" required>

        <label>Nhập lại mật khẩu mới</label>
        <input type="password" name="confirmPassword" maxlength="8" required>

        <button class="btn" type="submit">Cập nhật mật khẩu</button>
    </form>

    <%@ include file="adminFooter.jspf" %>
</body>
</html>
