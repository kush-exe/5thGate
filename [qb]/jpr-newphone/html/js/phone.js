var ContactSearchActive = false;
var CurrentFooterTab = "contacts";
var CallData = {};
var ClearNumberTimer = null;
var SelectedSuggestion = null;
var AmountOfSuggestions = 0;
var keyPadHTML;
var contadordocaralho = 0;
var contadorsug = 0;

$(document).on('click', '.phone-app-footer-button', function(e){
    e.preventDefault();

    var PressedFooterTab = $(this).data('phonefootertab');

    if (PressedFooterTab !== CurrentFooterTab) {
        var PreviousTab = $(this).parent().find('[data-phonefootertab="'+CurrentFooterTab+'"');

        $('.phone-app-footer').find('[data-phonefootertab="'+CurrentFooterTab+'"').removeClass('phone-selected-footer-tab');
        $(this).addClass('phone-selected-footer-tab');

        $(".phone-"+CurrentFooterTab).hide();
        $(".phone-"+PressedFooterTab).show();

        if (PressedFooterTab == "recent") {
            $.post('https://jpr-newphone/ClearRecentAlerts');
        } else if (PressedFooterTab == "suggestedcontacts") {
            $.post('https://jpr-newphone/ClearRecentAlerts');
        }

        CurrentFooterTab = PressedFooterTab;
    }
});

$(document).on("click", "#phone-search-icon", function(e){
    e.preventDefault();

    if (!ContactSearchActive) {
        $("#phone-plus-icon").animate({
            opacity: "0.0",
            "display": "none"
        }, 150, function(){
            $("#contact-search").css({"display":"block"}).animate({
                opacity: "1.0",
            }, 150);
        });
    } else {
        $("#contact-search").animate({
            opacity: "0.0"
        }, 150, function(){
            $("#contact-search").css({"display":"none"});
            $("#phone-plus-icon").animate({
                opacity: "1.0",
                display: "block",
            }, 150);
        });
    }

    ContactSearchActive = !ContactSearchActive;
});


JPR.Phone.Functions.SetupRecentCalls = function(recentcalls) {
    $(".phone-recent-calls").html("");

    recentcalls = recentcalls.reverse();
    contadordocaralho = 0;
    $.each(recentcalls, function(i, recentCall){
        var FirstLetter = (recentCall.name).charAt(0);
        var TypeIcon = 'fas fa-phone-slash';
        var IconStyle = "color: #e74c3c;";
        if (recentCall.type === "outgoing") {
            TypeIcon = 'fas fa-phone-volume';
            var IconStyle = "color: #2ecc71; font-size: 1.4vh;";
        }
        if (recentCall.anonymous) {
            FirstLetter = "A";
            recentCall.name = "Desconhecido";
        }
        var elem = '<div class="phone-recent-call" id="recent-'+i+'"><div class="phone-recent-call-image">'+FirstLetter+'</div> <div class="phone-recent-call-name">'+recentCall.name+'</div> <div class="phone-recent-call-type"><i class="'+TypeIcon+' fa-shake" style="'+IconStyle+';--fa-animation-duration: 3s;"></i></div> <div class="phone-recent-call-time">'+recentCall.time+'</div> </div>'

        $(".phone-recent-calls").append(elem);
        $("#recent-"+i).data('recentData', recentCall);
        contadordocaralho = contadordocaralho+1;
    });
    if (contadordocaralho < 1) {
        var elem = '<div class="phone-recent-call" id="recent-'+"1"+'"><div class="phone-recent-call-image"><i class="fa-solid fa-circle-exclamation fa-shake" style="--fa-animation-duration: 3s;"></i></div> <div class="phone-recent-call-name" style="margin-top: 1.25vh !important;">'+"No call logging"+'</div> <div class="phone-recent-call-type"><i class="'+"TypeIcon"+'" style="'+"IconStyle"+'"></i></div> <div class="phone-recent-call-time">'+""+'</div> </div>'

        $(".phone-recent-calls").append(elem);
        $("#recent-"+"1").data('recentData', "nenhuma");
    }
}

