<%-- 
    Document   : user_check
    Created on : Apr 21, 2025, 12:06:08 PM
    Author     : balwant-kumawat
--%>
<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
            String email=request.getParameter("email");
            String password=request.getParameter("pass");
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3","root","");
                Statement st=cn.createStatement();
                ResultSet rs=st.executeQuery("select * from  users where email='"+email+"'");
                if(rs.next()){
                    if(rs.getString("password").equals(password)){
                        Cookie c= new Cookie("login",email);
                        session.setAttribute(email, password);
                        session.setMaxInactiveInterval(3600);
                        c.setMaxAge(3600);
                        response.addCookie(c);
                        out.print("success");
                    }
                    else{
                        out.print("again");
                    }
                }
                else{
                    out.print("no_account");
                }
                cn.close();
            }
            catch(Exception e){
                out.print(e.getMessage());
            }
%>