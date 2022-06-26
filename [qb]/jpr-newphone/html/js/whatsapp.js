var WhatsappSearchActive = false;
var OpenedChatPicture = null;
var ExtraButtonsOpen = false;
var fazergrupo = false;
var nomegrupo = '';
var editargrupo = false;
var nomeantigo = null;


$(document).ready(function(){
    $("#whatsapp-search-input").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $(".whatsapp-chats .whatsapp-chat").filter(function() {
          $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });
});

var grupo = false;
var estaemchat = false;
$(document).on('click', '#whatsapp-search-chats', function(e){
    e.preventDefault();
    grupo = true;
    $(".whatsapp-chat").css({"display":"none"});
    $(".whatsapp-grupo").css({"display":"block"});
    $.post('https://jpr-newphone/GetWhatsappGrupos', JSON.stringify({}), function(chats){
        JPR.Phone.Functions.LoadWhatsappChats(chats);
    });
    
});


function AtualizarVars(testeunicoinovador) {
    estaemchat = testeunicoinovador;
}



$(document).on('click', '#whatsapp-search-chats2', function(e){
    e.preventDefault();
    grupo = true;
    if (grupo == true && estaemchat == false) {
        $(".whatsapp-chat").css({"display":"none"});
        $(".whatsapp-grupo").css({"display":"block"});
        $.post('https://jpr-newphone/GetWhatsappGrupos', JSON.stringify({}), function(chats){
            JPR.Phone.Functions.LoadWhatsappChats(chats);
        });
        if (grupo == false) {
            $(".whatsapp-extra-buttons2").animate({
                right: -15+"vh"
            }, 250, function(){
                $(".whatsapp-extra-buttons2").css({"display":"block"});
                ExtraButtonsOpen = false;
            });
        } else {
            $(".whatsapp-extra-buttons2").animate({
                right: -20+"vh"
            }, 250, function(){
                $(".whatsapp-extra-buttons2").css({"display":"block"});
                ExtraButtonsOpen = false;
            });  
        }
        
        $("#whatsapp-search-input").fadeOut(150);
        WhatsappSearchActive = false;
    } else if (grupo == true && estaemchat == true) {
        if (grupo == false) {
            $(".whatsapp-extra-buttons2").animate({
                right: -15+"vh"
            }, 250, function(){
                $(".whatsapp-extra-buttons2").css({"display":"block"});
                ExtraButtonsOpen = false;
            });
        } else {
            $(".whatsapp-extra-buttons2").animate({
                right: -20+"vh"
            }, 250, function(){
                $(".whatsapp-extra-buttons2").css({"display":"block"});
                ExtraButtonsOpen = false;
            });  
        }
        e.preventDefault();
        //grupo = false;
        estaemchat = true;
        $.post("https://jpr-newphone/evitarnotifsnochat", JSON.stringify({estaemchat}));
        $(".whatsapp-extra-buttons2").animate({
            right: -20+"vh"
        }, 250, function(){
            $(".whatsapp-extra-buttons2").css({"display":"block"});
            ExtraButtonsOpen = false;
        });
        $("#whatsapp-search-input").fadeOut(150);
        WhatsappSearchActive = false;
    
        if (grupo == false) {
            $.post('https://jpr-newphone/GetWhatsappChats', JSON.stringify({}), function(chats){
                JPR.Phone.Functions.LoadWhatsappChats(chats);
            });
        } else {
            $.post('https://jpr-newphone/GetWhatsappGrupos', JSON.stringify({}), function(chats){
                JPR.Phone.Functions.LoadWhatsappChats(chats);
            }); 
        }
        OpenedChatData.number = null;
        $(".whatsapp-chats").css({"display":"block"});
        $(".whatsapp-chats").animate({
            left: 0+"vh"
        }, 200);
        $(".whatsapp-openedchat").animate({
            left: -30+"vh"
        }, 200, function(){
            $(".whatsapp-openedchat").css({"display":"none"});
        });
        OpenedChatPicture = null;
        
        $("#whatsapp-search-input").fadeOut(150);
        WhatsappSearchActive = false;
        $.post("https://jpr-newphone/RemoverGrupo", JSON.stringify({nomegrupo}));
        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Left the group!", "#25D366", 1750);
        setTimeout(function(){
            $.post('https://jpr-newphone/GetWhatsappGrupos', JSON.stringify({}), function(chats){
            JPR.Phone.Functions.LoadWhatsappChats(chats);}); 
        },400);
        estaemchat = false;
        setTimeout(function(){
            $.post("https://jpr-newphone/evitarnotifsnochat", JSON.stringify({estaemchat}));
        },1000);
    }
});
//if (grupo == false && estaemchat == false) {
$(document).on('click', '#whatsapp-search-chats3', function(e){
    e.preventDefault();
    
    if (grupo == false) {
        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Only for groups and in chat!", "#25D366", 1750);
    } else {
        if (estaemchat == true) {
            $(".whatsapp-extra-buttons2").animate({
                right: -20+"vh"
            }, 250, function(){
                $(".whatsapp-extra-buttons2").css({"display":"block"});
                ExtraButtonsOpen = false;
            });
            if ($("#whatsapp-search-input").css('display') == "none") {
                $("#whatsapp-search-input").fadeIn(150);
                WhatsappSearchActive = true;
            } else {
                $("#whatsapp-search-input").fadeOut(150);
                WhatsappSearchActive = false;
            }
        }  else {
            $(".whatsapp-extra-buttons2").animate({
                right: -20+"vh"
            }, 250, function(){
                $(".whatsapp-extra-buttons2").css({"display":"block"});
                ExtraButtonsOpen = false;
            });
            if ($(".whatsapp-search-input2").css('display') == "none") {
                $(".whatsapp-search-input2").fadeIn(150);
                fazergrupo = true
                WhatsappSearchActive = true;
            } else {
                $("#whatsapp-search-input").fadeOut(150);
                WhatsappSearchActive = false;
            }
        }
        //$.post('https://jpr-newphone/GetWhatsappGrupos', JSON.stringify({}), function(chats){
        //    JPR.Phone.Functions.LoadWhatsappChats(chats);
        //});
    }
    
});