$(document).on('click', '.phone-recent-call', function(e){
    e.preventDefault();

    if (contadordocaralho >= 1) {
        var RecendId = $(this).attr('id');
        var RecentData = $("#"+RecendId).data('recentData');

        cData = {
            number: RecentData.number,
            name: RecentData.name
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
                                JPR.Phone.Notifications.Add("phone.png", "Phone", "You started an anonymous call!", "#13a10b");
                            }
                            $(".phone-call-outgoing").css({"display":"block"});
                            $(".phone-header").css({"color":"white"});
                            $(".phone-home-button").css({"background-color":"rgba(232, 232, 232, 0.9)"});
                            $(".phone-call-incoming").css({"display":"none"});
                            $(".phone-call-ongoing").css({"display":"none"});
                            $(".phone-call-outgoing-caller").html(cData.name);
                            JPR.Phone.Functions.HeaderTextColor("white", 400);
                            JPR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                            setTimeout(function(){
                                $(".phone-app").css({"display":"none"});
                                JPR.Phone.Animations.TopSlideDown('.phone-application-container', 400, 0);
                                JPR.Phone.Functions.ToggleApp("phone-call", "block");
                            }, 450);

                            CallData.name = cData.name;
                            CallData.number = cData.number;

                            JPR.Phone.Data.currentApplication = "phone-call";
                        } else {
                            JPR.Phone.Notifications.Add("phone.png", "Phone", "You are already on a call!", "#13a10b");
                        }
                    } else {
                        JPR.Phone.Notifications.Add("phone.png", "Phone", "This person is busy!", "#13a10b");
                    }
                } else {
                    JPR.Phone.Notifications.Add("phone.png", "Phone", "This person is not available!", "#13a10b");
                }
            } else {
                JPR.Phone.Notifications.Add("phone.png", "Phone", "You can't call yourself!", "#13a10b");
            }
        });
    } else {
        JPR.Phone.Notifications.Add("phone.png", "Phone", "Go make friends!", "#13a10b");
    }
});

$(document).on('click', ".phone-keypad-key-call", function(e){
    e.preventDefault();

    var InputNum = keyPadHTML;

    cData = {
        number: InputNum,
        name: InputNum,
    }

    $.post('https://jpr-newphone/CallContact', JSON.stringify({
        ContactData: cData,
        Anonymous: JPR.Phone.Data.AnonymousCall,
    }), function(status){
        if (cData.number !== JPR.Phone.Data.PlayerData.charinfo.phone) {
            if (status.IsOnline) {
                if (status.CanCall) {
                    if (!status.InCall) {
                        $(".phone-call-outgoing").css({"display":"block"});
                        $(".phone-call-incoming").css({"display":"none"});
                        $(".phone-call-ongoing").css({"display":"none"});
                        $(".phone-header").css({"color":"white"});
                        $(".phone-home-button").css({"background-color":"rgba(232, 232, 232, 0.9)"});
                        $(".phone-call-outgoing-caller").html(cData.name);
                        JPR.Phone.Functions.HeaderTextColor("white", 400);
                        JPR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                        setTimeout(function(){
                            $(".phone-app").css({"display":"none"});
                            JPR.Phone.Animations.TopSlideDown('.phone-application-container', 400, 0);
                            JPR.Phone.Functions.ToggleApp("phone-call", "block");
                        }, 450);

                        CallData.name = cData.name;
                        CallData.number = cData.number;

                        JPR.Phone.Data.currentApplication = "phone-call";
                    } else {
                        JPR.Phone.Notifications.Add("phone.png", "Phone", "Are you already on a call!", "#13a10b");
                    }
                } else {
                    JPR.Phone.Notifications.Add("phone.png", "Phone", "This person is busy!", "#13a10b");
                }
            } else {
                JPR.Phone.Notifications.Add("phone.png", "Phone", "This person is not available!", "#13a10b");
            }
        } else {
            JPR.Phone.Notifications.Add("phone.png", "Phone", "You can't call yourself!", "#13a10b");
        }
    });
});

