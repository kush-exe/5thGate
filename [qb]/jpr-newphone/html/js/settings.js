JPR.Phone.Settings = {};
JPR.Phone.Settings.Background = "fundo-original";
JPR.Phone.Settings.OpenedTab = null;
JPR.Phone.Settings.Backgrounds = {
    'fundo-original': {
        label: "Original"
    }
};

var PressedBackground = null;
var PressedBackgroundObject = null;
var OldBackground = null;
var IsChecked = null;
var fotoatual = null;

$(document).on('click', '.settings-app-tab', function(e){
    e.preventDefault();
    var PressedTab = $(this).data("settingstab");

    if (PressedTab == "background") {
        JPR.Phone.Animations.TopSlideDown(".settings-"+PressedTab+"-tab", 200, 0);
        JPR.Phone.Settings.OpenedTab = PressedTab;
    } else if (PressedTab == "profilepicture") {
        JPR.Phone.Animations.TopSlideDown(".settings-"+PressedTab+"-tab", 200, 0);
        JPR.Phone.Settings.OpenedTab = PressedTab;
    } else if (PressedTab == "numberrecognition") {
        var checkBoxes = $(".numberrec-box");
        JPR.Phone.Data.AnonymousCall = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", JPR.Phone.Data.AnonymousCall);

        if (!JPR.Phone.Data.AnonymousCall) {
            $("#numberrecognition > p").html('Off');
        } else {
            $("#numberrecognition > p").html('On');
        }
    }
});



$(document).on('click', '#testedefinicao', function(e){
    e.preventDefault();
        var checkBoxes = $(".numberrec-box3");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        if (usouaviao == false) {
            $(".menuinteracao-4").css({"background-color":"rgb(203, 183, 35)"});
            usouaviao = true;
            $(".menuinteracao-9").css({"background-color":"rgba(86, 86, 86, 0.6)"});
            usoublue = true;
            $(".menuinteracao-8").css({"background-color":"rgba(86, 86, 86, 0.6)"});
            usouwifi = true;
            $(".menuinteracao-10").css({"background-color":"rgba(86, 86, 86, 0.6)"});
            usoutower = true;
            
            var checkBoxes2 = $(".numberrec-box2");
            if (!checkBoxes2.prop("checked") == false) {
                
                Teste1 = !checkBoxes2.prop("checked");
                checkBoxes2.prop("checked", Teste1);
            }
            

            var checkBoxes3 = $(".numberrec-box6");

            if (!checkBoxes3.prop("checked") == false) {
                Teste1 = !checkBoxes3.prop("checked");
                checkBoxes3.prop("checked", Teste1);
            }

            var checkBoxes4 = $(".numberrec-box7");

            if (!checkBoxes4.prop("checked") == false) {
                Teste1 = !checkBoxes4.prop("checked");
                checkBoxes4.prop("checked", Teste1);
            }
            $("#phone-signal2").removeClass('fa-wifi');
            $("#phone-signal").removeClass('fa-signal');
            $("#phone-signal2").addClass('fa-plane');
        } else {
            $(".menuinteracao-4").css({"background-color":"rgba(86, 86, 86, 0.6)"});
            $("#phone-signal2").removeClass('fa-plane');
            $("#phone-signal2").addClass('fa-wifi');
            $("#phone-signal").addClass('fa-signal');
            usouaviao = false;
        }
});

var checkBoxes = $(".numberrec-box2");
Teste1 = !checkBoxes.prop("checked");
checkBoxes.prop("checked", Teste1);

var checkBoxes = $(".numberrec-box6");
Teste1 = !checkBoxes.prop("checked");
checkBoxes.prop("checked", Teste1);

var checkBoxes = $(".numberrec-box7");
Teste1 = !checkBoxes.prop("checked");
checkBoxes.prop("checked", Teste1);

$(document).on('click', '#testedefinicao2', function(e){
    e.preventDefault();
        var checkBoxes = $(".numberrec-box2");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        if (usoublue == false) {
            $(".menuinteracao-9").css({"background-color":"rgba(86, 86, 86, 0.6)"});
            usoublue = true;
        } else {
            var checkBoxes5 = $(".numberrec-box3");
            
            if (!checkBoxes5.prop("checked") == false) {
                
                Teste1 = !checkBoxes5.prop("checked");
                checkBoxes5.prop("checked", Teste1);
            }
            $(".menuinteracao-9").css({"background-color":"rgb(41, 121, 232)"});
            usoublue = false;
            $(".menuinteracao-4").css({"background-color":"rgba(86, 86, 86, 0.6)"});
            usouaviao = false;
            $("#phone-signal2").removeClass('fa-plane');
            $("#phone-signal2").addClass('fa-wifi');
            $("#phone-signal").addClass('fa-signal');
        }
});

