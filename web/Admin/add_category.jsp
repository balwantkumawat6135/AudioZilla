<%-- 
    Document   : add_category
    Created on : Sep 19, 2024, 6:47:44 PM
    Author     : BALWANT
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*,java.io.*" pageEncoding="UTF-8"%>
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
                if(request.getParameter("category").trim().length()>0 && request.getParameter("category")!=null){
                    
                try{
                    String category=request.getParameter("category");
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
                    int sn=0;
                    Statement st=cn.createStatement();
                    ResultSet rs=st.executeQuery("select MAX(sn) from category");
                    if(rs.next()){
                        sn = rs.getInt(1);
                    }
                    sn++;
                    LinkedList ls=new LinkedList();
                    for(int i=1;i<=9;i++){
                     ls.add(i);   
                    }
                    for(int i='a';i<='z';i++){
                     ls.add(i);   
                    }
                    for(char i='A';i<='Z';i++){
                     ls.add(i);   
                    }
                    
                    Collections.shuffle(ls);
                    String code="";
                    for(int i=0;i<=6;i++){
                        code+=ls.get(i);
                    }
                    code=code+"_"+sn;
                    if(st.executeUpdate("insert into category values("+sn+",'"+code+"','"+category+"')")>0){
                        response.sendRedirect("dashboard.jsp?success=1");
                    }
                    else{
                        response.sendRedirect("dashboard.jsp?again=1");
                    }
                }
                catch(Exception e){
                    out.print("<h1>"+ e.getMessage() +"</h1>");
                }
                    
                }
                else{
                 response.sendRedirect("dashboard.jsp?empty=1");   
                }
            }
            else{
                response.sendRedirect("index.jsp?no_cookie=1");
            }
        }
%>