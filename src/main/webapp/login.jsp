<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    String flash = (String) session.getAttribute("flashMsg");

    if (flash != null) {
        session.removeAttribute("flashMsg");
    }

    String next = request.getParameter("next");

    if (next == null) {
        next = "";
    }
%>

<!doctype html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Đăng nhập</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">

</head>

<body>

    <%@ include file="WEB-INF/header.jspf" %>

    <% if(flash != null){ %>

        <div class="alert success">
            <%=flash%>
        </div>

    <% } %>

    <% if(request.getParameter("msg") != null){ %>

        <div class="alert success">
            <%=request.getParameter("msg")%>
        </div>

    <% } %>

    <% if(request.getParameter("err") != null){ %>

        <div class="alert error">
            <%=request.getParameter("err")%>
        </div>

    <% } %>

    <form class="form"
          method="post"
          action="login">

        <h2>Đăng nhập G2 Hotel</h2>

        <input type="hidden"
               name="next"
               value="<%=next%>">

        <label>Email</label>

        <input name="email"
               type="email"
               required>

        <label>Mật khẩu</label>

        <input name="password"
               type="password"
               required>

        <button class="btn"
                type="submit">

            Đăng nhập

        </button>

        <p>

            Chưa có tài khoản?

            <a href="register.jsp<%=next.isBlank()
                    ? ""
                    : "?next=" + java.net.URLEncoder.encode(next, "UTF-8")%>">

                Đăng ký khách hàng

            </a>

        </p>

    </form>

</body>

</html>