JPR = {}
JPR.Phone = {}
JPR.Screen = {}
JPR.Phone.Functions = {}
JPR.Phone.Animations = {}
JPR.Phone.Notifications = {}
JPR.Phone.ContactColors = {
    0: "#9b59b6",
    1: "#3498db",
    2: "#e67e22",
    3: "#e74c3c",
    4: "#1abc9c",
    5: "#9c88ff",
}

JPR.Phone.Data = {
    currentApplication: null,
    PlayerData: {},
    Applications: {},
    IsOpen: false,
    CallActive: false,
    MetaData: {},
    PlayerJob: {},
    AnonymousCall: false,
}

JPR.Phone.Data.MaxSlots = 16;

OpenedChatData = {
    number: null,
}

var CanOpenApp = true;
var up = false;
var grupos = false;
var contadorchavescasas = 0;
var ecrabloq = true;
var eumanuncio = false;
var emojisnowpp = false;
var emojisnogaleria = false;
var emojisnotwt = false;
var emojisnoolx = false;

function IsAppJobBlocked(joblist, myjob) {
    var retval = false;
    if (joblist.length > 0) {
        $.each(joblist, function(i, job){
            if (job == myjob && JPR.Phone.Data.PlayerData.job.onduty) {
                retval = true;
            }
        });
    }
    return retval;
}

JPR.Phone.Functions.SetupApplications = function(data) {
    JPR.Phone.Data.Applications = data.applications;

    var i;
    for (i = 1; i <= JPR.Phone.Data.MaxSlots; i++) {
        var applicationSlot = $(".phone-applications").find('[data-appslot="'+i+'"]');
        $(applicationSlot).html("");
        $(applicationSlot).css({
            "background-color":"none"
        });
        $(applicationSlot).prop('title', "");
        $(applicationSlot).removeData('app');
        $(applicationSlot).removeData('placement');
    }

    $.each(data.applications, function(i, app){
        var applicationSlot = $(".phone-applications").find('[data-appslot="'+app.slot+'"]');
        var blockedapp = IsAppJobBlocked(app.blockedjobs, JPR.Phone.Data.PlayerJob.name)
        

        if ((!app.job || app.job === JPR.Phone.Data.PlayerJob.name) && !blockedapp) {
            $(applicationSlot).css({"background-color":app.color});
            //var icon = '<i class="ApplicationIcon '+app.icon+'" style="'+app.style+'"></i>';
            var icon =  '<img src="./img/apps2/'+app.icon+'" class="fotos-icon" style="background-color: transparent !important;">';
            if (app.slot == "1" || app.slot == "2" || app.slot == "3" || app.slot == "4") {
                $(applicationSlot).html(icon+'<div class="app-unread-alerts">0</div>');
                $(applicationSlot).css({"box-shadow":"rgba(0, 0, 0, 0.35) 0px 5px 15px"});
                //$(applicationSlot).html(app.tooltipText);
                $(applicationSlot).data('app', app.app);
            } else {
                $(applicationSlot).html(icon+'<div class="app-unread-alerts">0</div>'+'<br><a class="fontetextos">'+app.tooltipText+'</a>');
                //$(applicationSlot).html(app.tooltipText);
                $(applicationSlot).css({"box-shadow":"rgba(0, 0, 0, 0.35) 0px 5px 15px"});
                $(applicationSlot).data('app', app.app);
            }

            

            if (app.tooltipPos !== undefined) {
                $(applicationSlot).data('placement', app.tooltipPos)
            }
        }
        
        if (IsAppJobBlocked(app.blockedjobs, JPR.Phone.Data.PlayerJob.name)) {
            //console.log(JPR.Phone.Data.PlayerJob.name)
            var applicationSlotTestes = $(".phone-applications").find('[data-appslot="'+app.slot+'"]');
            $(applicationSlotTestes).css({"display":"none"});
        } else {
            var applicationSlotTestes = $(".phone-applications").find('[data-appslot="'+app.slot+'"]');
            $(applicationSlotTestes).css({"display":"block"});
            if (app.app == "meos") {
                if (app.job == JPR.Phone.Data.PlayerJob.name) {
                    $(applicationSlotTestes).css({"display":"block"});
                } else {
                    $(applicationSlotTestes).css({"display":"none"});
                }
            }
        }

        
    });

    $('[data-toggle="tooltip"]').tooltip();
}

JPR.Phone.Functions.SetupAppWarnings = function(AppData) {
    $.each(AppData, function(i, app){
        var AppObject = $(".phone-applications").find("[data-appslot='"+app.slot+"']").find('.app-unread-alerts');

        if (app.Alerts > 0) {
            $(AppObject).html(app.Alerts);
            $(AppObject).css({"display":"block"});
        } else {
            $(AppObject).css({"display":"none"});
        }
    });
}

JPR.Phone.Functions.IsAppHeaderAllowed = function(app) {
    var retval = true;
    $.each(Config.HeaderDisabledApps, function(i, blocked){
        if (app == blocked) {
            retval = false;
        }
    });
    return retval;
}

