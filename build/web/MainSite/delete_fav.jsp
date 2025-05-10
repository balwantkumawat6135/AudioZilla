<%-- 
    Document   : delete_fav
    Created on : Oct 23, 2024, 4:43:27 PM
    Author     : BALWANT
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    if(request.getParameter("sn").trim().length()>0 && request.getParameter("sn")!=null){
        int sn=Integer.parseInt(request.getParameter("sn"));
        String email=request.getParameter("email");
         try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
            Statement st=cn.createStatement();
            PreparedStatement p=cn.prepareStatement("delete from liked_song where sn=? AND email=?");
            p.setInt(1,sn);
            p.setString(2,email);
            if(p.executeUpdate()>0){
                out.print("success");
            }
            else{
                out.print("failed");
            }
         }
         catch(Exception e){
             out.print(e.getMessage());
         }
    }
%>