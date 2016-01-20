function unixtime() {
	return parseInt(new Date().getTime()/1000)
}
function extend(Child, Parent) {
	var F = function(){};
	F.prototype = Parent.prototype;
	Child.prototype = new F();
	Child.prototype.constructor = Child;
	Child.superclass = Parent.prototype;
}
function datetime(rus) {
	function _null(n) {
		if (n < 10) {
			return ('0'  + n);
		}
		return n;
	}
	var dt = new Date();
	day = _null(dt.getDate());
	month = _null(dt.getMonth() + 1);
	month = _null(dt.getMonth() + 1);
	hours = _null(dt.getHours());
	min = _null(dt.getMinutes());
	sec = _null(dt.getSeconds());
	var sDate = day + '.' + month + '.' + year + ' ' + hours + ':' + min + ':' + sec;
	if (!rus) {
		sDate = year + '-' + month + '-' + day + ' ' + hours + ':' + min + ':' + sec;
	}
	return sDate;
}
/**
 * @description Устанавливает маску ввода на текстовое поле ввода 
 * @param {Event} e onkeydown
*/
function inputMask (e) {
	var allow = "1234567890,-", codes = {8:1,37:1, 39:1, 16:1, 46:1, 36:1, 35:1};
	if ( !~allow.indexOf(e.key) && !codes[e.keyCode]) {
		e.preventDefault();
	}
}
function getCaretPosition(input) {
	/*var pos = 0;
	// IE < 9 Support
	if (document.selection) {
		return input.selectionStart;
		if (input.value.length == 0) return 0;
		input.focus();
		var sel = document.selection.createRange();
		var clone  = sel.duplicate();
		sel.collapse(true);
		clone.moveToElementText(input);
		clone.setEndPoint('EndToEnd', sel);
		return (clone.text.length);
	}
	// Firefox support
	else if (input.selectionStart || input.selectionStart == '0'){
		pos = input.selectionStart;
	}
	return pos;*/
	return input.selectionStart;
}
