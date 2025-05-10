<%-- 
    Document   : add_fav
    Created on : Oct 22, 2024, 4:34:29 PM
    Author     : BALWANT
--%>
<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    
    if(request.getParameter("name").trim().length()>0 && request.getParameter("name")!=null && request.getParameter("code")!=null && request.getParameter("code").trim().length()>0){
        String code=request.getParameter("code").trim();
        int sn=Integer.parseInt(request.getParameter("name").trim());
        String email=request.getParameter("email").trim();
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
            Statement st=cn.createStatement();
            PreparedStatement ps=cn.prepareStatement("insert into liked_song values(?,?,?)");
            ps.setInt(1,sn);
            ps.setString(2,code);
            ps.setString(3,email);
            if(ps.executeUpdate()>0){
                out.print("success");
            }
            else{
                out.print("failed");
            }
        }
        catch(Exception e){
            out.println(e.getMessage());
        }
    }
%>