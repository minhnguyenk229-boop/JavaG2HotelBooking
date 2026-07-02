<%@ page import="com.g2hotel.dao.BookingDao,java.util.*"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    if(session.getAttribute("userId") == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!doctype html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Đơn của tôi</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">

</head>

<body>

    <%@ include file="WEB-INF/header.jspf" %>

    <section class="section">

        <h1>Đơn đặt phòng của tôi</h1>

        <% if(request.getParameter("msg") != null){ %>

            <div class="alert">
                <%=request.getParameter("msg")%>
            </div>

        <% } %>

        <table>

            <tr>
                <th>Mã đơn</th>
                <th>Phòng</th>
                <th>Ngày nhận</th>
                <th>Ngày trả</th>
                <th>Trạng thái</th>
                <th>Thanh toán</th>
                <th>Thao tác</th>
            </tr>

            <%
                for(Map<String,Object> b :
                    new BookingDao().all(
                        (Integer)session.getAttribute("userId")
                    )) {

                    String st = String.valueOf(b.get("status"));
            %>

            <tr>

                <td>
                    #<%=b.get("id")%>
                </td>

                <td>
                    <%=b.get("room_number")%>
                    -
                    <%=b.get("type")%>
                </td>

                <td>
                    <%=b.get("check_in")%>
                </td>

                <td>
                    <%=b.get("check_out")%>
                </td>

                <td>
                    <%=st%>
                </td>

                <td>
                    <%=b.get("payment_status")%>
                </td>

                <td>

                    <a class="btn dark" href="booking-complete.jsp?bookingId=<%=b.get("id")%>">Chi tiết</a>

                    <% if("Chuyển khoản ngân hàng".equals(String.valueOf(b.get("payment_method"))) &&
                          !"Đã thanh toán".equals(String.valueOf(b.get("payment_status")))) { %>
                        <a class="btn" href="payment.jsp?bookingId=<%=b.get("id")%>">Thanh toán</a>
                    <% } %>

                    <%
                        if("Chờ xác nhận".equals(st) ||
                           "Đã xác nhận".equals(st)) {
                    %>

                        <form method="post"
                              action="cancel-booking"
                              onsubmit="return confirm('Bạn chắc chắn muốn hủy đơn này?')">

                            <input type="hidden"
                                   name="bookingId"
                                   value="<%=b.get("id")%>">

                            <input type="hidden"
                                   name="roomId"
                                   value="<%=b.get("room_id")%>">

                            <button class="btn dark">
                                Hủy đơn
                            </button>

                        </form>

                    <% } %>

                </td>

            </tr>

            <% } %>

        </table>

    </section>

    <%@ include file="WEB-INF/footer.jspf" %>

</body>

</html>