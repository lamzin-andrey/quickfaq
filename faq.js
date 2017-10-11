function unixtime() {
	return parseInt(new Date().getTime()/1000);
}
/**
 * @description 
 * @param {String} sDatetime 'Y-m-d H:i:s' (php date() format)
 * @return Количество секунд с 01.01.1970 до sDatetime
*/
function time(sDatetime) {
	var re = /^[0-9]{4}\-[0-9]{2}\-[0-9]{2}\s[0-9]{2}:[0-9]{2}:[0-9]{2}$/, arr = String(sDatetime).split(' '),
		sDate = arr[0],
		sTime = arr[1], d = new Date(),
		re2 = /^[0-9]{4}\-[0-9]{2}\-[0-9]{2}$/;
	if (!re.test(sDatetime) && !re2.test(sDatetime)) {
		return parseInt(new Date().getTime()/1000);
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

function  _map(data, read) {
	var $obj, obj, i;
	for (i in data) {
		$obj = $(i);
		//obj = $obj[0];
		obj = $obj;
		if (obj) {
			if (obj.tagName == 'INPUT' || obj.tagName == 'TEXTAREA') {
				if (!read) {
					obj.value = data[i];
				} else {
					if (obj.type == 'checkbox') {
						data[i] = obj.checked;
					} else {
						data[i] = obj.value;
					}
				}
			} else {
				if (!read) {
					if (obj.type == 'checkbox') {
						var v = data[i] == 'false' ? false: data[i];
						v = v ? true : false;
						obj.checked = v;
					} else {
						obj.innerText = data[i];
					}
				} else {
					data[i] = obj.innerText;
				}
			}
		}
	}
}
function _get(onSuccess, url, onFail) {
	_restreq('get', {}, onSuccess, url, onFail)
}
function _delete(onSuccess, url, onFail) {
	_restreq('post', {}, onSuccess, url, onFail)
}
function _post(data, onSuccess, url, onFail) {
	var t = getToken();
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
	/*$('#preloader').show();
	$('#preloader').width(screen.width);
	$('#preloader').height(screen.height);
	$('#preloader div').css('margin-top', Math.round((screen.height - 350) / 2) + 'px');
	*/
	if (!url) {
		url = window.location.href;
	} else {
		url = W.root + url;
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
	/*$.ajax({
		method: method,
		data:data,
		url:url,
		dataType:'json',
		success:onSuccess,
		error:onFail
	});*/
	pureAjax(url, data, onSuccess, onFail, method);
}


/**
 * @desc Аякс запрос к серверу, использует JSON
*/
function pureAjax(url, data, onSuccess, onFail, method) {
	var xhr = new XMLHttpRequest();
	//подготовить данные для отправки
	var arr = []
	for (var i in data) {
		arr.push(i + '=' + encodeURIComponent(data[i]));
	}
	var sData = arr.join('&');
	//установить метод  и адрес
	//console.log("'" + url + "'");
	xhr.open(method, url);
	//console.log('Open...');
	//установить заголовок
	xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	//обработать ответ
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			var error = {};
			if (xhr.status == 200) {
				try {
					var response = JSON.parse(String(xhr.responseText));
					onSuccess(response, xhr);
					return;
				} catch(e) {
					console.log(e);
					error.state = 1;
					error.info = 'Fail parse JSON';
				}
			}else {
				error.state = 1;
			}
			if (error.state) {
				onFail(xhr.status, xhr.responseText, error.info, xhr);
			}
		} 
	}
	//отправить
	//console.log('bef send');
	xhr.send(sData);
	//console.log('aft send');
}
/**
 * @description Инпут с соответствующими атрибутами будет при выборе файла отправлять данные на data-url
 * Передаются опционально:
 * data-onselect - обработка выбора файла, если передать функцию, не будет немедленной отправки.
 * В этом случае надо вызвать sendFile(iFile, url, onSuccess, onFail,  onProgress) когда надо отправить файл
 * onProgress будет вызвана с аргументами loadedPercents, loadedButes, total
 * onFail будет вызвана с аргументами status, arguments  - оригинальные параметры
*/
function initFileInputs() {
	W.iFiles = {};
	var ls = $$(D, 'input'), i, j, attrs = {}, k, isValid = 1, onSelect, url;
	for (i = 0; i < ls.length; i++) {
		j = ls[i];
		if (j.type == 'file') {
			url = attr(j, 'data-url' );
			attrs.success    = attr(j, 'data-success');
			attrs.fail       = attr(j, 'data-fail');
			attrs.progress   = attr(j, 'data-progress');
			//не обязательные атрибуты
			onSelect   = attr(j, 'data-onselect');
			for (k in attrs) {
				if (!(attrs[k] && (window[attrs[k]] instanceof Function)) ) {
					isValid = 0
				}
			}
			if (isValid && j.id) {
				attrs.url = url;
				iFiles[j.id] = attrs;
				initFileInput(j, onSelect);
			}
		}
	}
}
/**
 * @see initFileInputs
*/
function initFileInput(iFile, onSelect) {
	if (window[onSelect] instanceof Function) {
		iFile.onchange = window[onSelect];
		return;
	}
	iFile.onchange = mcrOnSelectFile;
}
/**
 * @see initFileInputs
*/
function mcrOnSelectFile(evt) {
	if(iFiles[evt.target.id]) {
		var o = iFiles[evt.target.id];
		sendFile($(evt.target.id), o.url, W[o.success], W[o.fail],  W[o.progress]);
	}
}
/**
 * @see initFileInputs
*/
function sendFile(iFile, url, onSuccess, onFail,  onProgress) {
	var xhr = new XMLHttpRequest(), form = new FormData(), t;
	form.append(iFile.id, iFile.files[0]);
	//form.append("isFormData", 1);
	form.append("path", url);//TODO ??
	t = getToken();
	if (t) {
		form.append("_token", t);
	}
	xhr.upload.addEventListener("progress", function(pEvt){
		var loadedPercents, loadedBytes, total;
		if (pEvt && pEvt.lengthComputable) {
			loadedPercents = Math.round((pEvt.loaded * 100) / pEvt.total);
		}
		onProgress(loadedPercents, loadedBytes, total);
	});
	xhr.upload.addEventListener("error", onFail);
	xhr.onreadystatechange = function () {
		t = this;
		if (t.readyState == 4) {
			if(this.status == 200) {
				try {
					t.responseText = JSON.parse(t.responseText);
				} catch(e){;}
				onSuccess(t.responseText);
			} else {
				onFail(t.status, arguments);
			}
		}
    };
    xhr.open("POST", url);
    xhr.send(form);
}
function defaultFail(data) {
	W.requestSended = 0;
	error('Не удалось обработать запрос, попробуйте снова');
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
/**
 * @description clear all storage elements with prefix key
*/
function clearStorageByPrefix(key) {
	var i, sz = localStorage.length, arr = [], str;
	for (i = 0; i < sz; i++) {
		str = localStorage.key(i);
		console.log(str);
		if (~str.indexOf(key)) {
			arr.push(str);
		}
	}
	for (i = 0; i < arr.length; i++) {
		localStorage.removeItem(arr[i]);
	}
}
function onBackButton() {
	$(window).bind('popstate', function() {
		setScopesCategoriesLevelByParentId(true);
	});
}
