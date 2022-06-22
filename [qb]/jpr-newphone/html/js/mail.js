var OpenedMail = null;

$(document).on('click', '.mail', function(e){
    e.preventDefault();

    $(".mail-home").animate({
        left: 30+"vh"
    }, 300);
    $(".opened-mail").animate({
        left: 0+"vh"
    }, 300);

    var MailData = $("#"+$(this).attr('id')).data('MailData');
    JPR.Phone.Functions.SetupMail(MailData);

    OpenedMail = $(this).attr('id');
});

$(document).on('click', '.mail-back', function(e){
    e.preventDefault();

    $(".mail-home").animate({
        left: 0+"vh"
    }, 300);
    $(".opened-mail").animate({
        left: -30+"vh"
    }, 300);
    OpenedMail = null;
});

$(document).on('click', '#accept-mail', function(e){
    e.preventDefault();
    var MailData = $("#"+OpenedMail).data('MailData');
    $.post('https://jpr-newphone/AcceptMailButton', JSON.stringify({
        buttonEvent: MailData.button.buttonEvent,
        buttonData: MailData.button.buttonData,
        mailId: MailData.mailid,
    }));
    $(".mail-home").animate({
        left: 0+"vh"
    }, 300);
    $(".opened-mail").animate({
        left: -30+"vh"
    }, 300);
});

$(document).on('click', '#remove-mail', function(e){
    e.preventDefault();
    var MailData = $("#"+OpenedMail).data('MailData');
    $.post('https://jpr-newphone/RemoveMail', JSON.stringify({
        mailId: MailData.mailid
    }));
    $(".mail-home").animate({
        left: 0+"vh"
    }, 300);
    $(".opened-mail").animate({
        left: -30+"vh"
    }, 300);
});

JPR.Phone.Functions.SetupMails = function(Mails) {
    var NewDate = new Date();
    var NewHour = NewDate.getHours();
    var NewMinute = NewDate.getMinutes();
    var Minutessss = NewMinute;
    var Hourssssss = NewHour;
    if (NewHour < 10) {
        Hourssssss = "0" + Hourssssss;
    }
    if (NewMinute < 10) {
        Minutessss = "0" + NewMinute;
    }
    var MessageTime = Hourssssss + ":" + Minutessss;

    //$("#mail-header-mail").html(JPR.Phone.Data.PlayerData.charinfo.firstname+"."+JPR.Phone.Data.PlayerData.charinfo.lastname+"@wildroleplay.com");
    $("#mail-header-lastsync").html("Ultima sicronização "+MessageTime);
    if (Mails !== null && Mails !== undefined) {
        if (Mails.length > 0) {
            $(".mail-list").html("");
            $.each(Mails, function(i, mail){
                var date = new Date(mail.date);
                var DateString = date.getDate()+" "+MonthFormatting[date.getMonth()]+" "+date.getFullYear()+" "+date.getHours()+":"+date.getMinutes();
                var element = '<div class="mail" id="mail-'+mail.mailid+'"><span class="mail-sender" style="font-weight: bold;">'+mail.sender+'</span> <div class="mail-text"><p>'+mail.message+'</p></div> <div class="mail-time">'+DateString+'</div></div>';

                $(".mail-list").append(element);
                $("#mail-"+mail.mailid).data('MailData', mail);
            });
        } else {
            $(".mail-list").html('<p class="nomails">You have no email..</p>');
        }

    }
}

var MonthFormatting = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

JPR.Phone.Functions.SetupMail = function(MailData) {
    var date = new Date(MailData.date);
    var DateString = date.getDate()+" "+MonthFormatting[date.getMonth()]+" "+date.getFullYear()+" "+date.getHours()+":"+date.getMinutes();
    $(".mail-subject").html("<p><span style='font-weight: bold;'>"+MailData.subject+"<br><img src='../html/img/apps2/mail.png' class='imagem-mail2'><a style='padding-left: 0.3vh; font-size: 1.25vh !important;'>"+MailData.sender+" &lt;wildroleplay@gov.pt&gt;</a></span></p>");
    $(".mail-date").html("<p>"+DateString+"</p>");
    $(".mail-content").html("<p>"+MailData.message+"</p>");

    var AcceptElem = '<div class="opened-mail-footer-item" id="accept-mail"><i class="fas fa-check-circle mail-icon"></i></div>';
    var RemoveElem = '<div class="opened-mail-footer-item" id="remove-mail"><i class="fas fa-trash-alt mail-icon"></i></div>';

    $(".opened-mail-footer").html("");

    if (MailData.button !== undefined && MailData.button !== null) {
        $(".opened-mail-footer").append(AcceptElem);
        $(".opened-mail-footer").append(RemoveElem);
        $(".opened-mail-footer-item").css({"width":"50%"});
    } else {
        $(".opened-mail-footer").append(RemoveElem);
        $(".opened-mail-footer-item").css({"width":"100%"});
    }
}

