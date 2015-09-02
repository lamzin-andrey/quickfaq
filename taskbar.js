// ==UserScript==
// @name        taskbar
// @namespace   *
// @description Мелочи
// @include     *
// @version     1
// @grant       none
// ==/UserScript==

(function LATaskbar(){
  var B, Apps;
  window.onload = function() {
     init();
     addBar();
  }
  
  //append taskbar on page
  function addBar() {
   
  }
  //init global vars
  function init() {
    B = document.body;
  }
  function e(i) {
    if (i && i.tagName) {
      return i;
    }
    return document.getElementById(i); 
  }
  function ee(tag, parent) {
    if (!parent) {
      parent = document;
    }
    return parent.getElementsByTagName(tag);
  }
  function eee(tag, cback, parent) {
    var ls = ee(tag, parent), i;
    for (i = 0; i < ls.length; i++) {
      cback(ls[i]);
    }
  }
  function sz(o) {
    if (o && o.length) {
      return o.length
    }
    return false;
  }
})()