$(document).on('click', '#sair-aba', function(e){
    e.preventDefault();
    $(".whatsapp-search-input2").css({"display":"none"});
    fazergrupo = false;
    $(".whatsapp-search-input5").css({"display":"none"});
    editargrupo = false;
});

function containsWhitespace(str) {
    return /\s/.test(str);
}

var format = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+/;
$(document).on('click', '#enviar-aba', function(e){
    e.preventDefault();
            
    var nomeescrito = $(".custom-grupo-input").val();
    var nomeescrito2 = $(".custom-grupo2-input").val();
    var datademacho = GetCurrentDateKey();
    var tempodemacho = FormatMessageTime();

    if (nomeescrito !== null && nomeescrito !== undefined && nomeescrito !== "") {
        var quantidade2 = nomeescrito.length
        if (quantidade2 < 1) {
            JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Name too small!", "#25D366", 1750);
        } else if (quantidade2 > 15) {
            JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Big name!", "#25D366", 1750);
        } else {
            var espaco = containsWhitespace(nomeescrito)
            if (espaco == false) {
                if (format.test(nomeescrito) == false) {
                    estaemchat = true;
                    $.post("https://jpr-newphone/evitarnotifsnochat", JSON.stringify({estaemchat}));
                    //$.post("https://jpr-newphone/AdicionarGrupo", JSON.stringify({nomeescrito, nomeescrito2}));
                    $.post('https://jpr-newphone/AdicionarGrupo', JSON.stringify({nomeescrito, nomeescrito2}), function(data){
                            ///console.log(data.podecriar)
                        if (data.podecriar == true) {
                            $.post("https://jpr-newphone/AdicionarGrupoJarda", JSON.stringify({nomeescrito, nomeescrito2, datademacho, tempodemacho}));
                            $(".whatsapp-search-input2").css({"display":"none"});
                            JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Successfully created!", "#25D366", 1750);
                            setTimeout(function(){
                                $.post('https://jpr-newphone/GetWhatsappGrupos', JSON.stringify({}), function(chats){
                                JPR.Phone.Functions.LoadWhatsappChats(chats);}); 
                            },400);
                            estaemchat = false;
                            setTimeout(function(){
                                $.post("https://jpr-newphone/evitarnotifsnochat", JSON.stringify({estaemchat}));
                            },1000);
                            fazergrupo = false;
                        } else {
                            JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "That name already exists!", "#25D366", 1750);
                        }
                    })
                    //$.post("https://jpr-newphone/AdicionarGrupo", JSON.stringify({}), function(data){
                        //console.log(data.nome)
                    //})
                } else {
                    JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Cannot have special characters!", "#25D366", 1750);
                }
            } else {
                JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Cannot have spaces!", "#25D366", 1750);
            }
        }
    } else {
        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "You have to name the group!", "#25D366", 1750);
    }
});

$(document).on('click', '#enviar-aba2', function(e){
    e.preventDefault();
            
    var nomeescrito3 = $(".custom-grupo3-input").val();
    var nomeescrito4 = $(".custom-grupo4-input").val();

    
        
            
           
                estaemchat = true;
                $.post("https://jpr-newphone/evitarnotifsnochat", JSON.stringify({estaemchat}));
                //$.post("https://jpr-newphone/AdicionarGrupo", JSON.stringify({nomeescrito, nomeescrito2}));
                nomeescrito = nomeescrito3;
                nomeescrito2 = nomeescrito4;
                
                        ///console.log(data.podecriar)
                    
                        $.post("https://jpr-newphone/EditarGrupoJarda", JSON.stringify({nomeescrito3, nomeescrito4, nomeantigo}));
                        $(".whatsapp-search-input5").css({"display":"none"});
                        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Edited successfully!", "#25D366", 1750);
                        OpenedChatData.number = null;
                        $(".whatsapp-chats").css({"display":"block"});
                        $(".whatsapp-chats").animate({
                            left: 0+"vh"
                        }, 200);
                        $(".whatsapp-openedchat").animate({
                            left: -30+"vh"
                        }, 200, function(){
                            $(".whatsapp-openedchat").css({"display":"none"});
                        });
                        OpenedChatPicture = null;
                        setTimeout(function(){
                            $.post('https://jpr-newphone/GetWhatsappGrupos', JSON.stringify({}), function(chats){
                            JPR.Phone.Functions.LoadWhatsappChats(chats);}); 
                        },400);
                        estaemchat = false;
                        setTimeout(function(){
                            $.post("https://jpr-newphone/evitarnotifsnochat", JSON.stringify({estaemchat}));
                        },1000);
                        editargrupo = false;
                        grupo = true;
                        estaemchat = false;
                    
               
                //$.post("https://jpr-newphone/AdicionarGrupo", JSON.stringify({}), function(data){
                    //console.log(data.nome)
                //})
           
});

