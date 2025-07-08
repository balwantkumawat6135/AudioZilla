<%-- 
    Document   : index
    Created on : Sep 19, 2024, 6:29:58 PM
    Author     : BALWANT
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Cookie c[]=request.getCookies();
    String email=null;
            for(int i=0; i<c.length; i++){
                if(c[i].getName().equals("user")){
                    email=c[i].getValue();
                    break;
                }
            }
            if(email!=null && session.getAttribute(email)!= null){
                response.sendRedirect("dashboard.jsp");
            }
            else{
            %>
<!DOCTYPE html>
<html>
     <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://common.olemiss.edu/_js/sweet-alert/sweet-alert.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://common.olemiss.edu/_js/sweet-alert/sweet-alert.css">
        <style>
            body{
                display:flex;
                justify-content:center;
                align-items:center;
                min-height:100vh;
                background:url('IMG/1.jpg') no-repeat;
                background-size: cover;
                background-position: center;
            }
            .col-lg-6,.card,.card-header{
                background: transparent;
            }
            .col-lg-6{
                backdrop-filter:blur(20px);
            }
            label{
                color:window;
            }
            .btn{
                background-color:#888;
                color:white;
            }
            .btn:hover{
                background-color:#86c53b;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-4 col-sm-2 col-2"></div>
                <div class="col-lg-4 col-md-4 col-sm-8 col-8">
                    <img src="IMG/logo.png" style="width: 100%;height:auto;">
                </div>
                <div class="col-lg-4 col-md-4 col-sm-2 col-2"></div>
                <div class="col-lg-3 col-md-3 col-sm-1 col-1"></div>
                <div class="col-lg-6 col-md-6 col-sm-10 col-10 mt-4">
                    <div class="card">
                        <div class="card-header"><h1 style="text-align:center;color:white;">Login</h1></div>
                        <div class="card-body">
                            <form method="post" action="Check.jsp">
                                <label>Email:</label>
                                <input type="email" class="form-control" name="email" placeholder="Email"><br><br>
                                <label>Password:</label> 
                                <input type="password" class="form-control" name="pass" placeholder="Password"><br><br>
                                <input type="submit" class="btn  form-control" value="Login To Admin">  
                            </form>
                        </div>
                    </div>
                </div>
            <div class="col-lg-3 col-md-4 col-sm-1 col-1"></div>
            </div>
        </div>
    </body>
</html>
<%
            }
  %>  