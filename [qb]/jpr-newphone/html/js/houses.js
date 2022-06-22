var SelectedHousesTab = "myhouses";
var CurrentHouseData = {};
var HousesData = {};
var contadorcasas = 0;
var contadorchaves = 0;

$(document).on('click', '.houses-app-header-tab', function(e){
    e.preventDefault();
    var CurrentHouseTab = $("[data-housetab='"+SelectedHousesTab+"']");
    var Data = $(this).data('housetab');

    if (SelectedHousesTab == "mykeys") {
        $(".texto-casas").find('p').html('Manage properties');
    } else {
        $(".texto-casas").find('p').html('Manage Keys');
    }
    if (Data !== SelectedHousesTab) {
        $(".house-app-" + $(CurrentHouseTab).data('housetab') + "-container").css("display", "none");
        $(".house-app-" + Data + "-container").css("display", "block");
        $(CurrentHouseTab).removeClass('houses-app-header-tab-selected');
        $("[data-housetab='"+Data+"']").addClass('houses-app-header-tab-selected');
        SelectedHousesTab = Data
    }
});

$(document).on('click', '.myhouses-house', function(e){
    e.preventDefault();

    var HouseData = $(this).data('HouseData');
    CurrentHouseData = HouseData;
    if (contadorcasas == 0) {
        JPR.Phone.Notifications.Add("home.png", "Houses", "To interact, buy a house!", "#e09f3c", 1750);
    } else {
        $(".myhouses-options-container").fadeIn(150);
        $(".myhouses-options-header").html(HouseData.label);
    }
});

$(document).on('click', '#myhouse-option-close', function(e){
    e.preventDefault();

    $(".myhouses-options-container").fadeOut(150);
});


function SetupPlayerHouses(Houses) {
    $(".house-app-myhouses-container").html("");
    HousesData = Houses;
    if (Houses.length > 0) {
        $.each(Houses, function(id, house){
            var TotalKeyholders = 0;
            if (house.keyholders !== undefined && house.keyholders !== null) {
                TotalKeyholders = (house.keyholders).length;
            }
            var HouseDetails = '<i class="fas fa-key"></i>&nbsp;&nbsp;' + TotalKeyholders + '&nbsp&nbsp&nbsp&nbsp<i class="fas fa-warehouse"></i>&nbsp;&nbsp;&nbsp;<i class="fas fa-times"></i>';
            if (house.testesunicos !== null && house.testesunicos !== undefined && house.testesunicos !== "") {
                if (house.testesunicos.length !== null && house.testesunicos.length !== undefined && house.testesunicos.length !== "") {
                    HouseDetails = '<i class="fas fa-key"></i>&nbsp;&nbsp;' + TotalKeyholders + '&nbsp&nbsp&nbsp&nbsp<i class="fas fa-warehouse"></i>&nbsp;&nbsp;&nbsp;<i class="fas fa-check"></i>';
                }
            }
           
            var elem = '<div class="myhouses-house" id="house-' + id + '"><div class="myhouse-house-icon"><i class="fas fa-home fa-shake" style="--fa-animation-duration: 3s;"></i></div> <div class="myhouse-house-titel">' + house.label + ' | Tier ' + house.tier + '</div> <div class="myhouse-house-details">' + HouseDetails + '</div> </div>';
            $(".house-app-myhouses-container").append(elem);
            $("#house-" + id).data('HouseData', house);
        });
        
    }
   
    if (Houses.length == 0) {
        var elem = '<div class="myhouses-house" id="house-' + "1" + '"><div class="myhouse-house-icon"><i class="fas fa-home fa-shake" style="--fa-animation-duration: 3s;"></i></div> <div class="myhouse-house-titel">' + '</div> <div class="myhouse-house-details">' + "Get in touch with a real estate agent!" + '</div> </div>';
        $(".house-app-myhouses-container").append(elem);
        $("#house-" + 1).data('HouseData', 'Teste');
    }
    contadorcasas = Houses.length;
}

var AnimationDuration = 200;

