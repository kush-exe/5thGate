var estaausar = false;
var escolheufoto = false;

function setUpGalleryData(Images){
    $(".gallery-images").html("");
    var cont = 0;
    var cont2 = 0;
    var cont3 = 1;
    $.each(Images, function(i, image){
        cont = cont + 1;
        if (cont == 49 || cont == 39 || cont == 29 || cont == 19 || cont == 9 || cont == 59 || cont == 69 || cont == 79 || cont == 89 || cont == 99 || cont == 109 || cont == 119 || cont == cont2) {
            cont3 = cont3+1;
        }
    });
    cont2 = cont;
    if (Images != null) {
        $.each(Images, function(i, image){
            if (cont % 10==0) {
                var Element = '<div class="gallery-image"  style="display: inline-block !important;"><img src="'+image.image+'" alt="'+image.citizenid+'" class="tumbnail"></div>';
            
                $(".gallery-images").append(Element);
                $("#image-"+i).data('ImageData', image);
                var Element = '<div class="gallery-image"  style="display: block !important;height: 2.1vh !important;"></div>';
                $(".gallery-images").append(Element);
                $("#image-"+i).data('ImageData', image);
                cont = cont - 1;
            }else{
                if (cont == 49 || cont == 39 || cont == 29 || cont == 19 || cont == 9 || cont == 59 || cont == 69 || cont == 79 || cont == 89 || cont == 99 || cont == 109 || cont == 119 || cont == cont2) {
                    
                        var Element = '<div class="gallery-album">Album: '+cont3+'</div><div class="gallery-image"><img src="'+image.image+'" alt="'+image.citizenid+'" class="tumbnail"></div>';
                    
                    $(".gallery-images").append(Element);
                    $("#image-"+i).data('ImageData', image);
                    cont = cont - 1;
                    cont3 = cont3 - 1;
                }else{
                    var Element = '<div class="gallery-image"><img src="'+image.image+'" alt="'+image.citizenid+'" class="tumbnail"></div>';
                
                    $(".gallery-images").append(Element);
                    $("#image-"+i).data('ImageData', image);
                    cont = cont - 1;
                }
            }
            $(".gallery-app-header").find('p').html('Gallery');
            escolheufoto = false;
        });
    }
}

$(document).on('click', '.tumbnail', function(e){
    e.preventDefault();
    let source = $(this).attr('src')
    // JPR.Screen.popUp(source)
    $(".gallery-homescreen").animate({
        left: 30+"vh"
    }, 200);
    $(".gallery-detailscreen").animate({
        left: 0+"vh"
    }, 200);
    SetupImageDetails(source);
    $(".gallery-app-header").find('p').html('Publish photo');
    escolheufoto = true;
});

var edagaleria = false;
$(document).on('click', '.image', function(e){
    e.preventDefault();
    
    let source = $(this).attr('src')
    JPR.Screen.popUp(source, "galeria")
});


$(document).on('click', '#delete-button', function(e){
    e.preventDefault();
    gifsabertosgaleria = false;
    $(".gifs-fundo-olx").css({"display":"none"});
    if (escolheufoto == true) {
        let source = $('.image').attr('src')

        setTimeout(() => {
            $.post('https://jpr-newphone/DeleteImage', JSON.stringify({image:source}), function(Hashtags){
                setTimeout(()=>{
                    $('#return-button').click()
                    $.post('https://jpr-newphone/GetGalleryData', JSON.stringify({}), function(data){
                        setTimeout(()=>{
                                setUpGalleryData(data);
                            
                        },200)
                    });
                },200)
            })
            
        }, 200);
        if (estaausar == true) {
            $(".gallery-detailscreen").animate({
                left: 00+"vh"
            }, 100);
            $(".gallery-postscreen").animate({
                left: -30+"vh"
            }, 100);
            estaausar = false;
        }
        $(".gallery-homescreen").animate({
            left: 00+"vh"
        }, 200);
        $(".gallery-detailscreen").animate({
            left: -30+"vh"
        }, 50);
        $(".gallery-app-header").find('p').html('Gallery');
        escolheufoto = false;
    } else {
        JPR.Phone.Notifications.Add("photos.png", "Gallery", "You have to choose a photo!" , "#f23d46");
    }
    $(".gallery-app-header").find('p').html('Gallery');
});


function SetupImageDetails(Image){
    $('#imagedata').attr("src", Image);
}
let postImageUrl="";
function SetupPostDetails(){
}


