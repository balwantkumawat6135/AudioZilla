<%-- 
    Document   : logout
    Created on : 28-May-2025, 2:05:09 PM
    Author     : balwant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
        Cookie c=new Cookie("user",null); 
        c.setMaxAge(0);
        response.addCookie(c);
        response.sendRedirect("index.jsp");
%>