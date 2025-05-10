<%-- 
    Document   : add_artist
    Created on : Apr 23, 2025, 12:20:20 PM
    Author     : balwant-kumawat
--%>
<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<%
    String artist = request.getParameter("artist");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery("select MAX(sn) from artist");
        int sn = 0;
        if (rs.next()) {
            sn = rs.getInt(1);
        }
        sn++;
        LinkedList ls = new LinkedList();
        for (int i = 1; i <= 9; i++) {
            ls.add(i);
        }
        for (int i = 'a'; i <= 'z'; i++) {
            ls.add(i);
        }
        for (char i = 'A'; i <= 'Z'; i++) {
            ls.add(i);
        }

        Collections.shuffle(ls);
        String code = "";
        for (int i = 0; i <= 6; i++) {
            code += ls.get(i);
        }
        code = code + "_" + sn;

        PreparedStatement p = cn.prepareStatement("insert into artist values(?,?,?)");
        p.setInt(1, sn);
        p.setString(2, code);
        p.setString(3, artist);
        if (p.executeUpdate() > 0) {
            response.sendRedirect("artist_img_upload.jsp?code="+code+"&success=1");
        }
        else{
            response.sendRedirect("artist.jsp?again=1");
        }
    } catch (Exception e) {
        out.print(e.getMessage());
    }
%>