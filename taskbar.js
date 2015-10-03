// ==UserScript==
// @name        taskbar
// @namespace   *
// @description Мелочи
// @include     *
// @version     1
// @grant       none
// ==/UserScript==

(function LATaskbar(){
  var W = window, D = document, B, Apps, Bar = null, INFO = {};
  window.onload = function() {
     init();
     addBar();
  }
  
  //append taskbar on page
  function addBar() {
    taskBarView();
    appMenuView();
    taskBarLogic();
  }
  //TODO STOP HERE 
  function appMenuView() {
    var htmlItem  = '<li><img src="{SRC}"/>{TEXT}</li>',
        html = '<div><input type="text"></div>',
        view  = ce('ul'),
        style = '';
    Bar.list = view;
  }
  //set click handler
  function taskBarLogic() {
    Bar.onclick = function() {
      toggleAppMenu();
    }
  }
  //@see name )
  function toggleAppMenu() {
    showMenu(INFO.menuIsShow  ? 1 : 0);
  }
  function showMenu(isVisible) {
    INFO.menuIsShow = isVisible;
  }
  //draw taskbar
  function taskBarView() {
    var L = localStorage, l = L.getItem('LATbarL'), t = L.getItem('LATbarT');
    t = t ? t : getViewport().h - 10;
    l = l ? l : getViewport().w - 100;
    var style = "position:fixed; z-index:30000; left:" + l + "px; top:" + t + "px;";
    style += 'background-color:#6DC6ED; width:60px; height:60px';
    d = ce('div', B, 'LATbarL');
    d.style = style;
    Bar = d;
  }
  //init global vars
  function init() {
    B = document.body;
  }
  //====================quickllib====================
  function ce(tag, parent, id) {
    if (!parent) {
      parent = document.body;
    }
    var e = document.createElement(tag);
    parent.appendChild(e);
    return e;
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
  
  function getViewport() {
    var w = W.innerWidth, h = W.innerHeight;
    if (!w && D.documentElement && D.documentElement.clientWidth) {
      w = D.documentElement.clientWidth;
    } else if (!w) {
      w = D.getElementsByTagName('body')[0].clientWidth;
    }
    if (!h && D.documentElement && D.documentElement.clientHeight) {
      h = D.documentElement.clientHeight;
    } else if (!h) {
      h = D.getElementsByTagName('body')[0].clientHeight;
    }
    return {w:w, h:h};
  }
})()
