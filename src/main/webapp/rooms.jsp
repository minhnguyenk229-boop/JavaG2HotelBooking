<%@ page import="com.g2hotel.dao.RoomDao,java.util.*"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!doctype html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Danh sách phòng</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">

</head>

<body>

    <%@ include file="WEB-INF/header.jspf" %>

    <section class="section">

        <h1>100 phòng tại G2 Hotel</h1>

        <div class="grid">

            <%
                List<Map<String,Object>> rooms =
                    new RoomDao().all(null);

                for(Map<String,Object> r : rooms){

                    String st = (String) r.get("status");
            %>

            <div class="card">

                <img src="assets/images/<%=r.get("image")%>">

                <div class="card-body">

                    <h3>
                        Phòng <%=r.get("room_number")%>
                        -
                        <%=r.get("type")%>
                    </h3>

                    <p>
                        <%=r.get("description")%>
                    </p>

                    <p class="price">

                        <%=String.format(
                            "%,.0f",
                            ((Number)r.get("price")).doubleValue()
                        )%>

                        VNĐ/đêm

                    </p>

                    <span class="badge <%="Trống".equals(st) ? "" : "busy"%>">

                        <%=st%>

                    </span>

                    <br><br>

                    <% if("Trống".equals(st)){ %>

                        <a class="btn"
                           href="booking.jsp?roomId=<%=r.get("id")%>">

                            Đặt phòng

                        </a>

                    <% } else { %>

                        <button class="btn dark"
                                disabled>

                            Không khả dụng

                        </button>

                    <% } %>

                </div>

            </div>

            <% } %>

        </div>

    </section>

    <%@ include file="WEB-INF/footer.jspf" %>

</body>

</html>