JPR.Phone.Functions.LoadContacts = function(myContacts) {
    var ContactsObject = $(".phone-contact-list");
    $(ContactsObject).html("");
    var TotalContacts = 0;

    $(".phone-contacts").hide();
    $(".phone-recent").hide();
    $(".phone-keypad").hide();

    $(".phone-"+CurrentFooterTab).show();

    $("#contact-search").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $(".phone-contact-list .phone-contact").filter(function() {
          $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });

    if (myContacts !== null) {
        $.each(myContacts, function(i, contact){
            contact.name = DOMPurify.sanitize(contact.name , {
                ALLOWED_TAGS: [],
                ALLOWED_ATTR: []
            });
            if (contact.name == '') contact.name = 'Inválido...'
            var ContactElement = '<div class="phone-contact" data-contactid="'+i+'"><div class="phone-contact-firstletter" style="background-color: rgb(255, 164, 44);">'+((contact.name).charAt(0)).toUpperCase()+'</div><div class="phone-contact-name">'+contact.name+'</div><div class="phone-contact-actions"><i class="fas fa-ellipsis-v fa-fade" style="--fa-animation-duration: 3s;"></i></div><div class="phone-contact-action-buttons"><i class="fas fa-phone-volume fa-shake" style="--fa-animation-duration: 3s;" id="phone-start-call"></i> <i class="fab fa-whatsapp fa-shake" style="--fa-animation-duration: 3s;" id="new-chat-phone" style="font-size: 1.5vh;"></i> <i class="fas fa-user-edit fa-shake" style="--fa-animation-duration: 3s;" id="edit-contact"></i> </div></div>'
            if (contact.status) {
                ContactElement = '<div class="phone-contact" data-contactid="'+i+'"><div class="phone-contact-firstletter" style="background-color: #33b864;">'+((contact.name).charAt(0)).toUpperCase()+'</div><div class="phone-contact-name">'+contact.name+'</div><div class="phone-contact-actions"><i class="fas fa-ellipsis-v"></i></div><div class="phone-contact-action-buttons"> <i class="fas fa-phone-volume fa-shake" style="--fa-animation-duration: 3s;" id="phone-start-call"></i> <i class="fab fa-whatsapp fa-shake" style="--fa-animation-duration: 3s;" id="new-chat-phone" style="font-size: 1.5vh;"></i> <i class="fas fa-user-edit fa-shake" style="--fa-animation-duration: 3s;" id="edit-contact"></i> </div></div>'
            }
            TotalContacts = TotalContacts + 1
            $(ContactsObject).append(ContactElement);
            $("[data-contactid='"+i+"']").data('contactData', contact);
        });
        $("#total-contacts").text(TotalContacts+ " Contacts");
    } else {
        var ContactElement = '<div class="phone-contact" data-contactid="'+"1"+'"><div class="phone-contact-firstletter" style="background-color: rgb(255, 164, 44);">'+(("You have no contact").charAt(0)).toUpperCase()+'</div><div class="phone-contact-name">'+"You have no contact"+'</div><div class="phone-contact-actions"></div><div class="phone-contact-action-buttons"> <i class="fas fa-phone-volume" id="phone-start-call"></i> <i class="fab fa-whatsapp" id="new-chat-phone" style="font-size: 1.5vh;"></i> <i class="fas fa-user-edit" id="edit-contact"></i> </div></div>'
        $(ContactsObject).append(ContactElement);
        $("#total-contacts").text("0 Contacts");
    }
};

$(document).on('click', '#new-chat-phone', function(e){
    var ContactId = $(this).parent().parent().data('contactid');
    var ContactData = $("[data-contactid='"+ContactId+"']").data('contactData');
    
    if (ContactData.number !== JPR.Phone.Data.PlayerData.charinfo.phone) {
        $.post('https://jpr-newphone/GetWhatsappChats', JSON.stringify({}), function(chats){
            JPR.Phone.Functions.LoadWhatsappChats(chats);
        });

        $('.phone-application-container').animate({
            top: -160+"%"
        });
        JPR.Phone.Functions.HeaderTextColor("white", 400);
        setTimeout(function(){
            $('.phone-application-container').animate({
                top: 0+"%"
            });

            JPR.Phone.Functions.ToggleApp("phone", "none");
            JPR.Phone.Functions.ToggleApp("whatsapp", "block");
            JPR.Phone.Data.currentApplication = "whatsapp";

            $.post('https://jpr-newphone/GetWhatsappChat', JSON.stringify({phone: ContactData.number}), function(chat){
                JPR.Phone.Functions.SetupChatMessages(chat, {
                    name: ContactData.name,
                    number: ContactData.number
                });
            });

            $('.whatsapp-openedchat-messages').animate({scrollTop: 9999}, 150);
            $(".whatsapp-openedchat").css({"display":"block"});
            $(".whatsapp-openedchat").css({left: 0+"vh"});
            $(".whatsapp-chats").animate({left: 30+"vh"},100, function(){
                $(".whatsapp-chats").css({"display":"none"});
            });
        }, 400)
    } else {
        JPR.Phone.Notifications.Add("phone.png", "Phone", "You can't message yourself..", "#13a10b", 3500);
    }
});

var CurrentEditContactData = {}

$(document).on('click', '#edit-contact', function(e){
    e.preventDefault();
    var ContactId = $(this).parent().parent().data('contactid');
    var ContactData = $("[data-contactid='"+ContactId+"']").data('contactData');

    CurrentEditContactData.name = DOMPurify.sanitize(ContactData.name , {
        ALLOWED_TAGS: [],
        ALLOWED_ATTR: []
    });
    if (CurrentEditContactData.name == '') CurrentEditContactData.name = 'Inválido...'
    CurrentEditContactData.number = ContactData.number

    $(".phone-edit-contact-header").text(ContactData.name+" Editar")
    $(".phone-edit-contact-name").val(ContactData.name);
    $(".phone-edit-contact-number").val(ContactData.number);
    if (ContactData.iban != null && ContactData.iban != undefined) {
        $(".phone-edit-contact-iban").val(ContactData.iban);
        CurrentEditContactData.iban = ContactData.iban
    } else {
        $(".phone-edit-contact-iban").val("");
        CurrentEditContactData.iban = "";
    }

    JPR.Phone.Animations.TopSlideDown(".phone-edit-contact", 200, 0);
});