$(document).on('click', '#mudarimagemfundo', function(e){
    e.preventDefault();

    if (escolheufoto == true) {
        let source = $('#imagedata').attr('src')
       
        JPR.Phone.Notifications.Add("settings.png", "CFG", "Set as background!", "#969695")
        $(".phone-background").css({"background-image":"url('"+source+"')"})

        $.post('https://jpr-newphone/SetBackground', JSON.stringify({
            background: source,
        }))
        if (estaausar == true) {
            $(".gallery-detailscreen").animate({
                left: 00+"vh"
            }, 100);
            $(".gallery-postscreen").animate({
                left: -30+"vh"
            }, 100);
            estaausar = false;
        }
        $(".gallery-homescreen").animate({
            left: 00+"vh"
        }, 200);
        $(".gallery-detailscreen").animate({
            left: -30+"vh"
        }, 50);
        $(".gallery-app-header").find('p').html('Gallery');
        escolheufoto = false;
    } else {
        JPR.Phone.Notifications.Add("photos.png", "Gallery", "You have to choose a photo!" , "#f23d46");
    }
});


$(document).on('click', '#mudarimagemperfil', function(e){
    e.preventDefault();

    if (escolheufoto == true) {
        let source = $('#imagedata').attr('src')
        JPR.Phone.Data.MetaData.profilepicture = source;
        $(OldProfilePicture).fadeOut(50, function(){
            $(OldProfilePicture).remove();
        });
        //JPR.Phone.Animations.TopSlideUp(".profilepicture-custom", 200, -23);
        $(".profilepicture-custom").fadeOut(200, function(){
            $(".profilepicture-custom").css({"display":"none"});
        });
        var ProfilePicture = JPR.Phone.Data.MetaData.profilepicture;
        if (ProfilePicture === "default") {
            JPR.Phone.Notifications.Add("settings.png", "CFG", "Set as avatar!", "#969695")
            JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
            $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="./img/default.png">');
            $("[data-settingstab='contautilizador']").find('.settings-tab-icon3').html('<img src="./img/default.png">');
        } else {
            JPR.Phone.Notifications.Add("settings.png", "CFG", "Set as avatar!", "#969695")
            JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
            $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="'+source+'">');
            $("[data-settingstab='contautilizador']").find('.settings-tab-icon3').html('<img src="'+source+'">');
        }
        $.post('https://jpr-newphone/UpdateProfilePicture', JSON.stringify({
            profilepicture: source,
        }));
        if (estaausar == true) {
            $(".gallery-detailscreen").animate({
                left: 00+"vh"
            }, 100);
            $(".gallery-postscreen").animate({
                left: -30+"vh"
            }, 100);
            estaausar = false;
        }
        $(".gallery-homescreen").animate({
            left: 00+"vh"
        }, 200);
        $(".gallery-detailscreen").animate({
            left: -30+"vh"
        }, 50);
        $(".gallery-app-header").find('p').html('Gallery');
        escolheufoto = false;
    } else {
        JPR.Phone.Notifications.Add("photos.png", "Gallery", "You have to choose a photo!" , "#f23d46");
    }
});

$(document).on('click', '#make-post-button', function(e){
    e.preventDefault();
    gifsabertosgaleria = false;
    $(".gifs-fundo-olx").css({"display":"none"});
    if (escolheufoto == true) {
        let source = $('#imagedata').attr('src')
        postImageUrl=source
        estaausar = true;

        // JPR.Screen.popUp(source)
        $(".gallery-detailscreen").animate({
            left: 30+"vh"
        }, 200);
        $(".gallery-postscreen").animate({
            left: 0+"vh"
        }, 200);
        SetupPostDetails();
    } else {
        JPR.Phone.Notifications.Add("photos.png", "Gallery", "You have to choose a photo!" , "#f23d46");
    }
});


$(document).on('click', '#return-button', function(e){
    e.preventDefault();

    $(".gallery-homescreen").animate({
        left: 00+"vh"
    }, 200);
    $(".gallery-detailscreen").animate({
        left: -30+"vh"
    }, 200);
});

$(document).on('click', '#returndetail-button', function(e){
    e.preventDefault();
    returnDetail();
    
});

$(document).on('click', '#pixota-button', function(e){
    e.preventDefault();
    gifsabertosgaleria = false;
    $(".gifs-fundo-olx").css({"display":"none"});
    if (estaausar == true) {
        $(".gallery-detailscreen").animate({
            left: 00+"vh"
        }, 100);
        $(".gallery-postscreen").animate({
            left: -30+"vh"
        }, 100);
        estaausar = false;
    }
    $(".gallery-homescreen").animate({
        left: 00+"vh"
    }, 200);
    $(".gallery-detailscreen").animate({
        left: -30+"vh"
    }, 50);
    $(".gallery-app-header").find('p').html('Gallery');
    escolheufoto = false;
    
});

