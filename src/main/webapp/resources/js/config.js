var AM = function () {};
AM.prototype = {
	ip: 'http://'+window.location.host+'/admin',
	ipImg: 'http://' + window.location.host + '/images',
	//ipImg: 'http://139.129.111.76/images',
	//ipImg: 'http://192.168.31.110:8080/images',
	ipVideo: 'http://'+window.location.host + '/video',
	ipUrl: location.href.split('#')[0],
	//手机号码正则表达式
	isMobile : /^(((13[0-9]{1})|(18[0-9]{1})|(17[6-9]{1})|(15[0-9]{1}))+\d{8})$/,
	//电话号码正则表达式
	isPhone : /[0-9-()（）]{7,18}/,
	//身份证正则表达式
	isIHCIard :   /^\d{15}(\d{2}[\d|X])?$/,
	//6-16的密码
	isPwd : /[A-Za-z0-9]{6,16}/,
	//输入的是否为数字
	isNumber : /^[0-9]*$/,
	//检查小数
	isDouble : /^\d+(\.\d+)?$/,
	//输入的只能为数字和字母
	isNumberChar: /[A-Za-z0-9]{3,16}/,
	//用户名
	isUserName : /[\w\u4e00-\u9fa5]/,
	//emoji 表情正则
	isEmoji : /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g,
	//验证邮箱
	isEmail : /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/,
	//只能输入汉字
	isChinese : /[\u4e00-\u9fa5]/gm,
	//获取url中的参数
	getUrlParam : function(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.search.substr(1).match(reg); //匹配目标参数
		if(r != null){
			return unescape(r[2]);
		}else{
			return null; //返回参数值
		}
	},
	//时间戳转日期
	timeStampConversion : function (timestamp){
		var d = new Date(timestamp);    //根据时间戳生成的时间对象
		var date = (d.getFullYear()) + "-" +
			(d.getMonth() + 1) + "-" +
			(d.getDate())+ " " +
			(d.getHours()) + ":" +
			(d.getMinutes()) + ":" +
			(d.getSeconds());
		return date;
	},
	//日期转换为时间戳
	getTimeStamp : function (time){
		time=time.replace(/-/g, '/');
		var date=new Date(time);
		return date.getTime();
	},
	//判断是否是json对象
	isJson : function (obj){
		var isjson = typeof(obj) == "object" && Object.prototype.toString.call(obj).toLowerCase() == "[object object]" && !obj.length;
		return isjson;
	},
	//获取登录人信息
	getUserInfo : function () {
		var userInfo = JSON.parse(localStorage.getItem("userInfo"));
		return userInfo;
	},
	//秒计算出分钟数
	getFormatTime: function(time) {
		var time = time;
		var h = parseInt(time / 3600),
			m = parseInt(time % 3600 / 60),
			s = parseInt(time % 60);
		h = h < 10 ? "0" + h : h;
		m = m < 10 ? "0" + m : m;
		s = s < 10 ? "0" + s : s;

		h = h == NaN ? "00" : h;
		m = m == NaN ? "00" : m;
		s = s == NaN ? "00" : s;
		return h + ":" + m + ":" + s;
	},
	//重新获取登录人信息
	setUserInfo : function () {
		AM.ajaxRequestData("get", false, AM.ip + "/user/getUserById", {id : AM.getUserInfo().id}, null , function(result){
			if(result.flag == 0 && result.code == 200){
				localStorage.setItem("userInfo", JSON.stringify(result.data));
			}
		});
	},
	//获取登录人所拥有的权限
	getLoginUserJurisdiction : function () {
		var menuList = null;
		AM.ajaxRequestData("get", false, AM.ip + "/menu/getRoleMenu", {}, function(result){
			menuList = result.data;
		});
		return menuList;
	},
	formPopup : function (html, title, widthOrHeight, confirmCallback, closeCallback) {
		layer.confirm(html, {
			btn: ['提交','取消'],
			title: title,
			area: widthOrHeight, //宽高
		}, confirmCallback, closeCallback);
	},
	confirmPopup : function (html, title, widthOrHeight, confirmCallback, closeCallback) {
		var index = layer.confirm(html, {
			title: title,
			area: widthOrHeight, //宽高
		}, confirmCallback(index), closeCallback);
	},
	//输入框输入只保留两位小数
	clearNoNum : function (obj) {
		//先把非数字的都替换掉，除了数字和.
		obj.value = obj.value.replace(/[^\d.]/g,"");
		//保证只有出现一个.而没有多个.
		obj.value = obj.value.replace(/\.{2,}/g,".");
		//必须保证第一个为数字而不是.
		obj.value = obj.value.replace(/^\./g,"");
		//保证.只出现一次，而不能出现两次以上
		obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		//只能输入两个小数
		obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');
	},
	//ajax请求数据  get/post方式
	ajaxRequestData : function(method,async,requestUrl,arr,callback){
		$.ajax({
			type: method,
			async: async,
			url: requestUrl,
			data: arr,
			//dataType:"jsonp",    //跨域json请求一定是jsonp
			//headers: {
			//	"token" : AM.getUserInfo() == null ? null : AM.getUserInfo().token,
			//},
			success:function(json){
				if (!AM.isJson(json)) {
					json = JSON.parse(json);
				}
				console.log(json);
				if(json.flag==0 && json.code ==200){
					if (callback) {
						callback(json);
					}
				}
				else if(json.code == 1005){
					localStorage.removeItem("userInfo");
					localStorage.clear();
					//alert("你的账号已在其他地方登录.");
					location.href = AM.ip + "/page/login";
				}
				else {
					layer.alert(json.msg);
				}
			},
			error: function(json) {
				layer.alert(json.responseText);
				console.log("请求出错了.");
			}
		})
	},
	//显示遮罩
	showShade : function (context) {
		var loading = '<div class="loader-inner ball-clip-rotate-multiple"><div></div><div></div></div>';
		var html = 	"<div class=\"loading-whiteMask\" style=\"display: block\">" +
			"	<div class=\"loading-bar\">" +
			"		<div class=\"mui-row\">" +
			"			<div class=\"mui-col-xs-12 mui-col-sm-12\">" +
			"				<div class=\"loadingImg\">" + loading + "</div>" +
			"				<span class=\"loading-hint\">" + context + "</span>" +
			"			</div>" +
			"		</div>" +
			"	</div>" +
			"</div>";
		return html;
	},
//关闭遮罩
	hideShade : function () {
		$(".loading-whiteMask").remove();
	},
};

var AM = new AM();

//转时间戳
Date.prototype.format = function (fmt) { //author: meizz
	var o = {
		"M+": this.getMonth() + 1, //月份
		"d+": this.getDate(), //日
		"h+": this.getHours(), //小时
		"m+": this.getMinutes(), //分
		"s+": this.getSeconds(), //秒
		"q+": Math.floor((this.getMonth() + 3) / 3), //季度
		"S": this.getMilliseconds() //毫秒
	};
	if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for (var k in o)
		if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}


