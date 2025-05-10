<%-- 
    Document   : more
    Created on : Oct 18, 2024, 4:09:43 PM
    Author     : BALWANT
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
    if (request.getParameter("id").trim().length() > 0 && request.getParameter("id") != null) {
        String category = request.getParameter("id").trim();
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
                <%
                    ResultSet rs1 = st.executeQuery("select * from category where code='" + category + "' ");
                    if (rs1.next()) {
                %>
                <div class="col-lg-12 mt-4" style="border-radius: 15px 15px 0 0;">
                    <h1 class="align-items-center"><%=rs1.getString(3)%></h1>
                </div>
                <%
                    }
                %>
                <div class="col-lg-12">
                    <div class="row">
                        <%
                            PreparedStatement ps = cn.prepareStatement("select * from album where category=? order by sn");
                            ps.setString(1, category);
                            ResultSet rs2 = ps.executeQuery();
                            while (rs2.next()) {
                                String name1 = rs1.getString(3);
                                String name = name1.replace(' ', '-');//to remove space from the album name
                        %>
                        <div class="col-lg-2">
                            <div>
                                <div class="img-wrapper">
                                    <a href="view_album.jsp?code=<%=rs2.getString(2)%>&Album=<%=name%>"><img src="../album/<%=rs2.getString(2)%>/<%=rs2.getString(2)%>.jpg" alt="img" class="img-fluid img-thumbnail inner-img"></a>
                                </div>
                                <div>
                                    <a href="view_album.jsp?code=<%=rs2.getString(2)%>&Album=<%=name%>"><h6 style="text-align:center" class="txt clamp"><%=rs2.getString(3)%></h6></a>
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
    } else {
        response.sendRedirect("index.jsp");
    }
%>
