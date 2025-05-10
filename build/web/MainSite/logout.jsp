<%-- 
    Document   : logout
    Created on : Apr 21, 2025, 1:21:41 PM
    Author     : balwant-kumawat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
        Cookie c=new Cookie("login",null); 
        c.setMaxAge(0);
        response.addCookie(c);
        response.sendRedirect("index.jsp");
        
%>