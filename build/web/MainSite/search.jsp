<%-- 
    Document   : search
    Created on : Oct 24, 2024, 4:06:00 PM
    Author     : BALWANT
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    Cookie c[] = request.getCookies();
    String email = "";
    for (int i = 0; i < c.length; i++) {
        if (c[i].getName().equals("login")) {
            email = c[i].getValue();
        }
    }
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
        Statement st = cn.createStatement();
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
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="mp3.css">
        <script src="jquery-3.7.1.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
        <style>
            a{
                color:black;
            }
            a:hover{
                color:red;
            }
            .title {
                display: -webkit-box;
                -webkit-box-orient: vertical;
                -webkit-line-clamp: 2;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .d1, .d2 {
                max-height: 70vh;
                overflow-y: scroll;
                border: 1px solid #000;
            }

            @media (min-width: 992px) {
                .d1, .d2 {
                    height: 70vh; /* fixed height on larger screens */
                }
            }
            @media (max-width: 992px) {
                .d1, .d2 {
                    height: 50vh; /* fixed height on larger screens */
                }
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
            .ht{
                text-align:center;
                background: linear-gradient(to right, #000000, #333333);
                color:white;
                font-weight:800;
                font-family:kanit;
            }
            .audio-player{
                display:none;
            }
            .song-card {
                background-color: #fff;
                border-radius: 12px;
                transition: box-shadow 0.3s ease, transform 0.3s ease;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            }

            .song-card:hover {
  border: 3px solid black; /* Bootstrap primary color */
}


        </style>
        <script>
            $(document).ready(function () {
                $("#search").attr("id", "searchb");
                $("#searchb").focus();
            });
            $(document).on("keyup", "#searchb", function () {
                var txt = $(this).val();
                $.post(
                        "search_bar.jsp", {text: txt}, function (data) {
                    $(".srh").html(data);
                }
                );
            });
            var tdno = 0;
            var sn = 0;
            var album = "";
            var p_flag = 0;
            $(document).on("click", ".song", function () {
                $(".audio-player").show();
                sn = parseInt($(this).attr("rel"));
                img = $(this).attr("img");
                var path = $(this).attr("name"); // Get the path from "name" attribute
                var title = $(this).attr("sname");
                // var artist = $(this).attr("artist");
                $("#SongImg").attr("src", img);
                $("#audioPlayer source").attr("src", path); // Set as audio source
                $("#audioPlayer")[0].load(); // Reload the audio player
                $("#audioPlayer")[0].play(); // Play the song
                $("#playPauseIcon").removeClass("fa-play").addClass("fa-pause"); // Update icon
                $("#trackTitle").html(title);
                // $("#trackArtist").html(artist);
                //$("#title").html(album + ":" + title);
                //$("#td-" + sn).html("<img src='Image/songplay.gif'  style='width:48px;height:48px;background:none;'>")
            });
            $(document).on("click", "#playPauseIcon", function () {
                var audio = $("#audioPlayer")[0];
                var cls = $(this).attr("class");
                if (cls == 'fa fa-pause') {
                    $("#playPauseIcon").attr("class", "fa fa-play");
                    audioPlayer.pause();
                    $("#td-" + sn).html("<img src='Image/songpaused.jpg' style='width:48px;height:48px;background:none;'>");

                } else {
                    $("#playPauseIcon").attr("class", "fa fa-pause");
                    audioPlayer.play();
                    $("#td-" + sn).html("<img src='Image/songplay.gif' style='width:48px;height:48px;background:none;'>");
                }
            });
            $(document).ready(function () {
                var audioPlayer = $("#audioPlayer")[0];
                var progressBar = $("#progressBar");
                var currentTimeDisplay = $("#currentTime");
                var totalTimeDisplay = $("#totalTime");
                // Update the total duration once the metadata is loaded
                $(audioPlayer).on("loadedmetadata", function () {
                    var totalMinutes = Math.floor(audioPlayer.duration / 60);
                    var totalSeconds = Math.floor(audioPlayer.duration % 60).toString().padStart(2, '0');
                    totalTimeDisplay.text(totalMinutes + ":" + totalSeconds);
                });

                // Update the progress bar and current time display as the audio plays

                $(audioPlayer).on("timeupdate", function () {
                    var currentMinutes = Math.floor(audioPlayer.currentTime / 60);
                    var currentSeconds = Math.floor(audioPlayer.currentTime % 60).toString().padStart(2, '0');
                    currentTimeDisplay.text(currentMinutes + ":" + currentSeconds);
                    var progress = (audioPlayer.currentTime / audioPlayer.duration) * 100;
                    progressBar.val(progress);
                });
                // Seek to a new time when the user changes the progress bar
                progressBar.on("input", function () {
                    var seekTime = (progressBar.val() / 100) * audioPlayer.duration;
                    audioPlayer.currentTime = seekTime;
                });
            });



        </script>
    </head>
    <html>
        <body>
            <%@include file="nav.jsp" %>
            <div class="container-fluid srh bg-light  shadow-sm" style="margin-bottom: 100px; border-radius: 10px;height: 80vh;">
                <div class="row justify-content-center">
                    <div class="col-md-8 text-center" style="margin-top: 18%;">
                        <h1 class="font-weight-bold text-dark mb-3">🎵 Search Music</h1>
                        <p class="text-muted lead">Find your favorite songs, albums, and artists instantly</p>
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
    </html>

    <%    } catch (Exception e) {
            out.print(e.getMessage());
        }
    %>