$(document).on('click', '.whatsapp-chat', function(e){
    e.preventDefault();
    if (fazergrupo == false) {
        if (editargrupo == false) {
            var ChatId = $(this).attr('id');
            var ChatData = $("#"+ChatId).data('chatdata');
            if (ChatData != "nenhum") {
                estaemchat = true;
                $.post("https://jpr-newphone/evitarnotifsnochat", JSON.stringify({estaemchat}));
                JPR.Phone.Functions.SetupChatMessages(ChatData);
                nomeantigo = ChatData.number;
                if (grupo == false ) {
                    $.post('https://jpr-newphone/ClearAlerts', JSON.stringify({
                        number: ChatData.number
                    }));
                } else {
                    nomegrupo = ChatData.number;
                    $.post('https://jpr-newphone/ClearAlertsGrupos', JSON.stringify({
                        number: ChatData.number
                    }));  
                }
                $.post('https://jpr-newphone/GetWhatsappGrupos', JSON.stringify({}), function(chats){
                    JPR.Phone.Functions.LoadWhatsappChats(chats);
                }); 
                if (WhatsappSearchActive) {
                    $("#whatsapp-search-input").fadeOut(150);
                }

                $(".whatsapp-extra-buttons2").animate({
                    right: -20+"vh"
                }, 250, function(){
                    $(".whatsapp-extra-buttons2").css({"display":"block"});
                    ExtraButtonsOpen = false;
                });

                $(".whatsapp-openedchat").css({"display":"block"});
                $(".whatsapp-openedchat").animate({
                    left: 0+"vh"
                },200);

                $(".whatsapp-chats").animate({
                    left: 30+"vh"
                },200, function(){
                    $(".whatsapp-chats").css({"display":"none"});
                });

                $('.whatsapp-openedchat-messages').animate({scrollTop: 9999}, 150);

                
                    if (OpenedChatPicture == null) {
                        OpenedChatPicture = "./img/default.png";
                        if (ChatData.picture != null || ChatData.picture != undefined || ChatData.picture != "default") {
                            OpenedChatPicture = ChatData.picture
                        }
                        $(".whatsapp-openedchat-picture").css({"background-image":"url("+OpenedChatPicture+")"});
                    }
            } else {
                JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "You don't have conversations!", "#25D366", 1750);
            }   
        } else {
            JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Finish editing!", "#25D366", 1750);
        }
    } else {
        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Finish creation!", "#25D366", 1750);
    }

    
});

$(document).on('click', '#whatsapp-openedchat-back', function(e){
    e.preventDefault();
    //grupo = false;
    if (editargrupo == false) {
        estaemchat = false;
        nomeantigo = '';
        $.post("https://jpr-newphone/evitarnotifsnochat", JSON.stringify({estaemchat}));
        $(".whatsapp-extra-buttons2").animate({
            right: -20+"vh"
        }, 250, function(){
            $(".whatsapp-extra-buttons2").css({"display":"block"});
            ExtraButtonsOpen = false;
        });
        $("#whatsapp-search-input").fadeOut(150);
        WhatsappSearchActive = false;

        if (grupo == false) {
            $.post('https://jpr-newphone/GetWhatsappChats', JSON.stringify({}), function(chats){
                JPR.Phone.Functions.LoadWhatsappChats(chats);
            });
        } else {
            $.post('https://jpr-newphone/GetWhatsappGrupos', JSON.stringify({}), function(chats){
                JPR.Phone.Functions.LoadWhatsappChats(chats);
            }); 
        }
        OpenedChatData.number = null;
        $(".whatsapp-chats").css({"display":"block"});
        $(".whatsapp-chats").animate({
            left: 0+"vh"
        }, 200);
        $(".whatsapp-openedchat").animate({
            left: -30+"vh"
        }, 200, function(){
            $(".whatsapp-openedchat").css({"display":"none"});
        });
        OpenedChatPicture = null;
        $(".whatsapp-extra-buttons").animate({
            left: -18+"vh"
        }, 250, function(){
            $(".whatsapp-extra-buttons").css({"display":"block"});
            ExtraButtonsOpen = false;
        });
        $(".menuinteracao-27").css({"display":"none"});
        emojisbaerto = false;
        emojisnowpp = false;
        emojisnotwt = false;
        emojisnoolx = false;
        emojisnogaleria = false;
        wppgaleria = false;
        $(".wpp-gallery-homescreen2").css({"display":"none"});
        $(".wpp-gallery-homescreen").css({"display":"none"});
    } else {
        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Finish creation!", "#25D366", 1750);
    }
});

$(document).on('click', '#whatsapp-openedchat-back2', function(e){
    e.preventDefault();
    if (editargrupo == false) { 
        if (estaemchat == false) {
            grupo = false;
            $.post('https://jpr-newphone/GetWhatsappChats', JSON.stringify({}), function(chats){
                JPR.Phone.Functions.LoadWhatsappChats(chats);
            });
            OpenedChatData.number = null;
            $(".whatsapp-chats").css({"display":"block"});
            $(".whatsapp-chats").animate({
                left: 0+"vh"
            }, 200);
            $(".whatsapp-openedchat").animate({
                left: -30+"vh"
            }, 200, function(){
                $(".whatsapp-openedchat").css({"display":"none"});
            });
            OpenedChatPicture = null;
            $("#whatsapp-search-chats3").css({"display":"none"});
            if (grupo == false) {
                $(".whatsapp-extra-buttons2").animate({
                    right: -15+"vh"
                }, 250, function(){
                    $(".whatsapp-extra-buttons2").css({"display":"block"});
                    ExtraButtonsOpen = false;
                });
            } else {
                $(".whatsapp-extra-buttons2").animate({
                    right: -20+"vh"
                }, 250, function(){
                    $(".whatsapp-extra-buttons2").css({"display":"block"});
                    ExtraButtonsOpen = false;
                });  
            }
            
            $("#whatsapp-search-input").fadeOut(150);
            WhatsappSearchActive = false;
        } else {
            grupo = false;
            $(".whatsapp-extra-buttons2").animate({
                right: -20+"vh"
            }, 250, function(){
                $(".whatsapp-extra-buttons2").css({"display":"block"});
                ExtraButtonsOpen = false;
            });
            if ($(".whatsapp-search-input5").css('display') == "none") {
                $(".whatsapp-search-input5").fadeIn(150);
                editargrupo = true
                WhatsappSearchActive = true;
            } else {
                $("#whatsapp-search-input").fadeOut(150);
                WhatsappSearchActive = false;
            }
        }
    } else {
        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Finish editing!", "#25D366", 1750);
    }
});

JPR.Phone.Functions.GetLastMessage = function(messages) {
    var CurrentDate = new Date();
    var CurrentMonth = CurrentDate.getMonth();
    var CurrentDOM = CurrentDate.getDate();
    var CurrentYear = CurrentDate.getFullYear();
    var LastMessageData = {
        time: "00:00",
        message: "No message"
    }

    $.each(messages[messages.length - 1], function(i, msg){
        var msgData = msg[msg.length - 1];
        LastMessageData.time = msgData.time
        LastMessageData.message = DOMPurify.sanitize(msgData.message , {
            ALLOWED_TAGS: [],
            ALLOWED_ATTR: []
        });
        if(LastMessageData.message == '') 'Invalid..'
    });

    return LastMessageData
}

