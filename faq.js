function unixtime() {
	return parseInt(new Date().getTime()/1000);
}
/**
 * @description 
 * @param {String} sDatetime 'Y-m-d H:i:s' (php date() format)
 * @return Количество секунд с 01.01.1970 до sDatetime
*/
function time(sDatetime) {
	var re = /^[0-9]{4}\-[0-9]{2}\-[0-9]{2}\s[0-9]{2}:[0-9]{2}:[0-9]{2}$/, arr = sDatetime.split(' '),
		sDate = arr[0],
		sTime = arr[1], d = new Date(),
		re2 = /^[0-9]{4}\-[0-9]{2}\-[0-9]{2}$/;
	if (!re.test(sDatetime) && !re2.test(sDatetime)) {
		return unixtime();//@see this faq
	}
	arr = sDate.split('-');
	d.setDate(parseInt(arr[2], 10));
	d.setFullYear(arr[0]);
	d.setMonth(parseInt(arr[1], 10) - 1);
	
	if (sTime) {
		arr = sTime.split(':');
		d.setHours(parseInt(arr[0], 10));
		d.setMinutes(parseInt(arr[1], 10));
		d.setSeconds(parseInt(arr[2], 10), 0);
	} else {
		d.setHours(0);
		d.setMinutes(0);
		d.setSeconds(0, 0);
	}
	return parseInt(d.getTime()/1000);
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
	var dt = new Date(),
	day = _null(dt.getDate()),
	month = _null(dt.getMonth() + 1),
	month = _null(dt.getMonth() + 1),
	hours = _null(dt.getHours()),
	min = _null(dt.getMinutes()),
	sec = _null(dt.getSeconds()),
	year = dt.getFullYear();
	var sDate = day + '.' + month + '.' + year + ' ' + hours + ':' + min + ':' + sec;
	if (!rus) {
		sDate = year + '-' + month + '-' + day + ' ' + hours + ':' + min + ':' + sec;
	}
	return sDate;
}
/**
 * @description Индексирует массив по указанному полю
 * @param {Array} data
 * @param {String} id
*/
function indexBy(data, id) {
	var i = 0, r = {};
	$(data).each(function(i, j){
		if (j && j[id]) {
			r[j[id]] = j;
		}
	});
	return j;
}

/**
 * @description Устанавливает маску ввода на текстовое поле ввода 
 * @param {Event} e onkeydown
*/
function inputMask (e) {
	//FF
	var allow = "1234567890,-", codes = {8:1,37:1, 39:1, 16:1, 46:1, 36:1, 35:1};
	if ( !~allow.indexOf(e.key) && !codes[e.keyCode]) {
		e.preventDefault();
	}
	
	//cross
	//allow codes: 0123456789-, arrowR, arrowL, home , end, shift, delete, backspace
	var codes = {8:1,37:1, 39:1, 16:1, 46:1, 36:1, 35:1, 109:1, 188:1, 191:1, 108:1},
		i,
		//,-
		o2 = {109:1, 189:1, 188:1, 191:1, 108:1};
	for (i = 96; i < 105; i++) {
		codes[i] = 1;
	}
	for (i = 48; i < 58; i++) {
		codes[i] = 1;
	}
	if (!codes[e.keyCode] || (e.keyCode == 191 && !e.shiftKey) ) {
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


//=================AJAX HELPERS=========================================
	function  _map(data, read) {
		var $obj, obj, i;
		for (i in data) {
			$obj = $('#' + i);
			obj = $obj[0];
			if (obj) {
				if (obj.tagName == 'INPUT' || obj.tagName == 'TEXTAREA') {
					if (!read) {
						$obj.val(data[i]);
					} else {
						data[i] = $obj.val();
					}
				} else {
					if (!read) {
						$obj.text(data[i]);
					} else {
						data[i] = $obj.text();
					}
				}
			}
		}
	}
	function _get(onSuccess, url, onFail) {
		Lib._get(onSuccess, url, onFail);
	}
	function _delete(onSuccess, url, onFail) {
		_restreq('post', {}, onSuccess, url, onFail)
	}
	function _post(data, onSuccess, url, onFail) {
		var list = document.getElementsByTagName('meta'), i, t;
		for (i = 0; i < list.length; i++) {
			if ($(list[i]).attr('name') == 'app') {
				t = $(list[i]).attr('content');
				break;
			}
		}
		if (t) {
			data._token = t;
			_restreq('post', data, onSuccess, url, onFail)
		}
	}
	function _patch(data, onSuccess, url, onFail) {
		_restreq('patch', data, onSuccess, url, onFail)
	}
	function _put(data, onSuccess, url, onFail) {
		_restreq('put', data, onSuccess, url, onFail)
	}
	function _restreq(method, data, onSuccess, url, onFail) {
		$('#preloader').show();
		$('#preloader').width(screen.width);
		$('#preloader').height(screen.height);
		$('#preloader div').css('margin-top', Math.round((screen.height - 350) / 2) + 'px');
		
		if (!url) {
			url = window.location.href;
		}
		if (!onFail) {
			onFail = defaultFail;
		}
		switch (method) {
			case 'put':
			case 'patch':
			case 'delete':
				break;
		}
		$.ajax({
			method: method,
			data:data,
			url:url,
			dataType:'json',
			success:onSuccess,
			error:onFail
		});
	}
	
	function defaultFail(data) {
		window.requestSended = 0;
		alert(__('messages.Default_fail'));
	}


/**
 * @description Индексирует массив по указанному полю
 * @param {Array} data
 * @param {String} id = 'id'
 * @return {Object};
*/
function storage(key, data) {
	var L = window.localStorage;
	if (L) {
		if (data === null) {
			L.removeItem(key);
		}
		if (!(data instanceof String)) {
			data = JSON.stringify(data);
		}
		if (!data) {
			data = L.getItem(key);
			if (data) {
				try {
					data = JSON.parse(data);
				} catch(e){;}
			}
		} else {
			L.setItem(key, data);
		}
	}
	return data;
}
function onBackButton() {
	$(window).bind('popstate', function() {
		setScopesCategoriesLevelByParentId(true);
	});
}
