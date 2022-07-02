SetupLawyers = function(data) {
    $(".lawyers-list").html("");
    var lawyers = [];
    var realestate = [];
    var mechanic = [];
    var taxi = [];
    var police = [];
    var ambulance = [];

    if (data.length > 0) {

        $.each(data, function(i, lawyer) {
            if (lawyer.typejob == "police") {
                police.push(lawyer);
            }
            if (lawyer.typejob == "ambulance") {
                ambulance.push(lawyer);
            }
            if (lawyer.typejob == "mechanic") {
                mechanic.push(lawyer);
            }
            if (lawyer.typejob == "taxi") {
                taxi.push(lawyer);
            }
        });

        $(".lawyers-list").append('<h1 style="font-size:1.541025641025641vh; padding:0.7256410256410255vh; color:rgba(23, 23, 23, 90%); font-weight: bold; margin-top:0; border-radius: 0.55rem; width:95%; display:block; background-color: rgb(42, 137, 214); margin-left: 0.6vh !important;"><i class="fa-solid fa-people-group fa-shake" style="--fa-animation-duration: 3s;font-size: 1.4vh;"></i>&nbsp;Police (' + police.length + ')</h1>');

        if (police.length > 0) {
            $.each(police, function(i, lawyer) {
                var element = '<div class="lawyer-list" id="lawyerid-' + i + '"> <div class="lawyer-list-firstletter" style="background-color: rgb(42, 137, 214);">' + (lawyer.name).charAt(0).toUpperCase() + '</div> <div class="lawyer-list-fullname" style="rgba(23, 23, 23, 90%);">' + lawyer.name + '</div> <div class="lawyer-list-call"><i class="fas fa-phone fa-shake" style="--fa-animation-duration: 3s;"></i></div> </div>'
                $(".lawyers-list").append(element);
                $("#lawyerid-" + i).data('LawyerData', lawyer);
            });
        } else {
            var element = '<div class="lawyer-list"><div class="no-lawyers">They are not Police on duty.</div></div>'
            $(".lawyers-list").append(element);
        }

        $(".lawyers-list").append('<br><h1 style="font-size:1.541025641025641vh; border-radius: 0.55rem; padding:0.7256410256410255vh; font-weight: bold;color:rgba(23, 23, 23, 90%); margin-top:0; width:95%; display:block; background-color: rgb(255, 190, 27); margin-left: 0.6vh !important;"><i class="fa-solid fa-people-group fa-shake" style="--fa-animation-duration: 3s;font-size: 1.4vh;"></i>&nbsp;Medical (' + ambulance.length + ')</h1>');

        if (ambulance.length > 0) {
            $.each(ambulance, function(i, lawyer1) {
                var element = '<div class="lawyer-list" id="lawyerid1-' + i + '"> <div class="lawyer-list-firstletter" style="background-color: rgb(255, 190, 27);">' + (lawyer1.name).charAt(0).toUpperCase() + '</div> <div class="lawyer-list-fullname" style="rgba(23, 23, 23, 90%);">' + lawyer1.name + '</div> <div class="lawyer-list-call"><i class="fas fa-phone fa-shake" style="--fa-animation-duration: 3s;"></i></div> </div>'
                $(".lawyers-list").append(element);
                $("#lawyerid1-" + i).data('LawyerData', lawyer1);
            });
        } else {
            var element = '<div class="lawyer-list"><div class="no-lawyers">They are not Medical on duty.</div></div>'
            $(".lawyers-list").append(element);
        }

        $(".lawyers-list").append('<br><h1 style="font-size:1.541025641025641vh; border-radius: 0.55rem; padding:0.7256410256410255vh; font-weight: bold;color:rgba(23, 23, 23, 90%); margin-top:0; width:95%; display:block; background-color: #652b2c; margin-left: 0.6vh !important;"><i class="fa-solid fa-people-group fa-shake" style="--fa-animation-duration: 3s;font-size: 1.4vh;"></i>&nbsp;Mechanic (' + mechanic.length + ')</h1>');

        if (mechanic.length > 0) {
            $.each(mechanic, function(i, lawyer2) {
                var element = '<div class="lawyer-list" id="lawyerid2-' + i + '"> <div class="lawyer-list-firstletter" style="background-color: #652b2c;">' + (lawyer2.name).charAt(0).toUpperCase() + '</div> <div class="lawyer-list-fullname" style="rgba(23, 23, 23, 90%);">' + lawyer2.name + '</div> <div class="lawyer-list-call"><i class="fas fa-phone fa-shake" style="--fa-animation-duration: 3s;"></i></div> </div>'
                $(".lawyers-list").append(element);
                $("#lawyerid2-" + i).data('LawyerData', lawyer2);
            });
        } else {
            var element = '<div class="lawyer-list"><div class="no-lawyers">They are not Mechanic on duty.</div></div>'
            $(".lawyers-list").append(element);
        }

        $(".lawyers-list").append('<br><h1 style="font-size:1.541025641025641vh; border-radius: 0.55rem; padding:0.7256410256410255vh; font-weight: bold;color:rgba(23, 23, 23, 90%); margin-top:0; width:95%; display:block; background-color: rgb(0, 204, 102); margin-left: 0.6vh !important;"><i class="fa-solid fa-people-group fa-shake" style="--fa-animation-duration: 3s;font-size: 1.4vh;"></i>&nbsp;Uber (' + taxi.length + ')</h1>');

        if (taxi.length > 0) {
            $.each(taxi, function(i, lawyer3) {
                var element = '<div class="lawyer-list" id="lawyerid3-' + i + '"> <div class="lawyer-list-firstletter" style="background-color: rgb(0, 204, 102);">' + (lawyer3.name).charAt(0).toUpperCase() + '</div> <div class="lawyer-list-fullname" style="rgba(23, 23, 23, 90%);">' + lawyer3.name + '</div> <div class="lawyer-list-call"><i class="fas fa-phone fa-shake" style="--fa-animation-duration: 3s;"></i></div> </div>'
                $(".lawyers-list").append(element);
                $("#lawyerid3-" + i).data('LawyerData', lawyer3);
            });
        } else {
            var element = '<div class="lawyer-list"><div class="no-lawyers">They are not uber on duty.</div></div>'
            $(".lawyers-list").append(element);
        }
    

    } else {
        $(".lawyers-list").append('<h1 style="font-size:1.541025641025641vh; padding:0.7256410256410255vh; color:rgba(23, 23, 23, 90%); font-weight: bold; margin-top:0; border-radius: 0.55rem; width:95%; display:block; background-color: rgb(42, 137, 214); margin-left: 0.6vh !important;"><i class="fa-solid fa-people-group fa-shake" style="--fa-animation-duration: 3s;font-size: 1.4vh;"></i>&nbsp;Police (' + police.length + ')</h1>');

        var element = '<div class="lawyer-list"><div class="no-lawyers">No Police on duty.</div></div>'
        $(".lawyers-list").append(element);

        $(".lawyers-list").append('<br><h1 style="font-size:1.541025641025641vh; border-radius: 0.55rem; padding:0.7256410256410255vh; font-weight: bold;color:rgba(23, 23, 23, 90%); margin-top:0; width:95%; display:block; background-color: rgb(255, 190, 27); margin-left: 0.6vh !important;"><i class="fa-solid fa-people-group fa-shake" style="--fa-animation-duration: 3s;font-size: 1.4vh;"></i>&nbsp;Medical (' + ambulance.length + ')</h1>');

        var element = '<div class="lawyer-list"><div class="no-lawyers">No EMS on duty.</div></div>'
        $(".lawyers-list").append(element);

        $(".lawyers-list").append('<br><h1 style="font-size:1.541025641025641vh; border-radius: 0.55rem; padding:0.7256410256410255vh; font-weight: bold;color:rgba(23, 23, 23, 90%); margin-top:0; width:95%; display:block; background-color: #652b2c; margin-left: 0.6vh !important;"><i class="fa-solid fa-people-group fa-shake" style="--fa-animation-duration: 3s;font-size: 1.4vh;"></i>&nbsp;Mechanic (' + mechanic.length + ')</h1>');

        var element = '<div class="lawyer-list"><div class="no-lawyers">No Mechanics on duty.</div></div>'
        $(".lawyers-list").append(element);

        $(".lawyers-list").append('<br><h1 style="font-size:1.541025641025641vh; border-radius: 0.55rem; padding:0.7256410256410255vh; font-weight: bold;color:rgba(23, 23, 23, 90%); margin-top:0; width:95%; display:block; background-color: rgb(0, 204, 102); margin-left: 0.6vh !important;"><i class="fa-solid fa-people-group fa-shake" style="--fa-animation-duration: 3s;font-size: 1.4vh;"></i>&nbsp;Uber (' + taxi.length + ')</h1>');

        var element = '<div class="lawyer-list"><div class="no-lawyers">No Ubers available.</div></div>'
        $(".lawyers-list").append(element);
        


    }
}