$(document).on('click', '#edit-contact-save', function(e){
    e.preventDefault();

    var ContactName = DOMPurify.sanitize($(".phone-edit-contact-name").val() , {
        ALLOWED_TAGS: [],
        ALLOWED_ATTR: []
    });
    if (ContactName == '') ContactName = 'Inválido...'
    var ContactNumber = $(".phone-edit-contact-number").val();
    var ContactIban = $(".phone-edit-contact-iban").val();

    if (ContactName != "" && ContactNumber != "") {
        $.post('https://jpr-newphone/EditContact', JSON.stringify({
            CurrentContactName: ContactName,
            CurrentContactNumber: ContactNumber,
            CurrentContactIban: ContactIban,
            OldContactName: CurrentEditContactData.name,
            OldContactNumber: CurrentEditContactData.number,
            OldContactIban: CurrentEditContactData.iban,
        }), function(PhoneContacts){
            JPR.Phone.Functions.LoadContacts(PhoneContacts);
        });
        JPR.Phone.Animations.TopSlideUp(".phone-edit-contact", 250, -100);
        setTimeout(function(){
            $(".phone-edit-contact-number").val("");
            $(".phone-edit-contact-name").val("");
        }, 250)
    } else {
        JPR.Phone.Notifications.Add("contacts.png", "Contacts", "Fill in all fields!", "#13a10b");
    }
});

$(document).on('click', '#edit-contact-delete', function(e){
    e.preventDefault();

    var ContactName = $(".phone-edit-contact-name").val();
    var ContactNumber = $(".phone-edit-contact-number").val();
    var ContactIban = $(".phone-edit-contact-iban").val();

    $.post('https://jpr-newphone/DeleteContact', JSON.stringify({
        CurrentContactName: ContactName,
        CurrentContactNumber: ContactNumber,
        CurrentContactIban: ContactIban,
    }), function(PhoneContacts){
        JPR.Phone.Functions.LoadContacts(PhoneContacts);
    });
    JPR.Phone.Animations.TopSlideUp(".phone-edit-contact", 250, -100);
    setTimeout(function(){
        $(".phone-edit-contact-number").val("");
        $(".phone-edit-contact-name").val("");
    }, 250);
});

$(document).on('click', '#edit-contact-cancel', function(e){
    e.preventDefault();

    JPR.Phone.Animations.TopSlideUp(".phone-edit-contact", 250, -100);
    setTimeout(function(){
        $(".phone-edit-contact-number").val("");
        $(".phone-edit-contact-name").val("");
    }, 250)
});

$(document).on('click', '.phone-keypad-key', function(e){
    e.preventDefault();
    var PressedButton = $(this).data('keypadvalue');
    if (!isNaN(PressedButton)) {
        keyPadHTML = $("#phone-keypad-input").text();
        $("#phone-keypad-input").text(keyPadHTML + PressedButton)
        keyPadHTML = $("#phone-keypad-input").text();
    } else if (PressedButton == "#") {
        keyPadHTML = $("#phone-keypad-input").text();
        $("#phone-keypad-input").text(keyPadHTML + PressedButton)
        keyPadHTML = $("#phone-keypad-input").text();
    } else if (PressedButton == "*") {
        if (ClearNumberTimer == null) {
            $("#phone-keypad-input").text("Limpo!")
            ClearNumberTimer = setTimeout(function(){
                $("#phone-keypad-input").text("");
                keyPadHTML = $("#phone-keypad-input").text();
                ClearNumberTimer = null;
            }, 750);
        }
    }
})

var OpenedContact = null;

$(document).on('click', '.phone-contact-actions', function(e){
    e.preventDefault();

    var FocussedContact = $(this).parent();
    var ContactId = $(FocussedContact).data('contactid');

    if (OpenedContact === null) {
        $(FocussedContact).find('.phone-contact-action-buttons').fadeIn(100);
        OpenedContact = ContactId;
    } else if (OpenedContact == ContactId) {
        $(FocussedContact).find('.phone-contact-action-buttons').fadeOut(100, function(){
            $(FocussedContact).animate({
                "height":"4.5vh"
            }, 150);
        });
        OpenedContact = null;
    } else if (OpenedContact != ContactId) {
        var PreviousContact = $(".phone-contact-list").find('[data-contactid="'+OpenedContact+'"]');
        $(PreviousContact).find('.phone-contact-action-buttons').fadeOut(100, function(){
            $(PreviousContact).animate({
                "height":"4.5vh"
            }, 150);
            OpenedContact = ContactId;
        });
        $(FocussedContact).find('.phone-contact-action-buttons').fadeIn(100);
    }
});