GetCurrentDateKey = function() {
    var CurrentDate = new Date();
    var CurrentMonth = CurrentDate.getMonth();
    var CurrentDOM = CurrentDate.getDate();
    var CurrentYear = CurrentDate.getFullYear();
    var CurDate = ""+CurrentDOM+"-"+CurrentMonth+"-"+CurrentYear+"";

    return CurDate;
}


JPR.Phone.Functions.LoadWhatsappChats = function(chats) {
    $(".whatsapp-chats").html("");
    var cont = 1;
    var quantidadechats = 0;
    $.each(chats, function(i, chat){
        var profilepicture = "./img/default.png";
        if (chat.picture !== "default") {
            profilepicture = chat.picture
        }
        if (grupo == false) {
            var LastMessage = JPR.Phone.Functions.GetLastMessage(chat.messages);
            var ChatElement = '<div class="whatsapp-chat" id="whatsapp-chat-'+i+'"><div class="whatsapp-chat-picture" style="background-image: url('+profilepicture+');"></div><div class="whatsapp-chat-name"><p>'+chat.name+'</p></div><div class="whatsapp-chat-lastmessage"><p>'+LastMessage.message+'</p></div> <div class="whatsapp-chat-lastmessagetime"><p>'+LastMessage.time+'</p></div><div class="whatsapp-chat-unreadmessages unread-chat-id-'+i+'">1</div></div>';
            
        } else {
            var LastMessage = JPR.Phone.Functions.GetLastMessage(chat.messages);
            var ChatElement = '<div class="whatsapp-chat" id="whatsapp-chat-'+i+'"><div class="whatsapp-chat-picture" style="background-image: url('+profilepicture+');"></div><div class="whatsapp-chat-name"><p>'+chat.name+'</p></div><div class="whatsapp-chat-lastmessage"><p>'+LastMessage.message+'</p></div> <div class="whatsapp-chat-lastmessagetime"><p>'+LastMessage.time+'</p></div><div class="whatsapp-chat-unreadmessages unread-chat-id-'+i+'">1</div></div>';   
            cont = cont + 1;
        }
        
        $(".whatsapp-chats").append(ChatElement);
        $("#whatsapp-chat-"+i).data('chatdata', chat);

        if (chat.name == "JPResources") {
            //console.log("sim")
            $("#whatsapp-chat-"+i).css({"display":"none"});
        } else {
            $("#whatsapp-chat-"+i).css({"display":"block"});
        }

        if (chat.Unread > 0 && chat.Unread !== undefined && chat.Unread !== null) {
            $(".unread-chat-id-"+i).html(chat.Unread);
            $(".unread-chat-id-"+i).css({"display":"block"});
        } else {
            $(".unread-chat-id-"+i).css({"display":"none"});
        }
        quantidadechats= quantidadechats+1;
    });
    
    if (quantidadechats == 0) {
        var ChatElement = '<div class="whatsapp-chat" id="whatsapp-chat-'+"nenhum"+'"><div class="whatsapp-chat-picture" style="background-image: url('+"https://i.imgur.com/urIFBqA.png"+');"></div><div class="whatsapp-chat-name"><p>'+"Make Friends"+'</p></div><div class="whatsapp-chat-lastmessage"><p>'+"You don't have any chat"+'</p></div> <div class="whatsapp-chat-lastmessagetime"><p>'+""+'</p></div><div class="whatsapp-chat-unreadmessages unread-chat-id-'+"nenhuma"+'">1</div></div>';   
        $(".whatsapp-chats").append(ChatElement);
        $("#whatsapp-chat-"+"nenhum").data('chatdata', "nenhum");
    }
}


JPR.Phone.Functions.ReloadWhatsappAlerts = function(chats) {
    $.each(chats, function(i, chat){
        if (chat.Unread > 0 && chat.Unread !== undefined && chat.Unread !== null) {
            $(".unread-chat-id-"+i).html(chat.Unread);
            $(".unread-chat-id-"+i).css({"display":"block"});
        } else {
            $(".unread-chat-id-"+i).css({"display":"none"});
        }
    });
}

const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

FormatChatDate = function(date) {
    var TestDate = date.split("-");
    var NewDate = new Date((parseInt(TestDate[1]) + 1)+"-"+TestDate[0]+"-"+TestDate[2]);

    var CurrentMonth = monthNames[NewDate.getMonth()];
    var CurrentDOM = NewDate.getDate();
    var CurrentYear = NewDate.getFullYear();
    var CurDateee = CurrentDOM + "-" + NewDate.getMonth() + "-" + CurrentYear;
    var ChatDate = CurrentDOM + " " + CurrentMonth + " " + CurrentYear;
    var CurrentDate = GetCurrentDateKey();

    var ReturnedValue = ChatDate;
    if (CurrentDate == CurDateee) {
        ReturnedValue = "Hoje";
    }

    return ReturnedValue;
}

FormatMessageTime = function() {
    var NewDate = new Date();
    var NewHour = NewDate.getHours();
    var NewMinute = NewDate.getMinutes();
    var Minutessss = NewMinute;
    var Hourssssss = NewHour;
    if (NewMinute < 10) {
        Minutessss = "0" + NewMinute;
    }
    if (NewHour < 10) {
        Hourssssss = "0" + NewHour;
    }
    var MessageTime = Hourssssss + ":" + Minutessss
    return MessageTime;
}


