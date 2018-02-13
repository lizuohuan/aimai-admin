<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加用户</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>
        .preview{height: 250px;width: 400px;margin-right: 10px;margin-bottom: 10px;float: left;text-align: center}
        .preview img{width: 100%;height:210px;border: 1px solid #eee;}

    </style>
</head>
<body>
<div style="margin: 15px;">
    <blockquote class="layui-elem-quote"><i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;表单带有 <span class="font-red">“*”</span> 号的为必填项.</blockquote>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>添加用户</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData">

        <div class="layui-form-item">
            <label class="layui-form-label">用户类型<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select name="roleId" id="roleId" lay-filter="roleId" lay-verify="required" lay-search>
                    <option value="">请选择</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item layui-hide" id="showNameDiv">
            <label class="layui-form-label"><span id="showName">机构名称</span><span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="showName" id="showNameInput" lay-verify="required" placeholder="请输入机构名称" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item layui-hide" id="phoneDiv">
            <label class="layui-form-label"><span id="phone">手机号</span><span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" onkeydown=if(event.keyCode==13)event.keyCode=9 onkeyup="value=value.replace(/[^0-9- ]/g,'');" id="phoneInput1" lay-verify="required|isPhone" placeholder="请输入手机号" autocomplete="off" class="layui-input layui-hide" maxLength="11">
                <input type="text" onkeyup="value=value.replace(/[\W]/g,'')"
                       onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" id="phoneInput2" lay-verify="required|isNumberChar" placeholder="请输入登录账号" autocomplete="off" class="layui-input layui-hide" maxLength="11">
            </div>
        </div>


        <div class="layui-form-item layui-hide" id="pidDiv">
            <label class="layui-form-label"><span id="pid">机构代码</span><span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="pid" onkeyup="value=value.replace(/[\W]/g,'')"
                       onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"   id="pidInput" lay-verify="required" placeholder="请输入机构代码" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>
        <div class="layui-form-item layui-hide" id="uploadImgDiv">
            <label class="layui-form-label">头像</label>
            <div class="layui-input-inline">
                <div>
                    <input type="file" name="file" id="avatarImg" class="layui-upload-file" lay-title="上传一张图片">
                </div>
                <label class="" style="margin-left: 20px">建议尺寸110*110</label>
            </div>
        </div>

        <div class="layui-form-item layui-hide">
            <label class="layui-form-label">头像预览</label>
            <div class="layui-input-block" id="preview">

            </div>
        </div>


        <div class="layui-form-item layui-hide" id="uploadImgLicenseFile">
            <label class="layui-form-label"><span id="licenseFileImg">介绍信</span></label>
            <div class="layui-input-inline">
                <div>
                    <input type="file" name="file" id="licenseImg" class="layui-upload-file" lay-title="上传介绍信图片">
                </div>
                <label class="" style="margin-left: 20px">建议尺寸300*200</label>
            </div>
        </div>

        <div class="layui-form-item layui-hide" id="previewLicenseDiv">
            <label class="layui-form-label" id="labelMsg">预览</label>
            <div class="layui-input-block" id="previewLicense">
            </div>
        </div>

        <div class="layui-form-item layui-hide" id="tradeIdDiv">
            <label class="layui-form-label">选择行业<span id="tradeIdSpan" class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select name="tradeId" id="tradeIdSelect" <%--lay-verify="required"--%> lay-search>
                    <option value="">请选择或搜索行业</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item layui-hide" id="cityDiv">
            <label class="layui-form-label">选择地区<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select id="provinceId" name="province" lay-search lay-filter="province">
                    <option value="">请选择或搜索省</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select id="cityId" name="city"  lay-search lay-filter="city">
                    <option value="">请选择或搜索市</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select id="districtId" name="district" lay-search lay-filter="district">
                    <option  value="">请选择或搜索县/区</option>
                </select>
            </div>
        </div>


        <div class="layui-form-item layui-hide" id="townDiv">
            <label class="layui-form-label">区域分配<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select id="provinceUserId" name="provinceUserId" lay-search lay-filter="provinceUserId">
                    <option value="">请选择或搜索省</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select id="cityUserId" name="cityUserId"  lay-search>
                    <option value="">请选择或搜索市</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <button class="layui-btn layui-btn-normal" type="button" onclick="addArea(this)">新增区域</button>
            </div>
        </div>

        <div class="layui-form-item layui-hide" id="parentIdDiv">
            <label class="layui-form-label">选择企业</label>
            <div class="layui-input-inline">
                <select name="parentId" id="parentIdSelect" lay-search>
                    <option value="">请选择或搜索企业</option>
                </select>
            </div>
            <label class="layui-form-label">部门名</label>
            <div class="layui-input-inline">
                <input type="text"  name="departmentName" id="departmentName" placeholder="请输入部门名" autocomplete="off" class="layui-input" maxlength="50">
            </div>
            <label class="layui-form-label">职位</label>
            <div class="layui-input-inline">
                <input type="text"  name="jobTitle" id="jobTitle" placeholder="请输入职位" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item layui-hide" id="introduceDiv">
            <label class="layui-form-label">介绍</label>
            <div class="layui-input-block">
                <textarea name="introduce" placeholder="请输入介绍" class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item" id="pwdDiv">
            <label class="layui-form-label"><span id="pwd">默认登录密码</span><span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" value="111111" name="pwd" onkeyup="value=value.replace(/[\W]/g,'')"
                       onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"  id="pwdInput" lay-verify="required" placeholder="请输入默认登录密码" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">账户是否有效</label>
            <div class="layui-input-block">
                <input type="radio" name="isValid" value="0" title="否" checked="">
                <input type="radio" name="isValid" value="1" title="是">
            </div>
        </div>


        <input type="hidden" name="avatar" id="avatar">
        <input type="hidden" name="licenseFile" id="licenseFile">
        <input type="hidden" name="cityId">
        <input type="hidden" name="status" value="1">

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<!--引入抽取公共js-->
<%@include file="../common/public-js.jsp" %>
<script src="<%=request.getContextPath()%>/resources/js/common/jQuery.md5.js"></script>
<script>
    //上传的类型 0：头像 1：营业执照/介绍信
    var type = 0;
    var form;
    var p = "";
    layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
        form = layui.form(),
                layer = layui.layer,
                layedit = layui.layedit
                ,$ = layui.jquery,
                laydate = layui.laydate;

        getRoleList(0); //角色列表


        //自定义验证规则
        form.verify({
            isNumber: function(value) {
                if(value.length > 0 && !AM.isNumber.test(value)) {
                    return "请输入一个整数";
                }
            },
            isPhone: function(value) {
                if(value.length > 0 && !AM.isMobile.test(value)) {
                    return "请输入一个正确的手机号";
                }
            },
            isNumberChar: function(value) {
                if(value.length > 0 && !AM.isNumberChar.test(value)) {
                    return "只能为数字和字母";
                }
            }

        });
        form.render();

        //监听省
        form.on('select(provinceUserId)', function(data) {
            var html = selectCity2(data.value);
            var c = $(data.elem).parent().next().find("select[name='cityUserId']");
            $(c).html(html);
            form.render();
        });

        //监听省
        form.on('select(province)', function(data) {
            $("select[name='district']").html("<option value=\"\">请选择或搜索县/区</option>");
            // if ($("#roleId").val() == 4) {
            //     $("input[name='cityId']").val("");
            // } else {
            //     $("input[name='cityId']").val(data.value);
            // }
            $("input[name='cityId']").val(data.value);
            selectCity(data.value);
           /* if ($("#roleId").val() == 4) {
                var provinceId = $("#provinceId").val();
                var cityId = $("#cityId").val();
                var districtId = $("#districtId").val();
                var roleId = 3;
                getRoleUserList(0,roleId,provinceId,cityId,districtId,"请选择企业");
            }*/
            form.render();
        });

        //监听市
        form.on('select(city)', function(data) {
            // if ($("#roleId").val() == 4) {
            //     $("input[name='cityId']").val("");
            // } else {
            //     $("input[name='cityId']").val(data.value);
            // }
            $("input[name='cityId']").val(data.value);
            selectCounty(data.value);
           /* if ($("#roleId").val() == 4) {
                var provinceId = $("#provinceId").val();
                var cityId = $("#cityId").val();
                var districtId = $("#districtId").val();
                var roleId = 3;
                getRoleUserList(0,roleId,provinceId,cityId,districtId,"请选择企业");
            }*/
            form.render();
        });

        //监听区
        form.on('select(district)', function(data) {
            $("input[name='cityId']").val(data.value);
           /* if ($("#roleId").val() == 4) {
                var provinceId = $("#provinceId").val();
                var cityId = $("#cityId").val();
                var districtId = $("#districtId").val();
                var roleId = 3;
                getRoleUserList(0,roleId,provinceId,cityId,districtId,"请选择企业");
            }*/
            form.render();
        });


        //监听角色
        form.on('select(roleId)', function(data) {
//            alert(data.value)
            if(data.value == 2) {
                $("#showNameDiv").show();
                $("#showName").html("机构名称");
                $("#showNameInput").attr("placeholder","请输入机构名称");

                $("#phoneDiv").show();
                $("#phone").html("手机号");
                $("#phoneInput1").show();
                $("#phoneInput1").attr("lay-verify","required|isPhone");
                $("#phoneInput2").hide();
                $("#phoneInput2").removeAttr("lay-verify");

                $("#pidDiv").show();
                $("#pid").html("机构代码");
                $("#pidInput").attr("placeholder","请输入机构代码");
                $("#pidInput").attr("lay-verify","required|isNumberChar");

                if ($("#licenseFile").val() == null || $("#licenseFile").val() == "") {
                    $("#uploadImgLicenseFile").show();
                }
                $("#licenseFileImg").html("介绍信");
                $("#labelMsg").html("介绍信预览");
                $("#licenseImg").attr("lay-title","上传介绍信图片");
                uploadLicenseImg();
                uploadAvatarImg();
                if ($("#avatar").val() == null || $("#avatar").val() == "") {
                    $("#uploadImgDiv").show();
                }
                $("#tradeIdDiv").hide();
                $("#tradeIdSpan").html("*");
                $("#tradeIdSelect").removeAttr("lay-verify");
                $("#cityDiv").show();
                $("#introduceDiv").show();

                $("#townDiv").hide();
                selectProvince(0); //默认调用省
            } else if(data.value == 3) {

                $("#showNameDiv").show();
                $("#showName").html("企业名称");
                $("#showNameInput").attr("placeholder","请输入企业名称");

                $("#phoneDiv").show();
                $("#phone").html("手机号");
                $("#phoneInput1").show();
                $("#phoneInput1").attr("lay-verify","required|isPhone");
                $("#phoneInput2").hide();
                $("#phoneInput2").removeAttr("lay-verify");

                $("#pidDiv").show();
                $("#pid").html("营业执照编码");
                $("#pidInput").attr("placeholder","请输入营业执照编码");
                $("#pidInput").attr("lay-verify","required|isNumberChar");

                $("#licenseFileImg").html("营业执照");
                $("#labelMsg").html("营业执照预览");
                $("#licenseImg").attr("lay-title","上传营业执照");
                uploadLicenseImg();
                uploadAvatarImg();

                if ($("#avatar").val() == null || $("#avatar").val() == "") {
                    $("#uploadImgDiv").show();
                }
                if ($("#licenseFile").val() == null || $("#licenseFile").val() == "") {
                    $("#uploadImgLicenseFile").show();
                }
                $("#tradeIdDiv").show();
                $("#tradeIdSpan").html("*");
                $("#tradeIdSelect").attr("lay-verify","required");
                $("#cityDiv").show();
                $("#introduceDiv").show();
                $("#parentIdDiv").hide();

                $("#townDiv").hide();
                getTradeList(0); //行业列表
                selectProvince(0); //默认调用省
            }  else if(data.value == 4) {

                $("#showNameDiv").show();
                $("#showName").html("用户名");
                $("#showNameInput").attr("placeholder","请输入用户名");

                $("#phoneDiv").show();
                $("#phone").html("手机号");
                $("#phoneInput1").show();
                $("#phoneInput1").attr("lay-verify","required|isPhone");
                $("#phoneInput2").hide();
                $("#phoneInput2").removeAttr("lay-verify");

                $("#pidDiv").show();
                $("#pid").html("身份证号");
                $("#pidInput").attr("placeholder","请输入身份证号");

                uploadAvatarImg();
                $("#uploadImgLicenseFile").hide();
                if ($("#avatar").val() == null || $("#avatar").val() == "") {
                    $("#uploadImgDiv").show();
                }
                $("#tradeIdDiv").show();
                $("#tradeIdSpan").html("");
                $("#tradeIdSelect").removeAttr("lay-verify");
                $("#cityDiv").show();
                $("#introduceDiv").show();
                selectProvince(0); //默认调用省
               /* var provinceId = $("#provinceId").val();
                var cityId = $("#cityId").val();
                var districtId = $("#districtId").val();*/
//                var roleId = $("#roleId").val();
                getRoleUserList(0,3,null,null,null,"请选择企业");
                $("#parentIdDiv").show();
                getTradeList(0); //行业列表

                $("#townDiv").hide();
            } else if(data.value == 5) {

                $("#showNameDiv").show();
                $("#showName").html("分销商名称");
                $("#showNameInput").attr("placeholder","请输入分销商名称");

                $("#townDiv").show();


                $("#phoneDiv").show();
                $("#phone").html("手机号");
                $("#phoneInput1").show();
                $("#phoneInput1").attr("lay-verify","required|isPhone");
                $("#phoneInput2").hide();
                $("#phoneInput2").removeAttr("lay-verify");

                $("#pidDiv").show();
                $("#pid").html("资质编码");
                $("#pidInput").attr("placeholder","请输入资质编码");
                $("#pidInput").attr("lay-verify","required|isNumberChar");

                if ($("#licenseFile").val() == null || $("#licenseFile").val() == "") {
                    $("#uploadImgLicenseFile").show();
                }
                $("#licenseFileImg").html("资质");
                $("#labelMsg").html("资质预览");
                $("#licenseImg").attr("lay-title","上传资质图片");
                if ($("#avatar").val() == null || $("#avatar").val() == "") {
                    $("#uploadImgDiv").show();
                }
                uploadLicenseImg();
                uploadAvatarImg();
                $("#tradeIdDiv").show();
                $("#tradeIdSpan").html("*");
                $("#tradeIdSelect").removeAttr("lay-verify");
                // $("#tradeIdSelect").attr("lay-verify","required");
                $("#cityDiv").show();
                $("#introduceDiv").show();
                $("#parentIdDiv").hide();
                getTradeList(0); //行业列表
                selectProvince(0); //默认调用省
                p = selectProvince2(0); //默认调用省
            } else {


                $("#showNameDiv").show();
                $("#showName").html("管理员姓名");
                $("#showNameInput").attr("placeholder","请输入管理员姓名");

                $("#phoneDiv").show();
                $("#phone").html("登录账号");
                $("#phoneInput2").show();
                $("#phoneInput2").attr("lay-verify","required");
                $("#phoneInput1").hide();
                $("#phoneInput1").removeAttr("lay-verify");

                $("#pidDiv").hide();
                $("#pidInput").removeAttr("lay-verify");
                $("#tradeIdSelect").removeAttr("lay-verify");
                $("#uploadImgLicenseFile").hide();
                $("#uploadImgDiv").hide();
                $("#preview").empty();
                $("#preview").parent().hide();
                $("#avatar").val("");
                $("#previewLicense").empty();
                $("#previewLicense").parent().hide()
                $("#licenseFile").val("");
                $("#previewLicenseDiv").hide();
                $("#tradeIdDiv").hide();
                $("#cityDiv").hide();
                $("#parentIdDiv").hide();
                $("#introduceDiv").hide();

                $("#townDiv").hide();
            }

            form.render();
        });


        //监听提交
        form.on('submit(demo1)', function(data) {

            //todo 当角色为2,3,5时 licenseFile(企业：营业执照 分销商：资质 政府：介绍信) 不能为空
            /*if (data.field.roleId == 2 || data.field.roleId == 3 || data.field.roleId == 5) {
                if ($("#licenseFile").val() == null || $("#licenseFile").val().trim() == "") {
                    layer.msg($("#licenseImg").attr("lay-title"), {icon: 2,anim: 6});
                    return false;
                }
            }*/
            //todo 当角色为3,5时 tradeId(经营行业) 不能为空
            // if (data.field.roleId == 3 || data.field.roleId == 5) {
            //     if (data.field.tradeId == null || data.field.tradeId == "") {
            //         layer.msg("请选择行业", {icon: 2,anim: 6});
            //         return false;
            //     }
            // }
//             if (data.field.roleId == 4) {
//                 if (data.field.cityId == null || data.field.cityId == "") {
//                     layer.msg("请选择地区至区/县", {icon: 2,anim: 6});
//                     return false;
//                 }
//             } else if (data.field.roleId > 1 && data.field.roleId < 6){
//                 data.field.cityId = 100000;
// //                if (data.field.cityId == null || data.field.cityId == "") {
// //                    layer.msg("请选择地区", {icon: 2,anim: 6});
// //                    return false;
// //                }
//             }
            if (data.field.cityId == null || data.field.cityId == "") {
                data.field.cityId = 100000;
            }
            if (data.field.roleId == 1 || data.field.roleId > 5) {
                data.field.phone = $("#phoneInput2").val();
            } else {
                data.field.phone = $("#phoneInput1").val();
            }

            delete data.field.city;


            if (data.field.avatar == "") {
                data.field.avatar = null;
            }

            if (data.field.licenseFile == "") {
                data.field.licenseFile = null;
            }
            data.field.pwd = $.md5("111111");

            if(data.field.roleId == 5){
                // 分销商
                var cityIds = [];
                $("select[name='cityUserId']").each(function () {
                    var cityId = $(this).find("option:selected").val();
                    if(cityId == '' || null == cityId){
                        layer.msg("区域城市没有选择", {icon: 2,anim: 6});
                        return false;
                    }
                    cityIds[cityIds.length] = cityId;
                })
                data.field.cityIds = JSON.stringify(cityIds);
            }
            console.log(data.field);
            // return false;
            AM.ajaxRequestData("post", false, AM.ip + "/user/save", data.field  , function(result) {
                if (result.flag == 0 && result.code == 200) {
                    layer.alert('添加成功.', {
                        skin: 'layui-layer-molv' //样式类名
                        ,closeBtn: 0
                        ,anim: 3 //动画类型
                    }, function(){
                        //关闭iframe页面
                        var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                        parent.layer.close(index);
                        window.parent.closeNodeIframe();
                    });
                } else {
                    layer.msg(result.msg, {icon: 2,anim: 6});
                    return false;
                }
            });
            return false;
        });
    });

    //删除图片
    function deleteImg (object) {
        if (type == 0) {
            var url = $(object).attr("avatar");
            var avatars = $("#avatar").val().split(",");
            for (var i = 0; i < avatars.length; i++) {
                if (avatars[i] == url) {
                    avatars.splice(i, 1);
                    $(object).parent().fadeOut();
                    break;
                }
            }
            if (avatars.length == 0) $("#preview").parent().hide();
            console.log(avatars);
            $("#avatar").val(avatars.toString());
            $("#uploadImgDiv").show();
        } else if (type == 1){
            var url = $(object).attr("licenseFile");
            var licenseFiles = $("#licenseFile").val().split(",");
            for (var i = 0; i < licenseFiles.length; i++) {
                if (licenseFiles[i] == url) {
                    licenseFiles.splice(i, 1);
                    $(object).parent().fadeOut();
                    break;
                }
            }
            if (licenseFiles.length == 0) $("#previewLicense").parent().hide();
            console.log(licenseFiles);
            $("#licenseFile").val(licenseFiles.toString());
            $("#uploadImgLicenseFile").show();
        }
    }
    
    function addArea(obj) {
        var html =
            '<div class="layui-form-item">'+
                '<label class="layui-form-label"><span class="font-red"></span></label>'+
                '<div class="layui-input-inline">'+
                    '<select  name="provinceUserId" lay-search lay-filter="provinceUserId">'+ p +
                    '</select>'+
                '</div>'+
                '<div class="layui-input-inline">'+
                    '<select  name="cityUserId"  lay-search>'+
                        '<option value="">请选择或搜索市</option>'+
                    '</select>'+
                '</div>'+
                '<div class="layui-input-inline">'+
                    // '<button class="layui-btn  layui-btn-normal" type="button" onclick="addArea(this)">新增区域</button>'+
                    '<button class="layui-btn  layui-btn-normal" type="button" onclick="delArea(this)"><i class="layui-icon">&#xe640;</i></button>'+
                '</div>'+
            '</div>';
        $(obj).parent().parent().append(html);
        form.render();
    }

    function delArea(obj) {
        $(obj).parent().parent().remove();
    }

    var uploadMsg;
    function uploadLicenseImg() {
        //上传图片
        layui.upload({
            url: AM.ipImg + "/res/upload", //上传接口
            elem:"#licenseImg"
            ,before: function(){
                uploadMsg = layer.msg('上传中，请不要刷新页面', {icon: 16,shade: 0.5, time: 100000000 })
            }
            ,success: function(res){ //上传成功后的回调
                type = 1;
                console.log(res.data.url);
                var urls = $("#licenseFile").val().split(",");
                if (urls[0] == "") {
                    urls = [];
                }
                urls.push(res.data.url);
                $("#licenseFile").val(urls.toString());
                var html = '<div class="preview">' +
                        '<img src="' + AM.ipImg + '/' + res.data.url + '"><br>' +
                        "<button type=\"button\" class=\"layui-btn layui-btn-danger\" licenseFile=\"" + res.data.url + "\" onclick=\"deleteImg(this)\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                $("#previewLicense").append(html);
                $("#previewLicense").parent().show();
                $("#uploadImgLicenseFile").hide();
                layer.close(uploadMsg);
                form.render();
            }
        });
    }


    function uploadAvatarImg(){
        //上传图片
        layui.upload({
            url: AM.ipImg + "/res/upload", //上传接口
            elem:"#avatarImg" //上传接口
            ,before: function(){
                uploadMsg = layer.msg('上传中，请不要刷新页面', {icon: 16,shade: 0.5, time: 100000000 })
            }
            ,success: function(res){ //上传成功后的回调
                type = 0;
                console.log(res.data.url);
                var urls = $("#avatar").val().split(",");
                if (urls[0] == "") {
                    urls = [];
                }
                urls.push(res.data.url);
                $("#avatar").val(urls.toString());
                var html = '<div class="preview">' +
                        '<img src="' + AM.ipImg + '/' + res.data.url + '"><br>' +
                        "<button type=\"button\" class=\"layui-btn layui-btn-danger\" avatar=\"" + res.data.url + "\" onclick=\"deleteImg(this)\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                $("#preview").append(html);
                $("#preview").parent().show();
                $("#uploadImgDiv").hide();
                layer.close(uploadMsg);
                form.render();
            }
        });

    }

//    function updateRole(obj) {
//        var role = $(obj);
//        if (role.val() == 1) {
//
//        }
//    }
</script>
</body>
</html>