$(document).on('click', '.phone-application', function(e){
    e.preventDefault();
    var PressedApplication = $(this).data('app');
    var AppObject = $("."+PressedApplication+"-app");

    if (PressedApplication == "meos") {
        if (AppObject.length !== 0) {
            if (CanOpenApp) {
                if (JPR.Phone.Data.PlayerJob.name == "police") {
                    if (JPR.Phone.Data.currentApplication == null) {
                        JPR.Phone.Animations.TopSlideDown('.phone-application-container', 300, 0);
                        JPR.Phone.Functions.ToggleApp(PressedApplication, "block");

                        if (JPR.Phone.Functions.IsAppHeaderAllowed(PressedApplication)) {
                            JPR.Phone.Functions.HeaderTextColor("black", 300);
                        }

                        JPR.Phone.Data.currentApplication = PressedApplication;

                        if (PressedApplication == "meos") {
                            SetupMeosHome();
                        } 

                        
                    }
                } else {
                    JPR.Phone.Notifications.Add("settings.png", "CFG", "You can't use this!")
                }
            }
        } else {
            if (PressedApplication != null){
                JPR.Phone.Notifications.Add("settings.png", "CFG", JPR.Phone.Data.Applications[PressedApplication].tooltipText+" it's unavailable!")
            }
        }
    } else {
        if (AppObject.length !== 0) {
            if (CanOpenApp) {
                if (JPR.Phone.Data.currentApplication == null) {
                    JPR.Phone.Animations.TopSlideDown('.phone-application-container', 300, 0);
                    JPR.Phone.Functions.ToggleApp(PressedApplication, "block");

                    if (JPR.Phone.Functions.IsAppHeaderAllowed(PressedApplication)) {
                        JPR.Phone.Functions.HeaderTextColor("black", 300);
                    }

                    JPR.Phone.Data.currentApplication = PressedApplication;

                    if (PressedApplication == "settings") {
                        $(".phone-header").css({"color":"black"});
                        $(".phone-home-button").css({"background-color":"rgba(23, 23, 23, 90%)"});
                        $(".phone-application-container").css({"background-color":"rgb(65, 65, 65)"});
                        $("#myPhoneNumber").text(JPR.Phone.Data.PlayerData.charinfo.phone);
                        $("#mySerialNumber").text("5GRP-" + JPR.Phone.Data.PlayerData.metadata["phonedata"].SerialNumber);
                        $("#myIbanNumber").text(JPR.Phone.Data.PlayerData.charinfo.account);
                    } else if (PressedApplication == "twitter") {
                        $.post('https://jpr-newphone/GetMentionedTweets', JSON.stringify({}), function(MentionedTweets){
                            JPR.Phone.Notifications.LoadMentionedTweets(MentionedTweets)
                        })
                        $.post('https://jpr-newphone/GetHashtags', JSON.stringify({}), function(Hashtags){
                            JPR.Phone.Notifications.LoadHashtags(Hashtags)
                        })
                        if (JPR.Phone.Data.IsOpen) {
                            $.post('https://jpr-newphone/GetTweets', JSON.stringify({}), function(Tweets){
                                JPR.Phone.Notifications.LoadTweets(Tweets);
                            });
                        }
                    } else if (PressedApplication == "bank") {
                        $(".phone-header").css({"color":"black"});
                        $(".phone-home-button").css({"background-color":"rgba(23, 23, 23, 90%)"});
                        JPR.Phone.Functions.DoBankOpen();
                        $.post('https://jpr-newphone/GetBankContacts', JSON.stringify({}), function(contacts){
                            JPR.Phone.Functions.LoadContactsWithNumber(contacts);
                        });
                        $.post('https://jpr-newphone/GetInvoices', JSON.stringify({}), function(invoices){
                            JPR.Phone.Functions.LoadBankInvoices(invoices);
                        });
                    } else if (PressedApplication == "whatsapp") {
                        $(".phone-header").css({"color":"white"});
                        $(".phone-home-button").css({"background-color":"rgba(23, 23, 23, 90%)"});
                        //$.post("https://jpr-newphone/Atualizar", JSON.stringify({}));
                       
                        AtualizarVars(false);
                        if (grupo == false) {
                            $.post('https://jpr-newphone/GetWhatsappChats', JSON.stringify({}), function(chats){
                                JPR.Phone.Functions.LoadWhatsappChats(chats);
                            });
                        } else {
                            $.post('https://jpr-newphone/GetWhatsappGrupos', JSON.stringify({}), function(chats){
                                JPR.Phone.Functions.LoadWhatsappChats(chats);
                            });
                        }
                         
                        
                    } else if (PressedApplication == "phone") {
                        $(".phone-header").css({"color":"black"});
                        $(".phone-home-button").css({"background-color":"rgba(23, 23, 23, 90%)"});
                        $.post('https://jpr-newphone/GetMissedCalls', JSON.stringify({}), function(recent){
                            JPR.Phone.Functions.SetupRecentCalls(recent);
                        });
                        $.post('https://jpr-newphone/GetSuggestedContacts', JSON.stringify({}), function(suggested){
                            JPR.Phone.Functions.SetupSuggestedContacts(suggested);
                        });
                        $.post('https://jpr-newphone/ClearGeneralAlerts', JSON.stringify({
                            app: "phone"
                        }));
                    } else if (PressedApplication == "mail") {
                        $(".phone-header").css({"color":"black"});
                        $(".phone-home-button").css({"background-color":"rgba(23, 23, 23, 90%)"});
                        $.post('https://jpr-newphone/GetMails', JSON.stringify({}), function(mails){
                            JPR.Phone.Functions.SetupMails(mails);
                        });
                        $.post('https://jpr-newphone/ClearGeneralAlerts', JSON.stringify({
                            app: "mail"
                        }));
                    } else if (PressedApplication == "advert") {
                        eumanuncio = true;
                        $.post('https://jpr-newphone/LoadAdverts', JSON.stringify({}), function(Adverts){
                            JPR.Phone.Functions.RefreshAdverts(Adverts);
                        })
                    } else if (PressedApplication == "garage") {
                        $(".phone-home-button").css({"background-color":"rgba(23, 23, 23, 90%)"});
                        $.post('https://jpr-newphone/SetupGarageVehicles', JSON.stringify({}), function(Vehicles){
                            SetupGarageVehicles(Vehicles);
                        })
                    } else if (PressedApplication == "crypto") {
                        $.post('https://jpr-newphone/GetCryptoData', JSON.stringify({
                            crypto: "qbit",
                        }), function(CryptoData){
                            SetupCryptoData(CryptoData);
                        })

                        $.post('https://jpr-newphone/GetCryptoTransactions', JSON.stringify({}), function(data){
                            RefreshCryptoTransactions(data);
                        })
                    
                    } else if (PressedApplication == "racing") {
                        $.post('https://jpr-newphone/GetAvailableRaces', JSON.stringify({}), function(Races){
                            SetupRaces(Races);
                        });
                    } else if (PressedApplication == "houses") {
                        $.post('https://jpr-newphone/GetPlayerHouses', JSON.stringify({}), function(Houses){
                            SetupPlayerHouses(Houses);
                        });
                        $.post('https://jpr-newphone/GetPlayerKeys', JSON.stringify({}), function(Keys){
                            $(".house-app-mykeys-container").html("");
                            contadorchavescasas = Keys.length;
                            if (Keys.length > 0) {
                                $.each(Keys, function(i, key){
                                    //var elem = '<div class="mykeys-key" id="keyid-'+i+'"><span class="mykeys-key-label">'  '</span> <span class="mykeys-key-sub"></span> </div>';
                                    var elem = '<div class="mykeys-key" id="keyid-' + i + '"><div class="myhouse-house-icon"><i class="fas fa-key fa-shake" style="--fa-animation-duration: 3s;"></i></div> <div class="myhouse-house-titel">' + key.HouseData.adress + '</div> <div class="myhouse-house-details">' + "See on GPS!" + '</div> </div>';
                                    $(".house-app-mykeys-container").append(elem);
                                    $("#keyid-"+i).data('KeyData', key);
                                });
                            } else {
                                var elem = '<div class="myhouses-house" id="keyid-' + "1" + '"><div class="myhouse-house-icon"><i class="fas fa-key fa-shake" style="--fa-animation-duration: 3s;"></i></div> <div class="myhouse-house-titel">' + '</div> <div class="myhouse-house-details">' + "Get in touch with a real estate agent!" + '</div> </div>';
                                $(".house-app-mykeys-container").append(elem);
                                $("#keyid-"+"1").data('KeyData', "jarda");
                            }
                        });
                    } else if (PressedApplication == "meos") {
                        if (JPR.Phone.Data.PlayerJob.name == "police") {
                            SetupMeosHome();
                        } else {
                            JPR.Phone.Notifications.Add("settings.png", "CFG", "You can't use this!")
                        }
                    } else if (PressedApplication == "lawyers") {
                        $(".phone-header").css({"color":"black"});
                        $(".phone-home-button").css({"background-color":"rgba(23, 23, 23, 90%)"});
                        $.post('https://jpr-newphone/GetCurrentLawyers', JSON.stringify({}), function(data){
                            SetupLawyers(data);
                        });
                    } else if (PressedApplication == "store") {
                        $(".phone-header").css({"color":"black"});
                        $(".phone-home-button").css({"background-color":"rgba(23, 23, 23, 90%)"});
                        $.post('https://jpr-newphone/SetupStoreApps', JSON.stringify({}), function(data){
                            SetupAppstore(data);
                        });
                    } else if (PressedApplication == "trucker") {
                        $.post('https://jpr-newphone/GetTruckerData', JSON.stringify({}), function(data){
                            SetupTruckerInfo(data);
                        });
                    }
                    else if (PressedApplication == "gallery") {
                        $(".phone-header").css({"color":"black"});
                        $(".phone-home-button").css({"background-color":"rgba(23, 23, 23, 90%)"});
                        edagaleria = true; 
                        $.post('https://jpr-newphone/GetGalleryData', JSON.stringify({}), function(data){
                            setUpGalleryData(data);
                        });
                    }
                    else if (PressedApplication == "camera") {
                        $.post('https://jpr-newphone/TakePhoto', JSON.stringify({}),function(url){
                            setUpCameraApp(url)
                        })
                        JPR.Phone.Functions.Close();
                    }
                    else if (PressedApplication == "jogos") {
                        if (document.getElementById('if5')) {
                            const element = document.getElementById('if5');
                            element.remove();
                        }
                        var JogosDiv = '<iframe name="I5" id="if5" src="https://flappybird.ee/" class="jogos-jogar" ></iframe>';
                        $(".jogos-app").append(JogosDiv);
                    }

                    
                }
            }
        } else {
            if (PressedApplication != null){
                JPR.Phone.Notifications.Add("settings.png", "CFG", JPR.Phone.Data.Applications[PressedApplication].tooltipText+" it's unavailable!")
            }
        }
    }
});

