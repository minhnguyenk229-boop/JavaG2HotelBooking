<%@ page import="com.g2hotel.dao.RoomDao,java.util.*"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!doctype html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Quản lý phòng</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">

</head>

<body>

    <%@ include file="adminHeader.jspf" %>

    <h1>Quản lý 100 phòng</h1>

    <%@ include file="adminMessages.jspf" %>

    <table>

        <tr>
            <th>Phòng</th>
            <th>Loại</th>
            <th>Giá</th>
            <th>Trạng thái nhanh</th>
            <th>Sửa chi tiết</th>
        </tr>

        <%
            String[] sts = {
                "Trống",
                "Đã đặt",
                "Bảo trì"
            };

            for(Map<String,Object> r : new RoomDao().all(null)) {

                String cur = String.valueOf(r.get("status"));
        %>

        <tr>

            <td>
                <%=r.get("room_number")%>
            </td>

            <td>
                <%=r.get("type")%>
            </td>

            <td>
                <%=String.format("%,.0f",
                    ((Number)r.get("price")).doubleValue())%>
            </td>

            <td>

                <form method="post"
                      action="${pageContext.request.contextPath}/admin/status-room">

                    <input type="hidden"
                           name="id"
                           value="<%=r.get("id")%>">

                    <select name="status">

                        <% for(String s : sts){ %>

                            <option <%=s.equals(cur) ? "selected" : ""%>>
                                <%=s%>
                            </option>

                        <% } %>

                    </select>

                    <button class="btn">
                        Lưu
                    </button>

                </form>

            </td>

            <td>

                <details>

                    <summary class="btn dark">
                        Mở form sửa
                    </summary>

                    <form method="post"
                          action="${pageContext.request.contextPath}/admin/update-room">

                        <input type="hidden"
                               name="id"
                               value="<%=r.get("id")%>">

                        <input name="type"
                               value="<%=r.get("type")%>">

                        <input name="price"
                               value="<%=r.get("price")%>">

                        <select name="status">

                            <% for(String s : sts){ %>

                                <option <%=s.equals(cur) ? "selected" : ""%>>
                                    <%=s%>
                                </option>

                            <% } %>

                        </select>

                        <input name="image"
                               value="<%=r.get("image")%>">

                        <textarea name="description"><%=r.get("description")%></textarea>

                        <button class="btn">
                            Cập nhật
                        </button>

                    </form>

                </details>

            </td>

        </tr>

        <% } %>

    </table>

    <%@ include file="adminFooter.jspf" %>

</body>

</html>