var YoutubeSearchActive = false;
var VideoDiv = "";
var avervideo = false;

$(document).on('click', '#youtube-search-chats3', function(e){
    e.preventDefault();

    
        if ($("#youtube-search-input").css('display') == "none") {
            $("#youtube-search-input").fadeIn(150);
            YoutubeSearchActive = true;
        } else {
            $("#youtube-search-input").fadeOut(150);
            YoutubeSearchActive = false;
        }
    
});

$(document).on('click', '#youtube-home', function(e){
    e.preventDefault();
    
    if (avervideo == true) {
        const element = document.getElementById('if1');
        element.remove();
        
            
        $("#debugyt").removeClass('youtube-corpoemsi2');
        $("#debugyt").addClass('youtube-corpoemsi')
        
        $("#youtube-search-input").fadeOut(150);
        YoutubeSearchActive = false;
        avervideo = false
    } 
});

$(document).on('click', '#video4', function(e){
    e.preventDefault();
    
    if (avervideo == false) {
        VideoDiv = '<iframe name="I1" id="if1" class="video-yt" src="https://www.youtube.com/embed/iwS9uhUF6GM?autoplay=1"</iframe>';
        avervideo = true;
        $(".youtube-app").append(VideoDiv);
        $("#youtube-search-input").val("");
        $("#youtube-search-input").fadeOut(150);
        YoutubeSearchActive = false;
        $("#debugyt").removeClass('youtube-corpoemsi');
        $("#debugyt").addClass('youtube-corpoemsi2')
    } else {
        const element = document.getElementById('if1');
        element.remove();
        VideoDiv = '<iframe name="I1" id="if1" class="video-yt" src="https://www.youtube.com/embed/iwS9uhUF6GM?autoplay=1"</iframe>';
        avervideo = true;
        $(".youtube-app").append(VideoDiv);
    }
});

$(document).on('click', '#video1', function(e){
    e.preventDefault();
    
    if (avervideo == false) {
        VideoDiv = '<iframe name="I1" id="if1" class="video-yt" src="https://www.youtube.com/embed/lYQ-j8-XbhU?autoplay=1"</iframe>';
        avervideo = true;
        $(".youtube-app").append(VideoDiv);
        $("#youtube-search-input").val("");
        $("#youtube-search-input").fadeOut(150);
        YoutubeSearchActive = false;
        
        $("#debugyt").removeClass('youtube-corpoemsi');
        $("#debugyt").addClass('youtube-corpoemsi2')
       
    } else {
        const element = document.getElementById('if1');
        element.remove();
        VideoDiv = '<iframe name="I1" id="if1" class="video-yt" src="https://www.youtube.com/embed/lYQ-j8-XbhU?autoplay=1"</iframe>';
        avervideo = true;
        $(".youtube-app").append(VideoDiv);
    }
});

$(document).on('click', '#video2', function(e){
    e.preventDefault();
    
    if (avervideo == false) {
        VideoDiv = '<iframe name="I1" id="if1" class="video-yt" src="https://www.youtube.com/embed/iVbgcaeA0AM?autoplay=1"</iframe>';
        avervideo = true;
        $(".youtube-app").append(VideoDiv);
        $("#youtube-search-input").val("");
        $("#youtube-search-input").fadeOut(150);
        YoutubeSearchActive = false;
        $("#debugyt").removeClass('youtube-corpoemsi');
        $("#debugyt").addClass('youtube-corpoemsi2')
    } else {
        const element = document.getElementById('if1');
        element.remove();
        VideoDiv = '<iframe name="I1" id="if1" class="video-yt" src="https://www.youtube.com/embed/iVbgcaeA0AM?autoplay=1"</iframe>';
        avervideo = true;
        $(".youtube-app").append(VideoDiv);
    }
});

$(document).on('click', '#video3', function(e){
    e.preventDefault();
    
    if (avervideo == false) {
        VideoDiv = '<iframe name="I1" id="if1" class="video-yt" src="https://www.youtube.com/embed/e4GSRPAT7Ng?autoplay=1"</iframe>';
        avervideo = true;
        $(".youtube-app").append(VideoDiv);
        $("#youtube-search-input").val("");
        $("#youtube-search-input").fadeOut(150);
        YoutubeSearchActive = false;
        $("#debugyt").removeClass('youtube-corpoemsi');
        $("#debugyt").addClass('youtube-corpoemsi2') 
    } else {
        const element = document.getElementById('if1');
        element.remove();
        VideoDiv = '<iframe name="I1" id="if1" class="video-yt" src="https://www.youtube.com/embed/e4GSRPAT7Ng?autoplay=1"</iframe>';
        avervideo = true;
        $(".youtube-app").append(VideoDiv);
    }
});

$(document).on('keypress', function (e) {
    if (YoutubeSearchActive == true) {
        if(e.which === 13){
                        
            var VideoEscolhido = $("#youtube-search-input").val();
                            
            if (VideoEscolhido !== null && VideoEscolhido !== undefined && VideoEscolhido !== "") {
                if (avervideo == false) {
                    VideoDiv = '<iframe name="I1" id="if1" class="video-yt" src="https://www.youtube.com/embed/'+VideoEscolhido+'?autoplay=1"</iframe>';
                    avervideo = true;
                    $(".youtube-app").append(VideoDiv);
                    $("#youtube-search-input").val("");
                    $("#youtube-search-input").fadeOut(150);
                    YoutubeSearchActive = false;
                    $("#debugyt").removeClass('youtube-corpoemsi');
                    $("#debugyt").addClass('youtube-corpoemsi2') 
                } else {
                    const element = document.getElementById('if1');
                    element.remove();
                    VideoDiv = '<iframe name="I1" id="if1" class="video-yt" src="https://www.youtube.com/embed/'+VideoEscolhido+'?autoplay=1"</iframe>';
                    avervideo = true;
                    $(".youtube-app").append(VideoDiv);
                    $("#youtube-search-input").val("");
                    $("#youtube-search-input").fadeOut(150);
                    YoutubeSearchActive = false;
                    $("#debugyt").removeClass('youtube-corpoemsi');
                    $("#debugyt").addClass('youtube-corpoemsi2') ;
                }
            } else {
                JPR.Phone.Notifications.Add("youtube.png", "Youtube", "Write something!", "#d32525", 1750);
            }              
        }
    }    

});