var FoccusedBank = null;
var CurrentTab = "accounts";

$(document).on('click', '.bank-app-header-button', function(e){
    e.preventDefault();

    var PressedObject = this;
    var PressedTab = $(PressedObject).data('headertype');

    if (CurrentTab != PressedTab) {
        var PreviousObject = $(".bank-app-header").find('[data-headertype="'+CurrentTab+'"]');

        if (PressedTab == "invoices") {
            $(".bank-app-"+CurrentTab).animate({
                left: -30+"vh"
            }, 250, function(){
                $(".bank-app-"+CurrentTab).css({"display":"none"})
            });
            $(".bank-app-"+PressedTab).css({"display":"block"}).animate({
                left: 0+"vh"
            }, 250);
        } else if (PressedTab == "accounts") {
            $(".bank-app-"+CurrentTab).animate({
                left: 30+"vh"
            }, 250, function(){
                $(".bank-app-"+CurrentTab).css({"display":"none"})
            });
            $(".bank-app-"+PressedTab).css({"display":"block"}).animate({
                left: 0+"vh"
            }, 250);
        }

        $(PreviousObject).removeClass('bank-app-header-button-selected');
        $(PressedObject).addClass('bank-app-header-button-selected');
        setTimeout(function(){ CurrentTab = PressedTab; }, 300)
    }
})

JPR.Phone.Functions.DoBankOpen = function() {
    JPR.Phone.Data.PlayerData.money.bank = (JPR.Phone.Data.PlayerData.money.bank).toFixed();
    $(".bank-app-account-number").html(JPR.Phone.Data.PlayerData.charinfo.account);
    $(".bank-app-account-balance").html(JPR.Phone.Data.PlayerData.money.bank+"&dollar; ");
    $(".bank-app-account-balance").data('balance', JPR.Phone.Data.PlayerData.money.bank);

    $(".bank-app-loaded").css({"display":"none", "padding-left":"30vh"});
    $(".bank-app-accounts").css({"left":"30vh"});
    $(".qbank-logo").css({"left": "0vh"});
    $("#qbank-text").css({"opacity":"0.0", "left":"9vh"});
    $(".bank-app-loading").css({
        "display":"block",
        "left":"0vh",
    });
    setTimeout(function(){
        CurrentTab = "accounts";
        $(".qbank-logo").animate({
            left: -15+"vh"
        }, 500);
        setTimeout(function(){
            $("#qbank-text").animate({
                opacity: 1.0,
                left: 12+"vh"
            });
        }, 100);
        setTimeout(function(){
            $(".bank-app-loaded").css({"display":"block"}).animate({"padding-left":"0"}, 300);
            $(".bank-app-accounts").animate({left:0+"vh"}, 300);
            $(".bank-app-loading").animate({
                left: -30+"vh"
            },300, function(){
                $(".bank-app-loading").css({"display":"none"});
            });
        }, 1500)
    }, 500)
}


$(document).on('click', '#transfer-money', function(e){
    e.preventDefault();

    $("#bank-transfer-iban").css({"display":"block"});
    $("#bank-transfer-amount").css({"display":"block"});
    $(".jarda2-number").css({"display":"block"});
    $(".jarda3-number").css({"display":"block"});
    $(".jarda4-number").css({"display":"block"});
    $(".jarda5-number").css({"display":"block"});
    $(".jarda6-number").css({"display":"block"});

    //JPR.Phone.Animations.TopSlideDown(".bank-app-transfer", 400, 0);
});

$(document).on('click', '#cancel-transfer', function(e){
    e.preventDefault();

    //JPR.Phone.Animations.TopSlideUp(".bank-app-transfer", 400, -100);
    
        $("#bank-transfer-iban").css({"display":"none"});
        $("#bank-transfer-amount").css({"display":"none"});
        $(".jarda2-number").css({"display":"none"});
        $(".jarda3-number").css({"display":"none"});
        $(".jarda4-number").css({"display":"none"});
        $(".jarda5-number").css({"display":"none"});
        $(".jarda6-number").css({"display":"none"});
   
});

