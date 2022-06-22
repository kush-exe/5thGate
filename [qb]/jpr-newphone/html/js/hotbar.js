function changeRange(_this, _value) {
    if (_value !== undefined) {
      _this.value = _value;
    }
    document.querySelector(".menuinteracao-12").textContent = _this.value;
    const percent = +_this.value / +_this.max;
    const percent100 = percent * 100;
    _this.style.backgroundImage = `linear-gradient(90deg, var(--bg-value-color) 0%, var(--bg-value-color) ${percent100}%, var(--bg-range-color) ${percent100}%, var(--bg-range-color) 100%)`;
  
    if (_this.value >= 80) {
        $(".overlay").css({"background-color":"transparent"});
        $(".phone-applications").css({"opacity":"0.95"});
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-volume-low');
        $("#mudar-items").removeClass('fa-volume-off');
        $("#mudar-items").removeClass('fa-volume-xmark');
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-eye');
        $("#mudar-items").removeClass('fa-eye-low-vision');
        $("#mudar-items").removeClass('fa-arrows-to-eye');
        $("#mudar-items").removeClass('fa-eye-slash');
        $("#mudar-items").addClass('fa-eye');
        $(".menuinteracao-16").css({"display":"block"});
    } 
    if (_this.value >= 60 && _this.value < 80) {
        $(".overlay").css({"background-color":"rgba(0, 0, 0, 0.2)"});
        $(".phone-applications").css({"opacity":"0.8"});
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-volume-low');
        $("#mudar-items").removeClass('fa-volume-off');
        $("#mudar-items").removeClass('fa-volume-xmark');
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-eye');
        $("#mudar-items").removeClass('fa-eye-low-vision');
        $("#mudar-items").removeClass('fa-arrows-to-eye');
        $("#mudar-items").removeClass('fa-eye-slash');
        $("#mudar-items").addClass('fa-eye');
        $(".menuinteracao-16").css({"display":"block"});
    } 
    if (_this.value >= 50 && _this.value < 60) {
        $(".overlay").css({"background-color":"rgba(0, 0, 0, 0.3)"});
        $(".phone-applications").css({"opacity":"0.7"});
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-volume-low');
        $("#mudar-items").removeClass('fa-volume-off');
        $("#mudar-items").removeClass('fa-volume-xmark');
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-eye');
        $("#mudar-items").removeClass('fa-eye-low-vision');
        $("#mudar-items").removeClass('fa-arrows-to-eye');
        $("#mudar-items").removeClass('fa-eye-slash');
        $("#mudar-items").addClass('fa-eye-low-vision');
        $(".menuinteracao-16").css({"display":"block"});
    } 
    if (_this.value >= 30 && _this.value < 50) {
        $(".overlay").css({"background-color":"rgba(0, 0, 0, 0.4)"});
        $(".phone-applications").css({"opacity":"0.6"});
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-volume-low');
        $("#mudar-items").removeClass('fa-volume-off');
        $("#mudar-items").removeClass('fa-volume-xmark');
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-eye');
        $("#mudar-items").removeClass('fa-eye-low-vision');
        $("#mudar-items").removeClass('fa-arrows-to-eye');
        $("#mudar-items").removeClass('fa-eye-slash');
        $("#mudar-items").addClass('fa-eye-low-vision');
        $(".menuinteracao-16").css({"display":"block"});
    } 
    if (_this.value >= 20 && _this.value < 30) {
        $(".overlay").css({"background-color":"rgba(0, 0, 0, 0.5)"});
        $(".phone-applications").css({"opacity":"0.5"});
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-volume-low');
        $("#mudar-items").removeClass('fa-volume-off');
        $("#mudar-items").removeClass('fa-volume-xmark');
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-eye');
        $("#mudar-items").removeClass('fa-eye-low-vision');
        $("#mudar-items").removeClass('fa-arrows-to-eye');
        $("#mudar-items").removeClass('fa-eye-slash');
        $("#mudar-items").addClass('fa-arrows-to-eye');
        $(".menuinteracao-16").css({"display":"block"});
    } 
    if (_this.value >= 10 && _this.value < 20) {
        $(".overlay").css({"background-color":"rgba(0, 0, 0, 0.6)"});
        $(".phone-applications").css({"opacity":"0.4"});
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-volume-low');
        $("#mudar-items").removeClass('fa-volume-off');
        $("#mudar-items").removeClass('fa-volume-xmark');
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-eye');
        $("#mudar-items").removeClass('fa-eye-low-vision');
        $("#mudar-items").removeClass('fa-arrows-to-eye');
        $("#mudar-items").removeClass('fa-eye-slash');
        $("#mudar-items").addClass('fa-arrows-to-eye');
        $(".menuinteracao-16").css({"display":"block"});
    } 
    if( _this.value <= 10) {
        $(".overlay").css({"background-color":"rgba(0, 0, 0, 0.7)"});
        $(".phone-applications").css({"opacity":"0.3"});
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-volume-low');
        $("#mudar-items").removeClass('fa-volume-off');
        $("#mudar-items").removeClass('fa-volume-xmark');
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-eye');
        $("#mudar-items").removeClass('fa-eye-low-vision');
        $("#mudar-items").removeClass('fa-arrows-to-eye');
        $("#mudar-items").removeClass('fa-eye-slash');
        $("#mudar-items").addClass('fa-eye-slash');
        $(".menuinteracao-16").css({"display":"block"});
    }
    setTimeout(function(){
        $().ready(function(){
            $(".menuinteracao-12").hover(function(){},
                             function(){$(".menuinteracao-16").css({"display":"none"});});
        });
        $().ready(function(){
            $(".menuinteracao-13").hover(function(){},
                             function(){$(".menuinteracao-16").css({"display":"none"});});
        });
    },400);   
        
  }
  



  function changeRange2(_this, _value) {
    //console.log(_this, _value);
    if (_value !== undefined) {
      _this.value = _value;
    }
    //console.log(_this.value);
    // update the current range
    document.querySelector(".menuinteracao-12").textContent = _this.value;
    const percent = +_this.value / +_this.max;
    const percent100 = percent * 100;
    _this.style.backgroundImage = `linear-gradient(90deg, var(--bg-value-color) 0%, var(--bg-value-color) ${percent100}%, var(--bg-range-color) ${percent100}%, var(--bg-range-color) 100%)`;
  
    if (_this.value >= 65) {
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-volume-low');
        $("#mudar-items").removeClass('fa-volume-off');
        $("#mudar-items").removeClass('fa-volume-xmark');
        $("#mudar-items").removeClass('fa-eye');
        $("#mudar-items").removeClass('fa-eye-low-vision');
        $("#mudar-items").removeClass('fa-arrows-to-eye');
        $("#mudar-items").removeClass('fa-eye-slash');
        $("#mudar-items").addClass('fa-volume-high');
        $(".menuinteracao-16").css({"display":"block"});
    } 
    if (_this.value >= 40 && _this.value < 65) {
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-volume-low');
        $("#mudar-items").removeClass('fa-volume-off');
        $("#mudar-items").removeClass('fa-volume-xmark');
        $("#mudar-items").removeClass('fa-eye');
        $("#mudar-items").removeClass('fa-eye-low-vision');
        $("#mudar-items").removeClass('fa-arrows-to-eye');
        $("#mudar-items").removeClass('fa-eye-slash');
        $("#mudar-items").addClass('fa-volume-low');
        $(".menuinteracao-16").css({"display":"block"});
    }
    if (_this.value >= 25 && _this.value < 40) {
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-volume-low');
        $("#mudar-items").removeClass('fa-volume-off');
        $("#mudar-items").removeClass('fa-volume-xmark');
        $("#mudar-items").removeClass('fa-eye');
        $("#mudar-items").removeClass('fa-eye-low-vision');
        $("#mudar-items").removeClass('fa-arrows-to-eye');
        $("#mudar-items").removeClass('fa-eye-slash');
        $("#mudar-items").addClass('fa-volume-off');
        $(".menuinteracao-16").css({"display":"block"});
    }
    if (_this.value >= 0 && _this.value < 25) {
        $("#mudar-items").removeClass('fa-volume-high');
        $("#mudar-items").removeClass('fa-volume-low');
        $("#mudar-items").removeClass('fa-volume-off');
        $("#mudar-items").removeClass('fa-volume-xmark');
        $("#mudar-items").removeClass('fa-eye');
        $("#mudar-items").removeClass('fa-eye-low-vision');
        $("#mudar-items").removeClass('fa-arrows-to-eye');
        $("#mudar-items").removeClass('fa-eye-slash');
        $("#mudar-items").addClass('fa-volume-xmark');
        $(".menuinteracao-16").css({"display":"block"});
    } 
    setTimeout(function(){
        $().ready(function(){
            $(".menuinteracao-12").hover(function(){},
                             function(){$(".menuinteracao-16").css({"display":"none"});});
        });
        $().ready(function(){
            $(".menuinteracao-13").hover(function(){},
                             function(){$(".menuinteracao-16").css({"display":"none"});});
        });
    },400);   
  }

  