$(document).on('click', '.lawyer-list-call', function(e){
    e.preventDefault();

    var LawyerData = $(this).parent().data('LawyerData');
    
    var cData = {
        number: LawyerData.phone,
        name: LawyerData.name
    }

    $.post('https://jpr-newphone/CallContact', JSON.stringify({
        ContactData: cData,
        Anonymous: JPR.Phone.Data.AnonymousCall,
    }), function(status){
        if (cData.number !== JPR.Phone.Data.PlayerData.charinfo.phone) {
            if (status.IsOnline) {
                if (status.CanCall) {
                    if (!status.InCall) {
                        if (JPR.Phone.Data.AnonymousCall) {
                            JPR.Phone.Notifications.Add("phone.png", "Phone", "You started an anonymous call!" , "#13a10b");
                        }
                        $(".phone-call-outgoing").css({"display":"block"});
                        $(".phone-call-incoming").css({"display":"none"});
                        $(".phone-call-ongoing").css({"display":"none"});
                        $(".phone-call-outgoing-caller").html(cData.name);
                        JPR.Phone.Functions.HeaderTextColor("white", 400);
                        JPR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                        setTimeout(function(){
                            $(".lawyers-app").css({"display":"none"});
                            JPR.Phone.Animations.TopSlideDown('.phone-application-container', 400, 0);
                            JPR.Phone.Functions.ToggleApp("phone-call", "block");
                        }, 450);
    
                        CallData.name = cData.name;
                        CallData.number = cData.number;
                    
                        JPR.Phone.Data.currentApplication = "phone-call";
                    } else {
                        JPR.Phone.Notifications.Add("phone.png", "Phone", "Are you already on a call!" , "#13a10b");
                    }
                } else {
                    JPR.Phone.Notifications.Add("phone.png", "Phone", "This person is already on a call" , "#13a10b");
                }
            } else {
                JPR.Phone.Notifications.Add("phone.png", "Phone", "This person is unavailable!", "#13a10b");
            }
        } else {
            JPR.Phone.Notifications.Add("phone.png", "Phone", "You can't call yourself!", "#13a10b");
        }
    });
});
