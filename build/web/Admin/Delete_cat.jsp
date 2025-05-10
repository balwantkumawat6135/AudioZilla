<%-- 
    Document   : Delete_cat
    Created on : Sep 19, 2024, 6:40:57 PM
    Author     : BALWANT
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
                    String code=request.getParameter("code");
                    String path=request.getRealPath("/");
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
                    Statement st=cn.createStatement();
                     PreparedStatement ps3 = cn.prepareStatement("SELECT code FROM album WHERE category=?");
                     ps3.setString(1, code);
                     ResultSet rs3 = ps3.executeQuery();
                     int count=0;
                     while(rs3.next()){
                        count=1;
                        String albcode=rs3.getString(1);
                         // Delete songs associated with the album
                            PreparedStatement ps = cn.prepareStatement("SELECT sn FROM song WHERE album=?");
                            ps.setString(1, albcode);
                            ResultSet rs = ps.executeQuery();

                            while (rs.next()) {
                                int songId = rs.getInt("sn");
                                File fr1 = new File(path + "/album/" + albcode + "/" + songId + ".mp3");
                                if (fr1.delete());
                            }
                     
                        //song dlt from database
                            PreparedStatement psDeleteSongs = cn.prepareStatement("DELETE FROM song WHERE album=?");
                            psDeleteSongs.setString(1, albcode);
                            psDeleteSongs.executeUpdate();

                            // Delete album cover and the album folder
                            File fr = new File(path + "/album/" + albcode + "/" + albcode + ".jpg");
                            if (fr.delete()) {
                                File alb = new File(path + "/album/" + albcode);
                                alb.delete();
                            }
                         // Delete albums associated with the category
                        PreparedStatement psDeleteAlbums = cn.prepareStatement("DELETE FROM album WHERE category=?");
                        psDeleteAlbums.setString(1, code);
                        psDeleteAlbums.executeUpdate();

                        // Finally, delete the category
                        PreparedStatement psDeleteCategory = cn.prepareStatement("DELETE FROM category WHERE code=?");
                        psDeleteCategory.setString(1, code);
                        if (psDeleteCategory.executeUpdate() > 0) {
                            response.sendRedirect("dashboard.jsp?alldel_success=1");
                        } else {
                            response.sendRedirect("dashboard.jsp?del_again=1");
                        }
                     }
                     if(count==0){
                          PreparedStatement psDeleteCategory = cn.prepareStatement("DELETE FROM category WHERE code=?");
                        psDeleteCategory.setString(1, code);
                        if (psDeleteCategory.executeUpdate() > 0) {
                            response.sendRedirect("dashboard.jsp?alldel_success=1");
                        } else {
                            response.sendRedirect("dashboard.jsp?del_again=1");
                        }
                     }
                }
                catch(Exception e){
                    out.print("<h1>"+"</h1>");
                }
            } else {
                response.sendRedirect("dashboard.jsp?del_empty=1");
            }
        } else {
            response.sendRedirect("index.jsp?no_cookie=1");
        }
    }
%>