$(document).on('click', '.mykeys-key', function(e){
    e.preventDefault();

    if (contadorchavescasas == 0) {
        JPR.Phone.Notifications.Add("home.png", "Houses", "To interact, buy a house!", "#e09f3c", 1750);
    } else {
        var KeyData = $(this).data('KeyData');

        $.post('https://jpr-newphone/SetHouseLocation', JSON.stringify({
            HouseData: KeyData
        }))
        JPR.Phone.Notifications.Add("home.png", "Houses", "Tagged in GPS", "#e09f3c", 2500);
    }
});

$(document).on('click', '.phone-home-container', function(event){
    event.preventDefault();

    var estaemchat = false;
    grupo = false;
    $.post("https://jpr-newphone/evitarnotifsnochat", JSON.stringify({estaemchat}));
    if (document.getElementById('if5')) {
        const element = document.getElementById('if5');
        element.remove();
    }
    if (document.getElementById('if6')) {
        const element = document.getElementById('if6');
        element.remove();
    }
    $(".phone-application-container").css({"background-color":"transparent"});
    $("#teste3").removeClass()
    $("#teste3").addClass('fa-solid fa-person')
    $("#teste2").removeClass();
    $("#teste2").addClass('fa-solid fa-people-group')
    $(".gifs-fundo").css({"display":"none"});        
    gifsabertos = false;
    gifsabertosolx = false;
    gifsabertosgaleria = false;
    $(".gifs-fundo-olx").css({"display":"none"});
    $(".gifs-fundo-galeria").css({"display":"none"});
    emojisnowpp = false;
    emojisnotwt = false;
    emojisnoolx = false;
    emojisnogaleria = false;
    if (usouheader == true) {
        JPR.Phone.Animations.TopSlideUp(".aba-ajustes", 450, -120);
        usouheader = false;
    } else {
        if (JPR.Phone.Data.currentApplication === null) {
            eumanuncio = false;
            edagaleria = false; 
            JPR.Phone.Functions.Close();
            $("#carregamento").removeClass();
            $("#carregamento").addClass('fa-solid fa-circle-notch fa-spin');
            $("#cadeado").removeClass();
            $("#cadeado").addClass('fa-solid fa-lock')
            $("#desbloqueio").html('')
            $(".ecra-bloqueio").css({"display":"block"});
            ecrabloq = true;
            $(".phone-currentcall-container").css({"top":"20vh"});
            carregou = false;
            $(".ecra-tralha").css({"display":"none"});
            $(".ecra-tralha2").css({"display":"none"});
            $(".phone-footer").css({"display":"block"});
            tralhaaberta = false;
            $(".ecra-tralha").css({"background-color":"rgba(232, 232, 232, 0.9)"});
        } else {
            edagaleria = false; 
            JPR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
            JPR.Phone.Animations.TopSlideUp('.'+JPR.Phone.Data.currentApplication+"-app", 400, -160);
            CanOpenApp = false;
            setTimeout(function(){
                JPR.Phone.Functions.ToggleApp(JPR.Phone.Data.currentApplication, "none");
                CanOpenApp = true;
            }, 400)
            JPR.Phone.Functions.HeaderTextColor("white", 300);

            if (JPR.Phone.Data.currentApplication == "whatsapp") {
                if (OpenedChatData.number !== null) {
                    setTimeout(function(){
                        $(".whatsapp-chats").css({"display":"block"});
                        $(".whatsapp-chats").animate({
                            left: 0+"vh"
                        }, 1);
                        $(".whatsapp-openedchat").animate({
                            left: -30+"vh"
                        }, 1, function(){
                            $(".whatsapp-openedchat").css({"display":"none"});
                        });
                        OpenedChatPicture = null;
                        OpenedChatData.number = null;
                    }, 450);
                }
            } else if (JPR.Phone.Data.currentApplication == "bank") {
                if (CurrentTab == "invoices") {
                    setTimeout(function(){
                        $(".bank-app-invoices").animate({"left": "30vh"});
                        $(".bank-app-invoices").css({"display":"none"})
                        $(".bank-app-accounts").css({"display":"block"})
                        $(".bank-app-accounts").css({"left": "0vh"});

                        var InvoicesObjectBank = $(".bank-app-header").find('[data-headertype="invoices"]');
                        var HomeObjectBank = $(".bank-app-header").find('[data-headertype="accounts"]');

                        $(InvoicesObjectBank).removeClass('bank-app-header-button-selected');
                        $(HomeObjectBank).addClass('bank-app-header-button-selected');

                        CurrentTab = "accounts";
                    }, 400)
                }
            } else if (JPR.Phone.Data.currentApplication == "meos") {
                if (JPR.Phone.Data.PlayerJob.name == "police") {
                    $(".meos-alert-new").remove();
                    setTimeout(function(){
                        $(".meos-recent-alert").removeClass("noodknop");
                        $(".meos-recent-alert").css({"background-color":"#004682"});
                    }, 400)
                }
            }
            $(".phone-header").css({"color":"white"});
            $(".phone-home-button").css({"background-color":"rgba(232, 232, 232, 0.9)"});
            JPR.Phone.Data.currentApplication = null;
        }
    }
});

JPR.Phone.Functions.Open = function(data) {
    JPR.Phone.Animations.BottomSlideUp('.container', 300, 0);
    JPR.Phone.Notifications.LoadTweets(data.Tweets);
    JPR.Phone.Data.IsOpen = true;
}

JPR.Phone.Functions.ToggleApp = function(app, show) {
    $("."+app+"-app").css({"display":show});
}

JPR.Phone.Functions.Close = function() {

    if (JPR.Phone.Data.currentApplication == "whatsapp") {
        setTimeout(function(){
            JPR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
            JPR.Phone.Animations.TopSlideUp('.'+JPR.Phone.Data.currentApplication+"-app", 400, -160);
            $(".whatsapp-app").css({"display":"none"});
            JPR.Phone.Functions.HeaderTextColor("white", 300);

            if (OpenedChatData.number !== null) {
                setTimeout(function(){
                    $(".whatsapp-chats").css({"display":"block"});
                    $(".whatsapp-chats").animate({
                        left: 0+"vh"
                    }, 1);
                    $(".whatsapp-openedchat").animate({
                        left: -30+"vh"
                    }, 1, function(){
                        $(".whatsapp-openedchat").css({"display":"none"});
                    });
                    OpenedChatData.number = null;
                }, 450);
            }
            OpenedChatPicture = null;
            JPR.Phone.Data.currentApplication = null;
        }, 500)
    } else if (JPR.Phone.Data.currentApplication == "meos") {
        if (JPR.Phone.Data.PlayerJob.name == "police") {
            $(".meos-alert-new").remove();
            $(".meos-recent-alert").removeClass("noodknop");
            $(".meos-recent-alert").css({"background-color":"#004682"});
        }
    }

    JPR.Phone.Animations.BottomSlideDown('.container', 300, -70);
    $.post('https://jpr-newphone/Close');
    JPR.Phone.Data.IsOpen = false;
}