// Advert JS

$(document).on('click', '.test-slet', function(e){
    e.preventDefault();
    $(".advert-home").animate({
        left: 30+"vh"
    });
    $(".new-advert").animate({
        left: 0+"vh"
    });
});

$(document).on('click', '#anuncios-button', function(e){
    e.preventDefault();
    $(".advert-home").animate({
        left: 30+"vh"
    });
    $(".new-advert").animate({
        left: 0+"vh"
    }); 
});

//$(document).on('click','.advimage', function (){

   // let source = $(this).attr('src')
   // JPR.Screen.popUp(source, "olx");
//});

$(document).on('click','#new-advert-photo',function(e){
    e.preventDefault();
    gifsabertosolx = false;
    emojisnowpp = false;
    emojisnotwt = false;
    emojisnoolx = false;
    emojisnogaleria = false;
    $(".gifs-fundo-olx").css({"display":"none"});
    $.post('https://jpr-newphone/TakePhoto',function(url){
        if(url){
            $('#advert-new-url').val(url)
        }
    })
    JPR.Phone.Functions.Close();
});

$(document).on('click', '#new-advert-back', function(e){
    e.preventDefault();

    gifsabertosolx = false;
    emojisnowpp = false;
    emojisnotwt = false;
    emojisnoolx = false;
    emojisnogaleria = false;
    $(".gifs-fundo-olx").css({"display":"none"});
    $(".advert-home").animate({
        left: 0+"vh"
    });
    $(".new-advert").animate({
        left: -30+"vh"
    });
});

$(document).on('click', '#new-advert-submit', function(e){
    e.preventDefault();
    
    var AnuncioMessage = $(".new-advert-textarea").val();
    var imageURL = $('#advert-new-url').val();
    if (AnuncioMessage != "") {
        gifsabertosolx = false;
        emojisnowpp = false;
        emojisnotwt = false;
        emojisnoolx = false;
        emojisnogaleria = false;
        $(".gifs-fundo-olx").css({"display":"none"});
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
            url: imageURL
        }), function(Anuncios){
            JPR.Phone.Functions.RefreshAdverts(Anuncios);
        });
        JPR.Phone.Animations.TopSlideUp(".twitter-new-tweet-tab", 450, -120);
    } else {
        JPR.Phone.Notifications.Add("twitter.png", "Twitter", "Write something!", "#1DA1F2");
    };
    $('#advert-new-url').val("")
    $(".new-advert-textarea").val("");
});

var gifsabertosolx = false;
$(document).on('click', '#olx-abrir-gifs', function(e){
    e.preventDefault();

    if (gifsabertosolx == false) {
        $(".gifs-fundo-olx").css({"display":"block"});
        gifsabertosolx = true;
        emojisnowpp = false;
        emojisnotwt = false;
        emojisnoolx = true;
        emojisnogaleria = false;
    } else {
        $(".gifs-fundo-olx").css({"display":"none"});
        gifsabertosolx = false;
        emojisnowpp = false;
        emojisnotwt = false;
        emojisnoolx = false;
        emojisnogaleria = false;
    }
    //console.log("aaaaa")
});

