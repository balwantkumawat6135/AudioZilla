<%-- 
    Document   : add_album
    Created on : Sep 20, 2024, 8:31:14 AM
    Author     : BALWANT
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*,java.io.*" pageEncoding="UTF-8"%>
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
       try{
                        String category=request.getParameter("code").trim();
                        String album=request.getParameter("album").trim();
                        String des=request.getParameter("des").trim();
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
                        Statement st=cn.createStatement();
                        ResultSet rs=st.executeQuery("select MAX(sn) from album");
                        int sn=0; 
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
                            if(st.executeUpdate("insert into album values("+ sn +",'"+ code +"','"+  album +"','"+  des +"','"+ category +"' ) " )>0){
                                String appPath = request.getRealPath("/");
                                out.print("<h1>" + appPath + "</h1>");
                                File dir = new File(appPath + "album" + File.separator + code);
                                if (dir.mkdir()) {
                                    response.sendRedirect("image_upload.jsp?success=1&id=" + code);
                                } else {
                                    out.print("Directory already exists or failed to create.");
                                    }
                            }
                            else{
                               response.sendRedirect("album.jsp?again=1");  
                            }
                        }
                        catch(Exception e){
                         out.print("<h1>"+ e.getMessage() +"</h1>");   
                        }
    }
    else{
         response.sendRedirect("index.jsp");
    }
}
%>