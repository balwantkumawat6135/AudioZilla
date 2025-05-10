<%-- 
    Document   : delete_song
    Created on : Oct 5, 2024, 3:18:32 PM
    Author     : BALWANT
--%>
<%@page contentType="text/html" import="java.sql.*,java.io.*" pageEncoding="UTF-8"%>
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
                if(request.getParameter("code").trim().length()>0 && request.getParameter("code")!=null && request.getParameter("scode").trim().length()>0 && request.getParameter("scode")!=null){
                try{
                    String code=request.getParameter("code").trim();
                    String sn=request.getParameter("scode").trim();
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
                    PreparedStatement ps= cn.prepareStatement("delete from songs where sn=?");
                    ps.setString(1,sn);
                    if(ps.executeUpdate()>0){
                        String path=request.getRealPath("/");
                        File fr=new File(path+"/album/"+code+"/"+sn+".mp3");
                        if(fr.delete()){
                            response.sendRedirect("song.jsp?del_success=1&id="+ code);
                        }
                    }
                    else{
                        response.sendRedirect("song.jsp?del_again=1&id="+ code);
                    }
                }
                catch(Exception e){
                    out.println("<h1>"+ e.getMessage() +"</h1>");
                }
                }
            }
            else{
                response.sendRedirect("index.jsp?no_cookie=1");
            }
        }
%>
