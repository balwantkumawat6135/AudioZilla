<%-- 
    Document   : playlist
    Created on : Apr 26, 2025, 2:07:53 PM
    Author     : balwant-kumawat
--%>
<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<%
    Cookie c[]=request.getCookies();
    String email="";
        for(int i=0; i<c.length; i++){
            if(c[i].getName().equals("login")){
                email=c[i].getValue();
            }
        }
        if(email!=null && session.getAttribute(email)!=null){
            try {
         
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
            Statement st = cn.createStatement();
            Random R=new Random();
            int v=Math.abs(R.nextInt());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AudioZila</title>
        
        <!-- BootStrap links -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="jquery-3.7.1.js"></script>
        <script src="ad.jsv=<%=v%>"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="mp3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
        <!--Toaster Links-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <style>
            .txt{
                font-family: "Kanit", sans-serif;
                font-weight: 500;
                font-style: normal;
                font-size: 20px;
            }
            a{
                color:black;
            }
            a:hover{
                color:red;
            }
            .text{
                text-align:center;
                font-size:20px;
            }
            .text:hover{
                font-size:22px;
                color:red;
                cursor:pointer;
            }
            .c{
                text-align:center;
               color:red;
            }
            .d0{
                display:none;
            }
            .nav-link:hover{
                 font-size:18px;
            }
            
            
        </style>
        <script>
                $(document).on("mouseover",".card-profile",function(){
                    var sn=$(this).attr("sn");
                    $(".block-1-"+sn).addClass("d0");
                    $(".block-2-"+sn).removeClass("d0");   
                });
                $(document).on("mouseout",".card-profile",function(){
                var sn=$(this).attr("sn");
                $(".block-2-"+sn).addClass("d0");
                $(".block-1-"+sn).removeClass("d0");
                $(".block-3-"+sn).addClass("d0");
                });
            
            $(document).on("click", ".fa-trash", function() {
                var sn = $(this).attr("sn");
                var code=$(this).attr("code");
                $.post(
                    "del_playlist.jsp",{code:code},function(data){
                        data=data.trim();
                        if(data=='success'){
                            console.log(sn);
                            $("#card-"+sn).hide();
                            location.reload();
                            toster.success("Playlist Deleted Successfully",'Success');
                        }
                    }
                );
                
                
            });
            $(document).ready(function(){
               $("#home").attr("class","nav-item");
               $("#playlist").attr("class","nav-item active");
            });
            
            
        </script>
    </head>
    <body class="scrh">
        <%@include file="nav.jsp" %>
            <div class="container-fluid">
            <div class="row">
                <div class=" col-lg-1 col-md-1 col-sm-1 col-1"></div>
                <div class="col-lg-10 col-md-10 col-sm-10 col-10">
                    <div class="row" >
                        <div class="col-lg-12 col-md-12 col-sm-12 col-12  mt-4"><h2 class="heading p-4">My Playlists</h2></div>
                        <div class="col-lg-2 col-md-3 col-sm-6 col-6">
                            <div class="card-profile">
                                <%
                                    PreparedStatement p0=cn.prepareStatement("select count(sn) from liked_song where email=?");
                                    p0.setString(1,email);
                                    ResultSet r0=p0.executeQuery();
                                    int ls=0;
                                    if(r0.next()){
                                        ls=r0.getInt(1);
                                    }
                                %>
                                        <a href="liked_song.jsp"><img src="Image/liked_song.jpeg" class="img-fluid"></a>
                                            <div class="card-body">
                                                <h4 class="text">Liked Song</h4>
                                                <p class="text"><b>Songs: </b><%=ls%></p>
                                            </div>
                            </div>
                        </div>
                        <div class="col-lg-1 col-md-1 d-none d-md-block "></div>
                        <%
                            ResultSet r=st.executeQuery("select * from playlist where email='"+email+"'");
                            PreparedStatement p=cn.prepareStatement("select count(sn) from playlist_song where pcode=?");
                            int sn=0;
                            while(r.next()){
                                sn++;
                                p.setString(1,r.getString(2));
                                ResultSet r1=p.executeQuery();
                                int scount=0;
                                if(r1.next()){
                                    scount=r1.getInt(1);
                                }
                                
                        %>
                                <div class="col-lg-2 col-md-3 col-sm-6 col-6">
                                    <div class="card-profile" sn="<%=sn%>" id="card-<%=sn%>">
                                        <a href="playlist_song.jsp?code=<%=r.getString(2)%>"><img src="Image/playlist.jpeg" class="img-fluid"></a>
                                            <div class="card-body">
                                                <div class="block-1-<%=sn%>">
                                                    <h4 class="text"><%=r.getString(3)%></h4>
                                                    <p class="text"><b>Songs: </b><%=scount%></p>
                                                </div>
                                                
                                                <div class="block-2-<%=sn%> d0" style="text-align:center;">
                                                    <button class="btn "><i class="fa fa-trash fa-2x c" sn="<%=sn%>" code="<%=r.getString(2)%>"></i></button>
                                                </div>
                                            </div>
                                    </div>
                                </div>
                                <div class="col-lg-1 col-md-1 d-none d-md-block"></div>
                        <%
                            
                            }
                        %>
                        
                    </div>
                </div>
                <div class="col-lg-1 col-md-1 col-sm-1 col-1"></div>
            </div>
            </div>
    </body>
    <%@include  file="footer.jsp" %>
</html>
<%
        } catch (Exception e) {
            out.print("<h1>" + e.getMessage() + "</h1>");
        }
}
else{
    response.sendRedirect("index.jsp");
}
%>
