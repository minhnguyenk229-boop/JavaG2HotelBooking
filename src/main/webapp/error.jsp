<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!doctype html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Lỗi</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">

</head>

<body>

    <%@ include file="WEB-INF/header.jspf" %>

    <div class="err">
        <b>Đã xảy ra lỗi:</b>
        <%=request.getAttribute("error")%>
    </div>

    <section class="section">

        <a class="btn"
           href="index.jsp">
            Về trang chủ
        </a>

    </section>

</body>

</html>