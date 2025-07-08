$(document).on("click", "#search", function () {
    window.open("search.jsp","_self");
});
$(document).on("click", "#Create-Account", function () {
    $("#card").load("sign_up.jsp");
});
$(document).on("click", "#Sign_IN", function () {
    $("#card").load("login_form.jsp");
});
$(document).on("click", "#signup", function () {
    var email = $("#email").val();
    var pass = $("#pass").val();
    var repass = $("#repass").val();
    console.log(email + pass + repass);
    if (pass === repass) {
        $.post(
                "add_user.jsp", {email: email, pass: pass}, function (data) {
            console.log(data);
            if (data === 'success') {
                console.log("success");
                $("#close").click();
            }

        }
        );
    }

});
$(document).on("click", "#login-btn", function () {
    var email = $("#email").val();
    var pass = $("#pass").val();
    $.post(
            "user_check.jsp", {email: email, pass: pass}, function (data) {
        data = data.trim();
        if (data === 'success') {
            console.log("success");
            location.reload();
        } else if (data === 'no_account') {
            $("#email-msg").html("Invalid Email OR Can't find account Tyr to Sign up");
        } else if (data === 'again') {
            $("#password-msg").html("Invalid Password");
        }
    }
    );
});
$(document).on("click", ".playlist", function () {
   var email=$(this).attr("email");
   var sn=$(this).attr("sn");
   if(email.length<1){
       toastr.error('Please Sign In', 'Error');
       $('#lModal').modal('show');
   }
   else{
       $("#myModal-"+sn).modal("show");
   }
});

$(document).on("click", ".add_pname", function () {
    var num=$(this).data("sn");
    var pname = $("#pname-"+num).val();
    var email = $("#pname-"+num).attr("email");

    if (!pname) {
        toastr.warning('Playlist name cannot be empty.', 'Warning');
        return;
    }

    $.post("add_playlist.jsp", { email: email, pname: pname })
        .done(function (data) {
            if (data.trim() === 'success') {
                toastr.success('Playlist Created', 'Success');
                $(".p-field").val('');
                location.reload();
            } else {
                toastr.error(data, 'Error'); // server response other than 'success'
            }
        })
        .fail(function () {
            toastr.error('Server error. Please try again.', 'Error');
        });
});


$(document).on("change",".p-select",function(){
    var email= $(this).attr("email");
    var acode= $(this).attr("acode");
    var sn= $(this).attr("sn");
    var pcode=$(this).val();
    console.log(email+" "+acode+" "+sn+" "+pcode);
    $.post(
            "ad_song_playlist.jsp",{email:email,acode:acode,sn:sn,pcode:pcode},function(data){
                    data=data.trim();
                    if(data=='success'){
                        $(".close").click();
                        toastr.success('Song Added In Playlist', 'Success');
                    }
                    else if(data=='exist'){
                        $(".close").click();
                        toastr.warning('Already Added In Playlist', 'Warning');
                    }
                }
       );
});