$(document).on('click', '#phone-plus-icon', function(e){
    e.preventDefault();

    JPR.Phone.Animations.TopSlideDown(".phone-add-contact", 200, 0);
});

$(document).on('click', '#add-contact-save', function(e){
    e.preventDefault();

        var ContactName = DOMPurify.sanitize($(".phone-add-contact-name").val() , {
            ALLOWED_TAGS: [],
            ALLOWED_ATTR: []
        });
        if (ContactName == '') ContactName = 'Inválido...'
        var ContactNumber = $(".phone-add-contact-number").val();
        var ContactIban = $(".phone-add-contact-iban").val();

        if (ContactName != "" && ContactNumber != "") {
            if (ContactName.length <= 11) {
                $.post('https://jpr-newphone/AddNewContact', JSON.stringify({
                    ContactName: ContactName,
                    ContactNumber: ContactNumber,
                    ContactIban: ContactIban,
                }), function(PhoneContacts){
                    JPR.Phone.Functions.LoadContacts(PhoneContacts);
                });
                JPR.Phone.Animations.TopSlideUp(".phone-add-contact", 250, -100);
                setTimeout(function(){
                    $(".phone-add-contact-number").val("");
                    $(".phone-add-contact-name").val("");
                }, 250)

                if (SelectedSuggestion !== null) {
                    $.post('https://jpr-newphone/RemoveSuggestion', JSON.stringify({
                        data: $(SelectedSuggestion).data('SuggestionData')
                    }));
                    $(SelectedSuggestion).remove();
                    SelectedSuggestion = null;
                    var amount = parseInt(AmountOfSuggestions);
                    if ((amount - 1) === 0) {
                        amount = 0
                    }
                    $(".amount-of-suggested-contacts").html(amount + " Contacts");
                }
            } else {
                JPR.Phone.Notifications.Add("contacts.png", "Contacts", "Extra characters!", "#13a10b");
            }
        } else {
            JPR.Phone.Notifications.Add("contacts.png", "Contacts", "Fill in all fields!", "#13a10b");
        }
    
});

$(document).on('click', '#add-contact-cancel', function(e){
    e.preventDefault();

    JPR.Phone.Animations.TopSlideUp(".phone-add-contact", 250, -100);
    setTimeout(function(){
        $(".phone-add-contact-number").val("");
        $(".phone-add-contact-name").val("");
    }, 250)
    $('.phone-app-footer').find('[data-phonefootertab="'+"contacts"+'"').removeClass('phone-selected-footer-tab');
    

    $(".phone-"+"contacts").hide();
    $(".phone-"+"contacts").show();
});

$(document).on('click', '#phone-start-call', function(e){
    e.preventDefault();

    var ContactId = $(this).parent().parent().data('contactid');
    var ContactData = $("[data-contactid='"+ContactId+"']").data('contactData');

    SetupCall(ContactData);
});

SetupCall = function(cData) {
    var retval = false;
    $.post('https://jpr-newphone/CallContact', JSON.stringify({
        ContactData: cData,
        Anonymous: JPR.Phone.Data.AnonymousCall,
    }), function(status){
        if (cData.number !== JPR.Phone.Data.PlayerData.charinfo.phone) {
            if (status.IsOnline) {
                if (status.CanCall) {
                    if (!status.InCall) {
                        $(".phone-call-outgoing").css({"display":"block"});
                        $(".phone-call-incoming").css({"display":"none"});
                        $(".phone-call-ongoing").css({"display":"none"});
                        $(".phone-header").css({"color":"white"});
                        $(".phone-home-button").css({"background-color":"rgba(232, 232, 232, 0.9)"});
                        $(".phone-call-outgoing-caller").html(cData.name);
                        JPR.Phone.Functions.HeaderTextColor("white", 400);
                        JPR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                        setTimeout(function(){
                            $(".phone-app").css({"display":"none"});
                            JPR.Phone.Animations.TopSlideDown('.phone-application-container', 400, 0);
                            JPR.Phone.Functions.ToggleApp("phone-call", "block");
                        }, 450);

                        CallData.name = cData.name;
                        CallData.number = cData.number;

                        JPR.Phone.Data.currentApplication = "phone-call";
                    } else {
                        JPR.Phone.Notifications.Add("phone.png", "Phone", "Are you already on a call!", "#13a10b");
                    }
                } else {
                    JPR.Phone.Notifications.Add("phone.png", "Phone", "This person is on call.", "#13a10b");
                }
            } else {
                JPR.Phone.Notifications.Add("phone.png", "Phone", "This person is not available!", "#13a10b");
            }
        } else {
            JPR.Phone.Notifications.Add("phone.png", "Phone", "You can't call yourself!", "#13a10b");
        }
    });
}

