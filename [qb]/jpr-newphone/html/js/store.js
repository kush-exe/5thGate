var TemplatePassword = null;
var CurrentApp = null;
var IsDownloading = false;
var antibugs = false;
var ultimaapp = "";
var ultimaapp2 = "";

const month2Names = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"];

SetupAppstore = function(data) {
    var CurrentDate = new Date();
    var CurrentMonth = month2Names[CurrentDate.getMonth()];
    var CurrentDOM = CurrentDate.getDate();
    var CurrentYear = CurrentDate.getFullYear();
    var CurDate = ""+CurrentDOM+" of "+CurrentMonth;
    $(".store-apps").html("");
    $(".store-app-header").find('p').html(CurDate);
    var elem = '<div class="storeapp2"><img src="../html/img/backgrounds/em-alta.jpg" class="storeapp-foto-icon"><div></div></div><br><br><br>'
    $(".store-apps").append(elem);
    $.each(data.StoreApps, function(i, app){
        if (app.app == "meos") {
            if (app.job == JPR.Phone.Data.PlayerJob.name) {
                if (data.PhoneData.InstalledApps[i] == null || data.PhoneData.InstalledApps[i] == undefined) {
                    if(app.blockedjobs != JPR.Phone.Data.PlayerJob.name){
                        var elem = '<div class="storeapp" id="app-'+i+'" data-app="'+i+'"><div><img class="storeapp-icon" src="./img/apps2/'+app.icon+'"></div><div class="storeapp-title">'+app.title+'</div> <div class="storeapp-creator">'+app.creator+'</div><div class="storeapp-avaliacao">'+app.avaliacao+'</div><div class="storeapp-download">GET</div></div>'
                        $(".store-apps").append(elem);
                        app.app = i;
                        $("#app-"+i).data('AppData', app);
                    }
                } else {
                    var elem = '<div class="storeapp" id="app-'+i+'" data-app="'+i+'"><div><img class="storeapp-icon" src="./img/apps2/'+app.icon+'"></div><div class="storeapp-title">'+app.title+'<span style="font-size: 1vh;"> - Installed</span></div> <div class="storeapp-creator">'+app.creator+'</div><div class="storeapp-avaliacao">'+app.avaliacao+'</div><div class="storeapp-remove">TRASH</div></div>'
                    $(".store-apps").append(elem);
                    app.app = i;
                    $("#app-"+i).data('AppData', app);
                }
            }
        }
        if (JPR.Phone.Data.PlayerJob.name == "police") {
            if (app.app == "droga") {

            }
        }else if (JPR.Phone.Data.PlayerJob.name == "ambulance") {
            if (app.app == "droga") {

            }
        }else if (JPR.Phone.Data.PlayerJob.name == "mechanic") {
            if (app.app == "droga") {

            }
        } else {
            if (app.app == "droga") {
                if (data.PhoneData.InstalledApps[i] == null || data.PhoneData.InstalledApps[i] == undefined) {
                    if(app.blockedjobs != JPR.Phone.Data.PlayerJob.name){
                        var elem = '<div class="storeapp" id="app-'+i+'" data-app="'+i+'"><div><img class="storeapp-icon" src="./img/apps2/'+app.icon+'"></div><div class="storeapp-title">'+app.title+'</div> <div class="storeapp-creator">'+app.creator+'</div><div class="storeapp-avaliacao">'+app.avaliacao+'</div><div class="storeapp-download">GET</div></div>'
                        $(".store-apps").append(elem);
                        app.app = i;
                        $("#app-"+i).data('AppData', app);
                    }
                } else {
                    var elem = '<div class="storeapp" id="app-'+i+'" data-app="'+i+'"><div><img class="storeapp-icon" src="./img/apps2/'+app.icon+'"></div><div class="storeapp-title">'+app.title+'<span style="font-size: 1vh;"> - Installed</span></div> <div class="storeapp-creator">'+app.creator+'</div><div class="storeapp-avaliacao">'+app.avaliacao+'</div><div class="storeapp-remove">TRASH</div></div>'
                    $(".store-apps").append(elem);
                    app.app = i;
                    $("#app-"+i).data('AppData', app);
                }
            }
        }
        if (app.app != "droga" && app.app != "meos") {
            if (data.PhoneData.InstalledApps[i] == null || data.PhoneData.InstalledApps[i] == undefined) {
                if(app.blockedjobs != JPR.Phone.Data.PlayerJob.name){
                    var elem = '<div class="storeapp" id="app-'+i+'" data-app="'+i+'"><div><img class="storeapp-icon" src="./img/apps2/'+app.icon+'"></div><div class="storeapp-title">'+app.title+'</div> <div class="storeapp-creator">'+app.creator+'</div><div class="storeapp-avaliacao">'+app.avaliacao+'</div><div class="storeapp-download">GET</div></div>'
                    $(".store-apps").append(elem);
                    app.app = i;
                    $("#app-"+i).data('AppData', app);
                }
            } else {
                var elem = '<div class="storeapp" id="app-'+i+'" data-app="'+i+'"><div><img class="storeapp-icon" src="./img/apps2/'+app.icon+'"></div><div class="storeapp-title">'+app.title+'<span style="font-size: 1vh;"> - Installed</span></div> <div class="storeapp-creator">'+app.creator+'</div><div class="storeapp-avaliacao">'+app.avaliacao+'</div><div class="storeapp-remove">TRASH</div></div>'
                $(".store-apps").append(elem);
                app.app = i;
                $("#app-"+i).data('AppData', app);
            }
        }
    });
}

