<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!doctype html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Giới thiệu - G2 Hotel</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/g2.css?v=blue-final-20260628">

</head>

<body>

    <%@ include file="WEB-INF/header.jspf" %>

    <section class="section">

        <h1>Giới thiệu về chúng tôi</h1>

        <div class="grid">

            <div>

                <p>
                    G2 Hotel là khách sạn được thiết kế theo phong cách hiện đại,
                    tập trung vào trải nghiệm đặt phòng nhanh, minh bạch và dễ sử dụng.
                </p>

                <p>
                    Website hỗ trợ khách hàng đăng ký tài khoản, đăng nhập,
                    xem danh sách 100 phòng, đặt phòng và thanh toán QR ngân hàng.
                </p>

                <p>
                    Đội ngũ quản trị gồm admin chính và nhân viên có thể quản lý phòng,
                    trạng thái phòng và đơn đặt phòng.
                </p>

            </div>

            <div class="card">

                <img src="assets/images/slider2.jpg">

                <div class="card-body">

                    <b>
                        G2 Hotel - Sang trọng, tiện nghi, thân thiện.
                    </b>

                </div>

            </div>

        </div>

    </section>

    <%@ include file="WEB-INF/footer.jspf" %>

</body>

</html>