$.post('https://jpr-newphone/TemNotificacoes2', JSON.stringify({}), function(data){
    if (data.notifsativas2 == 1) {
        var checkBoxes = $(".numberrec-box4");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
    } else {
    }
})

$(document).on('click', '#testedefinicao3', function(e){
    e.preventDefault();
        var checkBoxes = $(".numberrec-box4");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        e.preventDefault();
        $.post('https://jpr-newphone/TemNotificacoes', JSON.stringify({}), function(data){
            if (data.notifsativas == 1) {
                $("#mudar-notifs").removeClass('fa-bell-slash');
                $("#mudar-notifs").removeClass('fa-bell');
                $("#mudar-notifs").addClass('fa-bell-slash');
                JPR.Phone.Notifications.Add("settings.png", "CFG", "Notification sound off!");
                $(".menuinteracao-19").css({"background":"rgb(203, 183, 35)"});
                $.post("https://jpr-newphone/TemNotificacoes3", JSON.stringify({}));
            } else {
                $("#mudar-notifs").removeClass('fa-bell-slash');
                $("#mudar-notifs").removeClass('fa-bell');
                $("#mudar-notifs").addClass('fa-bell');
                JPR.Phone.Notifications.Add("settings.png", "CFG", "Notification sound on!");
                $(".menuinteracao-19").css({"background":"rgba(20, 20, 20, 0.77)"});
                $.post("https://jpr-newphone/TemNotificacoes3", JSON.stringify({}));
            }
            //console.log(data.notifsativas)
        })
});

$(document).on('click', '#testedefinicao4', function(e){
    e.preventDefault();
        var checkBoxes = $(".numberrec-box5");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        if (lanternaativa == false) {
            $.post("https://jpr-newphone/LigarLanterna", JSON.stringify({}));
            $(".menuinteracao-20").css({"background":"rgb(34, 200, 45)"});
            $(".menuinteracao-22").css({"background":"rgb(34, 200, 45)"});
            lanternaativa = true;
        } else {
            $.post("https://jpr-newphone/LigarLanterna", JSON.stringify({}));
            $(".menuinteracao-20").css({"background":"rgba(20, 20, 20, 0.77)"});
            $(".menuinteracao-22").css({"background":"transparent"});
            lanternaativa = false;
        }
});

$(document).on('click', '#testedefinicao5', function(e){
    e.preventDefault();
        var checkBoxes = $(".numberrec-box6");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        if (usouwifi == false) {
            
            $(".menuinteracao-8").css({"background-color":"rgba(86, 86, 86, 0.6)"});
            usouwifi = true;
        } else {
            var checkBoxes5 = $(".numberrec-box3");
            
            if (!checkBoxes5.prop("checked") == false) {
                
                Teste1 = !checkBoxes5.prop("checked");
                checkBoxes5.prop("checked", Teste1);
            }
            $(".menuinteracao-8").css({"background-color":"rgb(41, 121, 232)"});
            usouwifi = false;
            $(".menuinteracao-4").css({"background-color":"rgba(86, 86, 86, 0.6)"});
            usouaviao = false;
            $("#phone-signal2").removeClass('fa-plane');
            $("#phone-signal2").addClass('fa-wifi');
            $("#phone-signal").addClass('fa-signal');
        }
});

$(document).on('click', '#testedefinicao6', function(e){
    e.preventDefault();
        var checkBoxes = $(".numberrec-box7");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        if (usoutower == false) {
    
            $(".menuinteracao-10").css({"background-color":"rgba(86, 86, 86, 0.6)"});
            usoutower = true;
         } else {
            var checkBoxes5 = $(".numberrec-box3");
            
            if (!checkBoxes5.prop("checked") == false) {
                
                Teste1 = !checkBoxes5.prop("checked");
                checkBoxes5.prop("checked", Teste1);
            }
             $(".menuinteracao-10").css({"background-color":"rgb(73, 200, 44)"});
             usoutower = false;
             $(".menuinteracao-4").css({"background-color":"rgba(86, 86, 86, 0.6)"});
             usouaviao = false;
             $("#phone-signal2").removeClass('fa-plane');
             $("#phone-signal2").addClass('fa-wifi');
             $("#phone-signal").addClass('fa-signal');
         }
});

