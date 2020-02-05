var MootoolMy = {
	post: function(url, data, F, E) {
		if (!E) {
			E = F;
		}
		data.token = window.token;
		data.xhr = 1;
		var req = new Request.JSON({
			url:url,
			data:data,
			method:'post',
			onSuccess:F,
			onFailure:E
		});
		req.send();
	},
	lskey: function (data) {
		var key = '', i;
		for (i in data) {
			if (i != 'token' && i != 'xhr') {
				key += i + "=" + data[i];
			}
		}
		return key;
	},
	cachepost: function(url, data, F, E) {
		if (!E) {E = F;}
		if (data.action && url) {
			var key = Tool.lskey(data), s, r;
			if (localStorage.getItem(key)) {
				try {
					r = localStorage.getItem(key);
					s = JSON.decode(r);
				    F(s, r);
				    return;
				} catch(err) {;}
			}
			Tool.cSucc = F;
			Tool.cFail = E;
			Tool.lsdata = data;
			Tool.post(url, data, Tool.cacheSuccess, Tool.cacheFail);
		}
	},
	cacheSuccess: function (data, raw) {
		localStorage.setItem(Tool.lskey(Tool.lsdata), raw);
		Tool.cSucc(data, raw);
	},
	cacheFail: function (xrh) {Tool.cFail(xrh);	},
	
	enableInputs: function(id, f) {
		if ($(id)) {
			$(id).getElements("input").each(
				function(i) {
					i.disabled = f;
				}
			);
			$(id).getElements("select").each(
				function(i) {
					i.disabled = f;
				}
			);
		}
	},
	parseData:function(s, pairSep, sep) {
		if (!pairSep) {
			pairSep = "&";
		}
		if (!sep) {
			sep = "=";
		}
		if (!s) {
			s = String(window.location.href.split("?")[1]);
		}
		var a = s.split(pairSep), r = {}, i, j;
		for (i = 0; i < sz(a); i++) {
			j = a[i].split(sep);
			r[j[0]] = j[1];
		}
		return r;
	},
	viewportSize:function() {
		var opera = (navigator.userAgent.toLowerCase().indexOf('opera') > -1),
		html = document.documentElement,
		body = document.body,
		w = document.compatMode=='CSS1Compat' && !opera ? html.clientWidth : body.clientWidth,
		h = document.compatMode=='CSS1Compat' && !opera ? html.clientHeight : body.clientHeight;
		return {w:w, h:h};
	},
	host:function(s) {
		if (!s) {
			s = window.location.href;
		}
		return s.split('/').slice(0, 3).join('/');
	}
};

var Shorten = {
	sz: function(obj) {
		return obj.length;
	},
	to_i: function(n) {
		var v = parseInt(n);
		v = v ? v : 0;
		return v;
	}
};

var Select = {
	selectByValue:function(select, n) {
		for (var i = 0; i < sz($(select).options); i++) {
			if ( $(select).options[i].value == n ) {
				$(select).options.selectedIndex = i;
				$(select).onchange();
				break;
			}
		}
	}
}

var OfflineTools = {
	Notify: function (s) {
		//FF
		if (window.Notification) {
			function _notify(s) {
				new Notification(s);
			}
			if (Notification.permission === 'granted') {
				_notify(s);
			} else {
				Notification.requestPermission(function(permission) {
					if (permission === 'granted') {
						_notify(s);
					}
				});
			}
		}
	}
};


var RestAjax = {
	//=================AJAX HELPERS=========================================
	 _map: function (data, read) {
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
	_get:function (onSuccess, url, onFail) {
		Lib._get(onSuccess, url, onFail);
	}
	_delete: function (onSuccess, url, onFail) {
		_restreq('post', {}, onSuccess, url, onFail)
	}
	 _post: function(data, onSuccess, url, onFail) {
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
	_patch:function(data, onSuccess, url, onFail) {
		_restreq('patch', data, onSuccess, url, onFail)
	}
	_put:function(data, onSuccess, url, onFail) {
		_restreq('put', data, onSuccess, url, onFail)
	}
	_restreq:function(method, data, onSuccess, url, onFail) {
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
	
	defaultFail:function(data) {
		window.requestSended = 0;
		alert(__('messages.Default_fail'));
	}
};
