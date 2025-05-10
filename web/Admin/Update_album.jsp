<%-- 
    Document   : Update_album
    Created on : Sep 27, 2024, 1:51:58 PM
    Author     : BALWANT
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    Cookie c[]=request.getCookies();
    String email="";
    if(c==null){
        response.sendRedirect("index.jsp");
    }
    else{
        for(int i=0; i<c.length; i++){
            if(c[i].getName().equals("user")){
                email=c[i].getValue();
            } 
        }
        if(email!=null && session.getAttribute(email)!=null){
                if(request.getParameter("code").trim().length()>0 && request.getParameter("code")!=null && request.getParameter("ccode").trim().length()>0 && request.getParameter("ccode")!=null){
                    try{
                         String code=request.getParameter("code");
                         String ccode=request.getParameter("ccode");
                         String name=request.getParameter("album");
                         String des=request.getParameter("des");
                         Class.forName("com.mysql.jdbc.Driver");
                         Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3","root","");
                         Statement st=cn.createStatement();
                         if(st.executeUpdate("update album set album='"+ name +"', des='"+ des +"' where code='"+ code +"'")>0){
                             response.sendRedirect("album.jsp?success_update=1&code="+ ccode);
                         }
                         else{
                             response.sendRedirect("album.jsp?failed_update=1&code="+ ccode);
                         }
                    }
                    catch(Exception e){
                        out.print("<h1>"+ e.getMessage() +"</h1>");
                    }
                }
                else{
                
                }
            }
       else{
            response.sendRedirect("index.jsp?no_cookie=1");
        }
    }
%>