CancelOutgoingCall = function() {
    if (JPR.Phone.Data.currentApplication == "phone-call") {
        JPR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
        JPR.Phone.Animations.TopSlideUp('.'+JPR.Phone.Data.currentApplication+"-app", 400, -160);
        setTimeout(function(){
            JPR.Phone.Functions.ToggleApp(JPR.Phone.Data.currentApplication, "none");
        }, 400)
        JPR.Phone.Functions.HeaderTextColor("white", 300);

        JPR.Phone.Data.CallActive = false;
        JPR.Phone.Data.currentApplication = null;
    }
}

$(document).on('click', '#outgoing-cancel', function(e){
    e.preventDefault();

    $.post('https://jpr-newphone/CancelOutgoingCall');
});

$(document).on('click', '#incoming-deny', function(e){
    e.preventDefault();

    $.post('https://jpr-newphone/DenyIncomingCall');
});

$(document).on('click', '#ongoing-cancel', function(e){
    e.preventDefault();

    $.post('https://jpr-newphone/CancelOngoingCall');
});

IncomingCallAlert = function(CallData, Canceled, AnonymousCall) {
    
    if (!Canceled) {
        var Label = "You have a call from "+CallData.name
                if (AnonymousCall) {
                    Label = "Anonymous Call"
                }
            JPR.Phone.Notifications.Add("phone.png", "Incoming Call", Label, 'green', 4000)

            
        if (!JPR.Phone.Data.CallActive) {
            
            /*console.log('1')
            JPR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
            JPR.Phone.Animations.TopSlideUp('.'+JPR.Phone.Data.currentApplication+"-app", 400, -160);
            console.log('2')
            setTimeout(function(){
                console.log('3')
                var Label = "You have a call from "+CallData.name
                if (AnonymousCall) {
                    Label = "Anonymous Call"
                }
                $(".call-notifications-title").html("Receiving Call");
                $(".call-notifications-content").html(Label);
                $(".call-notifications").css({"display":"block"});
                $(".call-notifications").animate({
                    right: 5+"vh"
                }, 400);
                $(".phone-call-outgoing").css({"display":"none"});
                $(".phone-call-incoming").css({"display":"block"});
                $(".phone-call-ongoing").css({"display":"none"});
                $(".phone-call-incoming-caller").html(CallData.name);
                $(".phone-app").css({"display":"none"});
                JPR.Phone.Functions.HeaderTextColor("white", 400);
                $("."+JPR.Phone.Data.currentApplication+"-app").css({"display":"none"});
                $(".phone-call-app").css({"display":"block"});
                $(".phone-header").css({"color":"white"});
                $(".phone-home-button").css({"background-color":"rgba(232, 232, 232, 0.9)"});
                setTimeout(function(){
                    JPR.Phone.Animations.TopSlideDown('.phone-application-container', 400, 0);
                }, 400);
            }, 400);*/
            /*var Label = "You have a call from "+CallData.name
                if (AnonymousCall) {
                    Label = "Anonymous Call"
                }
            JPR.Phone.Notifications.Add('phone.png', "Incoming Call", Label, 'green', 3000)

            JPR.Phone.Data.currentApplication = "phone-call";
            JPR.Phone.Data.CallActive = true;&/*/
            $(".phone-call-outgoing").css({"display":"none"});
            $(".phone-call-incoming").css({"display":"block"});
            $(".phone-call-ongoing").css({"display":"none"});
            $(".phone-call-incoming-caller").html(CallData.name);
            $(".phone-app").css({"display":"none"});
            JPR.Phone.Functions.HeaderTextColor("white", 400);
            $("."+JPR.Phone.Data.currentApplication+"-app").css({"display":"none"});
            $(".phone-call-app").css({"display":"block"});
            $(".phone-header").css({"color":"white"});
            $(".phone-home-button").css({"background-color":"rgba(232, 232, 232, 0.9)"});
            JPR.Phone.Data.currentApplication = "phone-call";
            JPR.Phone.Data.CallActive = true;
        }
        setTimeout(function(){
            $(".call-notifications").addClass('call-notifications-shake');
            setTimeout(function(){
                $(".call-notifications").removeClass('call-notifications-shake');
            }, 1000);
        }, 400);
    } else {
        $(".call-notifications").animate({
            right: -35+"vh"
        }, 400);
        JPR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
        JPR.Phone.Animations.TopSlideUp('.'+JPR.Phone.Data.currentApplication+"-app", 400, -160);
        console.log('triggered call 0')
        setTimeout(function(){
            $("."+JPR.Phone.Data.currentApplication+"-app").css({"display":"none"});
            $(".phone-call-outgoing").css({"display":"none"});
            $(".phone-call-incoming").css({"display":"none"});
            $(".phone-call-ongoing").css({"display":"none"});
            $(".call-notifications").css({"display":"block"});
            $(".phone-header").css({"color":"white"});
            $(".phone-home-button").css({"background-color":"rgba(232, 232, 232, 0.9)"});
        }, 400)
        JPR.Phone.Functions.HeaderTextColor("white", 300);
        JPR.Phone.Data.CallActive = false;
        JPR.Phone.Data.currentApplication = null;
    }
}

