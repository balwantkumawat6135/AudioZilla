<%-- 
    Document   : index
    Created on : Oct 15, 2024, 3:48:19 PM
    Author     : BALWANT
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    Cookie c[] = request.getCookies();
    String email = "";
    for (int i = 0; i < c.length; i++) {
        if (c[i].getName().equals("login")) {
            email = c[i].getValue();
        }
    }
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
        Statement st = cn.createStatement();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AudioZila</title>
        <!-- BootStrap links -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <script src="jquery-3.7.1.js"></script>
        <script src="ad.js?v=0"></script>

        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="mp3.css?v=2">
        <link href="https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    </head>
    <body class="scrh">
        <%@include file="nav.jsp"%>
        <div class="container-fluid">
            <div id="demo" class="carousel slide" data-ride="carousel">

                <!-- The slideshow -->
                <div class="carousel-inner">
                    <div class="carousel-item  active">
                        <img src="Image/2.jpg" class="c_img" alt="Los Angeles" >
                    </div>
                    <div class="carousel-item">
                        <img src="Image/3.jpg" class="c_img" alt="Chicago" >
                    </div>
                    <div class="carousel-item">
                        <img src="Image/4.jpg" class="c_img" alt="New York" >
                    </div>
                    <div class="carousel-item">
                        <img src="Image/5.png" class="c_img" alt="New York" >
                    </div>
                    <div class="carousel-item">
                        <img src="Image/6.jpeg" class="c_img" alt="New York" >
                    </div>
                </div>

                <!-- Left and right controls -->
                <a class="carousel-control-prev" href="#demo" data-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                </a>
                <a class="carousel-control-next" href="#demo" data-slide="next">
                    <span class="carousel-control-next-icon"></span>
                </a>
            </div>

        </div>

        <div class="container-fluid my-4">
            <div class="row m-4">
                <%                    ResultSet cat = st.executeQuery("select * from category");
                    while (cat.next()) {
                        String catcode = cat.getString(2);
                %>
                <div class="col-lg-12 col-sm-12 col-md-12 col-12 mt-4" style="border-radius: 15px 15px 0 0;">
                    <h3 style="float:left;" class="heading"><%=cat.getString(3)%></h3>
                    <a href="more.jsp?id=<%=catcode%>"><button  class="btn  heading-btn" >More</button></a>
                </div>
                <div class="col-lg-12 col-sm-12 col-md-12 col-12">
                    <div class="row">
                        <%
                            PreparedStatement ps = cn.prepareStatement("select * from album where category=? order by RAND() limit 0,6");
                            ps.setString(1, catcode);
                            ResultSet rs1 = ps.executeQuery();
                            while (rs1.next()) {
                                String code = rs1.getString(2);
                                String Name = rs1.getString(3);
                                String Name1 = Name.replace(' ', '-');//to remove space from the album name

                        %>
                        <div class="col-lg-2 col-md-3 col-sm-4 col-6">
                            <div>
                                <div class="img-wrapper" border="1">
                                    <a href="view_album.jsp?code=<%=code%>&Album=<%=Name1%>"><img src="../album/<%=code%>/<%=code%>.jpg" alt="img" class="img-fluid  inner-img"></a>
                                </div>
                                <div>
                                    <a href="view_album.jsp?code=<%=code%>&Album=<%=Name1%>"><h6 style="text-align:center" class="txt clamp"><%=rs1.getString(3)%></h6></a>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>

                    </div>
                </div>
                <%
                    }
                %>
                <div class="col-lg-12 col-sm-12 col-md-12 col-12 mt-4" style="border-radius: 15px 15px 0 0;">
                    <h3 style="float:left;" class="heading">Artists</h3>
                    <a href="artists.jsp"><button  class="btn  heading-btn" >More</button></a>
                </div>
                <div class="col-lg-12 col-sm-12 col-md-12 col-12">
                    <div class="row">
                        <%
                            PreparedStatement ps = cn.prepareStatement("select * from artist order by RAND() limit 0,6");
                            ResultSet rs1 = ps.executeQuery();
                            while (rs1.next()) {
                                String code = rs1.getString(2);
                                String Name = rs1.getString(3);
                                String Name1 = Name.replace(' ', '-');//to remove space from the album name

                        %>
                        <div class="col-lg-2 col-md-3 col-sm-4 col-6">
                            <div>
                                <div class="img-wrapper" style="border-radius:50%;">
                                    <a href="view_artist.jsp?code=<%=code%>"><img src="../artist/<%=code%>/<%=code%>.jpg" alt="img" class="img-fluid rounded-circle img-thumbnail inner-img"></a>
                                </div>
                                <div>
                                    <a href="view_artist.jsp?code=<%=code%>"><h6 style="text-align:center" class="txt clamp"><%=rs1.getString(3)%></h6></a>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>


    </body>
    <%@include file="footer.jsp" %>
</html>
<%
    } catch (Exception e) {
        out.print("<h1>" + e.getMessage() + "</h1>");
    }
%>