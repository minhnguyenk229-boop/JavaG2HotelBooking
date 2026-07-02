<%@ page import="com.g2hotel.dao.BookingDao,java.util.*"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!doctype html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Quản lý đặt phòng</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">

</head>

<body>

    <%@ include file="adminHeader.jspf" %>

    <h1>Quản lý đơn đặt phòng</h1>

    <%@ include file="adminMessages.jspf" %>

    <table>

        <tr>
            <th>Mã</th>
            <th>Khách</th>
            <th>Phòng</th>
            <th>Ngày</th>
            <th>Trạng thái hiện tại</th>
            <th>Cập nhật</th>
        </tr>

        <%
            String[] statuses = {
                "Chờ xác nhận",
                "Đã xác nhận",
                "Đã nhận phòng",
                "Đã trả phòng",
                "Đã hủy"
            };

            String[] pays = {
                "Chờ thanh toán",
                "Đã thanh toán",
                "Hoàn tiền"
            };

            for(Map<String,Object> b : new BookingDao().all(null)) {

                String st = String.valueOf(b.get("status"));
                String pay = String.valueOf(b.get("payment_status"));
        %>

        <tr>

            <td>
                #<%=b.get("id")%>
            </td>

            <td>
                <%=b.get("full_name")%>
                <br>
                <%=b.get("phone")%>
            </td>

            <td>
                <%=b.get("room_number")%>
                -
                <%=b.get("type")%>
            </td>

            <td>
                <%=b.get("check_in")%>
                →
                <%=b.get("check_out")%>
            </td>

            <td>
                <span class="badge">
                    <%=st%>
                </span>

                <br><br>

                <%=pay%>
            </td>

            <td>

                <form method="post"
                      action="${pageContext.request.contextPath}/admin/update-booking">

                    <input type="hidden"
                           name="bookingId"
                           value="<%=b.get("id")%>">

                    <input type="hidden"
                           name="roomId"
                           value="<%=b.get("room_id")%>">

                    <select name="status">

                        <% for(String s : statuses){ %>

                            <option <%=s.equals(st) ? "selected" : ""%>>
                                <%=s%>
                            </option>

                        <% } %>

                    </select>

                    <select name="payment">

                        <% for(String p : pays){ %>

                            <option <%=p.equals(pay) ? "selected" : ""%>>
                                <%=p%>
                            </option>

                        <% } %>

                    </select>

                    <button class="btn">
                        Lưu
                    </button>

                </form>

            </td>

        </tr>

        <% } %>

    </table>

    <%@ include file="adminFooter.jspf" %>

</body>

</html>