<%@ page import="com.g2hotel.dao.BookingDao,java.util.*,java.text.DecimalFormat"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    Object roleCheck = session.getAttribute("role");
    if(!"ADMIN".equals(roleCheck)) {
        response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
        return;
    }

    request.setCharacterEncoding("UTF-8");
    String from = request.getParameter("from");
    String to = request.getParameter("to");

    BookingDao dao = new BookingDao();
    List<Map<String,Object>> details = dao.revenueDetails(from, to);
    double totalRevenue = dao.totalRevenueBetween(from, to);
    int totalPaid = dao.paidBookingCountBetween(from, to);
    DecimalFormat money = new DecimalFormat("#,###");
%>

<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý doanh thu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">
</head>
<body>
    <%@ include file="adminHeader.jspf" %>

    <h1>Quản lý doanh thu</h1>
    <%@ include file="adminMessages.jspf" %>

    <form class="filter-box" method="get" action="revenue.jsp">
        <div>
            <label>Từ ngày</label>
            <input type="date" name="from" value="<%=from == null ? "" : from%>">
        </div>
        <div>
            <label>Đến ngày</label>
            <input type="date" name="to" value="<%=to == null ? "" : to%>">
        </div>
        <div class="filter-actions">
            <button class="btn" type="submit">Lọc doanh thu</button>
            <a class="btn dark" href="revenue.jsp">Xóa lọc</a>
        </div>
    </form>

    <div class="stats revenue-summary">
        <div class="stat">
            <p>Tổng đơn đã thanh toán</p>
            <b><%=totalPaid%></b>
        </div>
        <div class="stat revenue-stat">
            <p>Tổng doanh thu</p>
            <b><%=money.format(totalRevenue)%> VNĐ</b>
        </div>
    </div>

    <h2>Chi tiết đơn đã thanh toán</h2>

    <table>
        <tr>
            <th>Mã đơn</th>
            <th>Khách hàng</th>
            <th>Phòng</th>
            <th>Ngày ở</th>
            <th>Thanh toán</th>
            <th>Ngày tạo</th>
            <th>Doanh thu</th>
        </tr>

        <% if(details.isEmpty()) { %>
        <tr>
            <td colspan="7">Chưa có đơn đã thanh toán trong khoảng thời gian này.</td>
        </tr>
        <% } %>

        <% for(Map<String,Object> b : details) { %>
        <tr>
            <td>#<%=b.get("id")%></td>
            <td>
                <b><%=b.get("customer_name")%></b><br>
                <%=b.get("customer_phone")%><br>
                <span class="muted"><%=b.get("customer_email")%></span>
            </td>
            <td>
                <%=b.get("room_number")%> - <%=b.get("type")%><br>
                <span class="muted"><%=money.format(((Number)b.get("price")).doubleValue())%> VNĐ/đêm</span>
            </td>
            <td>
                <%=b.get("check_in")%> → <%=b.get("check_out")%>
            </td>
            <td>
                <span class="badge"><%=b.get("payment_status")%></span><br><br>
                <%=b.get("payment_method")%>
            </td>
            <td><%=b.get("created_at")%></td>
            <td><b><%=money.format(((Number)b.get("total_amount")).doubleValue())%> VNĐ</b></td>
        </tr>
        <% } %>
    </table>

    <%@ include file="adminFooter.jspf" %>
</body>
</html>