$(document).on('click', '#accept-background', function(e){
    e.preventDefault();
    var hasCustomBackground = JPR.Phone.Functions.IsBackgroundCustom();

    if (hasCustomBackground === false) {
        JPR.Phone.Notifications.Add("settings.png", "CFG", JPR.Phone.Settings.Backgrounds[JPR.Phone.Settings.Background].label+" applied!", "#969695")
        JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $(".phone-background").css({"background-image":"url('/html/img/backgrounds/"+JPR.Phone.Settings.Background+".png')"})
    } else {
        JPR.Phone.Notifications.Add("settings.png", "CFG", "applied!", "#969695")
        JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $(".phone-background").css({"background-image":"url('"+JPR.Phone.Settings.Background+"')"});
    }

    $.post('https://jpr-newphone/SetBackground', JSON.stringify({
        background: JPR.Phone.Settings.Background,
    }))
});

JPR.Phone.Functions.LoadMetaData = function(MetaData) {
    if (MetaData.background !== null && MetaData.background !== undefined) {
        JPR.Phone.Settings.Background = MetaData.background;
    } else {
        JPR.Phone.Settings.Background = "default-qbcore";
    }

    var hasCustomBackground = JPR.Phone.Functions.IsBackgroundCustom();

    if (!hasCustomBackground) {
        $(".phone-background").css({"background-image":"url('/html/img/backgrounds/"+JPR.Phone.Settings.Background+".png')"})
    } else {
        $(".phone-background").css({"background-image":"url('"+JPR.Phone.Settings.Background+"')"});
    }
    fotoatual = MetaData.profilepicture;
    if (MetaData.profilepicture == "default") {
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="./img/default.png">');
    } else {
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="'+MetaData.profilepicture+'">');
    }
    if (fotoatual == "default") {
        $("[data-settingstab='contautilizador']").find('.settings-tab-icon3').html('<img src="./img/default.png">');
    } else {
        $("[data-settingstab='contautilizador']").find('.settings-tab-icon3').html('<img src="'+fotoatual+'">');
    }
    $("[data-settingstab='contautilizador']").find('.settings-tab-title3').html(JPR.Phone.Data.PlayerData.charinfo.firstname+" "+JPR.Phone.Data.PlayerData.charinfo.lastname);
    $("[data-settingstab='contautilizador']").find('.settings-tab-title4').html(JPR.Phone.Data.PlayerData.charinfo.firstname+"."+JPR.Phone.Data.PlayerData.charinfo.lastname+"@wildroleplay.com");
}

$(document).on('click', '#cancel-background', function(e){
    e.preventDefault();
    JPR.Phone.Animations.TopSlideUp(".background-custom", 200, -23);
    JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
});

$(document).on('click', '#bk1', function(e){
    e.preventDefault();

    JPR.Phone.Settings.Background = "https://imgur.com/Upmc7QF.jpg"; 

    JPR.Phone.Notifications.Add("settings.png", "CFG", "Background 1 applied!", "#969695")
    JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
    $(".phone-background").css({"background-image":"url('https://imgur.com/Upmc7QF.jpg')"})

    $.post('https://jpr-newphone/SetBackground', JSON.stringify({
        background: JPR.Phone.Settings.Background,
    }))

});

$(document).on('click', '#bk2', function(e){
    e.preventDefault();

    JPR.Phone.Settings.Background = "https://imgur.com/AzHOh8m.jpg"; 

    JPR.Phone.Notifications.Add("settings.png", "CFG", "Background 2 applied!", "#969695")
    JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
    $(".phone-background").css({"background-image":"url('https://imgur.com/AzHOh8m.jpg')"})

    $.post('https://jpr-newphone/SetBackground', JSON.stringify({
        background: JPR.Phone.Settings.Background,
    }))

});

