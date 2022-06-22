let veh

$(document).on('click', '.garage-vehicle', function(e){
    e.preventDefault();

    if (contadorgaragem != 0) {
        $(".garage-homescreen").animate({
            left: 30+"vh"
        }, 200);
        $(".garage-detailscreen").animate({
            left: 0+"vh"
        }, 200);

        var Id = $(this).attr('id');
        var VehData = $("#"+Id).data('VehicleData');
        veh = VehData
        SetupDetails(VehData);
        $(".garage-app").find('p').html('Manage vehicle');
    } else {
        JPR.Phone.Notifications.Add("garagem.png", "Garage", "You don't have vehicles", "#00a153", 2500);
    }
});

$(document).on('click', '#track-vehicle', function(e){
    e.preventDefault()
    $.post("https://jpr-newphone/track-vehicle", JSON.stringify({
        veh: veh,
    }));
});


$(document).on('click', '#return-button', function(e){
    e.preventDefault();

    $(".garage-homescreen").animate({
        left: 00+"vh"
    }, 200);
    $(".garage-detailscreen").animate({
        left: -30+"vh"
    }, 200);

    $(".garage-app").find('p').html('Garage');
});

var icon1 = "";
var icon2 = "";
var icon3 = "";
var icon4 = "";
var contadorgaragem = "";
var foto = "";
SetupGarageVehicles = function(Vehicles) {
    $(".garage-vehicles").html("");
    if (Vehicles != null) {
        $.each(Vehicles, function(i, vehicle){
            if (vehicle.state == 'Out') {
                icon1 = "fa-solid fa-house-circle-xmark";
            } else {
                icon1 = "fa-solid fa-square-parking";
            }
            if (Math.ceil(vehicle.engine / 10) < 50) {
                icon2 = "fa-solid fa-triangle-exclamation";
            } else {
                icon2 = "fa-solid fa-oil-can";
            }
            if (Math.ceil(vehicle.fuel) < 25) {
                icon3 = "fa-solid fa-droplet-slash";
            } else {
                icon3 = "fa-solid fa-gas-pump";
            }
            if (Math.ceil(vehicle.body / 10) < 70) {
                icon4 = "fa-solid fa-road-circle-exclamation";
            } else {
                icon4 = "fa-solid fa-road-circle-check";
            }
            
            //if (vehicle.brand == "Audi") {
            foto = vehicle.brand
            //} else {
                //foto = "default"
            //}
            var Element = '<div class="garage-vehicle" id="vehicle-'+i+'"><img src="./img/marcas/'+foto+'.png" class="garage-vehicle-firstletter"></span> <span class="garage-vehicle-name">'+vehicle.model+'</span><span class="garage-vehicle-desc"><i class="'+icon1+'"></i><i class="'+icon2+'" style= "padding-left: 0.3vh;"></i><i class="'+icon3+'" style= "padding-left: 0.3vh;"></i><i class="'+icon4+'" style= "padding-left: 0.3vh;"></i></span> </div>';
            $(".garage-vehicles").append(Element);
            $("#vehicle-"+i).data('VehicleData', vehicle);
            contadorgaragem = contadorgaragem + 1;
        });
    } else {
        contadorgaragem = 0;
        var Element = '<div class="garage-vehicle" id="vehicle-'+"1"+'"><img src="./img/apps2/'+"garagem2"+'.png" class="garage-vehicle-firstletter"></span> <span class="garage-vehicle-name">'+"Nenhum veiculo!"+'</span><span class="garage-vehicle-desc"><i class="'+"fa-solid fa-handshake-slash"+'"></i></span> </div>';
        $(".garage-vehicles").append(Element);
        $("#vehicle-"+"1").data('VehicleData', "nenhum");
    }
}

var icon5 = "";
var icon6 = "";
var icon7 = "";
var icon8 = "";
SetupDetails = function(data) {
    if (data.state == 'Out') {
        icon5 = "fa-solid fa-house-circle-xmark";
    } else {
        icon5 = "";
    }
    if (Math.ceil(data.engine / 10) < 50) {
        icon6 = "fa-solid fa-triangle-exclamation";
    } else {
        icon6 = "";
    }
    if (Math.ceil(data.fuel) < 50) {
        icon7 = "fa-solid fa-droplet-slash";
    } else {
        icon7 = "";
    }
    if (Math.ceil(data.body / 10) < 70) {
        icon8 = "fa-solid fa-road-circle-exclamation";
    } else {
        icon8 = "";
    }
    $(".vehicle-brand").find(".vehicle-answer").html(data.brand);
    $(".vehicle-model").find(".vehicle-answer").html(data.model);
    $(".vehicle-plate").find(".vehicle-answer").html(data.plate);
    $(".vehicle-garage").find(".vehicle-answer").html(data.garage);
    $(".vehicle-status").find(".vehicle-answer").html('<i class="'+icon5+' fa-shake" style="color: red; --fa-animation-duration: 3s;"></i> '+data.state);
    $(".vehicle-fuel").find(".vehicle-answer").html('<i class="'+icon7+' fa-shake" style="color: red; --fa-animation-duration: 3s;"></i> '+Math.ceil(data.fuel)+"%");
    $(".vehicle-engine").find(".vehicle-answer").html('<i class="'+icon6+' fa-shake" style="color: red; --fa-animation-duration: 3s;"></i> '+Math.ceil(data.engine / 10)+"%");
    $(".vehicle-body").find(".vehicle-answer").html('<i class="'+icon8+' fa-shake" style="color: red; --fa-animation-duration: 3s;"></i> '+Math.ceil(data.body / 10)+"%");
    if (icon6 != "" && icon7 != "" && icon8 != "") {
        $(".garage-box2").css({"background-color":"rgb(251, 1, 1)"});
    } else {
        $(".garage-box2").css({"background-color":"rgb(251,176,1)"});
    }
}