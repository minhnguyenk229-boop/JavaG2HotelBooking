<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!doctype html>

<html>

<head>

    <meta charset="UTF-8">

    <title>G2 Hotel</title>

    <link rel="icon" type="image/png"
          href="${pageContext.request.contextPath}/assets/images/g2-logo.png">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">

</head>

<body>

    <%@ include file="WEB-INF/header.jspf" %>

    <section class="hero">

        <div>

            <h1>Chào mừng đến G2 Hotel</h1>

            <p>
                Không gian nghỉ dưỡng hiện đại,
                100 phòng tiện nghi,
                đặt phòng nhanh chóng và thanh toán bằng QR ngân hàng.
            </p>

            <a class="btn"
               href="rooms.jsp">
                Đặt phòng ngay
            </a>

        </div>

    </section>

    <section class="section">

        <h2>Dịch vụ nổi bật</h2>

        <div class="grid">

            <div class="card">

                <img src="assets/images/hotel_feture_1.jpg">

                <div class="card-body">

                    <h3>Phòng sang trọng</h3>

                    <p>
                        Nội thất hiện đại,
                        đầy đủ tiện nghi,
                        vệ sinh sạch sẽ mỗi ngày.
                    </p>

                </div>

            </div>

            <div class="card">

                <img src="assets/images/hotel_feture_2.jpg">

                <div class="card-body">

                    <h3>Thanh toán QR</h3>

                    <p>
                        Khách hàng đặt phòng và chuyển khoản
                        bằng mã QR nhanh gọn.
                    </p>

                </div>

            </div>

            <div class="card">

                <img src="assets/images/hotel_feture_3.jpg">

                <div class="card-body">

                    <h3>Quản lý chuyên nghiệp</h3>

                    <p>
                        Admin và nhân viên cập nhật trạng thái phòng
                        theo thời gian thực.
                    </p>

                </div>

            </div>

        </div>

    </section>

    <%@ include file="WEB-INF/footer.jspf" %>

</body>

</html>