$(document).on('click', '#whatsapp-openedchat-send', function(e){
    e.preventDefault();

    var Message = $("#whatsapp-openedchat-message").val();

    if (nomeantigo == 'WildRoleplay') {
        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "No permissions!", "#25D366", 1750);
    } else {
        if (grupo == false) {
            if (Message !== null && Message !== undefined && Message !== "") {
                if (OpenedChatData.number !== null && OpenedChatData.number !== undefined && OpenedChatData.number !== "") {
                    $.post('https://jpr-newphone/SendMessage', JSON.stringify({
                        ChatNumber: OpenedChatData.number,
                        ChatDate: GetCurrentDateKey(),
                        ChatMessage: Message,
                        ChatTime: FormatMessageTime(),
                        ChatType: "message",
                    }));
                    $("#whatsapp-openedchat-message").val("");
                } else {
                    JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "No network, try again!", "#25D366", 1750);
                }
            } else {
                JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Write something!", "#25D366", 1750);
            }
        } else {
                if (Message !== null && Message !== undefined && Message !== "") {
                    $.post('https://jpr-newphone/SendMessageGrupo', JSON.stringify({
                        GrupoNumber: OpenedChatData.number,
                        GrupoDate: GetCurrentDateKey(),
                        GrupoMessage: Message,
                        GrupoTime: FormatMessageTime(),
                        GrupoType: "message",
                    }));
                    $("#whatsapp-openedchat-message").val("");
                } else {
                    JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Write something!", "#25D366", 1750);
                }   
        }
    }
});

$(document).on('keypress', function (e) {
    
    if (WhatsappSearchActive == false) {
        if (OpenedChatData.number !== null) {
            
                if(e.which === 13){
                    if (nomeantigo == 'WildRoleplay') {
                        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "No permissions!", "#25D366", 1750);
                    } else {
                        var Message = $("#whatsapp-openedchat-message").val();

                        if (grupo == false) {
                            if (Message !== null && Message !== undefined && Message !== "") {
                                var clean = DOMPurify.sanitize(Message , {
                                    ALLOWED_TAGS: [],
                                    ALLOWED_ATTR: []
                                });
                                if (clean == '') clean = 'Inválido...'
                                $.post('https://jpr-newphone/SendMessage', JSON.stringify({
                                    ChatNumber: OpenedChatData.number,
                                    ChatDate: GetCurrentDateKey(),
                                    ChatMessage: clean,
                                    ChatTime: FormatMessageTime(),
                                    ChatType: "message",
                                }));
                                $("#whatsapp-openedchat-message").val("");
                            } else {
                                JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Write something!", "#25D366", 1750);
                            }
                        } else {
                            var Message = $("#whatsapp-openedchat-message").val();
                            
                                if (Message !== null && Message !== undefined && Message !== "") {
                                    var clean = DOMPurify.sanitize(Message , {
                                        ALLOWED_TAGS: [],
                                        ALLOWED_ATTR: []
                                    });
                                    if (clean == '') clean = 'Inválido...'
                                    $.post('https://jpr-newphone/SendMessageGrupo', JSON.stringify({
                                        GrupoNumber: OpenedChatData.number,
                                        GrupoDate: GetCurrentDateKey(),
                                        GrupoMessage: clean,
                                        GrupoTime: FormatMessageTime(),
                                        GrupoType: "message",
                                    }));
                                   
                                    $("#whatsapp-openedchat-message").val("");

                                } else {
                                    JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Write something!", "#25D366", 1750);
                                }   
                            
                        }
                    }
                }
            
        }
    } else if (WhatsappSearchActive == true) {
        if(e.which === 13){
            if (nomeantigo == 'WildRoleplay') {
                JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "No permissions!", "#25D366", 1750);
            } else {
                var valorescrito = $("#whatsapp-search-input").val();

                if (valorescrito !== null && valorescrito !== undefined && valorescrito !== "") {
                    var quantidade = valorescrito.length
                    if (quantidade == 10) {
                        $.post('https://jpr-newphone/AdicionarPessoal', JSON.stringify({valorescrito, GrupoNumber: OpenedChatData.number}), function(data){
                            if (data.podeadicionar == true) {
                                $.post('https://jpr-newphone/AdicionarPessoalVerificar2', JSON.stringify({valorescrito, GrupoNumber: OpenedChatData.number}), function(data){
                                    if (data.podeadicionar2 == true) {
                                        $.post("https://jpr-newphone/AdicionarPessoalJarda", JSON.stringify({valorescrito, GrupoNumber: OpenedChatData.number}));
                                        setTimeout(function(){
                                            $.post('https://jpr-newphone/AdicionarPessoalVerificar2', JSON.stringify({valorescrito, GrupoNumber: OpenedChatData.number}), function(data){
                                                if (data.podeadicionar2 == true) {
                                                    $.post("https://jpr-newphone/AdicionarPessoalJarda", JSON.stringify({valorescrito, GrupoNumber: OpenedChatData.number}));
                                                    JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "You are not the owner!", "#25D366", 1750);
                                                    $("#whatsapp-search-input").fadeOut(150);
                                                    WhatsappSearchActive = false;
                                                } else {
                                                    JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Successfully added!", "#25D366", 1750);
                                                    $("#whatsapp-search-input").fadeOut(150);
                                                    WhatsappSearchActive = false;
                                                }
                                            })
                                        },400);
                                        //JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Adicionado com sucesso!", "#25D366", 1750);
                                        //$("#whatsapp-search-input").fadeOut(150);
                                        //WhatsappSearchActive = false;
                                    } else {
                                        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "It's been added before!", "#25D366", 1750);
                                    }
                                })
                                //$.post("https://jpr-newphone/AdicionarPessoalJarda", JSON.stringify({valorescrito, GrupoNumber: OpenedChatData.number}));
                                //JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Adicionado com sucesso!", "#25D366", 1750);
                                //$("#whatsapp-search-input").fadeOut(150);
                                //WhatsappSearchActive = false;
                            } else {
                                JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Number does not exist!", "#25D366", 1750);
                            }
                        })
                    } else if (quantidade < 10) {
                        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Missing digits!", "#25D366", 1750);
                    } else if (quantidade > 10) {
                        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Too many digits!", "#25D366", 1750);
                    }
                } else {
                    JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Write something!", "#25D366", 1750);
                }
            }
        }
    }
});

