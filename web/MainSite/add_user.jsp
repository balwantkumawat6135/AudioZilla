<%-- 
    Document   : add_user
    Created on : Apr 21, 2025, 10:16:41 AM
    Author     : balwant-kumawat
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*,java.io.*" pageEncoding="UTF-8"%>
<%
            try {
                String u_email = request.getParameter("email");
                String password = request.getParameter("pass");
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
                Statement st = cn.createStatement();
                PreparedStatement p = cn.prepareStatement("insert into users values(?,?)");
                p.setString(1, u_email);
                p.setString(2, password);
                if (p.executeUpdate() > 0) {
                    out.print("success");
                }
            } catch (Exception e) {
                out.print("<h1>" + e.getMessage() + "</h1>");
            }
        

%>