$(document).on('click', '#bk3', function(e){
    e.preventDefault();

    JPR.Phone.Settings.Background = "https://imgur.com/SlmFo1O.jpg"; 

    JPR.Phone.Notifications.Add("settings.png", "CFG", "Background 3 applied!", "#969695")
    JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
    $(".phone-background").css({"background-image":"url('https://imgur.com/SlmFo1O.jpg')"})

    $.post('https://jpr-newphone/SetBackground', JSON.stringify({
        background: JPR.Phone.Settings.Background,
    }))

});

$(document).on('click', '#bk4', function(e){
    e.preventDefault();

    JPR.Phone.Settings.Background = "https://imgur.com/Kk7hpQE.jpg"; 

    JPR.Phone.Notifications.Add("settings.png", "CFG", "Background 4 applied!", "#969695")
    JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
    $(".phone-background").css({"background-image":"url('https://imgur.com/Kk7hpQE.jpg')"})

    $.post('https://jpr-newphone/SetBackground', JSON.stringify({
        background: JPR.Phone.Settings.Background,
    }))

});

$(document).on('click', '#bk5', function(e){
    e.preventDefault();

    JPR.Phone.Settings.Background = "https://imgur.com/1MMLU4Z.jpg"; 

    JPR.Phone.Notifications.Add("settings.png", "CFG", "Background 5 applied!", "#969695")
    JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
    $(".phone-background").css({"background-image":"url('https://imgur.com/1MMLU4Z.jpg')"})

    $.post('https://jpr-newphone/SetBackground', JSON.stringify({
        background: JPR.Phone.Settings.Background,
    }))

});

$(document).on('click', '#bk6', function(e){
    e.preventDefault();

    JPR.Phone.Settings.Background = "https://imgur.com/XW5FJ6t.jpg"; 

    JPR.Phone.Notifications.Add("settings.png", "CFG", "Background 6 applied!", "#969695")
    JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
    $(".phone-background").css({"background-image":"url('https://imgur.com/XW5FJ6t.jpg')"})

    $.post('https://jpr-newphone/SetBackground', JSON.stringify({
        background: JPR.Phone.Settings.Background,
    }))

});

$(document).on('click', '#bk7', function(e){
    e.preventDefault();

    JPR.Phone.Settings.Background = "https://imgur.com/x4R5LOT.jpg"; 

    JPR.Phone.Notifications.Add("settings.png", "CFG", "Background 7 applied!", "#969695")
    JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
    $(".phone-background").css({"background-image":"url('https://imgur.com/x4R5LOT.jpg')"})

    $.post('https://jpr-newphone/SetBackground', JSON.stringify({
        background: JPR.Phone.Settings.Background,
    }))

});

$(document).on('click', '#bk8', function(e){
    e.preventDefault();

    JPR.Phone.Settings.Background = "https://imgur.com/Scds02p.jpg"; 

    JPR.Phone.Notifications.Add("settings.png", "CFG", "Background 8 applied!", "#969695")
    JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
    $(".phone-background").css({"background-image":"url('https://imgur.com/Scds02p.jpg')"})

    $.post('https://jpr-newphone/SetBackground', JSON.stringify({
        background: JPR.Phone.Settings.Background,
    }))

});

$(document).on('click', '#bk9', function(e){
    e.preventDefault();

    JPR.Phone.Settings.Background = "https://imgur.com/cBxiok6.jpg"; 

    JPR.Phone.Notifications.Add("settings.png", "CFG", "Background 9 applied!", "#969695")
    JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
    $(".phone-background").css({"background-image":"url('https://imgur.com/cBxiok6.jpg')"})

    $.post('https://jpr-newphone/SetBackground', JSON.stringify({
        background: JPR.Phone.Settings.Background,
    }))

});

JPR.Phone.Functions.IsBackgroundCustom = function() {
    var retval = true;
    $.each(JPR.Phone.Settings.Backgrounds, function(i, background){
        if (JPR.Phone.Settings.Background == i) {
            retval = false;
        }
    });
    return retval
}

$(document).on('click', '#background-option', function(e){
    e.preventDefault();
    PressedBackground = $(this).data('background');
    PressedBackgroundObject = this;
    OldBackground = $(this).parent().find('.background-option-current');
    IsChecked = $(this).find('.background-option-current');

    if (IsChecked.length === 0) {
        JPR.Phone.Animations.TopSlideDown(".background-custom", 200, 13);
    }
});

