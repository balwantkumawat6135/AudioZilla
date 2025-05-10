<%-- 
    Document   : ad_song_playlist
    Created on : Apr 23, 2025, 10:14:02 AM
    Author     : balwant-kumawat
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<%
    String email=request.getParameter("email");
    int sn=Integer.parseInt(request.getParameter("sn"));
    String acode=request.getParameter("acode");
    String pcode=request.getParameter("pcode");
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
        PreparedStatement p0=cn.prepareStatement("select * from playlist_song where sn=? AND pcode=? AND email=?");
        p0.setInt(1,sn);
        p0.setString(2,pcode);
        p0.setString(3,email);
        ResultSet r=p0.executeQuery();
        if(r.next()){
            out.print("exist");
        }
        else{
            PreparedStatement p=cn.prepareStatement("insert into playlist_song values(?,?,?,?)");
            p.setInt(1,sn);
            p.setString(2,acode);
            p.setString(3,pcode);
            p.setString(4,email);
            if(p.executeUpdate()>0){
                out.print("success");
            }
            
        }
        
    }
    catch(Exception e){
        out.print(e.getMessage());
    }
%>