// IncomingCallAlert = function(CallData, Canceled) {
//     if (!Canceled) {
//         if (!JPR.Phone.Data.CallActive) {
//             $(".call-notifications-title").html("Inkomende Oproep");
//             $(".call-notifications-content").html("Je hebt een inkomende oproep van "+CallData.name);
//             $(".call-notifications").css({"display":"block"});
//             $(".call-notifications").animate({
//                 right: 5+"vh"
//             }, 400);
//             $(".phone-call-outgoing").css({"display":"none"});
//             $(".phone-call-incoming").css({"display":"block"});
//             $(".phone-call-ongoing").css({"display":"none"});
//             $(".phone-call-incoming-caller").html(CallData.name);
//             $(".phone-app").css({"display":"none"});
//             JPR.Phone.Functions.HeaderTextColor("white", 400);
//             JPR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
//             $(".phone-call-app").css({"display":"block"});
//             setTimeout(function(){
//                 JPR.Phone.Animations.TopSlideDown('.phone-application-container', 400, 0);
//             }, 450);

//             JPR.Phone.Data.currentApplication = "phone-call";
//             JPR.Phone.Data.CallActive = true;
//         }
//         setTimeout(function(){
//             $(".call-notifications").addClass('call-notifications-shake');
//             setTimeout(function(){
//                 $(".call-notifications").removeClass('call-notifications-shake');
//             }, 1000);
//         }, 400);
//     } else {
//         $(".call-notifications").animate({
//             right: -35+"vh"
//         }, 400);
//         JPR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
//         JPR.Phone.Animations.TopSlideUp('.'+JPR.Phone.Data.currentApplication+"-app", 400, -160);
//         setTimeout(function(){
//             JPR.Phone.Functions.ToggleApp(JPR.Phone.Data.currentApplication, "none");
//             $(".phone-call-outgoing").css({"display":"none"});
//             $(".phone-call-incoming").css({"display":"none"});
//             $(".phone-call-ongoing").css({"display":"none"});
//             $(".call-notifications").css({"display":"block"});
//         }, 400)
//         JPR.Phone.Functions.HeaderTextColor("white", 300);

//         JPR.Phone.Data.CallActive = false;
//         JPR.Phone.Data.currentApplication = null;
//     }
// }

JPR.Phone.Functions.SetupCurrentCall = function(cData) {
    if (cData.InCall) {
        CallData = cData;
        $(".phone-currentcall-container").css({"display":"block"});

        //if (ecrabloq == true) {
           // $(".phone-currentcall-container").css({"top":"20vh"});
        //} else {
           // $(".phone-currentcall-container").css({"top":"60vh"});
        //}

        if (cData.CallType == "incoming") {
            $(".phone-currentcall-title").html("Incoming Call");
        } else if (cData.CallType == "outgoing") {
            $(".phone-currentcall-title").html("Calling");
        } else if (cData.CallType == "ongoing") {
            $(".phone-currentcall-title").html("Active Call ("+cData.CallTime+")");
        }

        $(".phone-currentcall-contact").html(cData.TargetData.name);
    } else {
        $(".phone-currentcall-container").css({"display":"none"});
    }
}