$(document).on('click', '#accept-transfer', function(e){
    e.preventDefault();

    var iban = $("#bank-transfer-iban").val();
    var amount = $("#bank-transfer-amount").val();
    var amountData = $(".bank-app-account-balance").data('balance');

    if (iban != "" && amount != "") {
            $.post('https://jpr-newphone/CanTransferMoney', JSON.stringify({
                sendTo: iban,
                amountOf: amount,
            }), function(data){
                if (data.TransferedMoney) {
                    $("#bank-transfer-iban").val("");
                    $("#bank-transfer-amount").val("");

                    $(".bank-app-account-balance").html("&#36; " + (data.NewBalance).toFixed(0));
                    $(".bank-app-account-balance").data('balance', (data.NewBalance).toFixed(0));
                    JPR.Phone.Notifications.Add("wallet.png", "WBank", "You transferred &#36; "+amount+"!", "#badc58", 1500);
                } else {
                    JPR.Phone.Notifications.Add("wallet.png", "WBank", "You don't have enough money!", "#badc58", 1500);
                }
                JPR.Phone.Animations.TopSlideUp(".bank-app-transfer", 400, -100);
            });
    } else {
        JPR.Phone.Notifications.Add("wallet.png", "WBank", "Fill in all fields!", "#badc58", 1750);
    }
});

GetInvoiceLabel = function(type) {
    retval = null;
    if (type == "request") {
        retval = "Payment requested";
    }

    return retval
}

$(document).on('click', '.pay-invoice', function(event){
    event.preventDefault();

    var InvoiceId = $(this).parent().parent().attr('id');
    var InvoiceData = $("#"+InvoiceId).data('invoicedata');
    var BankBalance = $(".bank-app-account-balance").data('balance');

    if (BankBalance >= InvoiceData.amount) {
        $.post('https://jpr-newphone/PayInvoice', JSON.stringify({
            sender: InvoiceData.sender,
            amount: InvoiceData.amount,
            society: InvoiceData.society,
            invoiceId: InvoiceData.id,
            senderCitizenId: InvoiceData.sendercitizenid
        }), function(CanPay){
            if (CanPay) {
                $("#"+InvoiceId).animate({
                    left: 30+"vh",
                }, 300, function(){
                    setTimeout(function(){
                        $("#"+InvoiceId).remove();
                    }, 100);
                });
                JPR.Phone.Notifications.Add("wallet.png", "WBank", "You payed &#36;"+InvoiceData.amount+"!", "#badc58", 1500);
                var amountData = $(".bank-app-account-balance").data('balance');
                var NewAmount = (amountData - InvoiceData.amount).toFixed();
                $("#bank-transfer-amount").val(NewAmount);
                $(".bank-app-account-balance").data('balance', NewAmount);
            } else {
                JPR.Phone.Notifications.Add("wallet.png", "WBank", "You don't have funds!", "#badc58", 1500);
            }
        });
    } else {
        JPR.Phone.Notifications.Add("wallet.png", "WBank", "You don't have enough funds!", "#badc58", 1500);
    }
});

