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
    String img = String.valueOf(b.get("image"));
%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh toán QR</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">
</head>
<body>
    <%@ include file="WEB-INF/header.jspf" %>

    <section class="section checkout-section">
        <div class="checkout-steps">
            <span>1 Đặt phòng</span>
            <span>›</span>
            <span class="active">2 Chi tiết thanh toán</span>
            <span>›</span>
            <span>3 Hoàn tất</span>
        </div>

        <div class="payment-layout">
            <div class="checkout-card payment-main">
                <h2>Thanh toán đặt phòng bằng QR ngân hàng</h2>
                <p class="success-text">Booking của bạn đã được ghi nhận. Vui lòng chuyển khoản theo thông tin bên dưới.</p>

                <div class="qr-box">
                    <img class="qr-img" src="${pageContext.request.contextPath}/assets/images/qr_g2hotel.png" alt="QR thanh toán G2 Hotel">
                </div>

                <div class="payment-info-box">
                    <p><b>Mã booking:</b> #<%=b.get("id")%></p>
                    <p><b>Số tiền:</b> <%=String.format("%,.0f", total)%> đ</p>
                    <p><b>Nội dung chuyển khoản:</b> G2HOTEL <%=b.get("id")%></p>
                    <p><b>Trạng thái:</b> <%=b.get("payment_status")%></p>
                </div>

                <p class="note-text">Sau khi chuyển khoản, Admin/Nhân viên sẽ kiểm tra và xác nhận trạng thái thanh toán trong hệ thống.</p>

                <a class="btn" href="booking-complete.jsp?bookingId=<%=b.get("id")%>">Xem chi tiết booking</a>
            </div>

            <aside class="booking-summary">
                <h2>Booking của bạn</h2>
                <div class="summary-room">
                    <div>
                        <h3>Phòng <%=b.get("room_number")%> - <%=b.get("type")%></h3>
                        <p>Ngày đến: <%=b.get("check_in")%></p>
                        <p>Ngày đi: <%=b.get("check_out")%></p>
                        <p>Số đêm: <%=nights%></p>
                    </div>
                    <img src="${pageContext.request.contextPath}/assets/images/<%=img%>" alt="Ảnh phòng">
                </div>
                <hr>
                <div class="price-row"><span>Tạm tính</span><b><%=String.format("%,.0f", total)%> đ</b></div>
                <div class="price-row total"><span>Tổng cộng</span><b><%=String.format("%,.0f", total)%> đ</b></div>
                <p><b>Phương thức:</b> <%=b.get("payment_method")%></p>
            </aside>
        </div>
    </section>

    <%@ include file="WEB-INF/footer.jspf" %>
</body>
</html>
