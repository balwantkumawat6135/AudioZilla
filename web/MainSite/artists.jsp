<%-- 
    Document   : artists
    Created on : 15-Jun-2025, 3:22:14 PM
    Author     : balwant
--%>
<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    Cookie c[]=request.getCookies();
    String email="";
        for(int i=0; i<c.length; i++){
            if(c[i].getName().equals("login")){
                email=c[i].getValue();
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
        <script src="jquery-3.7.1.js"></script>
        <script src="ad.js"></script>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="mp3.css">
    </head>
    <body class="scrh">
        <%@include file="nav.jsp" %>
            <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 mt-4" style="border-radius: 15px 15px 0 0;">
                    <h1 class="align-items-center">Artists</h1>
                </div>
                <div class="col-lg-12">
                    <div class="row">
                        <%
                            PreparedStatement ps = cn.prepareStatement("select * from artist order by sn");
                            ResultSet rs2 = ps.executeQuery();
                            while (rs2.next()) {
                        %>
                        <div class="col-lg-2">
                            <div>
                                <div class="img-wrapper" style="border-radius:50%;">
                                    <a href="view_artist.jsp?code=<%=rs2.getString(2)%>"><img src="../artist/<%=rs2.getString(2)%>/<%=rs2.getString(2)%>.jpg" alt="img" class="img-fluid img-thumbnail rounded-circle inner-img"></a>
                                </div>
                                <div>
                                    <a href="view_artist.jsp?code=<%=rs2.getString(2)%>"><h6 style="text-align:center" class="txt clamp"><%=rs2.getString(3)%></h6></a>
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
</html>
<%
        } catch (Exception e) {
            out.print("<h1>" + e.getMessage() + "</h1>");
        }
%>
