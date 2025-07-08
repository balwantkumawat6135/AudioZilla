<%-- 
    Document   : playlist_new
    Created on : May 5, 2025, 10:14:59 AM
    Author     : balwant-kumawat
--%>
<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<%
    Cookie c[] = request.getCookies();
    String email = "";
    for (int i = 0; i < c.length; i++) {
        if (c[i].getName().equals("login")) {
            email = c[i].getValue();
        }
    }
    if (request.getParameter("code").trim().length() > 0 && request.getParameter("code") != null) {
        String artist = request.getParameter("code").trim();
        try {
            int max_sn = 0;
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
            Statement st = cn.createStatement();
            PreparedStatement ps = cn.prepareStatement("select sn from songs where aname LIKE ?");
            ps.setString(1, "%" + artist + "%");
            ResultSet rs5 = ps.executeQuery();
            while (rs5.next()) {
                max_sn++;
            }
            String aname = null;
            PreparedStatement s = cn.prepareStatement("select artist from artist where code=?");
            s.setString(1, artist);
            ResultSet s5 = s.executeQuery();
            if (s5.next()) {
                aname = s5.getString(1);
            }
            int v = (int) (Math.random() * 101);
            String img_path = "";
            String Artist = "";
            ResultSet rs2 = st.executeQuery("select * from artist where code='" + artist + "'");
            if (rs2.next()) {
                img_path = "../artist/" + rs2.getString(2) + "/" + rs2.getString(2) + ".jpg";
                Artist = rs2.getString(3);
            }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title id="title">AudioZila</title>
        <!-- BootStrap links -->
        <script src="jquery-3.7.1.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="mp3.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
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
            .clamp-text {
                display: -webkit-box;
                -webkit-box-orient: vertical;
                -webkit-line-clamp: 2;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            .mtauto{
                padding-top: 100px;
            }
            a{
                color:black;
            }
            .song{
                cursor:pointer;
            }
            .audio-player {
                text-align: center;
                margin-top: 50px;
            }
            .audio_ctrl {
                border:none;
                margin: 5px;
                font-size: 26px;
                color:transparent;
            }
            .playlist-dropdown{
                display:none;
            }
            .progress-bar {
                width: 100%;
                margin-top: 10px;
            }
            .clr{
                color:black;
                border:none;
                background:none;
                font-size:30px;
            }
            .clr:hover{
                color:red;
            }
            .atitle{
                text-align:center;
                padding-top: 100px;
                font-weight:800;
                font-size:70px;
                /* background-color: #2f8d46;*/
                background-image: url("<%=img_path%>");
                background-repeat: repeat;
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                text-transform: uppercase;
                font-family: 'Steelfish Rg', 'helvetica neue',helvetica, arial, sans-serif;
                -webkit-font-smoothing: antialiased;
                text-shadow:
                    10px 3px 0 rgba(0, 0, 0, 0.2),
                    4px 5px 6px rgba(0, 0, 0, 0.15),
                    6px 8px 10px rgba(0, 0, 0, 0.1);
                -moz-osx-font-smoothing: grayscale;
            }
            .audio-player{
                display:none;
            }
            #cover {
                background: transparent; /* Modern gradient */
                border-radius: 20px; /* 50px is often too much, 20px is smoother */
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2); /* Soft shadow for depth */
                padding: 20px; /* Inner spacing */
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .phead{
                text-align:center;
                font-weight:900;
                font-size:22px;
            }

        </style>

        <script>
            var max_sn = "<%=max_sn%>";
        </script>
        <script src="ad.js?v=<%=v%>"></script>
    </head>
    <body class="scrh">
        <%@include file="nav.jsp" %>
        <div class="container" style="margin-bottom: 100px;">
            <div class="row mt-4" id="cover">

                <div class="col-lg-3 mt-4 col-md-12 col-sm-12 col-12">
                    <img src="<%=img_path%>" class="img-fluid d-block mx-auto">
                </div>

                <div class="col-lg-9 col-md-12 col-sm-12 col-12 mt-4 align-items-center">
                    <h1 class="atitle"><%=Artist%></h1>
                </div>


                <div class="col-lg-12 mt-4">
                    <table class="table  table-hover" p_flag="1">
                        <thead class="thead-dark">
                            <tr>
                                <th>#</th>
                                <th>Image</th>
                                <th>Song Name</th>
                                <th></th>
                                <th>Playlist</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int sn = 0;
                                String path = request.getRealPath("/");
                                ResultSet rs12 = st.executeQuery("select * from songs where aname LIKE '%" + artist + "%'");
                                while (rs12.next()) {
                                    sn++;
                                    String album = rs12.getString(5);
                            %>
                            <tr>
                                <td id="td-<%=sn%>" class="gif"><%=sn%></td>
                                <td><img src="../album/<%=album%>/<%=album%>.jpg" id="trackImg-<%=sn%>" style="width: 50px; height: 50px;"  class="song" name="../album/<%=album%>/<%=rs12.getString(1)%>.mp3" rel="<%=sn%>" pid="<%=max_sn%>" sname="<%=rs12.getString(2)%>" artist="<%=aname%>" ></td>
                                <td><b  id="<%=sn%>-name" class="song" name="../album/<%=album%>/<%=rs12.getString(1)%>.mp3" rel="<%=sn%>" pid="<%=max_sn%>" sname="<%=rs12.getString(2)%>" artist="<%=aname%>" ><%=rs12.getString(2)%></b>
                                    <br><span id="s-<%=sn%>-name"><%=aname%></span>
                                </td>                
                                <td>
                                    <%
                                        PreparedStatement ps1 = cn.prepareStatement("select * from liked_song where sn=? AND code=? AND email=?");
                                        ps1.setInt(1, rs12.getInt(1));
                                        ps1.setString(2, album);
                                        ps1.setString(3, email);
                                        ResultSet rs13 = ps1.executeQuery();
                                        if (rs13.next()) {
                                    %>
                                    <i class="fa fa-heart fav pt-2" name="<%=rs12.getString(1)%>" email="<%=email%>" id="<%=album%>" style="color:red;font-size:20px;"></i>       
                                    <%
                                    } else {
                                    %>
                                    <i class="far fa-heart unfav pt-2" name="<%=rs12.getString(1)%>" email="<%=email%>" id="<%=album%>" style="color:red;font-size:20px;"></i>       
                                    <%
                                        }
                                    %>
                                </td>
                                <%

                                %>
                                <td>
                                    <img src="Image/playlist.png" style="width:40px;" sn="<%=sn%>" class="playlist" email="<%=email%>" >

                                    <!-- The Modal -->
                                    <div class="modal fade" id="myModal-<%=sn%>">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">

                                                <!-- Modal Header -->
                                                <div class="modal-header">
                                                    <h4 class="modal-title" style="text-align:center;">Playlist</h4>
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                </div>

                                                <!-- Modal body -->
                                                <div class="modal-body bg-light">
                                                    <div class="row">
                                                        <div class="col-lg-12 ">
                                                            <div class="row">
                                                                <div class="col-lg-1"></div>
                                                                <div class="col-lg-10">
                                                                    <h6 class="phead">Create Playlist</h6><br>
                                                                    <input type="text" id="pname-<%=sn%>" placeholder="Enter Playlist Name" class="form-control p-field" email="<%=email%>">
                                                                    <button class="btn btn-outline-success mt-2 add_pname"  data-sn="<%=sn%>">Create</button><br><br>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12">
                                                            <hr>
                                                        </div>
                                                        <div class="col-lg-1"></div>
                                                        <div class="col-lg-10" id="reload">
                                                            <h6 class="phead">Playlists</h6><br>
                                                            <select name="Playlist" class="form-control p-select" email="<%=email%>" acode="<%=rs12.getString(5)%>" sn="<%=rs12.getInt(1)%>">
                                                                <option>Select a Playlist</option>
                                                                <%
                                                                    PreparedStatement ps0 = cn.prepareStatement("select * from playlist where email=?");
                                                                    ps0.setString(1, email);
                                                                    ResultSet rs0 = ps0.executeQuery();
                                                                    while (rs0.next()) {
                                                                        out.print("<option value='" + rs0.getString(2) + "' >" + rs0.getString(3) + "</option>");
                                                                    }

                                                                %>
                                                            </select>
                                                        </div>
                                                        <div class="col-lg-1"></div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <%                                }
                            %>
                        </tbody>
                    </table>
                </div>

            </div>

        </div>
        <div class="audio-player">
            <nav class="navbar bg-light  fixed-bottom p-0">
                <!-- Progress bar on top -->
                <input type="range" id="progressBar" style="color:red;" class="form-control-range w-100 m-0" value="0" max="100">

                <div class="container-fluid py-2">
                    <div class="row w-100 align-items-center">
                        <!-- Left section: Album art and track info -->
                        <div class="col-4 d-flex align-items-center">
                            <img src="" class="rounded mr-3" id="SongImg" style="width: 50px; height: 50px;">
                            <div>
                                <h6 id="trackTitle" class="mb-1"></h6>
                                <small id="trackArtist"></small>
                            </div>
                        </div>

                        <!-- Center section: Control buttons -->
                        <div class="col-4 d-flex justify-content-center">
                            <button  class="clr"><i class="fa fa-step-backward "></i></button>
                            <button  class="clr"><i class="fa fa-play " id="playPauseIcon"></i></button>
                            <button  class="clr"><i class="fa fa-step-forward"></i></button>
                        </div>

                        <!-- Right section: Time info -->
                        <div class="col-4 text-right">
                            <span id="currentTime">0:00</span> / <span id="totalTime">0:00</span>
                        </div>
                    </div>
                </div>

                <audio id="audioPlayer">
                    <source src="" type="audio/mpeg">
                </audio>
            </nav>
        </div>
    </body>
    <%@include file="footer.jsp" %>
</html>
<%
        } catch (Exception e) {
            out.print("<h1>" + e.getMessage() + "</h1>");
        }
    } else {
        response.sendRedirect("index.jsp");
    }

%>