JPR.Phone.Functions.RefreshAdverts = function(Adverts) {
    $.post('https://jpr-newphone/GetAnuncios', JSON.stringify({}), function(Anuncios){
        if (Anuncios !== null && Anuncios !== undefined && Anuncios !== "" && Anuncios.length > 0) {
            Anuncios = Anuncios.reverse();
        
    
            $("#advert-header-name").html(""+JPR.Phone.Data.PlayerData.charinfo.firstname+""+JPR.Phone.Data.PlayerData.charinfo.lastname+" | "+JPR.Phone.Data.PlayerData.charinfo.phone);
            //if (Adverts.length > 0 || Adverts.length == undefined) {
                $(".advert-list").html("");
                
                $.each(Anuncios, function(i, Anuncio){
                    var clean = DOMPurify.sanitize(Anuncio.message , {
                        ALLOWED_TAGS: [],
                        ALLOWED_ATTR: []
                    });
                    if (clean == '') clean = 'Inválido...'
                    var OLXMessage = JPR.Phone.Functions.FormatTwitterMessage(clean);
                    var TimeAgo = moment(Anuncio.date).format('MM/DD/YYYY hh:mm');
        
                    var OLXHandle = JPR.Phone.Data.PlayerData.charinfo.phone
                    var PictureUrl = "./img/default.png"
                    if (Anuncio.picture !== "default") {
                        PictureUrl = Anuncio.picture
                    }
        
                    if (Anuncio.url == "") {
                        let OLXElement = '<div class="twitter-tweet" style="background-color: rgba(12, 186, 178, 0.8) !important;" data-twtcid="'+Anuncio.citizenid+'" data-twtid ="'+Anuncio.tweetId+'" data-twthandler="&middot &nbsp;' + OLXHandle.replace(" ", "_") + '">' +
                            '<div class="tweet-tweeter">' + Anuncio.firstName + ' ' + Anuncio.lastName + ' &nbsp;<span>&middot &nbsp;' + OLXHandle.replace(" ", "_") + ' &middot; ' + TimeAgo + '</span></div>' +
                            '<div class="tweet-message">' + OLXMessage + '</div>' +
                            '<div class="twt-img" style="top: 1vh;"><img src="' + PictureUrl + '" class="tweeter-image"></div>' +
                            '</div>';
                            $(".advert-list").append(OLXElement);
                    } else {
                        let OLXElement = '<div class="twitter-tweet" style="background-color: rgba(12, 186, 178, 0.8) !important;" data-twthandler="&middot &nbsp;'+OLXHandle.replace(" ", "_")+'">'+
                            '<div class="tweet-tweeter">'+Anuncio.firstName+' '+Anuncio.lastName+' &nbsp;<span>&middot &nbsp;'+OLXHandle.replace(" ", "_")+' &middot; '+TimeAgo+'</span></div>'+
                            '<div class="tweet-message">'+OLXMessage+'</div>'+
                            '<img class="image" src= ' + Anuncio.url + ' style = " border-radius:4px; width: 70%; position:relative; z-index: 1; left:52px; margin:.6rem .5rem .6rem 1rem;height: auto; padding-bottom: 15px;">' +
                            '<div class="twt-img" style="top: 1vh;"><img src="'+PictureUrl+'" class="tweeter-image"></div>' +
                            '</div>';
                        $(".advert-list").append(OLXElement);
                    }
                    // if (Tweet.citizenid === JPR.Phone.Data.PlayerData.citizenid){
                    //     $(".tweet-message").append('<span><div class="twt-icon"><i class="fas fa-trash"style="position:absolute; right:2%; font-size: 1.5rem; z-index:4;" id ="twt-delete-click"></i></div>')
                    // }
                });
            //} else {
                //$(".advert-list").html("");
                //var element = '<div style="text-align: center !important;"><span class="advert-sender" style="color: #fff;">Não há anuncios ainda!</span></div>';
                //$(".advert-list").append(element);
            //}
        } else {
            $(".advert-list").html("");
            var element = '<div style="text-align: center !important;"><span class="advert-sender" style="color: #fff;">Não há anuncios ainda!</span></div>';
            $(".advert-list").append(element);
        }
    });
}

$(document).on('click','#adv-delete',function(e){
    e.preventDefault();
    $.post('https://jpr-newphone/DeleteAdvert', function(){
        setTimeout(function(){
            JPR.Phone.Notifications.Add("olx.png", "OLX", "Advert deleted", "#00e6dc", 2000);
        },400)
    });
})