$(document).on('click', '#send-location', function(e){
    e.preventDefault();

    if (grupo == false) {
        $.post('https://jpr-newphone/SendMessage', JSON.stringify({
            ChatNumber: OpenedChatData.number,
            ChatDate: GetCurrentDateKey(),
            ChatMessage: "GPS",
            ChatTime: FormatMessageTime(),
            ChatType: "location",
            url : "https://i.imgur.com/End8GRk.png"
        }));
    } else {
        
            $.post('https://jpr-newphone/SendMessageGrupo', JSON.stringify({
                GrupoNumber: OpenedChatData.number,
                GrupoDate: GetCurrentDateKey(),
                GrupoMessage: "GPS",
                GrupoTime: FormatMessageTime(),
                GrupoType: "location",
                url : "https://i.imgur.com/End8GRk.png"
            }));  

        
    }
});

var emojisbaerto = false;
$(document).on('click', '#abriremojis', function(e){
    e.preventDefault();

    if (wppgaleria == true) {
        $(".wpp-gallery-homescreen2").css({"display":"none"});
        $(".wpp-gallery-homescreen").css({"display":"none"});
        wppgaleria = false;
    }

    if (emojisbaerto == false) {
        $(".menuinteracao-27").css({"display":"block"});
        emojisbaerto = true;
        emojisnowpp = true;
        emojisnotwt = false;
        emojisnoolx = false;
        emojisnogaleria = false;
    } else {
        $(".menuinteracao-27").css({"display":"none"});
        emojisbaerto = false;
        emojisnowpp = false;
        emojisnotwt = false;
        emojisnoolx = false;
        emojisnogaleria = false;
    }
});

var wppgaleria = false
$(document).on('click', '#abrir-galeria', function(e){
    e.preventDefault();

    if (emojisbaerto == true) {
        $(".menuinteracao-27").css({"display":"none"});
        emojisbaerto = false;
        emojisnowpp = false;
        emojisnotwt = false;
        emojisnoolx = false;
        emojisnogaleria = false;
    }


    if (wppgaleria == false) {
        $.post('https://jpr-newphone/GetGalleryData', JSON.stringify({}), function(data){
            setUpWhappGaleriaData(data)
        });
        wppgaleria = true;
    } else {
        wppgaleria = false;
        $(".wpp-gallery-homescreen2").css({"display":"none"});
        $(".wpp-gallery-homescreen").css({"display":"none"});
    }

});

function setUpWhappGaleriaData(Images){
    $(".wpp-gallery-images").html("");
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
                var Element = '<div class="gallery-image"  style="display: inline-block !important;"><img src="'+image.image+'" alt="'+image.citizenid+'" class="tumbnail-wpp"></div>';
            
                $(".wpp-gallery-images").append(Element);
                $("#image-"+i).data('ImageData', image);
                var Element = '<div class="gallery-image"  style="display: block !important;height: 2.1vh !important;"></div>';
                $(".wpp-gallery-images").append(Element);
                $("#image-"+i).data('ImageData', image);
                cont = cont - 1;
            }else{
                if (cont == 49 || cont == 39 || cont == 29 || cont == 19 || cont == 9 || cont == 59 || cont == 69 || cont == 79 || cont == 89 || cont == 99 || cont == 109 || cont == 119 || cont == cont2) {
                    
                        var Element = '<div class="wpp-gallery-album">Album: '+cont3+'</div><div class="gallery-image"><img src="'+image.image+'" alt="'+image.citizenid+'" class="tumbnail-wpp"></div>';
                    
                    $(".wpp-gallery-images").append(Element);
                    $("#image-"+i).data('ImageData', image);
                    cont = cont - 1;
                    cont3 = cont3 - 1;
                }else{
                    var Element = '<div class="gallery-image"><img src="'+image.image+'" alt="'+image.citizenid+'" class="tumbnail-wpp"></div>';
                
                    $(".wpp-gallery-images").append(Element);
                    $("#image-"+i).data('ImageData', image);
                    cont = cont - 1;
                }
            }
            $(".gallery-app-header").find('p').html('Galeria');
            escolheufoto = false;
        });
    }
    $(".wpp-gallery-homescreen2").css({"display":"block"});
    $(".wpp-gallery-homescreen").css({"display":"block"});
}

var podemandarfotos = true;
$(document).on('click', '.tumbnail-wpp', function(e){
    e.preventDefault();
    let source = $(this).attr('src')
    
    if (podemandarfotos == true) {
        if (grupo == false) {
            $.post('https://jpr-newphone/SendMessage', JSON.stringify({
                ChatNumber: OpenedChatData.number,
                ChatDate: GetCurrentDateKey(),
                ChatMessage: "Photo",
                ChatTime: FormatMessageTime(),
                ChatType: "picture",
                url : source
            }));
        } else {
            $.post('https://jpr-newphone/SendMessageGrupo', JSON.stringify({
                GrupoNumber: OpenedChatData.number,
                GrupoDate: GetCurrentDateKey(),
                GrupoMessage: "Photo",
                GrupoTime: FormatMessageTime(),
                GrupoType: "picture",
                url : source
            }));  
        }
        podemandarfotos = false;
    } else {
        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Slower!", "#25D366", 1750);
    }

    setTimeout(function(){
        podemandarfotos = true;
    }, 2000)
});

$(document).on('click', '#send-image', function(e){
    e.preventDefault();
    let ChatNumber2 = OpenedChatData.number;
    if (grupo == false) {
        grupo = false;
        $.post('https://jpr-newphone/TakePhoto', JSON.stringify({}),function(url){
            if(url){
            $.post('https://jpr-newphone/SendMessage', JSON.stringify({
            ChatNumber: ChatNumber2,
            ChatDate: GetCurrentDateKey(),
            ChatMessage: "Photo",
            ChatTime: FormatMessageTime(),
            ChatType: "picture",
            url : url
        }))}})
        $("#teste3").removeClass('fa-solid fa-image');
        $("#teste3").addClass('fa-solid fa-person')
        $("#teste2").removeClass('fa-solid fa-circle-xmark');
        $("#teste2").addClass('fa-solid fa-people-group')
        $("#teste").removeClass('fa-solid fa-person-circle-plus');
        $("#teste").addClass('fa-solid fa-person-circle-plus');
        //grupo == false;
    } else {
        grupo = false;
        $.post('https://jpr-newphone/TakePhoto', JSON.stringify({}),function(url){
            if(url){
            $.post('https://jpr-newphone/SendMessageGrupo', JSON.stringify({
            GrupoNumber: ChatNumber2,
            GrupoDate: GetCurrentDateKey(),
            GrupoMessage: "Photo",
            GrupoTime: FormatMessageTime(),
            GrupoType: "picture",
            url : url
        }))}})  
        $("#teste3").removeClass('fa-solid fa-image');
        $("#teste3").addClass('fa-solid fa-person')
        $("#teste2").removeClass('fa-solid fa-circle-xmark');
        $("#teste2").addClass('fa-solid fa-people-group')
        $("#teste").removeClass('fa-solid fa-person-circle-plus');
        $("#teste").addClass('fa-solid fa-person-circle-plus');
    }
    estaemchat = false;
    grupo = false;
    AtualizarVars(false);
    JPR.Phone.Functions.Close();
});

