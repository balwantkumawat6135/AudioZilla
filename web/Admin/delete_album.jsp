<%-- 
    Document   : delete_album
    Created on : Sep 23, 2024, 3:06:05 PM
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
            if(request.getParameter("code").trim().length()>0 && request.getParameter("code")!=null && request.getParameter("ccode").trim().length()>0 && request.getParameter("ccode")!=null){
                try{
                    String code=request.getParameter("code").trim();
                    String ccode=request.getParameter("ccode").trim();
                    String path=request.getRealPath("/");
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
                    Statement st=cn.createStatement();
                    int count=0;
                    ResultSet rs=st.executeQuery("select sn from songs where album='"+code+"'");
                    while(rs.next()){
                            count=1;
                            File fr=new File(path+"/album/"+code+"/"+rs.getInt(1)+".mp3");
                            if(fr.delete());
                        }
                    if(count==1){
                    PreparedStatement ps1= cn.prepareStatement("delete from songs where album=?");
                    ps1.setString(1,code); 
                    if(ps1.executeUpdate()>0){
                        PreparedStatement ps= cn.prepareStatement("delete from album where code=?");
                        ps.setString(1,code);
                        if(ps.executeUpdate()>0){
                            File fr=new File(path+"/album/"+code+"/"+code+".jpg");
                            if(fr.delete()){
                                File alb=new File(path+"/album/"+code);
                                if(alb.delete()){
                                    response.sendRedirect("album.jsp?del_success=1&code="+ ccode);
                                }
                                else{
                                    out.print("failed to delete folder");
                                }
                            }
                          
                        }
                        else{
                          response.sendRedirect("album.jsp?del_again=1&code="+ ccode);
                        }
                    }
                    else{
                      response.sendRedirect("album.jsp?song_del_again=1&code="+ ccode);
                    }
                }
                    else{
                        PreparedStatement ps= cn.prepareStatement("delete from album where code=?");
                        ps.setString(1,code);
                        if(ps.executeUpdate()>0){
                            File fr=new File(path+"/album/"+code+"/"+code+".jpg");
                            if(fr.delete()){
                                File alb=new File(path+"/album/"+code);
                                if(alb.delete());
                            }
                          response.sendRedirect("album.jsp?del_success=1&code="+ ccode);
                        }
                        else{
                          response.sendRedirect("album.jsp?del_again=1&code="+ ccode);
                        }
                    }
                   
                  
                    
                }
                catch(Exception e){
                    out.println("<h1>"+ e.getMessage() +"</h1>");
                }
            }
            else{
                response.sendRedirect("album.jsp?del_empty=1");
            }
        }
            else{
                response.sendRedirect("index.jsp?no_cookie=1");
            }
    }
%>