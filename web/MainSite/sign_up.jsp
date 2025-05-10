<%-- 
    Document   : sign_up
    Created on : Apr 20, 2025, 1:32:22 PM
    Author     : balwant-kumawat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<label>Email:</label>
<div id="email-msg" style="color:red;"></div>
<input type="email" class=" form-control" id="email" name="email" placeholder="Email">
<label>Password:</label>
<div id="password-msg" style="color:red;"></div>
<input type="password" class=" form-control " id="pass" name="pass" placeholder="Password">
<label>Conform Password:</label>
<input type="password" class=" form-control " id="repass" name="repass" placeholder="Retype Password"><br>
<button  class="btn btn-dark px-3"   id="signup">SignUp</button><br><br>
<h6>Already Created Account <span style='color:blue;cursor:pointer;' id="Sign_IN">Sign IN</span></h6><br>