JPR.Phone.Functions.HeaderTextColor = function(newColor, Timeout) {
    $(".phone-header").animate({color: newColor}, Timeout);
}

var usouheader = false;
$(document).on('click', '.phone-header', function(e){
    e.preventDefault();
 
    if (usouheader == false) {
        JPR.Phone.Animations.TopSlideDown(".aba-ajustes", 450, 0);
        ///setTimeout(function(){
        //    $(".aba-ajustes").css({"background-color":"rgba(181, 181, 181, 0.1)"});
        //},50);
        var CurrentDate = new Date();
        $(".menuinteracao-1").html(monthNames[CurrentDate.getMonth()]);
        $(".menuinteracao-1a").html("Day: "+CurrentDate.getDate());
        usouheader = true;

        $.post('https://jpr-newphone/TemNotificacoes2', JSON.stringify({}), function(data){
            if (data.notifsativas2 == 1) {
                $("#mudar-notifs").removeClass('fa-bell-slash');
                $("#mudar-notifs").removeClass('fa-bell');
                $("#mudar-notifs").addClass('fa-bell');
                $(".menuinteracao-19").css({"background":"rgba(20, 20, 20, 0.77)"});
            } else {
                $("#mudar-notifs").removeClass('fa-bell-slash');
                $("#mudar-notifs").removeClass('fa-bell');
                $("#mudar-notifs").addClass('fa-bell-slash');
                $(".menuinteracao-19").css({"background":"rgb(203, 183, 35)"});
            }
        })
    } else {
        JPR.Phone.Animations.TopSlideUp(".aba-ajustes", 450, -120);
        $(".menuinteracao-16").css({"display":"none"});
        //$(".aba-ajustes").css({"background-color":"transparent"});
        usouheader = false;
    }
});

var usouaviao = false;
$(document).on('click', '#ligar-aviao', function(e){
    e.preventDefault();
 
    if (usouaviao == false) {
        $(".menuinteracao-4").css({"background-color":"rgb(203, 183, 35)"});
        usouaviao = true;
        $(".menuinteracao-9").css({"background-color":"rgba(86, 86, 86, 0.6)"});
        usoublue = true;
        $(".menuinteracao-8").css({"background-color":"rgba(86, 86, 86, 0.6)"});
        usouwifi = true;
        $(".menuinteracao-10").css({"background-color":"rgba(86, 86, 86, 0.6)"});
        usoutower = true;
        var checkBoxes = $(".numberrec-box3");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        $("#phone-signal2").removeClass('fa-wifi');
        $("#phone-signal").removeClass('fa-signal');
        $("#phone-signal2").addClass('fa-plane');
    } else {
        var checkBoxes = $(".numberrec-box3");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        $(".menuinteracao-4").css({"background-color":"rgba(86, 86, 86, 0.6)"});
        $("#phone-signal2").removeClass('fa-plane');
        $("#phone-signal2").addClass('fa-wifi');
        $("#phone-signal").addClass('fa-signal');
        usouaviao = false;
    }
});

var usouwifi = false;
$(document).on('click', '#ligar-wifi', function(e){
    e.preventDefault();
 
    if (usouwifi == false) {
        $(".menuinteracao-8").css({"background-color":"rgba(86, 86, 86, 0.6)"});
        var checkBoxes = $(".numberrec-box6");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        usouwifi = true;
    } else {
        var checkBoxes = $(".numberrec-box6");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        $(".menuinteracao-8").css({"background-color":"rgb(41, 121, 232)"});
        usouwifi = false;
        $(".menuinteracao-4").css({"background-color":"rgba(86, 86, 86, 0.6)"});
        usouaviao = false;
        $("#phone-signal2").removeClass('fa-plane');
        $("#phone-signal2").addClass('fa-wifi');
        $("#phone-signal").addClass('fa-signal');
    }
});

var usoublue = false;
$(document).on('click', '#ligar-blue', function(e){
    e.preventDefault();
    
    if (usoublue == false) {
        $(".menuinteracao-9").css({"background-color":"rgba(86, 86, 86, 0.6)"});
        var checkBoxes = $(".numberrec-box2");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        usoublue = true;
    } else {
        $(".menuinteracao-9").css({"background-color":"rgb(41, 121, 232)"});
        usoublue = false;
        $(".menuinteracao-4").css({"background-color":"rgba(86, 86, 86, 0.6)"});
        usouaviao = false;
        var checkBoxes = $(".numberrec-box2");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        $("#phone-signal2").removeClass('fa-plane');
        $("#phone-signal2").addClass('fa-wifi');
        $("#phone-signal").addClass('fa-signal');
    }
});

$(document).on('click', '#ativar-calculadora', function(e){
    e.preventDefault();
    
    if (JPR.Phone.Data.currentApplication == null) {
        JPR.Phone.Animations.TopSlideUp(".aba-ajustes", 450, -120);
        $(".menuinteracao-16").css({"display":"none"});
        JPR.Phone.Animations.TopSlideDown('.phone-application-container', 300, 0);
        JPR.Phone.Functions.ToggleApp("calculator", "block");
        CanOpenApp = true;
        usouheader = false;
        JPR.Phone.Data.currentApplication = "calculator";
    } else {
        JPR.Phone.Notifications.Add("settings.png", "CFG", "Close the application!");
    }
});

var usoutower = false;
$(document).on('click', '#ligar-tower', function(e){
    e.preventDefault();

    if (usoutower == false) {
       $(".menuinteracao-10").css({"background-color":"rgba(86, 86, 86, 0.6)"});
       var checkBoxes = $(".numberrec-box7");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
       usoutower = true;
    } else {
        var checkBoxes = $(".numberrec-box7");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        $(".menuinteracao-10").css({"background-color":"rgb(73, 200, 44)"});
        usoutower = false;
        $(".menuinteracao-4").css({"background-color":"rgba(86, 86, 86, 0.6)"});
        usouaviao = false;
        $("#phone-signal2").removeClass('fa-plane');
        $("#phone-signal2").addClass('fa-wifi');
        $("#phone-signal").addClass('fa-signal');
    }
});

$(document).on('click', '#abrir-camara', function(e){
    e.preventDefault();

    $.post('https://jpr-newphone/TakePhoto', JSON.stringify({}),function(url){
        setUpCameraApp(url)
    })
    JPR.Phone.Functions.Close();
});

