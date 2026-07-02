<%@ page import="com.g2hotel.dao.BookingDao,java.util.*,java.time.*,java.time.temporal.ChronoUnit"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    if(session.getAttribute("userId") == null){
        response.sendRedirect("login.jsp");
        return;
    }

    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
    Map<String,Object> b = new BookingDao().find(bookingId, (Integer)session.getAttribute("userId"));
    LocalDate checkIn = LocalDate.parse(String.valueOf(b.get("check_in")));
    LocalDate checkOut = LocalDate.parse(String.valueOf(b.get("check_out")));
    long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
    double total = b.get("total_amount") != null ? ((Number)b.get("total_amount")).doubleValue() : ((Number)b.get("price")).doubleValue() * nights;
%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking hoàn tất</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">
</head>
<body>
    <%@ include file="WEB-INF/header.jspf" %>

    <section class="section checkout-section">
        <div class="checkout-steps">
            <span>1 Đặt phòng</span>
            <span>›</span>
            <span>2 Chi tiết thanh toán</span>
            <span>›</span>
            <span class="active">3 Booking hoàn tất</span>
        </div>

        <div class="complete-layout">
            <div class="checkout-card detail-card">
                <h2>Chi tiết booking</h2>

                <div class="detail-row header-row">
                    <b>Sản phẩm</b>
                    <b>Tổng</b>
                </div>
                <div class="detail-row">
                    <span>Phòng <%=b.get("room_number")%> - <%=b.get("type")%> x <%=nights%> đêm</span>
                    <b><%=String.format("%,.0f", total)%> đ</b>
                </div>
                <div class="detail-row"><span>Ngày đến</span><b><%=b.get("check_in")%></b></div>
                <div class="detail-row"><span>Ngày đi</span><b><%=b.get("check_out")%></b></div>
                <div class="detail-row"><span>Trạng thái đơn</span><b><%=b.get("status")%></b></div>
                <div class="detail-row"><span>Thanh toán</span><b><%=b.get("payment_status")%></b></div>
                <div class="detail-row"><span>Phương thức thanh toán</span><b><%=b.get("payment_method")%></b></div>
                <div class="detail-row total"><span>Tổng cộng</span><b><%=String.format("%,.0f", total)%> đ</b></div>

                <h2>Thông tin khách hàng</h2>
                <p><b>Họ tên:</b> <%=b.get("customer_name") != null ? b.get("customer_name") : b.get("full_name")%></p>
                <p><b>Số điện thoại:</b> <%=b.get("customer_phone") != null ? b.get("customer_phone") : b.get("phone")%></p>
                <p><b>Email:</b> <%=b.get("customer_email") != null ? b.get("customer_email") : b.get("email")%></p>
                <p><b>Ghi chú:</b> <%=b.get("note") != null ? b.get("note") : "Không có"%></p>
            </div>

            <aside class="complete-message">
                <h2>Cảm ơn bạn. Booking của bạn đã được nhận.</h2>
                <ul>
                    <li><b>Mã booking:</b> #<%=b.get("id")%></li>
                    <li><b>Ngày tạo:</b> <%=b.get("created_at")%></li>
                    <li><b>Tổng cộng:</b> <%=String.format("%,.0f", total)%> đ</li>
                    <li><b>Phương thức thanh toán:</b> <%=b.get("payment_method")%></li>
                </ul>
                <a class="btn" href="my-bookings.jsp">Xem đơn của tôi</a>
            </aside>
        </div>
    </section>

    <%@ include file="WEB-INF/footer.jspf" %>
</body>
</html>
