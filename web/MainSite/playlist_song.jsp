<%-- 
    Document   : playlist_song
    Created on : Apr 28, 2025, 11:54:12 AM
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
    if (email != null && session.getAttribute(email) != null) {
        if (request.getParameter("code").trim().length() > 0 && request.getParameter("code") != null) {
            String code = request.getParameter("code").trim();
            try {
                int max_sn = 0;
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
                Statement st = cn.createStatement();
                PreparedStatement ps = cn.prepareStatement("select count(sn) from playlist_song where pcode=? AND email=?");
                ps.setString(1, code);
                ps.setString(2, email);
                ResultSet rs5 = ps.executeQuery();
                while (rs5.next()) {
                    max_sn = rs5.getInt(1);
                }
                int v = (int) (Math.random() * 101);
                out.print(max_sn);
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
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
        <script>
            var max_sn =<%=max_sn%>;
            alert(max_sn);
        </script>
        <script src="ad.js?v=<%=v%>"></script>
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
            #cover{
                background: linear-gradient(135deg, #d3d3d3, #a9a9a9);
                border-radius:50px;
            }
        </style>
    </head>
    <body class="scrh">
        <%@include file="nav.jsp" %>
        <div style="margin-top: 50px;"></div>
        <div class="container-fluid" style="margin-bottom: 100px;">
            <div class="row " >
                <div class="col-lg-1 col-md-1 d-none d-md-block"></div>
                <div class="col-lg-10 col-md-10 col-sm-12 col-12" id="cover">
                    <div class="row">

                        <%                                ResultSet rs2 = st.executeQuery("select * from playlist where code='" + code + "'");
                            if (rs2.next()) {
                        %>
                        <div class="col-lg-12" >
                            <div class="row">
                                <div class="col-lg-1 mt-4 col-md-1 col-sm-1 col-1"></div>
                                <div class="col-lg-3 mt-4 col-md-3 col-sm-3 col-3">
                                    <img src="Image/playlist.jpeg" class="img-fluid">
                                </div>
                                <div class="col-lg-8 col-md-8 col-sm-8 col-8 mt-4 align-items-center">
                                    <h1><%=rs2.getString(3)%></h1>
                                </div>
                                <div class="col-lg-12 mt-4">
                                    <table class="table" p_flag="1">
                                        <thead class="thead-light">
                                            <tr>
                                                <th></th>
                                                <th>Name</th>
                                                <th>Album</th>
                                                <th>Artist</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int sn = 0;
                                                String path = request.getRealPath("/");
                                                PreparedStatement s = cn.prepareStatement("select * from playlist_song where pcode=? AND email=?");
                                                s.setString(1, code);
                                                s.setString(2, email);
                                                ResultSet rs12 = s.executeQuery();
                                                while (rs12.next()) {
                                                    String album = rs12.getString(2);
                                                    sn++;
                                                    //for get artist name from artist code
                                                    PreparedStatement p9 = cn.prepareStatement("select * from songs where sn=?");
                                                    p9.setInt(1, Integer.parseInt(rs12.getString(1)));
                                                    ResultSet r9 = p9.executeQuery();
                                                    String acode = "";
                                                    String sname = "";
                                                    if (r9.next()) {
                                                        acode = r9.getString(3);
                                                        sname = r9.getString(2);
                                                    }
                                                    String aname = "";
                                                    if (acode.indexOf(",") != -1) {
                                                        String[] codes = acode.split(","); // Split by commaa
                                                        PreparedStatement p0 = cn.prepareStatement("select * from artist where code=?");
                                                        for (String co : codes) {
                                                            p0.setString(1, co);
                                                            ResultSet r = p0.executeQuery();
                                                            if (r.next()) {
                                                                String a = "<a href='artist.jsp?code=" + r.getString(2) + "'>" + r.getString(3) + "</a>";
                                                                aname += a + " ";

                                                            }
                                                        }
                                                    } else {
                                                        PreparedStatement p0 = cn.prepareStatement("select * from artist where code=?");
                                                        p0.setString(1, acode);
                                                        ResultSet r = p0.executeQuery();
                                                        if (r.next()) {
                                                            aname = "<a href='artist.jsp?code=" + r.getString(2) + "'>" + r.getString(3) + "</a>";
                                                        }
                                                    }

                                            %>
                                            <tr>
                                                <td id="td-<%=sn%>" class="gif"><%=sn%></td>
                                                <td><img src="../album/<%=album%>/<%=album%>.jpg" id="trackImg-<%=sn%>" style="width: 50px; height: 50px;"  class="song" name="../album/<%=album%>/<%=rs12.getString(1)%>.mp3" rel="<%=sn%>" pid="<%=max_sn%>" sname="<%=sname%>" artist="<%=aname%>" ></td>
                                                <td><b  id="<%=sn%>-name" class="song" name="../album/<%=album%>/<%=rs12.getString(1)%>.mp3" rel="<%=sn%>" pid="<%=max_sn%>" sname="<%=sname%>" artist="<%=aname%>" ><%=sname%></b>
                                                </td>
                                                <td><span id="s-<%=sn%>-name"><%=aname%></span></td>
                                                <td>
                                                    <%
                                                        PreparedStatement ps1 = cn.prepareStatement("select * from liked_song where sn=? AND email=?");
                                                        ps1.setInt(1, Integer.parseInt(rs12.getString(1)));
                                                        ps1.setString(2, email);
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
                                            </tr>
                                            <%
                                                }
                                                if (sn == 0) {
                                                    out.print("<td colspan='4' style='text-align:center;font-size:30px;font-weight:700;'>No Song added In This Playlist</td>");
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
                <div class="col-lg-1 col-md-1 d-none d-md-block"></div>
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
</html>
<%
            } catch (Exception e) {
                out.print("<h1>" + e.getMessage() + "</h1>");
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    } else {
        response.sendRedirect("index.jsp");
    }

%>


