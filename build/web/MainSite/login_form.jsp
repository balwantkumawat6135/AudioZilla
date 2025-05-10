<%-- 
    Document   : login_form
    Created on : Apr 19, 2025, 4:28:22 PM
    Author     : balwant-kumawat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<label>Email:</label>
<div id="email-msg" style="color:red;"></div>
<input type="email" class=" form-control" id="email" name="email" placeholder="Email">
<label>Password:</label>
<div id="password-msg" style="color:red;"></div>
<input type="password" class=" form-control " id="pass" name="pass" placeholder="Password"><br>
<button  class="btn btn-dark px-3"   id="login-btn">Login</button><br><br>
<h6>Don't have any account <span style='color:blue;cursor:pointer;' id="Create-Account">Signup</span></h6><br>