JPR.Phone.Functions.SetupChatMessages = function(cData, NewChatData) {
    if (cData) {
        OpenedChatData.number = cData.number;

        if (OpenedChatPicture == null) {
            if (grupo == false) {
                $.post('https://jpr-newphone/GetProfilePicture', JSON.stringify({
                    number: OpenedChatData.number,
                }), function(picture){
                    OpenedChatPicture = "./img/default.png";
                    if (picture != "default" && picture != null) {
                        OpenedChatPicture = picture
                    }
                    $(".whatsapp-openedchat-picture").css({"background-image":"url("+OpenedChatPicture+")"});
                });
            } else {
                $.post('https://jpr-newphone/GetProfilePictureGrupos', JSON.stringify({
                    number: OpenedChatData.number,
                }), function(picture){
                    OpenedChatPicture = "./img/default.png";
                    if (picture != "default" && picture != null) {
                        OpenedChatPicture = picture
                    }
                    $(".whatsapp-openedchat-picture").css({"background-image":"url("+OpenedChatPicture+")"});
                });  
            }
        } else {
            $(".whatsapp-openedchat-picture").css({"background-image":"url("+OpenedChatPicture+")"});
        }

        $(".whatsapp-openedchat-name").html("<p>"+cData.name+"</p>");
        $(".whatsapp-openedchat-messages").html("");

        $.each(cData.messages, function(i, chat){

            var ChatDate = FormatChatDate(chat.date);
            var ChatDiv = '<div class="whatsapp-openedchat-messages-'+i+' unique-chat"><div class="whatsapp-openedchat-date">'+ChatDate+'</div></div>';

            $(".whatsapp-openedchat-messages").append(ChatDiv);

            $.each(cData.messages[i].messages, function(index, message){
                message.message = DOMPurify.sanitize(message.message , {
                    ALLOWED_TAGS: [],
                    ALLOWED_ATTR: []
                });
                if (message.message == '') message.message = 'Hmm, não podes fazer isto...'
                var Sender = "me";
                if (message.sender !== JPR.Phone.Data.PlayerData.citizenid) { Sender = "other"; }
                var MessageElement
                if (message.type == "message") {
                    if (message.macho !== null && message.macho !== undefined && message.macho !== "") {
                        MessageElement = '<div class="whatsapp-openedchat-message whatsapp-openedchat-message-'+Sender+'">'+message.message+'<div class="whatsapp-openedchat-message-time" style="font-weight: normal !important;">'+message.time+' - <a style="color: #1274dc;">'+message.macho+'</a></div></div><div class="clearfix"></div>'    
                    } else {
                        MessageElement = '<div class="whatsapp-openedchat-message whatsapp-openedchat-message-'+Sender+'">'+message.message+'<div class="whatsapp-openedchat-message-time" style="font-weight: normal !important;">'+message.time+' - <a style="color: #1274dc;">'+message.sender+'</a></div></div><div class="clearfix"></div>'
                    }
                } else if (message.type == "location") {


                    MessageElement = '<div class="whatsapp-openedchat-message whatsapp-openedchat-message-'+Sender+' whatsapp-shared-location" data-x="'+message.data.x+'" data-y="'+message.data.y+'"><img class="wppimage-gps" src='+message.data.url +'  style=" border-radius:4px; width: 100%; position:relative; z-index: 1; right:1px;height: auto;"></div><div class="whatsapp-openedchat-message-time" style="font-weight: normal !important;">'+message.time+' - <a style="color: #1274dc;">'+message.macho+'</a></div></div><div class="clearfix"></div>'
                } else if (message.type == "picture") {
                    MessageElement = '<div class="whatsapp-openedchat-message whatsapp-openedchat-message-'+Sender+'" data-id='+OpenedChatData.number+'><img class="wppimage" src='+message.data.url +'  style=" border-radius:4px; width: 100%; position:relative; z-index: 1; right:1px;height: auto;"></div><div class="whatsapp-openedchat-message-time" style="font-weight: normal !important;">'+message.time+' - <a style="color: #1274dc;">'+message.macho+'</a></div></div><div class="clearfix"></div>'
                    
                }
                $(".whatsapp-openedchat-messages-"+i).append(MessageElement);
            });
        });
        $('.whatsapp-openedchat-messages').animate({scrollTop: 9999}, 1);
    } else {
        OpenedChatData.number = NewChatData.number;
        if (OpenedChatPicture == null) {
            if (grupo == false) {
                $.post('https://jpr-newphone/GetProfilePicture', JSON.stringify({
                    number: OpenedChatData.number,
                }), function(picture){
                    OpenedChatPicture = "./img/default.png";
                    if (picture != "default" && picture != null) {
                        OpenedChatPicture = picture
                    }
                    $(".whatsapp-openedchat-picture").css({"background-image":"url("+OpenedChatPicture+")"});
                });
            } else {
                $.post('https://jpr-newphone/GetProfilePictureGrupos', JSON.stringify({
                    number: OpenedChatData.number,
                }), function(picture){
                    OpenedChatPicture = "./img/default.png";
                    if (picture != "default" && picture != null) {
                        OpenedChatPicture = picture
                    }
                    $(".whatsapp-openedchat-picture").css({"background-image":"url("+OpenedChatPicture+")"});
                });  
            }
        }

        $(".whatsapp-openedchat-name").html("<p>"+NewChatData.name+"</p>");
        $(".whatsapp-openedchat-messages").html("");
        var NewDate = new Date();
        var NewDateMonth = NewDate.getMonth();
        var NewDateDOM = NewDate.getDate();
        var NewDateYear = NewDate.getFullYear();
        var DateString = ""+NewDateDOM+"-"+(NewDateMonth+1)+"-"+NewDateYear;
        var ChatDiv = '<div class="whatsapp-openedchat-messages-'+DateString+' unique-chat"><div class="whatsapp-openedchat-date">Today</div></div>';

        $(".whatsapp-openedchat-messages").append(ChatDiv);
    }

    $('.whatsapp-openedchat-messages').animate({scrollTop: 9999}, 1);
}