var carregou = false;
$(document).on('click', '#botaocarregar', function(e){
    e.preventDefault();
    

    if (ecrabloq == false) {
        $.post('https://jpr-newphone/DesbloquearSom', JSON.stringify({}));
        $(".ecra-bloqueio").css({"display":"none"});
        $(".ecra-tralha").css({"display":"block"});
        $(".phone-applications").css({"display":"block"});
        $(".phone-application").css({"width":"3vh"});
        $(".phone-application").css({"height":"3vh"});
        $(".fotos-icon").css({"width":"2vh"});
        $(".phone-application").animate({
            "width":"4.8vh",
            "height":"4.8vh",
        }, 350);
        $(".fotos-icon").animate({
            "width":"4.8vh",
        }, 350);
        $(".phone-currentcall-container").css({"top":"33.5vh"});
        carregou = true;
    }
});

var tralhaaberta = false;
$(document).on('click', '#cenas-tralha', function(e){
    e.preventDefault();
    
    if (carregou == false) {
        JPR.Phone.Notifications.Add("settings.png", "CFG", "Unlock your cell phone!");
    } else {
        if (tralhaaberta == false) {
            if (JPR.Phone.Data.currentApplication == null) {
                $(".ecra-bloqueio").css({"display":"none"});
                $(".phone-applications").css({"display":"none"});
                $(".ecra-tralha").css({"background-color":"#949191"});
                $(".ecra-tralha2").css({"width":"3%"});
                if (document.getElementById('if6')) {
                    const element = document.getElementById('if6');
                    element.remove();
                }
                //var TralhaDiv = '<iframe name="I6" id="if6" src="https://www.bing.com/news" style="width: 100%; height: 95%; margin-top: 3vh;" ></iframe>';
                $(".ecra-tralha2").append(TralhaDiv);
                $(".ecra-tralha2").css({"height":"3%"});
                $(".ecra-tralha2").css({"display":"block"});
                $(".ecra-tralha2").animate({
                    "width":"100%",
                    "height":"100%"
                }, 350);
                $(".phone-footer").css({"display":"none"});
                tralhaaberta = true;
            } else {
                JPR.Phone.Notifications.Add("settings.png", "CFG", "Do you have an open application?!");
            }
        } else {
            
            
            $(".ecra-tralha").css({"background-color":"rgba(232, 232, 232, 0.9)"});
            $(".ecra-tralha2").css({"width":"100%"});
            $(".ecra-tralha2").css({"height":"100%"});
            $(".ecra-tralha2").animate({
                "width":"3%",
                "height":"3%"
            }, 350);
            setTimeout(function(){
                $(".ecra-tralha2").css({"display":"none"});
                $(".ecra-bloqueio").css({"display":"none"});
                $(".phone-applications").css({"display":"block"});
                $(".phone-footer").css({"display":"block"});
                
            },350);

            tralhaaberta = false;
        }
        
    }
});

//var modoescuro = false;
//$(document).on('click', '#ativar-escuro', function(e){
    //e.preventDefault();

    //if (modoescuro == false) {
       // $(".menuinteracao-18").css({"background":"rgba(20, 20, 20, 0.97)"});
      //  $(".modo-escuro-basico").css({"color":"rgba(41, 121, 232, 0.75)"});

        //// galeria
       // $(".gallery-app").css({"background":"rgba(23, 23, 23, 90%)"});
       // $(".phone-app-footer4").css({"background-color":"rgba(65, 64, 64, 0.7)"});
       // $(".gallery-app-header").css({"color":"rgb(233, 233, 233)"});
//$(".gallery-album").css({"color":"rgb(233, 233, 233)"});
       // $(".phone-app-footer4-button").css({"color":"rgb(233, 233, 233)"});
       // $(".textogaleriaunica").css({"color":"rgb(233, 233, 233)"});
        //$(".textogaleriaunica2").css({"color":"rgb(233, 233, 233)"});

        /// appstore
       // $(".store-app").css({"background":"rgba(23, 23, 23, 90%)"});
       // $(".store-app-header").css({"background":"rgba(23, 23, 23, 90%)"});
        //$(".store-texto2-header").css({"color":"rgb(233, 233, 233)"});
       // $(".storeapp").css({"background-color":"rgba(23, 23, 23, 90%)"});
        //$(".storeapp-title").css({"color":"rgb(233, 233, 233)"});
        //$(".storeapp-creator").css({"color":"rgb(233, 233, 233)"});
        //$(".download-password").css({"background-color":"rgba(23, 23, 23, 100%)"});
        //$(".testo-parte-baixar").css({"color":"rgb(233, 233, 233)"});

         ////banco
         
         //$(".bank-app").css({"background":"rgba(23, 23, 23, 90%)"});
         //$(".bank-texto").css({"color":"rgb(233, 233, 233)"});

        // $(".bank-app-account-title").css({"color":"rgb(233, 233, 233)"});
        // $(".bank-app-account-number").css({"color":"rgb(233, 233, 233)"});
        // $(".bank-app-account-balance").css({"color":"rgb(233, 233, 233)"});
        // $(".bank-app-account3-title").css({"color":"rgb(233, 233, 233)"});
        // $(".bank-app-account4-title").css({"color":"rgb(233, 233, 233)"});
        // $(".bank-app-account2-title").css({"color":"rgb(233, 233, 233)"});
         //$(".bank-app-header-button").css({"color":"rgb(233, 233, 233)"});
        // $("#qbank-text").css({"color":"rgb(233, 233, 233)"});

         //// casas

        //modoescuro = true;
   // } else {
        //$(".menuinteracao-18").css({"background":"rgba(20, 20, 20, 0.77)"});
       // $(".modo-escuro-basico").css({"color":"rgba(232, 232, 232, 0.6)"});

        //// galeria
        //$(".gallery-app").css({"background":"rgb(233, 233, 233)"});
        //$(".phone-app-footer4").css({"background-color":"rgba(232, 232, 232, 0.7)"});
       // $(".gallery-app-header").css({"color":"rgba(23, 23, 23, 90%)"});
        //$(".gallery-album").css({"color":"rgba(23, 23, 23, 90%)"});
        //$(".phone-app-footer4-button").css({"color":"rgba(23, 23, 23, 90%)"});
        ///$(".textogaleriaunica").css({"color":"rgba(23, 23, 23, 90%)"});
        //$(".textogaleriaunica2").css({"color":"rgba(23, 23, 23, 90%)"});

         /// appstore
        // $(".store-app").css({"background":"rgb(233, 233, 233)"});
         //$(".store-app-header").css({"background":"rgb(233, 233, 233)"});
         //$(".store-texto2-header").css({"color":"rgba(23, 23, 23, 90%)"});
         //$(".storeapp").css({"background-color":"rgb(233, 233, 233)"});
        // $(".storeapp-title").css({"color":"rgba(23, 23, 23, 90%)"});
        // $(".storeapp-creator").css({"color":"rgba(23, 23, 23, 90%)"});
         //$(".download-password").css({"background-color":"rgb(233, 233, 233)"});
         //$(".testo-parte-baixar").css({"color":"rgba(23, 23, 23, 90%)"});

         ////banco

         //$(".bank-app").css({"background":"rgb(233, 233, 233)"});
         //$(".bank-texto").css({"color":"rgba(23, 23, 23, 90%)"});

        // $(".bank-app-account-title").css({"color":"rgba(23, 23, 23, 90%)"});
        // $(".bank-app-account-number").css({"color":"rgba(23, 23, 23, 90%)"});
        // $(".bank-app-account-balance").css({"color":"rgba(23, 23, 23, 90%)"});
        // $(".bank-app-account3-title").css({"color":"rgba(23, 23, 23, 90%)"});
        // $(".bank-app-account4-title").css({"color":"rgba(23, 23, 23, 90%)"});
        // $(".bank-app-account2-title").css({"color":"rgba(23, 23, 23, 90%)"});
        // $(".bank-app-header-button").css({"color":"rgba(23, 23, 23, 90%)"});
        // $("#qbank-text").css({"color":"rgba(23, 23, 23, 90%)"});

         ////casas

        //modoescuro = false;
   // }
