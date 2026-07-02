<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    String next = request.getParameter("next");

    if(next == null) {
        next = "";
    }
%>

<!doctype html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Đăng ký</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">

</head>

<body>

    <%@ include file="WEB-INF/header.jspf" %>

    <% if(request.getParameter("err") != null){ %>

        <div class="alert error">
            <%=request.getParameter("err")%>
        </div>

    <% } %>

    <form class="form"
          method="post"
          action="register">

        <h2>Tạo tài khoản khách hàng</h2>

        <p class="muted">
            Tài khoản đăng ký tại đây sẽ được lưu với quyền khách hàng. 
            
        </p>

        <input type="hidden"
               name="next"
               value="<%=next%>">

        <label>Họ tên</label>

        <input name="name"
               required>

        <label>Email</label>

        <input name="email"
               type="email"
               pattern="[A-Za-z0-9._%+-]+@gmail\.com"
               title="Email bắt buộc phải kết thúc bằng @gmail.com"
               placeholder="ví dụ: tenban@gmail.com"
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

        <input name="password"
               type="password"
               maxlength="8"
               title="Mật khẩu tối đa 8 ký tự"
               required>

        <button class="btn"
                type="submit">

            Đăng ký

        </button>

    </form>

</body>

</html>