$(document).on('click', '.whatsapp-shared-location', function(e){
    e.preventDefault();
    var messageCoords = {}
    messageCoords.x = $(this).data('x');
    messageCoords.y = $(this).data('y');

    $.post('https://jpr-newphone/SharedLocation', JSON.stringify({
        coords: messageCoords,
    }))
});

$(document).on('click', '.wppimage', function(e){
    e.preventDefault();

    let source = $(this).attr('src')
   JPR.Screen.popUp(source, "wpp")
});

$(document).on('click', '#whatsapp-openedchat-message-extras', function(e){
    e.preventDefault();

    if (nomeantigo == 'WildRoleplay') {
        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "No permissions!", "#25D366", 1750);
    } else {
        if (!ExtraButtonsOpen) {
            $(".whatsapp-extra-buttons").css({"display":"block"}).animate({
                left: 0+"vh"
            }, 250);
            ExtraButtonsOpen = true;
            $(".menuinteracao-27").css({"bottom":"11.99vh"});
            $(".wpp-gallery-homescreen ").css({"height":"72.5%"});
        } else {
            
                $(".whatsapp-extra-buttons").animate({
                    left: -18+"vh"
                }, 250, function(){
                    $(".whatsapp-extra-buttons").css({"display":"block"});
                    ExtraButtonsOpen = false;
                });
                $(".menuinteracao-27").css({"bottom":"6.75vh"});
                $(".wpp-gallery-homescreen ").css({"height":"82%"});
        }
    }
});

$(document).on('click', '#whatsapp-openedchat-message-extras2', function(e){
    e.preventDefault();

    if (grupo == true) {
        if (nomeantigo == 'WildRoleplay') {
            JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "No permissions!", "#25D366", 1750);
        } else {
            if (!ExtraButtonsOpen) {
                $("#whatsapp-search-input").fadeOut(150);
                    WhatsappSearchActive = false;
                $(".whatsapp-extra-buttons2").css({"display":"block"}).animate({
                    right: 3.6+"vh"
                }, 250);
                ExtraButtonsOpen = true;
                
                $("#whatsapp-search-chats3").css({"display":"block"});
                
                if (estaemchat == false && grupo == true) {
                    $("#whatsapp-openedchat-back2").css({"display":"block"});
                    $("#whatsapp-search-chats2").css({"display":"block"});
                    $("#teste3").removeClass('fa-solid fa-image');
                    $("#teste3").addClass('fa-solid fa-person')
                    $("#teste2").removeClass('fa-solid fa-circle-plus');
                    $("#teste2").addClass('fa-solid fa-people-group')
                    $("#teste").removeClass('fa-solid fa-person-circle-plus');
                    $("#teste").addClass('fa-solid fa-circle-plus');
                } else if (grupo == true) {
                    $("#whatsapp-openedchat-back2").css({"display":"block"});
                    $("#whatsapp-search-chats2").css({"display":"block"});
                    $("#teste3").removeClass('fa-solid fa-person');
                    $("#teste3").addClass('fa-solid fa-image')
                    $("#teste2").removeClass('fa-solid fa-people-group');
                    $("#teste2").addClass('fa-solid fa-circle-xmark')
                    $("#teste").removeClass('fa-solid fa-circle-plus');
                    $("#teste").addClass('fa-solid fa-person-circle-plus');
                }
            } else {
                $(".whatsapp-extra-buttons2").animate({
                    right: -20+"vh"
                }, 250, function(){
                    $(".whatsapp-extra-buttons2").css({"display":"block"});
                    ExtraButtonsOpen = false;
                });
            }
        }    
    } else if (estaemchat == false) {
        if (!ExtraButtonsOpen) {
            $("#whatsapp-search-input").fadeOut(150);
                WhatsappSearchActive = false;
            $(".whatsapp-extra-buttons2").css({"display":"block"}).animate({
                right: 3.6+"vh"
            }, 250);
            ExtraButtonsOpen = true;
            
            $("#whatsapp-search-chats3").css({"display":"none"});
        } else {
            if (grupo == false) {
                $(".whatsapp-extra-buttons2").animate({
                    right: -15+"vh"
                }, 250, function(){
                    $(".whatsapp-extra-buttons2").css({"display":"block"});
                    ExtraButtonsOpen = false;
                });
            } else {
                $(".whatsapp-extra-buttons2").animate({
                    right: -20+"vh"
                }, 250, function(){
                    $(".whatsapp-extra-buttons2").css({"display":"block"});
                    ExtraButtonsOpen = false;
                });  
            }
        }
    } else {
        JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "You can't use this here!", "#25D366", 1750);
    }

    if (estaemchat == true) {
        $("#whatsapp-openedchat-back5").css({"display":"none"});
    } else {
        $("#whatsapp-openedchat-back5").css({"display":"block"});
    }
});

$(document).on('click', '#whatsapp-openedchat-back5', function(e){
    e.preventDefault();

    $.post("https://jpr-newphone/Atualizar", JSON.stringify({}));
    JPR.Phone.Notifications.Add("whatsapp.png", "Whatsapp", "Updated!", "#25D366", 1750);
});