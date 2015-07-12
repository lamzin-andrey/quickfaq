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
