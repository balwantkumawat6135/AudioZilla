<%-- 
    Document   : update_artist
    Created on : Apr 24, 2025, 12:24:20 PM
    Author     : balwant-kumawat
--%>
<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    Cookie c[]=request.getCookies();
        String email=null;
        if(c==null){
            response.sendRedirect("index.jsp");
        }
        else{
            for(int i=0; i<c.length; i++){
                if(c[i].getName().equals("user")){
                    email=c[i].getValue();
                    break;
                }
            }
            if(email!=null && session.getAttribute(email)!=null){
                if(request.getParameter("code").trim().length()>0 && request.getParameter("code")!=null && request.getParameter("artist").trim().length()>0 && request.getParameter("artist")!=null){
                    try{
                        String code=request.getParameter("code").trim();
                        String artist=request.getParameter("artist").trim();
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
                        Statement st=cn.createStatement();
                        if(st.executeUpdate("update artist set artist='"+artist+"' where code='"+code+"'")>0){
                          response.sendRedirect("artist.jsp?update_success=1");  
                        }
                        else{
                            response.sendRedirect("artist.jsp?update_again=1");  
                        }
                    }
                    catch(Exception e){
                     out.print("<h1>"+ e.getMessage() +"</h1>");   
                    }
                }
                else{
                    response.sendRedirect("edit_artist.jsp?empty=1");
                }
            }
            else{
                response.sendRedirect("index.jsp?no_cookie=1");
            }
        }
                %>