var tdno = 0;
            var sn = 0;
            var album = "";
            var p_flag=0;
            $(document).ready(function(){
                p_flag=$(".table").attr("p_flag");
            });
            $(document).on("click", ".song", function () {
                $(".audio-player").show();
                for(var i=1;i<=max_sn;i++){
                    $("#td-" + i).html(i);
                }
                sn = parseInt($(this).attr("rel"));
                var img="";
                if(p_flag=='0'){
                     img = $("#trackImg").attr("src");
                }
                else{
                     img = $("#trackImg-"+sn).attr("src");
                }
                var path = $(this).attr("name"); // Get the path from "name" attribute
                var title = $(this).attr("sname");
                var artist = $(this).attr("artist");
                $("#SongImg").attr("src", img);
                $("#audioPlayer source").attr("src", path); // Set as audio source
                $("#audioPlayer")[0].load(); // Reload the audio player
                $("#audioPlayer")[0].play(); // Play the song
                $("#playPauseIcon").removeClass("fa-play").addClass("fa-pause"); // Update icon
                $("#trackTitle").html(title);
                $("#trackArtist").html(artist);
                $("#title").html(album + ":" + title);
                $("#td-" + sn).html("<img src='Image/songplay.gif'  style='width:48px;height:48px;background:none;'>")
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
                    if (audioPlayer.duration == audioPlayer.currentTime) {
                        var max_sn =$("#"+sn+"-name").attr("pid");
                        $("#td-" + sn).html(sn);
                        var path1 = $("#audioPlayer source").attr("src");
                        var rel_path = path1.substr(0, path1.length - 5);
                        if (sn < max_sn) {
                            sn = sn + 1;
                            var path =$("#"+sn+"-name").attr("name");
                        } else {
                            // For double digit value
                            rel_path = path1.substr(0, path1.length - 6)
                            sn = 1;
                            var path = $("#"+sn+"-name").attr("name");
                        }
                        var title = $("#" + sn + "-name").text();//take artist name from td
                        var artist = $("#s-" + sn + "-name").text();//take artist name from td
                        $("#td-" + sn).html("<img src='Image/songplay.gif' style='width:48px;height:48px;background:none;'>");
                        var img="";
                        if(p_flag!='0'){
                             img = $("#trackImg-"+sn).attr("src");
                             $("#SongImg").attr("src", img);
                        }
                        $("#title").html(album + ":" + title);
                        $("#trackTitle").html(title);
                        $("#trackArtist").html(artist);
                        $("#audioPlayer source").attr("src", path); // Set as audio source
                        $("#audioPlayer")[0].load(); // Reload the audio player
                        $("#audioPlayer")[0].play(); // Play the song
                        $("#playPauseIcon").removeClass("fa-play").addClass("fa-pause");
                    }

                });
                // Seek to a new time when the user changes the progress bar
                progressBar.on("input", function () {
                    var seekTime = (progressBar.val() / 100) * audioPlayer.duration;
                    audioPlayer.currentTime = seekTime;
                });
            });
            $(document).on("click", ".fa-step-forward", function () {
                $("#td-" + sn).html(sn);// when we change song then remove the gif and replace serial no
                var max_sn =$("#"+sn+"-name").attr("pid");
                var path1 = $("#audioPlayer source").attr("src");
                var rel_path = path1.substr(0, path1.length - 5);
                if (sn < max_sn) {
                    sn = sn + 1;
                    var path = $("#"+sn+"-name").attr("name");
                }
                var title = $("#" + sn + "-name").text();//take artist name from td
                var artist = $("#s-" + sn + "-name").text();//take artist name from td
                $("#trackTitle").html(title);
                $("#trackArtist").html(artist);
                $("#title").html(album + ":" + title);
                $("#td-" + sn).html("<img src='Image/songplay.gif' style='width:48px;height:48px;background:none;'>");//set gif for song playing indication
                $("#audioPlayer source").attr("src", path); // Set as audio source
                var img="";
                if(p_flag!='0'){
                    img = $("#trackImg-"+sn).attr("src");
                    $("#SongImg").attr("src", img);
                }
                $("#audioPlayer")[0].load(); // Reload the audio player
                $("#audioPlayer")[0].play(); // Play the song
                $("#playPauseIcon").removeClass("fa-play").addClass("fa-pause");
            });
            $(document).on("click", ".fa-step-backward", function () {
                $("#td-" + sn).html(sn);
                var max_sn =$("#"+sn+"-name").attr("pid");
                var path1 = $("#audioPlayer source").attr("src");
                var rel_path = path1.substr(0, path1.length - 5);
                if (sn > 1) {
                    sn = sn - 1;
                    var path = $("#"+sn+"-name").attr("name");
                }
                var title = $("#" + sn + "-name").text();//take artist name from td
                var artist = $("#s-" + sn + "-name").text();//take artist name from td
                $("#td-" + sn).html("<img src='Image/songplay.gif' style='width:48px;height:48px;background:none;'>");
                $("#title").html(album + ":" + title);
                $("#trackTitle").html(title);
                $("#trackArtist").html(artist);
                $("#audioPlayer source").attr("src", path); // Set as audio source
                 var img="";
                if(p_flag!='0'){
                    img = $("#trackImg-"+sn).attr("src");
                    $("#SongImg").attr("src", img);
                }
                $("#audioPlayer")[0].load(); // Reload the audio player
                $("#audioPlayer")[0].play(); // Play the song
                $("#playPauseIcon").removeClass("fa-play").addClass("fa-pause");
            });
            $(document).on("click", ".unfav", function () {
                var sn = $(this).attr("name").trim();
                var code = $(this).attr("id").trim();
                var email = $(this).attr("email").trim();
                var $this = $(this);

                if (email.length < 1) {
                    toastr.error('Please Sign In', 'Error');
                    $('#lModal').modal('show');
                } else {
                    $.post(
                            "add_fav.jsp", {name: sn, code: code, email: email}, function (data) {
                        data = data.trim();
                        if (data == 'success') {
                            $this.attr("class", "fa fa-heart fav pt-2");
                        }
                    });
                }
            });
            $(document).on("click", ".fav", function () {
                var sn = $(this).attr("name").trim();
                var code = $(this).attr("id").trim();
                var email = $(this).attr("email").trim();
                var $this = $(this);
                if (email.length < 1) {
                    $('#lModal').modal('show');
                } else {

                    $.post(
                            "delete_fav.jsp", {sn: sn, email: email}, function (data) {
                        data = data.trim();
                        if (data == 'success') {
                            $this.attr("class", "far fa-heart unfav pt-2");
                        }
                    }
                    );
                }

            });