$(document).on('click', '.phone-currentcall-container', function(e){
    e.preventDefault();

    if (CallData.CallType == "incoming") {
        $(".phone-call-incoming").css({"display":"block"});
        $(".phone-call-outgoing").css({"display":"none"});
        $(".phone-call-ongoing").css({"display":"none"});
        $(".phone-header").css({"color":"white"});
        $(".phone-home-button").css({"background-color":"rgba(232, 232, 232, 0.9)"});
    } else if (CallData.CallType == "outgoing") {
        $(".phone-call-incoming").css({"display":"none"});
        $(".phone-call-outgoing").css({"display":"block"});
        $(".phone-call-ongoing").css({"display":"none"});
        $(".phone-header").css({"color":"white"});
        $(".phone-home-button").css({"background-color":"rgba(232, 232, 232, 0.9)"});
    } else if (CallData.CallType == "ongoing") {
        $(".phone-call-incoming").css({"display":"none"});
        $(".phone-call-outgoing").css({"display":"none"});
        $(".phone-call-ongoing").css({"display":"block"});
        $(".phone-header").css({"color":"white"});
        $(".phone-home-button").css({"background-color":"rgba(232, 232, 232, 0.9)"});
    }
    $(".phone-call-ongoing-caller").html(CallData.name);

    JPR.Phone.Functions.HeaderTextColor("white", 500);
    JPR.Phone.Animations.TopSlideDown('.phone-application-container', 500, 0);
    JPR.Phone.Animations.TopSlideDown('.phone-call-app', 500, 0);
    JPR.Phone.Functions.ToggleApp("phone-call", "block");
    $(".phone-header").css({"color":"white"});
    $(".phone-home-button").css({"background-color":"rgba(232, 232, 232, 0.9)"});

    JPR.Phone.Data.currentApplication = "phone-call";
});

$(document).on('click', '#incoming-answer', function(e){
    e.preventDefault();

    $.post('https://jpr-newphone/AnswerCall');
});

JPR.Phone.Functions.AnswerCall = function(CallData) {
    $(".phone-call-incoming").css({"display":"none"});
    $(".phone-call-outgoing").css({"display":"none"});
    $(".phone-call-ongoing").css({"display":"block"});
    $(".phone-call-ongoing-caller").html(CallData.TargetData.name);
    $(".phone-header").css({"color":"white"});
    $(".phone-home-button").css({"background-color":"rgba(232, 232, 232, 0.9)"});
    JPR.Phone.Functions.Close();
}


JPR.Phone.Functions.SetupSuggestedContacts = function(Suggested) {
    $(".suggested-contacts").html("");
    AmountOfSuggestions = Suggested.length;
    
    if (AmountOfSuggestions > 0) {
        $(".amount-of-suggested-contacts").html(AmountOfSuggestions + " Contacts");
        Suggested = Suggested.reverse();
        $.each(Suggested, function(index, suggest){
            var elem = '<div class="suggested-contact" id="suggest-'+index+'" style= "width: 90%;"><div class="phone-recent-call-image"><i class="fa-solid fa-circle-exclamation fa-shake" style="--fa-animation-duration: 3s;"></i></div> <div class="phone-recent-call-name" style="margin-top: 1.25vh !important;">'+suggest.name[0]+' '+suggest.name[1]+ '&nbsp;&middot;&nbsp;'+ suggest.number + '</div> <div class="phone-recent-call-type"><i class="'+"TypeIcon"+'" style="'+"IconStyle"+'"></i></div> <div class="phone-recent-call-time">'+""+'</div> </div>'
            $(".suggested-contacts").append(elem);
            $("#suggest-"+index).data('SuggestionData', suggest);
        });
    } else {
        var elem = '<div class="suggested-contact" id="suggest-'+"1"+'" style= "width: 90%;"><div class="phone-recent-call-image"><i class="fa-solid fa-circle-exclamation fa-shake" style="--fa-animation-duration: 3s;"></i></div> <div class="phone-recent-call-name" style="margin-top: 1.25vh !important;">You have no suggestion</div> <div class="phone-recent-call-type"><i class="'+"TypeIcon"+'" style="'+"IconStyle"+'"></i></div> <div class="phone-recent-call-time">'+""+'</div> </div>'
        $(".suggested-contacts").append(elem);
        $("#suggest-"+"1").data('SuggestionData', "nenhum");
    }
    contadorsug = AmountOfSuggestions;
}

$(document).on('click', '.suggested-contact', function(e){
    e.preventDefault();

    if(contadorsug >= 1) {
        var SuggestionData = $(this).data('SuggestionData');
        SelectedSuggestion = this;

        JPR.Phone.Animations.TopSlideDown(".phone-add-contact", 200, 0);

        $(".phone-add-contact-name").val(SuggestionData.name[0] + " " + SuggestionData.name[1]);
        $(".phone-add-contact-number").val(SuggestionData.number);
        $(".phone-add-contact-iban").val(SuggestionData.bank);
    } else {
        JPR.Phone.Notifications.Add("phone.png", "Phone", "Go make friends!", "#13a10b");
    }
});