$(document).on('click', '.storeapp-download', function(e){
    e.preventDefault();

    var AppId = $(this).parent().attr('id');
    var AppData = $("#"+AppId).data('AppData');

    //if (ultimaapp == AppData.app) {
        //JPR.Phone.Notifications.Add("appstore.png", "AppStore", "Já foi instalado!", "#3477eb")
    //} else {
        $(".download-progressbar-fill").css("width", "0%");
        $(".download-password").find('a').html('<img class="foto-icon-baixar" src="./img/apps2/'+AppData.icon+'">');
        if (AppData.title == "Calculadora") {
            $(".download-password").find('p').html("Calcular");
            $(".download-password").find('h1').html("iPhone"+', Inc.');
        } else {
            $(".download-password").find('p').html(AppData.title);
            $(".download-password").find('h1').html(AppData.title+', Inc.');
        }
        
        $(".download-password").find('span').html('<a style="color: #7d7d7d !important;">ACCOUNT: &nbsp;</a>'+'<a style="color: rgba(23, 23, 23, 90%) !important;">'+JPR.Phone.Data.PlayerData.charinfo.firstname+"."+JPR.Phone.Data.PlayerData.charinfo.lastname+"@wildroleplay.com </a>");
        
        CurrentApp = AppData.app;
        
        if (AppData.password) {
            $(".download-password-container").fadeIn(150);
        } else {
            $(".download-nopassword-container").fadeIn(150);
            e.preventDefault();

            var FilledInPassword = $(".download-password-input").val();
            
            FilledInPassword = TemplatePassword;
            $(".download-password-buttons").fadeOut(150);
            IsDownloading = true;
            $(".download-password-input").attr('readonly', true);
            // Teste para evitar bugs
            const element = document.getElementById("app-"+AppData.app+"");
            element.remove();
            var elem = '<div class="storeapp" id="app-'+AppData+'" data-app="'+AppData.app+'"><div><img class="storeapp-icon" src="./img/apps2/'+AppData.icon+'"></div><div class="storeapp-title">'+AppData.title+'<span style="font-size: 1vh;"> - Installed</span></div> <div class="storeapp-creator">'+AppData.creator+'</div><div class="storeapp-avaliacao">'+AppData.avaliacao+'</div><div class="storeapp-remove"><i class="fa-solid fa-circle-xmark"></i></div></div>'
            $(".store-apps").append(elem);
            // Teste para evitar bugs
            $(pixateste).css({"display":"block"});
            $.post('https://jpr-newphone/Somdoiphone', JSON.stringify({}));
            $(".download-progressbar-fill").animate({
                width: "100%",
            }, 5000, function(){
                IsDownloading = false;
                $(".download-password-input").attr('readonly', false);
                $(".download-nopassword-container").fadeOut(150, function(){
                    $(".download-progressbar-fill").css("width", "0%");
                });

                $.post('https://jpr-newphone/InstallApplication', JSON.stringify({
                    app: CurrentApp,
                }), function(Installed){
                    if (Installed) {
                        var applicationSlot = $(".phone-applications").find('[data-appslot="'+Installed.data.slot+'"]');
                        var blockedapp = IsAppJobBlocked(Installed.data.blockedjobs, JPR.Phone.Data.PlayerJob.name)
                        if ((!Installed.data.job || Installed.data.job === JPR.Phone.Data.PlayerJob.name) && !blockedapp) {
                            $(applicationSlot).css({"background-color":Installed.data.color});
                            var icon = '<img src="./img/apps2/'+Installed.data.icon+'" class="fotos-icon" style="box-shadow: rgba(0, 0, 0, 0.56) 0px 22px 70px 4px; !important;">';
                            if (Installed.data.app == "meos") {
                                icon = '<img src="./img/meos.png" class="police-icon">';
                            }
                            $(applicationSlot).html(icon+'<div class="app-unread-alerts">0</div>');
                            $(applicationSlot).prop('title', Installed.data.tooltipText);
                            $(applicationSlot).data('app', Installed.data.app);
                            $(applicationSlot).css({"display":"block"});
                
                            if (Installed.data.tooltipPos !== undefined) {
                                $(applicationSlot).data('placement', Installed.data.tooltipPos)
                            }
                        }
                        $(".phone-applications").find('[data-appslot="'+Installed.data.slot+'"]').tooltip();

                        var AppObject = $(".phone-applications").find("[data-appslot='"+Installed.data.slot+"']").find('.app-unread-alerts');

                        if (Installed.data.Alerts > 0) {
                            $(AppObject).html(Installed.data.Alerts);
                            $(AppObject).css({"display":"block"});
                        } else {
                            $(AppObject).css({"display":"none"});
                        }
                        JPR.Phone.Data.Applications[Installed.data.app] = Installed.data;

                        setTimeout(function(){
                            $.post('https://jpr-newphone/SetupStoreApps', JSON.stringify({}), function(data){
                                SetupAppstore(data);
                                $(".download-password-input").attr('readonly', false);
                                $(".download-progressbar-fill").css("width", "0%");
                                $(".download-password-buttons").show();
                                $(".download-password-input").val("");
                            });
                        }, 100);
                    }
                });
            });
        }
    //}
    //ultimaapp = AppData.app;
});

