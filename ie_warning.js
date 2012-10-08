if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)) { //test for MSIE x.x;
    var ieversion=new Number(RegExp.$1) // capture x.x portion and store as a number
    alert("WARNING: This website does not work well with Internet Explorer. Please try any other browser in existence.");
}
