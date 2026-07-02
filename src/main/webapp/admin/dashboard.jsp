<%@ page import="com.g2hotel.dao.*,java.util.*"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!doctype html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Quản trị</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">

</head>

<body>

    <%@ include file="adminHeader.jspf" %>

    <h1>Bảng điều khiển</h1>

    <%
        List<Map<String,Object>> all = new RoomDao().all(null);
        BookingDao bookingDao = new BookingDao();
        double revenue = bookingDao.totalRevenue();
        int totalBookings = bookingDao.bookingCount();
        int paidBookings = bookingDao.paidBookingCount();

        int empty = 0;
        int busy = 0;
        int fix = 0;

        for(Map<String,Object> r : all){

            String s = (String) r.get("status");

            if("Trống".equals(s)){
                empty++;
            }
            else if("Đã đặt".equals(s)){
                busy++;
            }
            else{
                fix++;
            }
        }
    %>

    <div class="stats">

        <div class="stat">
            <p>Tổng phòng</p>
            <b><%=all.size()%></b>
        </div>

        <div class="stat">
            <p>Phòng trống</p>
            <b><%=empty%></b>
        </div>

        <div class="stat">
            <p>Đã đặt</p>
            <b><%=busy%></b>
        </div>

        <div class="stat">
            <p>Bảo trì</p>
            <b><%=fix%></b>
        </div>

        <div class="stat">
            <p>Tổng đơn đặt phòng</p>
            <b><%=totalBookings%></b>
        </div>

        <div class="stat">
            <p>Đơn đã thanh toán</p>
            <b><%=paidBookings%></b>
        </div>

        <% if("ADMIN".equals(session.getAttribute("role"))) { %>
        <a class="stat revenue-stat stat-link" href="revenue.jsp">
            <p>Tổng doanh thu</p>
            <b><%=String.format("%,.0f", revenue)%> VNĐ</b>
            <small>Xem chi tiết doanh thu</small>
        </a>
        <% } %>

    </div>

    <%@ include file="adminFooter.jspf" %>

</body>

</html>