$(document).on('click', '.decline-invoice', function(event){
    event.preventDefault();
    var InvoiceId = $(this).parent().parent().attr('id');
    var InvoiceData = $("#"+InvoiceId).data('invoicedata');

    $.post('https://jpr-newphone/DeclineInvoice', JSON.stringify({
        sender: InvoiceData.sender,
        amount: InvoiceData.amount,
        society: InvoiceData.society,
        invoiceId: InvoiceData.id,
    }));
    $("#"+InvoiceId).animate({
        left: 30+"vh",
    }, 300, function(){
        setTimeout(function(){
            $("#"+InvoiceId).remove();
        }, 100);
    });
});
$(".bank-app-invoice").css({"display":"block"});
JPR.Phone.Functions.LoadBankInvoices = function(invoices) {
    if (invoices !== null && invoices !== undefined && invoices !== "") {
        $(".bank-app-invoices-list").html("");

        $.each(invoices, function(i, invoice){
            if (invoice.society == 'police') {
                    var Elem = '<div class="bank-app-invoice" id="invoiceid-'+i+'" style="background: rgb(21,18,116) !important; background: linear-gradient(341deg, rgba(21,18,116,1) 0%, rgba(104,102,251,1) 100%) !important;"> <div class="bank-app-invoice-title">'+"Police"+' <span style="font-size: 1vh; color: rgba(23, 23, 23, 90%);">(Envio: '+invoice.sender+')</span></div> <div class="bank-app-invoice-amount">'+invoice.amount+' &dollar;</div> <div class="bank-app-invoice-buttons"> <i class="fas fa-check-circle fa-shake pay-invoice" style="--fa-animation-duration: 3s;"></i></div> </div>';
                
                
            } else if (invoice.society == 'ambulance') {
                    var Elem = '<div class="bank-app-invoice" id="invoiceid-'+i+'" style="background: rgb(255,248,0) !important; background: linear-gradient(341deg, rgba(255,248,0,1) 0%, rgba(252,249,132,1) 100%) !important;"> <div class="bank-app-invoice-title">'+"EMS"+' <span style="font-size: 1vh; color: rgba(23, 23, 23, 90%);">(Envio: '+invoice.sender+')</span></div> <div class="bank-app-invoice-amount">'+invoice.amount+' &dollar;</div> <div class="bank-app-invoice-buttons"> <i class="fas fa-check-circle fa-shake pay-invoice" style="--fa-animation-duration: 3s;"></i></div> </div>';
                
                
            } else if (invoice.society == 'mechanic') {

                    var Elem = '<div class="bank-app-invoice" id="invoiceid-'+i+'" style="background: rgb(101,43,44) !important; background: linear-gradient(341deg, rgba(116,18,20,1) 0%, rgba(251,102,102,1) 100%) !important;"> <div class="bank-app-invoice-title">'+"Mechanic"+' <span style="font-size: 1vh; color: rgba(23, 23, 23, 90%);">(Envio: '+invoice.sender+')</span></div> <div class="bank-app-invoice-amount">'+invoice.amount+' &dollar;</div> <div class="bank-app-invoice-buttons"> <i class="fas fa-check-circle fa-shake pay-invoice" style="--fa-animation-duration: 3s;"></i></div> </div>';
                
                
            } else if (invoice.society == 'bahamas') {
                    var Elem = '<div class="bank-app-invoice" id="invoiceid-'+i+'" style="background: rgb(163,92,255) !important; background: linear-gradient(341deg, rgba(163,92,255,1) 0%, rgba(82,28,180,1) 100%) !important;"> <div class="bank-app-invoice-title">'+"Bahamas"+' <span style="font-size: 1vh; color: rgba(23, 23, 23, 90%);">(Envio: '+invoice.sender+')</span></div> <div class="bank-app-invoice-amount">'+invoice.amount+' &dollar;</div> <div class="bank-app-invoice-buttons"> <i class="fas fa-check-circle fa-shake pay-invoice" style="--fa-animation-duration: 3s;"></i></div> </div>';
                
                
            } else if (invoice.society == 'split') {
                    var Elem = '<div class="bank-app-invoice" id="invoiceid-'+i+'" style="background: rgb(172,21,159) !important; background: linear-gradient(341deg, rgba(172,21,159,1) 0%, rgba(180,28,28,1) 100%) !important;"> <div class="bank-app-invoice-title">'+"SplitSides"+' <span style="font-size: 1vh; color: rgba(23, 23, 23, 90%);">(Envio: '+invoice.sender+')</span></div> <div class="bank-app-invoice-amount">'+invoice.amount+' &dollar;</div> <div class="bank-app-invoice-buttons"> <i class="fas fa-check-circle fa-shake pay-invoice" style="--fa-animation-duration: 3s;"></i></div> </div>';
                
                
            } else {

                    var Elem = '<div class="bank-app-invoice" id="invoiceid-'+i+'"> <div class="bank-app-invoice-title">'+invoice.society+' <span style="font-size: 1vh; color: rgba(23, 23, 23, 90%);">(Envio: '+invoice.sender+')</span></div> <div class="bank-app-invoice-amount">'+invoice.amount+' &dollar;</div> <div class="bank-app-invoice-buttons"> <i class="fas fa-check-circle fa-shake pay-invoice" style="--fa-animation-duration: 3s;"></i></div> </div>';
                
                
            } 
            $(".bank-app-invoices-list").append(Elem);
            $("#invoiceid-"+i).data('invoicedata', invoice);
        }); 
    } else {
        var Elem = '<div class="bank-app-invoice" id="invoiceid-'+"1"+'" style="background: rgb(74,162,29) !important; background: linear-gradient(341deg, rgba(74,162,29,1) 0%, rgba(91,210,30,1) 100%) !important;"> <div class="bank-app-invoice-title">'+"Tudo em dia!"+' <span style="font-size: 1vh; color: rgba(23, 23, 23, 90%);">(Envio: '+invoice.sender+')</span></div> <div class="bank-app-invoice-amount">&#36; '+invoice.amount+'</div> <div class="bank-app-invoice-buttons"> <i class="fas fa-check-circle pay-invoice"></i></div> </div>';

        $(".bank-app-invoices-list").append(Elem);
        $("#invoiceid-"+"1").data('invoicedata', "nenhuma");
    }
}

