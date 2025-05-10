<%-- 
    Document   : assign_artist
    Created on : Apr 25, 2025, 12:36:27 PM
    Author     : balwant-kumawat
--%>
<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<%
    String artist = request.getParameter("artist");
    int sn =Integer.parseInt(request.getParameter("sn"));
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
        Statement st = cn.createStatement();
        ResultSet rs=st.executeQuery("select aname from songs where sn="+sn);
        String acode="";
        int flag=0;
        if (rs.next()) {
            acode = rs.getString(1);
            if (!acode.trim().isEmpty()) { // check if acode is not empty after trimming
                flag = 1;
            }
        }

        if (flag == 1) {
            artist = acode + "," + artist; // append comma and new artist
        }
        PreparedStatement p = cn.prepareStatement("update songs set aname=? where sn=?");
        p.setString(1, artist);
        p.setInt(2, sn);
        if (p.executeUpdate() > 0){
            out.print("success");
        }
        
    } catch (Exception e) {
        out.print(e.getMessage());
    }
%>