//});

$(document).on('click', '#desativar-notifs', function(e){
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

var lanternaativa = false;
$(document).on('click', '#abrir-lanterna', function(e){
    e.preventDefault();

    
    if (lanternaativa == false) {
        $.post("https://jpr-newphone/LigarLanterna", JSON.stringify({}));
        $(".menuinteracao-20").css({"background":"rgb(34, 200, 45)"});
        $(".menuinteracao-22").css({"background":"rgb(34, 200, 45)"});
        var checkBoxes = $(".numberrec-box5");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        lanternaativa = true;
    } else {
        $.post("https://jpr-newphone/LigarLanterna", JSON.stringify({}));
        $(".menuinteracao-20").css({"background":"rgba(20, 20, 20, 0.77)"});
        $(".menuinteracao-22").css({"background":"transparent"});
        var checkBoxes = $(".numberrec-box5");
        Teste1 = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", Teste1);
        lanternaativa = false;
    }
});


JPR.Phone.Animations.BottomSlideUp = function(Object, Timeout, Percentage) {
    $(Object).css({'display':'block'}).animate({
        bottom: Percentage+"%",
    }, Timeout);
}

JPR.Phone.Animations.BottomSlideDown = function(Object, Timeout, Percentage) {
    $(Object).css({'display':'block'}).animate({
        bottom: Percentage+"%",
    }, Timeout, function(){
        $(Object).css({'display':'none'});
    });
}

JPR.Phone.Animations.TopSlideDown = function(Object, Timeout, Percentage) {
    $(Object).css({'display':'block'}).animate({
        top: Percentage+"%",
    }, Timeout);
}

JPR.Phone.Animations.TopSlideUp = function(Object, Timeout, Percentage) {
    $(Object).css({'display':'block'}).animate({
        top: Percentage+"%",
    }, Timeout, function(){
        
        $(Object).css({'display':'none'});
    });
}

JPR.Phone.Notifications.Add = function(icon, title, text, color, timeout) {
    $.post('https://jpr-newphone/HasPhone', JSON.stringify({}), function(HasPhone){
        if (HasPhone) {
            if (timeout == null && timeout == undefined) {
                timeout = 1500;
            }
            if (icon == null) {
                icon = "phone.png"
            }
            if (JPR.Phone.Notifications.Timeout == undefined || JPR.Phone.Notifications.Timeout == null) {
                if (color != null || color != undefined) {
                    $(".notification-icon").css({"color":color});
                    $(".notification-title").css({"color":color});
                } else if (color == "default" || color == null || color == undefined) {
                    $(".notification-icon").css({"color":"#e74c3c"});
                    $(".notification-title").css({"color":"#e74c3c"});
                }
                if (!JPR.Phone.Data.IsOpen) {
                    JPR.Phone.Animations.BottomSlideUp('.container', 300, -52);
                }
                JPR.Phone.Animations.TopSlideDown(".phone-notification-container", 200, 8);
                if (icon !== "meos") {
                    $(".notification-icon").html('<img src="./img/apps2/'+icon+'" class="icons-icon-notify">');
                } else {
                    $(".notification-icon").html('<img src="./img/meos.png" class="police-icon-notify">');
                }
                $(".notification-title").html(title);
                $(".notification-text").html(text);
                if (JPR.Phone.Notifications.Timeout !== undefined || JPR.Phone.Notifications.Timeout !== null) {
                    clearTimeout(JPR.Phone.Notifications.Timeout);
                }
                JPR.Phone.Notifications.Timeout = setTimeout(function(){
                    JPR.Phone.Animations.TopSlideUp(".phone-notification-container", 200, -8);
                    if (!JPR.Phone.Data.IsOpen) {
                        JPR.Phone.Animations.BottomSlideUp('.container', 300, -100);
                    }
                    JPR.Phone.Notifications.Timeout = null;
                }, timeout);
            } else {
                if (color != null || color != undefined) {
                    $(".notification-icon").css({"color":color});
                    $(".notification-title").css({"color":color});
                } else {
                    $(".notification-icon").css({"color":"#e74c3c"});
                    $(".notification-title").css({"color":"#e74c3c"});
                }
                if (!JPR.Phone.Data.IsOpen) {
                    JPR.Phone.Animations.BottomSlideUp('.container', 300, -52);
                }
                $(".notification-icon").html('<img src="./img/apps2/'+icon+'" class="police-icon-notify">');
                $(".notification-title").html(title);
                $(".notification-text").html(text);
                if (JPR.Phone.Notifications.Timeout !== undefined || JPR.Phone.Notifications.Timeout !== null) {
                    clearTimeout(JPR.Phone.Notifications.Timeout);
                }
                JPR.Phone.Notifications.Timeout = setTimeout(function(){
                    JPR.Phone.Animations.TopSlideUp(".phone-notification-container", 200, -8);
                    if (!JPR.Phone.Data.IsOpen) {
                        JPR.Phone.Animations.BottomSlideUp('.container', 300, -100);
                    }
                    JPR.Phone.Notifications.Timeout = null;
                }, timeout);
            }
        }
    });
}

var dadosdotelemovel = null;
JPR.Phone.Functions.LoadPhoneData = function(data) {
    JPR.Phone.Data.PlayerData = data.PlayerData;
    JPR.Phone.Data.PlayerJob = data.PlayerJob;
    JPR.Phone.Data.MetaData = data.PhoneData.MetaData;
    JPR.Phone.Functions.LoadMetaData(data.PhoneData.MetaData);
    JPR.Phone.Functions.LoadContacts(data.PhoneData.Contacts);
    dadosdotelemovel = data;
    JPR.Phone.Functions.SetupApplications(data);

    $("#player-id").html("<span>" + "ID: " + data.PlayerId + "</span>")
}

JPR.Phone.Functions.LoadPhoneData2 = function(data) {
    JPR.Phone.Data.PlayerData = data.PlayerData;

}

JPR.Phone.Functions.UpdateTime = function(data) {
    var NewDate = new Date();
    var NewHour = NewDate.getHours();
    var NewMinute = NewDate.getMinutes();
    var Minutessss = NewMinute;
    var Hourssssss = NewHour;
    var CurrentDate = new Date();
    const d = new Date();
    let day = d.getDay();
    var dia = "jpresources";
    if (day == 0) {
        dia = "Sunday";
        $("#phone-time3").css({"margin-left":"26%"});
    } else if (day == 1) {
        dia = "Second";
        $("#phone-time3").css({"margin-left":"26%"});
    } else if (day == 2) {
        dia = "Tuesday";
        $("#phone-time3").css({"margin-left":"28%"});
    } else if (day == 3) {
        dia = "Wednesday";
        $("#phone-time3").css({"margin-left":"28%"});
    } else if (day == 4) {
        dia = "Thursday";
        $("#phone-time3").css({"margin-left":"28%"});
    } else if (day == 5) {
        dia = "Friday";
        $("#phone-time3").css({"margin-left":"28%"});
    } else {
        dia = "Saturday";
        $("#phone-time3").css({"margin-left":"26%"});
    }
    if (NewHour < 10) {
        Hourssssss = "0" + Hourssssss;
    }
    if (NewMinute < 10) {
        Minutessss = "0" + NewMinute;
    }
    var MessageTime = Hourssssss + ":" + Minutessss

    $("#phone-time").html("<span>" + data.InGameTime.hour + ":" + data.InGameTime.minute + "</span>");
    $("#phone-time2").html("<span>" + data.InGameTime.hour + ":" + data.InGameTime.minute + "</span>");
    $("#phone-time3").html(dia+", " + monthNames[CurrentDate.getMonth()]+ " "+CurrentDate.getDate());
}

var NotificationTimeout = null;

JPR.Screen.Notification = function(title, content, icon, timeout, color) {
    $.post('https://jpr-newphone/HasPhone', JSON.stringify({}), function(HasPhone){
        if (HasPhone) {
            if (color != null && color != undefined) {
                $(".screen-notifications-container").css({"background-color":color});
            }
            $(".screen-notification-icon").html('<img src="./img/apps2/'+icon+'" class="police-icon-notify">');
            $(".screen-notification-title").text(title);
            $(".screen-notification-content").text(content);
            $(".screen-notifications-container").css({'display':'block'}).animate({
                right: 5+"vh",
            }, 200);

            if (NotificationTimeout != null) {
                clearTimeout(NotificationTimeout);
            }

            NotificationTimeout = setTimeout(function(){
                $(".screen-notifications-container").animate({
                    right: -35+"vh",
                }, 200, function(){
                    $(".screen-notifications-container").css({'display':'none'});
                });
                NotificationTimeout = null;
            }, timeout);
        }
    });
}

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESCAPE
        
        if (up){
            $('#popup').fadeOut('slow');
            $('.popupclass').fadeOut('slow');
            $('.menuinteracao-28').fadeOut('slow');
            $('.popupclass').html("");
            $(".menuinteracao-28").css({"display":"none"});
            up = false
            
        } else {
            emojisnowpp = false;
            emojisnotwt = false;
            emojisnoolx = false;
            emojisnogaleria = false;
            $(".gifs-fundo").css({"display":"none"});        
            gifsabertos = false;
            gifsabertosolx = false;
            gifsabertosgaleria = false;
            $(".gifs-fundo-olx").css({"display":"none"});
            $(".gifs-fundo-galeria").css({"display":"none"});
            $(".phone-application-container").css({"background-color":"transparent"});
            edagaleria = false; 
            eumanuncio = false;
            $("#teste3").removeClass()
            $("#teste3").addClass('fa-solid fa-person')
            $("#teste2").removeClass();
            $("#teste2").addClass('fa-solid fa-people-group')
            JPR.Phone.Functions.Close();
            
            var estaemchat = false;
            grupo = false;
            $.post("https://jpr-newphone/evitarnotifsnochat", JSON.stringify({estaemchat}));
            if (document.getElementById('if5')) {
                const element = document.getElementById('if5');
                element.remove();
            }
            if (document.getElementById('if6')) {
                const element = document.getElementById('if6');
                element.remove();
            }
            $("#carregamento").removeClass();
            $("#carregamento").addClass('fa-solid fa-circle-notch fa-spin');
            $("#cadeado").removeClass();
            $("#cadeado").addClass('fa-solid fa-lock')
            $("#desbloqueio").html('')
            $(".ecra-bloqueio").css({"display":"block"});
            ecrabloq = true;
            $(".phone-currentcall-container").css({"top":"20vh"});
            carregou = false;
            $(".ecra-tralha2").css({"display":"none"});
            $(".phone-footer").css({"display":"block"});
            $(".ecra-tralha").css({"display":"none"});
            tralhaaberta = false;
            $(".ecra-tralha").css({"background-color":"rgba(232, 232, 232, 0.9)"});
            $(".phone-header").css({"color":"white"});
            $(".phone-home-button").css({"background-color":"rgba(232, 232, 232, 0.9)"});
            JPR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
            JPR.Phone.Animations.TopSlideUp('.'+JPR.Phone.Data.currentApplication+"-app", 400, -160);
            CanOpenApp = false;
            setTimeout(function(){
                JPR.Phone.Functions.ToggleApp(JPR.Phone.Data.currentApplication, "none");
                CanOpenApp = true;
            }, 400)
            JPR.Phone.Functions.HeaderTextColor("white", 300);

            if (JPR.Phone.Data.currentApplication == "whatsapp") {
                if (OpenedChatData.number !== null) {
                    setTimeout(function(){
                        $(".whatsapp-chats").css({"display":"block"});
                        $(".whatsapp-chats").animate({
                            left: 0+"vh"
                        }, 1);
                        $(".whatsapp-openedchat").animate({
                            left: -30+"vh"
                        }, 1, function(){
                            $(".whatsapp-openedchat").css({"display":"none"});
                        });
                        OpenedChatPicture = null;
                        OpenedChatData.number = null;
                    }, 450);
                }
            } else if (JPR.Phone.Data.currentApplication == "bank") {
                if (CurrentTab == "invoices") {
                    setTimeout(function(){
                        $(".bank-app-invoices").animate({"left": "30vh"});
                        $(".bank-app-invoices").css({"display":"none"})
                        $(".bank-app-accounts").css({"display":"block"})
                        $(".bank-app-accounts").css({"left": "0vh"});

                        var InvoicesObjectBank = $(".bank-app-header").find('[data-headertype="invoices"]');
                        var HomeObjectBank = $(".bank-app-header").find('[data-headertype="accounts"]');

                        $(InvoicesObjectBank).removeClass('bank-app-header-button-selected');
                        $(HomeObjectBank).addClass('bank-app-header-button-selected');

                        CurrentTab = "accounts";
                    }, 400)
                }
            } else if (JPR.Phone.Data.currentApplication == "meos") {
                if (JPR.Phone.Data.PlayerJob.name == "police") {
                    $(".meos-alert-new").remove();
                    setTimeout(function(){
                        $(".meos-recent-alert").removeClass("noodknop");
                        $(".meos-recent-alert").css({"background-color":"#004682"});
                    }, 400)
                }
            }
            $(".phone-header").css({"color":"white"});
            $(".phone-home-button").css({"background-color":"rgba(232, 232, 232, 0.9)"});
            JPR.Phone.Data.currentApplication = null;
            break;
        }
    }
});