$(document).on('click', '#myhouse-option-transfer', function(e){
    e.preventDefault();

    $(".myhouses-options").animate({
        left: -35+"vw"
    }, AnimationDuration);

    $(".myhouse-option-transfer-container").animate({
        left: 0
    }, AnimationDuration);
});


$(document).on('click', '#myhouse-option-keys', function(e){
    $(".keys-container").html("");
    if (CurrentHouseData.keyholders !== undefined && CurrentHouseData.keyholders !== null) {
        $.each(CurrentHouseData.keyholders, function(i, keyholder){
            if (keyholder !== null && keyholder !== undefined) {
                var elem;
                if (keyholder.citizenid !== JPR.Phone.Data.PlayerData.citizenid) {
                    elem = '<div class="house-key" id="holder-'+i+'"><span class="house-key-holder">' + keyholder.charinfo.firstname + ' ' + keyholder.charinfo.lastname + '</span> <div class="house-key-delete"><i class="fas fa-trash"></i></div> </div>';
                } else {
                    elem = '<div class="house-key" id="holder-'+i+'"><span class="house-key-holder">(Eu) ' + keyholder.charinfo.firstname + ' ' + keyholder.charinfo.lastname + '</span></div>';
                } 
                $(".keys-container").append(elem);
                $('#holder-' + i).data('KeyholderData', keyholder);
            }
            contadorchaves = contadorchaves+1;
        });
    }
    $(".myhouses-options").animate({
        left: -35+"vw"
    }, AnimationDuration);
    $(".myhouse-option-keys-container").animate({
        left: 0
    }, AnimationDuration);
});

$(document).on('click', '.house-key-delete', function(e){
    e.preventDefault();
    var Data = $(this).parent().data('KeyholderData');

    $.each(CurrentHouseData.keyholders, function(i, keyholder){
        if (Data.citizenid == keyholder.citizenid) {
            CurrentHouseData.keyholders.splice(i);
        }
    });

    $.each(HousesData, function(i, house){
        if (house.name == CurrentHouseData.name) {
            HousesData[i].keyholders = CurrentHouseData.keyholders;
        }
    });

    SetupPlayerHouses(HousesData);

    $(this).parent().fadeOut(250, function(){
        $(this).remove();
    });

    $.post('https://jpr-newphone/RemoveKeyholder', JSON.stringify({
        HolderData: Data,
        HouseData: CurrentHouseData,
    }));
});

function shakeElement(element){
    $(element).addClass('shake');
    setTimeout(function(){
        $(element).removeClass('shake');
    }, 500);
};

$(document).on('click', '#myhouse-option-transfer-confirm', function(e){
    e.preventDefault();
        
    var NewBSN = $(".myhouse-option-transfer-container-citizenid").val();

    $.post('https://jpr-newphone/TransferCid', JSON.stringify({
        newBsn: NewBSN,
        HouseData: CurrentHouseData,
    }), function(CanTransfer){
        if (CanTransfer) {
            $(".myhouses-options").animate({
                left: 0
            }, AnimationDuration);
        
            $(".myhouse-option-transfer-container").animate({
                left: 35+"vw"
            }, AnimationDuration);

            setTimeout(function(){
                $.post('https://jpr-newphone/GetPlayerHouses', JSON.stringify({}), function(Houses){
                    SetupPlayerHouses(Houses);
                    $(".myhouses-options-container").fadeOut(150);
                });
            }, 100);
        } else {
            JPR.Phone.Notifications.Add("home.png", "Houses", "Invalid NIF", "#e09f3c", 2500);
            shakeElement(".myhouse-option-transfer-container");
            $(".myhouse-option-transfer-container-citizenid").val("");
        }
    });
});

$(document).on('click', '#myhouse-option-transfer-back', function(e){
    e.preventDefault();

    $(".myhouses-options").animate({
        left: 0
    }, AnimationDuration);

    $(".myhouse-option-transfer-container").animate({
        left: 35+"vw"
    }, AnimationDuration);
});

$(document).on('click', '#myhouse-option-keys-back', function(e){
    e.preventDefault();

    $(".myhouses-options").animate({
        left: 0
    }, AnimationDuration);
    $(".myhouse-option-keys-container").animate({
        left: 35+"vw"
    }, AnimationDuration);
});
