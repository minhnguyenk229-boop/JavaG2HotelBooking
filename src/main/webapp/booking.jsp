<%@ page import="com.g2hotel.dao.RoomDao,java.util.*"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    if(session.getAttribute("userId") == null){
        String next = "/booking.jsp?roomId=" + request.getParameter("roomId");
        response.sendRedirect("login.jsp?err=" + java.net.URLEncoder.encode("Vui lòng đăng nhập để đặt phòng", "UTF-8") + "&next=" + java.net.URLEncoder.encode(next, "UTF-8"));
        return;
    }

    Map<String,Object> room = new RoomDao().find(Integer.parseInt(request.getParameter("roomId")));
    double price = ((Number)room.get("price")).doubleValue();
    String img = String.valueOf(room.get("image"));
%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết thanh toán</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">
</head>
<body>
    <%@ include file="WEB-INF/header.jspf" %>

    <section class="section checkout-section">
        <div class="checkout-steps">
            <span class="active">1 Đặt phòng</span>
            <span>›</span>
            <span class="active">2 Chi tiết thanh toán</span>
            <span>›</span>
            <span>3 Hoàn tất</span>
        </div>

        <form method="post" action="book" class="checkout-layout">
            <input type="hidden" name="roomId" value="<%=room.get("id")%>">

            <div class="checkout-card">
                <h2>Thông tin thanh toán</h2>

                <label>Họ tên *</label>
                <input type="text" name="customerName" value="<%=session.getAttribute("name") != null ? session.getAttribute("name") : ""%>" required>

                <label>Số điện thoại *</label>
                <input type="text" name="customerPhone" value="<%=session.getAttribute("phone") != null ? session.getAttribute("phone") : ""%>" pattern="0[0-9]{9,10}" maxlength="11" title="Số điện thoại phải bắt đầu bằng 0 và có 10-11 số" required>

                <label>Địa chỉ email *</label>
                <input type="email" name="customerEmail" value="<%=session.getAttribute("email") != null ? session.getAttribute("email") : ""%>" pattern="^[A-Za-z0-9._%+-]+@gmail\.com$" title="Email phải kết thúc bằng @gmail.com" required>

                <div class="two-cols">
                    <div>
                        <label>Ngày nhận phòng *</label>
                        <input type="date" name="checkIn" required>
                    </div>
                    <div>
                        <label>Ngày trả phòng *</label>
                        <input type="date" name="checkOut" required>
                    </div>
                </div>

                <label>Ghi chú booking (tùy chọn)</label>
                <textarea name="note" placeholder="Ví dụ: muốn phòng tầng cao, nhận phòng sớm, cần hỗ trợ thêm..."></textarea>
            </div>

            <aside class="booking-summary">
                <h2>Booking của bạn</h2>

                <div class="summary-room">
                    <div>
                        <h3>Phòng <%=room.get("room_number")%> - <%=room.get("type")%></h3>
                        <p>G2 Hotel</p>
                        <p>Giá mỗi đêm: <b><%=String.format("%,.0f", price)%> đ</b></p>
                    </div>
                    <img src="${pageContext.request.contextPath}/assets/images/<%=img%>" alt="Ảnh phòng">
                </div>

                <hr>

                <div class="price-row">
                    <span>Tạm tính / đêm</span>
                    <b><%=String.format("%,.0f", price)%> đ</b>
                </div>
                <div class="price-row total">
                    <span>Tổng dự kiến</span>
                    <b><%=String.format("%,.0f", price)%> đ x số đêm</b>
                </div>

                <div class="payment-options">
                    <label class="radio-line">
                        <input type="radio" name="paymentMethod" value="Chuyển khoản ngân hàng" checked>
                        Chuyển khoản ngân hàng bằng QR
                    </label>
                    <label class="radio-line">
                        <input type="radio" name="paymentMethod" value="Thanh toán tại khách sạn">
                        Thanh toán tại quầy khi nhận phòng
                    </label>
                </div>

                <button class="btn full-btn">Đặt booking</button>
            </aside>
        </form>
    </section>

    <%@ include file="WEB-INF/footer.jspf" %>
</body>
</html>
