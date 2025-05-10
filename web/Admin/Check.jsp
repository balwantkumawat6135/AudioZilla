<%-- 
    Document   : Check
    Created on : Sep 19, 2024, 6:32:41 PM
    Author     : BALWANT
--%>
<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
if(request.getParameter("email")!=null&&request.getParameter("email").trim().length()>0&&request.getParameter("pass")!=null&&request.getParameter("pass").trim().length()>0){
            String email=request.getParameter("email");
            String password=request.getParameter("pass");
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3","root","");
                Statement st=cn.createStatement();
                ResultSet rs=st.executeQuery("select * from  admin where email='"+email+"'");
                if(rs.next()){
                    if(rs.getString("pass").equals(password)){
                        Cookie c= new Cookie("user",email);
                        session.setAttribute(email, password);
                        session.setMaxInactiveInterval(3600);
                        c.setMaxAge(3600);
                        response.addCookie(c);
                        response.sendRedirect("dashboard.jsp");
                    }
                    else{
                        response.sendRedirect("index.jsp?invalid_pass=1");
                    }
                }
                else{
                    response.sendRedirect("index.jsp?invalid_email=1");
                }
                cn.close();
            }
            catch(Exception e){
                out.println(e.getMessage());
            }
            
            
    
        }
        else{
             response.sendRedirect("index.jsp?empty=1");
        }
%>