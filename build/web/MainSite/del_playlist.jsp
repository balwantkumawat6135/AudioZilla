<%-- 
    Document   : del_playlist
    Created on : Apr 28, 2025, 4:17:02 PM
    Author     : balwant-kumawat
--%>
<%@page contentType="text/html" import="java.sql.*,java.io.*" pageEncoding="UTF-8"%>
<%
         if (request.getParameter("code").trim().length() > 0 && request.getParameter("code") != null) {
                try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
                        String code=request.getParameter("code");
                        PreparedStatement ps = cn.prepareStatement("DELETE FROM playlist_song WHERE pcode=?");
                        ps.setString(1, code);
                        int x=0;
                        ps.executeUpdate();
                        PreparedStatement p = cn.prepareStatement("DELETE FROM playlist WHERE code=?");
                        p.setString(1,code);
                        if(p.executeUpdate() >0){
                            out.print("success");
                        }
                     }
                catch(Exception e){
                    out.print(e.getMessage());
                }
            } else {
                response.sendRedirect("artist.jsp?del_empty=1");
            }
%>