var pixateste = 0;
var cont5 = 1;
$(document).on('click', '.storeapp-remove', function(e){
    e.preventDefault();
        if (cont5 < 3){
            var AppId = $(this).parent().attr('id');
            var AppData = $("#"+AppId).data('AppData');
            //if (ultimaapp2 == AppData.app) {
                //JPR.Phone.Notifications.Add("appstore.png", "AppStore", "Já foi desinstalado!", "#3477eb")
            //} else {
                //var slot = AppData.slot-1;
                //if (AppData.slot == 8){
                    var applicationSlot = $(".phone-applications").find('[data-appslot="'+AppData.slot+'"]');
                // }else{
                // var applicationSlot = $(".phone-applications").find('[data-appslot="'+slot+1+'"]');
                //}
                const element = document.getElementById("app-"+AppData.app+"");
                element.remove();
                var elem = '<div class="storeapp" id="app-'+AppData+'" data-app="'+AppData.app+'"><div><img class="storeapp-icon" src="./img/apps2/'+AppData.icon+'"></div><div class="storeapp-title">'+AppData.title+'</div> <div class="storeapp-creator">'+AppData.creator+'</div><div class="storeapp-avaliacao">'+AppData.avaliacao+'</div><div class="storeapp-download">GET</div></div>'
                $(".store-apps").append(elem);
                //$(applicationSlot).css({"width":"0%","opacity": "0"});
                $(applicationSlot).html("");
                $(applicationSlot).css({
                    "background-color":"transparent"
                });
                $(applicationSlot).prop('title', "");
                $(applicationSlot).removeData('app');
                $(applicationSlot).removeData('placement');
                
                pixateste = applicationSlot;
            
                $(applicationSlot).css({"display":"none"});

                JPR.Phone.Data.Applications[AppData.app] = null;

                $.post('https://jpr-newphone/RemoveApplication', JSON.stringify({
                    app: AppData.app
                }));
                setTimeout(function(){
                    $.post('https://jpr-newphone/SetupStoreApps', JSON.stringify({}), function(data){
                        SetupAppstore(data); 
                    });
                }, 100);
                cont5=cont5+1;
            //}
        } else {
            JPR.Phone.Notifications.Add("appstore.png", "AppStore", "Máx. of two apps. at a time!", "#3477eb")
        }
    
    //ultimaapp2 = AppData.app;
});

$(document).on('click', '.download-password-deny', function(e){
    e.preventDefault();

    $(".download-password-container").fadeOut(150);
    CurrentApp = null;
    IsDownloading = false;
});