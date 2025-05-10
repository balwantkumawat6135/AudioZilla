<%-- 
    Document   : add_song
    Created on : Oct 4, 2024, 11:27:51 AM
    Author     : BALWANT
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<%
    Cookie c[]=request.getCookies();
    String email="";
    String albcode="";
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
            if(request.getParameter("code").trim().length()>0 && request.getParameter("code")!=null && request.getParameter("sname").trim().length()>0 && request.getParameter("sname")!=null  && request.getParameter("des").trim().length() > 0 && request.getParameter("des") != null){
                try{
                    albcode=request.getParameter("code").trim();
                    String sname=request.getParameter("sname").trim();
                    String des=request.getParameter("des").trim();
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3","root","");
                    Statement st=cn.createStatement();
                    ResultSet rs=st.executeQuery("select MAX(sn) from songs");
                        int sn=0; 
                        if(rs.next()){
                            sn = rs.getInt(1);
                        }
                        sn++;
                    if(st.executeUpdate("insert into songs values("+sn+",'"+ sname +"',NULL,'"+ des +"','"+ albcode +"')")>0){
                        response.sendRedirect("song_upload.jsp?success=1&code="+albcode+"&sn="+ sn +"");
                    }
                    else{
                        response.sendRedirect("song.jsp?again=1");
                    }
                }
                catch(Exception e){
                    out.print("<h1>"+e.getMessage()+"</h1>");
                }
            }
            else{
                response.sendRedirect("song.jsp");
            }
        }
        else{
            response.sendRedirect("index.jsp?no_cookie=1");
        }
    }
%>