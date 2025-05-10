<%-- 
    Document   : update_song
    Created on : Oct 4, 2024, 5:36:34 PM
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
                String code="";
                if(request.getParameter("scode").trim().length()>0 && request.getParameter("scode")!=null && request.getParameter("code").trim().length()>0 && request.getParameter("code")!=null && request.getParameter("sname").trim().length()>0 && request.getParameter("sname")!=null && request.getParameter("aname").trim().length()>0 && request.getParameter("aname")!=null && request.getParameter("des").trim().length()>0 && request.getParameter("des")!=null ){
                    try{
                         String sn=request.getParameter("scode").trim();
                         code=request.getParameter("code").trim();
                         String sname=request.getParameter("sname").trim();
                         String des=request.getParameter("des").trim();
                         Class.forName("com.mysql.jdbc.Driver");
                         Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3","root","");
                         PreparedStatement ps=cn.prepareStatement("update song set name=?,des=? where sn=?");
                         ps.setString(1, sname);
                         ps.setString(2, des);
                         ps.setString(3, sn);
                         if(ps.executeUpdate()>0){
                             response.sendRedirect("song.jsp?success_update=1&id="+code+"");
                         }
                         else{
                             response.sendRedirect("song.jsp?again=1&id="+code+"");
                         }
                         
                    }
                    catch(Exception e){
                        out.print("<h1>"+ e.getMessage() +"</h1>");
                    }
                }
                else{
                   response.sendRedirect("song.jsp?id="+code+"");    
                }
            }
       else{
            response.sendRedirect("index.jsp?no_cookie=1");
        }
    }
%>