JPR.Phone.Functions.LoadContactsWithNumber = function(myContacts) {
    var ContactsObject = $(".bank-app-my-contacts-list");
    $(ContactsObject).html("");
    var TotalContacts = 0;

    $("#bank-app-my-contact-search").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $(".bank-app-my-contacts-list .bank-app-my-contact").filter(function() {
          $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });

    if (myContacts !== null) {
        $.each(myContacts, function(i, contact){
            var RandomNumber = Math.floor(Math.random() * 6);
            var ContactColor = JPR.Phone.ContactColors[RandomNumber];
            var ContactElement = '<div class="bank-app-my-contact" data-bankcontactid="'+i+'"> <div class="bank-app-my-contact-firstletter">'+((contact.name).charAt(0)).toUpperCase()+'</div> <div class="bank-app-my-contact-name">'+contact.name+'</div> </div>'
            TotalContacts = TotalContacts + 1
            $(ContactsObject).append(ContactElement);
            $("[data-bankcontactid='"+i+"']").data('contactData', contact);
        });
    }
};

$(document).on('click', '.bank-app-my-contacts-list-back', function(e){
    e.preventDefault();

    JPR.Phone.Animations.TopSlideUp(".bank-app-my-contacts", 400, -100);
});

$(document).on('click', '.jarda4-number', function(e){
    e.preventDefault();

    JPR.Phone.Animations.TopSlideDown(".bank-app-my-contacts", 400, 0);
});

$(document).on('click', '.bank-app-my-contact', function(e){
    e.preventDefault();
    var PressedContactData = $(this).data('contactData');

    if (PressedContactData.iban !== "" && PressedContactData.iban !== undefined && PressedContactData.iban !== null) {
        $("#bank-transfer-iban").val(PressedContactData.iban);
    } else {
        JPR.Phone.Notifications.Add("wallet.png", "WBank", "This number is not associated with any bank account!", "#badc58", 2500);
    }
    JPR.Phone.Animations.TopSlideUp(".bank-app-my-contacts", 400, -100);
});