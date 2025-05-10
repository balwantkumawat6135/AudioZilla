<%-- 
    Document   : delete_artist
    Created on : Apr 24, 2025, 12:25:20 PM
    Author     : balwant-kumawat
--%>

<%@page contentType="text/html" import="java.sql.*,java.io.*" pageEncoding="UTF-8"%>
<%
    Cookie c[] = request.getCookies();
    String email = null;
    if (c == null) {
        response.sendRedirect("index.jsp");
    } else {
        for (int i = 0; i < c.length; i++) {
            if (c[i].getName().equals("user")) {
                email = c[i].getValue();
                break;
            }
        }
        if (email != null && session.getAttribute(email) != null) {
            if (request.getParameter("code").trim().length() > 0 && request.getParameter("code") != null) {
                try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
                        String code=request.getParameter("code");
                        PreparedStatement ps = cn.prepareStatement("DELETE FROM artist WHERE code=?");
                        ps.setString(1, code);
                        if (ps.executeUpdate() > 0) {
                            response.sendRedirect("artist.jsp?del_success=1");
                        } else {
                            response.sendRedirect("artist.jsp?del_again=1");
                        }
                     }
                catch(Exception e){
                    out.print("<h1>"+"</h1>");
                }
            } else {
                response.sendRedirect("artist.jsp?del_empty=1");
            }
        } else {
            response.sendRedirect("index.jsp?no_cookie=1");
        }
    }
%>