$(document).on('click', '#accept-custom-background', function(e){
    e.preventDefault();

    JPR.Phone.Settings.Background = $(".custom-background-input").val();

    JPR.Phone.Notifications.Add("settings.png", "CFG", "Custom applied background!", "#969695")
    JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
    $(".phone-background").css({"background-image":"url('"+$(".custom-background-input").val()+"')"})

    $.post('https://jpr-newphone/SetBackground', JSON.stringify({
        background: JPR.Phone.Settings.Background,
    }))
});

$(document).on('click', '#cancel-custom-background', function(e){
    e.preventDefault();

    JPR.Phone.Animations.TopSlideUp(".background-custom", 200, -23);
});

// Profile Picture

var PressedProfilePicture = null;
var PressedProfilePictureObject = null;
var OldProfilePicture = null;
var ProfilePictureIsChecked = null;

$(document).on('click', '#accept-profilepicture', function(e){
    e.preventDefault();
    var ProfilePicture = JPR.Phone.Data.MetaData.profilepicture;
    if (ProfilePicture === "default") {
        JPR.Phone.Notifications.Add("settings.png", "CFG", "Applied!", "#969695")
        JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="./img/default.png">');
        $("[data-settingstab='contautilizador']").find('.settings-tab-icon3').html('<img src="./img/default.png">');
    } else {
        JPR.Phone.Notifications.Add("settings.png", "CFG", "Applied!", "#969695")
        JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="'+ProfilePicture+'">');
        $("[data-settingstab='contautilizador']").find('.settings-tab-icon3').html('<img src="'+ProfilePicture+'">');
    }
    $.post('https://jpr-newphone/UpdateProfilePicture', JSON.stringify({
        profilepicture: ProfilePicture,
    }));
});

$(document).on('click', '#accept-custom-profilepicture', function(e){
    e.preventDefault();
    JPR.Phone.Data.MetaData.profilepicture = $(".custom-profilepicture-input").val();
    $(OldProfilePicture).fadeOut(50, function(){
        $(OldProfilePicture).remove();
    });
    //JPR.Phone.Animations.TopSlideUp(".profilepicture-custom", 200, -23);
    $(".profilepicture-custom").fadeOut(200, function(){
        $(".profilepicture-custom").css({"display":"none"});
    });

    var ProfilePicture = JPR.Phone.Data.MetaData.profilepicture;
    if (ProfilePicture === "default") {
        JPR.Phone.Notifications.Add("settings.png", "CFG", "Applied!", "#969695")
        JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="./img/default.png">');
        $("[data-settingstab='contautilizador']").find('.settings-tab-icon3').html('<img src="./img/default.png">');
    } else {
        JPR.Phone.Notifications.Add("settings.png", "CFG", "Applied!", "#969695")
        JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="'+ProfilePicture+'">');
        $("[data-settingstab='contautilizador']").find('.settings-tab-icon3').html('<img src="'+ProfilePicture+'">');
    }
    $.post('https://jpr-newphone/UpdateProfilePicture', JSON.stringify({
        profilepicture: ProfilePicture,
    }));
});

$(document).on('click', '#profilepicture-option', function(e){
    e.preventDefault();
    PressedProfilePicture = $(this).data('profilepicture');
    PressedProfilePictureObject = this;
    OldProfilePicture = $(this).parent().find('.profilepicture-option-current');
    ProfilePictureIsChecked = $(this).find('.profilepicture-option-current');
    if (ProfilePictureIsChecked.length === 0) {
        //JPR.Phone.Animations.TopSlideDown(".profilepicture-custom", 200, 13);  
        $(".profilepicture-custom").css({"display":"block"});
    }
});

$(document).on('click', '#cancel-profilepicture', function(e){
    e.preventDefault();
    JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
});


$(document).on('click', '#cancel-custom-profilepicture', function(e){
    e.preventDefault();
    JPR.Phone.Animations.TopSlideUp(".settings-"+JPR.Phone.Settings.OpenedTab+"-tab", 200, -100);
    //JPR.Phone.Animations.TopSlideUp(".profilepicture-custom", 200, -23);
    $(".profilepicture-custom").fadeOut(200, function(){
        $(".profilepicture-custom").css({"display":"none"});
    });
    
});
