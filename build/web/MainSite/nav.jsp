<%-- 
    Document   : nav
    Created on : Apr 19, 2025, 1:19:20 PM
    Author     : balwant-kumawat
--%>

<nav class="navbar navbar-expand-md navbar-light" style="background-color:#f6f6f6;">
            <a class="navbar-brand" href="index.jsp"><img src="Image/logo.png" class="img-fluid"></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>


            <div class="collapse navbar-collapse mx-auto" id="collapsibleNavbar">
                <div class="input-group ">
                    <input class="form-control" id="search" type="text" name="txt" placeholder="Search Song Album Artist">
                    <div class="input-group-append">
                        <span class="input-group-text"><i class="fa fa-search"></i></span>
                    </div>
                </div>

                <ul class="navbar-nav ml-auto ">
                    <li class="nav-item active" id="home">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>

                    <!-- Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                            Category
                        </a>
                        <div class="dropdown-menu">
                            <%
                                ResultSet rs = st.executeQuery("select * from category");
                                while (rs.next()) {
                            %>
                            <a class="dropdown-item" href="more.jsp?id=<%=rs.getString(2)%>"><%=rs.getString(3)%></a>
                            <%
                                }
                            %> 
                        </div>
                    </li>
                    <%
                        if(email!=null && session.getAttribute(email)!=null){
                    %>
                           <li class="nav-item" id="playlist">
                                <a class="nav-link" href="playlist.jsp">Playlists</a>
                            </li> 
                    <%
                        }
                    %>
                    <%
                        if(email!=null && session.getAttribute(email)!=null){
                    %>
                           <li class="nav-item">
                                <a class="nav-link" href="logout.jsp">Logout</a>
                            </li> 
                    <%
                        }
                        else{
                    %>
                            <li class="nav-item">
                                <a class="nav-link"  data-toggle="modal" data-target="#lModal"  >Login</a>
                            </li>
                    <%
                        }
                    %>
                    <div class="modal fade" id="lModal">
                                        <div class="modal-dialog modal-dialog-centered">
                                          <div class="modal-content">

                                            <!-- Modal Header -->
                                            <div class="modal-header">
                                              <h4 class="modal-title">Login</h4>
                                              <button type="button" class="close"  data-dismiss="modal">&times;</button>
                                            </div>

                                            <!-- Modal body -->
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="card-body" id="card">
                                                            <label>Email:</label>
                                                            <div id="email-msg" style="color:red;"></div>
                                                            <input type="email" class=" form-control" id="email" name="email" placeholder="Email">
                                                            <label>Password:</label>
                                                            <div id="password-msg" style="color:red;"></div>
                                                            <input type="password" class=" form-control " id="pass" name="pass" placeholder="Password"><br>
                                                            <button  class="btn btn-dark px-3"   id="login-btn">Login</button><br><br>
                                                            <h6>Don't have any account <span style='color:blue;cursor:pointer;' id="Create-Account">Signup</span></h6><br>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                          </div>
                                        </div>
                                      </div>
                </ul>

            </div>  
        </nav>