function returnDetail(){
    $(".gallery-detailscreen").animate({
        left: 00+"vh"
    }, 200);
    $(".gallery-postscreen").animate({
        left: -30+"vh"
    }, 200);
}


$(document).on('click', '#tweet-button', function(e){
    e.preventDefault();
    var TweetMessage = $("#new-textarea").val();
    var imageURL = postImageUrl
    gifsabertosgaleria = false;
    $(".gifs-fundo-olx").css({"display":"none"});
    if (TweetMessage != "") {
        if (estaausar == true) {
            $(".gallery-detailscreen").animate({
                left: 00+"vh"
            }, 100);
            $(".gallery-postscreen").animate({
                left: -30+"vh"
            }, 100);
            estaausar = false;
        }
        $(".gallery-homescreen").animate({
            left: 00+"vh"
        }, 200);
        $(".gallery-detailscreen").animate({
            left: -30+"vh"
        }, 50);
        $(".gallery-app-header").find('p').html('Gallery');
        escolheufoto = false;
        var CurrentDate = new Date();
        $.post('https://jpr-newphone/PostNewTweet', JSON.stringify({
            Message: TweetMessage,
            Date: CurrentDate,
            Picture: JPR.Phone.Data.MetaData.profilepicture,
            url: imageURL
        }), function(Tweets){
            JPR.Phone.Notifications.LoadTweets(Tweets);
        });
        var TweetMessage = $("#new-textarea").val(' ');
        $.post('https://jpr-newphone/GetHashtags', JSON.stringify({}), function(Hashtags){
            JPR.Phone.Notifications.LoadHashtags(Hashtags)
        })
        // JPR.Phone.Animations.TopSlideUp(".twitter-new-tweet-tab", 450, -120);
        //returnDetail()
    } else {
        JPR.Phone.Notifications.Add("twitter.png", "Twitter", "Write something!", "#1DA1F2");
    };
    $('#tweet-new-url').val("");
    $("#tweet-new-message").val("");
});

var gifsabertosgaleria = false;
$(document).on('click', '#galeria-abrir-gifs', function(e){
    e.preventDefault();

    if (gifsabertosgaleria == false) {
        $(".gifs-fundo-galeria").css({"display":"block"});
        gifsabertosgaleria = true;
        emojisnowpp = false;
        emojisnotwt = false;
        emojisnoolx = false;
        emojisnogaleria = true;
    } else {
        $(".gifs-fundo-galeria").css({"display":"none"});
        gifsabertosgaleria = false;
        emojisnowpp = false;
        emojisnotwt = false;
        emojisnoolx = false;
        emojisnogaleria = true;
    }
    //console.log("aaaaa")
});


$(document).on('click', '#advert-button', function(e){
    e.preventDefault();
    var AnuncioMessage = $("#new-textarea").val();
    let picture = postImageUrl;
    gifsabertosgaleria = false;
    $(".gifs-fundo-olx").css({"display":"none"});
    if (AnuncioMessage !== "") {
        if (estaausar == true) {
            $(".gallery-detailscreen").animate({
                left: 00+"vh"
            }, 100);
            $(".gallery-postscreen").animate({
                left: -30+"vh"
            }, 100);
            estaausar = false;
        }
        $(".gallery-homescreen").animate({
            left: 00+"vh"
        }, 200);
        $(".gallery-detailscreen").animate({
            left: -30+"vh"
        }, 50);
        $(".gallery-app-header").find('p').html('Gallery');
        escolheufoto = false;
        $(".advert-home").animate({
            left: 0+"vh"
        });
        $(".new-advert").animate({
            left: -30+"vh"
        });
        var CurrentDate = new Date();
        $.post('https://jpr-newphone/PostNewAnuncio', JSON.stringify({
            Message: AnuncioMessage,
            Date: CurrentDate,
            Picture: JPR.Phone.Data.MetaData.profilepicture,
            url: picture
        }), function(Anuncios){
            JPR.Phone.Notifications.LoadTweets(Anuncios);
        });
        var TweetMessage = $("#new-textarea").val(' ');
        //returnDetail()
        $("#new-textarea").val(' ');
    } else {
        JPR.Phone.Notifications.Add("photos.png", "OLX", "Write something!", "#ff8f1a", 2000);
    }
});