JPR.Screen.popUp = function(source, app){
    if(!up){
        $('#popup').fadeIn('slow');
        $('.popupclass').fadeIn('slow');
        if (app == "twitter" && edagaleria == false && eumanuncio == false) {
            $(".menuinteracao-28").css({"background-color":"rgba(29, 161, 242,255)"});
        } else if (app == "wpp" && edagaleria == false && eumanuncio == false) {
            $(".menuinteracao-28").css({"background-color":"rgba(0,128,105,255)"});
        } else if (eumanuncio == true) {
            $(".menuinteracao-28").css({"background-color":"#002b31"});
        } else if (edagaleria == true) {
            $(".menuinteracao-28").css({"background-color":"#e43c3c"});
        } else {
            $(".menuinteracao-28").css({"background-color":"rgb(252, 186, 3)"});
        }
        $('.menuinteracao-28').fadeIn('slow');
        $('<img  src='+source+' style = "width:100%; height: 100%; border-radius: 0.55rem; box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;">').appendTo('.popupclass')
        up = true
    }
}

JPR.Screen.popDown = function(){
    if(up){
        $('#popup').fadeOut('slow');
        $('.popupclass').fadeOut('slow');
        $('.menuinteracao-28').fadeOut('slow');
        $(".menuinteracao-28").css({"display":"block"});
        $('.popupclass').html("");
        up = false
    }
}

$(document).on('click', '#close-foto', function(e){
    e.preventDefault();

    $('#popup').fadeOut('slow');            
    $('.popupclass').fadeOut('slow');   
    $(".menuinteracao-28").css({"display":"none"});         
    $('.menuinteracao-28').fadeOut('slow');            
    $('.popupclass').html("");            
    up = false
});

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case "open":
                JPR.Phone.Functions.Open(event.data);
                JPR.Phone.Functions.SetupAppWarnings(event.data.AppData);
                JPR.Phone.Functions.SetupCurrentCall(event.data.CallData);
                JPR.Phone.Data.IsOpen = true;
                JPR.Phone.Data.PlayerData = event.data.PlayerData;
                if (ecrabloq == true) {
                    $(".phone-applications").css({"display":"none"});
                    $(".ecra-tralha").css({"display":"none"});
                    carregou = false;
                }
                setTimeout(function(){
                    shakeElement("#cadeado");
                    shakeElement("#desbloqueio");
                    $("#carregamento").removeClass('fa-solid fa-circle-notch fa-spin');
                    $("#carregamento").addClass('fa-solid fa-circle-check fa-fade');
                    $("#cadeado").removeClass('fa-solid fa-lock');
                    $("#cadeado").addClass('fa-solid fa-lock-open');
                    $("#desbloqueio").html('Unlocked');
                    ecrabloq = false;
                },700);
                break;
            case "LoadPhoneData":
                JPR.Phone.Functions.LoadPhoneData(event.data);
                break;
            case "LoadPhoneData2":
                JPR.Phone.Functions.LoadPhoneData2(event.data);
                break;
            case "UpdateTime":
                JPR.Phone.Functions.UpdateTime(event.data);
                break;
            case "Notification":
                JPR.Screen.Notification(event.data.NotifyData.title, event.data.NotifyData.content, event.data.NotifyData.icon, event.data.NotifyData.timeout, event.data.NotifyData.color);
                break;
            case "PhoneNotification":
                JPR.Phone.Notifications.Add(event.data.PhoneNotify.icon, event.data.PhoneNotify.title, event.data.PhoneNotify.text, event.data.PhoneNotify.color, event.data.PhoneNotify.timeout);
                break;
            case "RefreshAppAlerts":
                JPR.Phone.Functions.SetupAppWarnings(event.data.AppData);
                break;
            case "UpdateMentionedTweets":
                JPR.Phone.Notifications.LoadMentionedTweets(event.data.Tweets);
                break;
            case "UpdateBank":
                $(".bank-app-account-balance").html("&#36; "+event.data.NewBalance);
                $(".bank-app-account-balance").data('balance', event.data.NewBalance);
                break;
            case "UpdateChat":
                if (JPR.Phone.Data.currentApplication == "whatsapp") {
                    if (OpenedChatData.number !== null && OpenedChatData.number == event.data.chatNumber) {
                        JPR.Phone.Functions.SetupChatMessages(event.data.chatData);
                    } else {
                        JPR.Phone.Functions.LoadWhatsappChats(event.data.Chats);
                    }
                }
                break;
            case "UpdateVar":
                if (JPR.Phone.Data.currentApplication == "whatsapp") {
                   grupos = true;
                   //console.log("test31")
                }
                break;
            case "UpdateVar2":
                if (JPR.Phone.Data.currentApplication == "whatsapp") {
                    grupos = false;
                    //console.log("test51")
                }
                break;
            case "UpdateHashtags":
                JPR.Phone.Notifications.LoadHashtags(event.data.Hashtags);
                break;
            case "RefreshWhatsappAlerts":
                JPR.Phone.Functions.ReloadWhatsappAlerts(event.data.Chats);
                break;
            case "CancelOutgoingCall":
                $.post('https://jpr-newphone/HasPhone', JSON.stringify({}), function(HasPhone){
                    if (HasPhone) {
                        CancelOutgoingCall();
                    }
                });
                break;
            case "IncomingCallAlert":
                $.post('https://jpr-newphone/HasPhone', JSON.stringify({}), function(HasPhone){
                    if (HasPhone) {
                        IncomingCallAlert(event.data.CallData, event.data.Canceled, event.data.AnonymousCall);
                    }
                });
                break;
            case "SetupHomeCall":
                JPR.Phone.Functions.SetupCurrentCall(event.data.CallData);
                break;
            case "AnswerCall":
                JPR.Phone.Functions.AnswerCall(event.data.CallData);
                break;
            case "UpdateCallTime":
                var CallTime = event.data.Time;
                var date = new Date(null);
                date.setSeconds(CallTime);
                var timeString = date.toISOString().substr(11, 8);
                if (!JPR.Phone.Data.IsOpen) {
                    if ($(".call-notifications").css("right") !== "52.1px") {
                        $(".call-notifications").css({"display":"block"});
                        $(".call-notifications").animate({right: 5+"vh"});
                    }
                    $(".call-notifications-title").html("Em chamada ("+timeString+")");
                    $(".call-notifications-content").html("Chamada com "+event.data.Name);
                    $(".call-notifications").removeClass('call-notifications-shake');
                } else {
                    $(".call-notifications").animate({
                        right: -35+"vh"
                    }, 400, function(){
                        $(".call-notifications").css({"display":"none"});
                    });
                }
                $(".phone-call-ongoing-time").html(timeString);
                $(".phone-currentcall-title").html("Em chamada ("+timeString+")");
                break;
            case "CancelOngoingCall":
                $(".call-notifications").animate({right: -35+"vh"}, function(){
                    $(".call-notifications").css({"display":"none"});
                });
                JPR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                setTimeout(function(){
                    JPR.Phone.Functions.ToggleApp("phone-call", "none");
                    $(".phone-application-container").css({"display":"none"});
                }, 400)
                JPR.Phone.Functions.HeaderTextColor("white", 300);

                JPR.Phone.Data.CallActive = false;
                JPR.Phone.Data.currentApplication = null;
                break;
            case "RefreshContacts":
                JPR.Phone.Functions.LoadContacts(event.data.Contacts);
                break;
            case "UpdateMails":
                JPR.Phone.Functions.SetupMails(event.data.Mails);
                break;
            case "RefreshAdverts":
                if (JPR.Phone.Data.currentApplication == "advert") {
                    JPR.Phone.Functions.RefreshAdverts(event.data.Adverts);
                }
                break;
            case "UpdateTweets":
                if (JPR.Phone.Data.currentApplication == "twitter") {
                    JPR.Phone.Notifications.LoadTweets(event.data.Tweets);
                }
                break;
            case "AddPoliceAlert":
                AddPoliceAlert(event.data)
                break;
            case "UpdateApplications":
                JPR.Phone.Data.PlayerJob = event.data.JobData;
                JPR.Phone.Functions.SetupApplications(event.data);
                break;
            case "UpdateTransactions":
                RefreshCryptoTransactions(event.data);
                break;
            case "TesteMacho":
                RefreshCryptoTransactions(event.data);
                break;
            case "UpdateRacingApp":
                $.post('https://jpr-newphone/GetAvailableRaces', JSON.stringify({}), function(Races){
                    SetupRaces(Races);
                });
                break;
            case "RefreshAlerts":
                JPR.Phone.Functions.SetupAppWarnings(event.data.AppData);
                break;
        }
    })
});