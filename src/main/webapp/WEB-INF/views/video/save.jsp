<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加视频</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>
        .preview{height: 250px;width: 400px;margin-right: 10px;margin-bottom: 10px;float: left;text-align: center}
        .preview img{width: 100%;height:210px;border: 1px solid #eee;}
        .preview video{width: 100%;height:210px;border: 1px solid #eee;}

    </style>
</head>
<body>
<div style="margin: 15px;">
    <blockquote class="layui-elem-quote"><i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;表单带有 <span class="font-red">“*”</span> 号的为必填项.</blockquote>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>添加视频</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData">
        <input type="text" id="courseWareId" name="courseWareId" value="${courseWareId}" style="display: none;">




        <div class="layui-form-item">
            <label class="layui-form-label">视频名<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" id="name" name="name" lay-verify="required" placeholder="请输入视频名" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item" id="uploadImgDiv">
            <label class="layui-form-label">视频预览图<%--<span class="font-red">*</span>--%></label>
            <div class="layui-input-inline">
                <div>
                    <input type="file" name="file" id="fileImage" class="layui-upload-file" onclick="uploadResource(0)">
                </div>
                <label class="" style="margin-left: 20px">建议尺寸300*200</label>
            </div>
        </div>

        <div class="layui-form-item layui-hide">
            <label class="layui-form-label">视频预览图预览</label>
            <div class="layui-input-block" id="preview">
            </div>
        </div>



        <div class="layui-form-item">
            <label class="layui-form-label">视频源选项</label>
            <div class="layui-input-inline">
                <select id="changeVideo" name="changeVideo" lay-filter="changeVideo">
                    <option value="">请选择视频选项</option>
                    <option value="0" selected>本地视频源</option>
                    <option value="1">云视频源</option>
                </select>
            </div>
        </div>

        <div id="localDiv">
            <div class="layui-form-item">
                <label class="layui-form-label">高清视频来源</label>
                <div class="layui-input-inline">
                    <select id="highDefinitionSel" name="sourceHigh" lay-filter="highDefinitionSel">
                        <option value="">请选择来源类型</option>
                        <option value="0">直接上传</option>
                        <option value="1">视频库选择</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item layui-hide" id="videoWareHouseHighDiv">
                <label class="layui-form-label">视频库</label>
                <div class="layui-input-inline">
                    <select name="videoWareHouseHighId" lay-filter="videoWareHouseHighId">
                        <option value="">请选择视频</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item layui-hide" id="uploadVideoG">
                <label class="layui-form-label">上传高清视频<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <input type="file" lay-type="video" id="fileVideoG" name="file" class="layui-upload-file" onclick="uploadResource(1)" lay-title="上传高清视频">
                </div>
            </div>

            <div class="layui-form-item layui-hide">
                <label class="layui-form-label">高清视频预览</label>
                <div class="layui-input-block" id="previewVideoG">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">流畅视频来源</label>
                <div class="layui-input-inline">
                    <select id="lowDefinitionSel" name="sourceLow" lay-filter="lowDefinitionSel">
                        <option value="">请选择来源类型</option>
                        <option value="0">直接上传</option>
                        <option value="1">视频库选择</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item layui-hide" id="videoWareHouseLowDiv">
                <label class="layui-form-label">视频库</label>
                <div class="layui-input-inline">
                    <select name="videoWareHouseLowId" lay-filter="videoWareHouseLowId">
                        <option value="">请选择视频</option>
                    </select>
                </div>
            </div>


            <div class="layui-form-item layui-hide" id="uploadVideoL">
                <label class="layui-form-label">上传流畅视频<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <input type="file" lay-type="video" id="fileVideoL" name="file" class="layui-upload-file" onclick="uploadResource(2)" lay-title="上传流畅视频">
                </div>
            </div>

            <div class="layui-form-item layui-hide">
                <label class="layui-form-label">流畅视频预览</label>
                <div class="layui-input-block" id="previewVideoL">

                </div>
            </div>
        </div>


        <div id="cloudDiv" class="layui-hide">
            <div class="layui-form-item ">
                <label class="layui-form-label">视频库</label>
                <div class="layui-input-inline">
                    <select name="cloudVideo" id="cloudVideo" lay-filter="cloudVideoFilter">
                        <option value="">请选择视频</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item layui-hide">
                <label class="layui-form-label">云视频预览</label>
                <div class="layui-input-block" id="previewCloudVideo">

                </div>
            </div>

        </div>


        <input type="hidden" name="cover" id="cover">
        <input type="hidden" name="highDefinition" id="highDefinition">
        <input type="hidden" name="lowDefinition" id="lowDefinition">
        <input type="hidden" name="highDefinitionSeconds" id="highDefinitionSeconds">
        <input type="hidden" name="lowDefinitionSeconds" id="lowDefinitionSeconds">
        <video src=""></video>
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
<script>

    //上传类型 0:头像  1：高清视频  2：流程视频
    var updateType = 0;
    function uploadResource(type){
        updateType = type;
    }
    layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
        var form = layui.form(),
                layer = layui.layer,
                layedit = layui.layedit
                ,$ = layui.jquery,
                laydate = layui.laydate;


        //监听视频源选项
        form.on('select(changeVideo)', function(data) {
            if(data.value == 0){
                // 本地视频库
                $("#localDiv").show("fast");
                $("#cloudDiv").hide("fast");
            }
            else{
                // 云视频库
                $("#localDiv").hide("fast");
                $("#cloudDiv").show("fast");
                getVideoHouse(0,"cloudVideo",1);
            }
            form.render();
        });





        //监听高清视频来源
        form.on('select(highDefinitionSel)', function(data) {
            $("#highDefinition").val("");
            $("#highDefinitionSeconds").val("");
            if (data.value == 1) {
                getVideoHouse(0,"videoWareHouseHighId",0);
                $("#uploadVideoG").hide();
                $("#videoWareHouseHighDiv").show();
            } else {
                $("#videoWareHouseHighDiv").hide();
                $("#uploadVideoG").show();
            }
            $("#videoG").parent().remove();
            $("#previewVideoG").parent().hide()
            form.render();
        });

        //监听流畅视频来源
        form.on('select(lowDefinitionSel)', function(data) {
            $("#lowDefinition").val("");
            $("#lowDefinitionSeconds").val("");
            if (data.value == 1) {
                getVideoHouse(0,"videoWareHouseLowId",0);
                $("#uploadVideoL").hide();
                $("#videoWareHouseLowDiv").show();
            } else {
                $("#videoWareHouseLowDiv").hide();
                $("#uploadVideoL").show();
            }
            $("#videoL").parent().remove();
            $("#previewVideoL").parent().hide()
            form.render();
        });


        //监听高清视频库
        form.on('select(videoWareHouseHighId)', function(data) {
            $("#videoG").parent().remove();
            var index = data.elem.selectedIndex;
            var url = data.elem.options[index].getAttribute("url");
            $("#highDefinition").val(url);
            $("#highDefinitionSeconds").val(data.elem.options[index].getAttribute("seconds"));
            var html = '<div class="preview">' +
                    '<video id="videoG" controls="controls" src="'+AM.ipVideo + '/' + url +'"></video><br></div>';
            $("#previewVideoG").append(html);
            $("#previewVideoG").parent().show();
            form.render();
        });

        //监听流畅视频来源
        form.on('select(videoWareHouseLowId)', function(data) {
            $("#videoL").parent().remove();
            var index = data.elem.selectedIndex;
            var url = data.elem.options[index].getAttribute("url");
            $("#lowDefinition").val(url);
            $("#lowDefinitionSeconds").val(data.elem.options[index].getAttribute("seconds"));
            var html = '<div class="preview">' +
                    '<video id="videoL" controls="controls" src="' + AM.ipVideo + '/' + url + '"></video><br></div>';
            $("#previewVideoL").append(html);
            $("#previewVideoL").parent().show();
            form.render();
        });

        //监听云视频
        form.on('select(cloudVideoFilter)', function(data) {
            $("#cloudVideoUrl").parent().remove();
            var index = data.elem.selectedIndex;
            var url = data.elem.options[index].getAttribute("url");
            // $("#lowDefinition").val(url);
            // $("#lowDefinitionSeconds").val(data.elem.options[index].getAttribute("seconds"));
            var html = '<div class="preview">' +
                    '<video id="cloudVideoUrl" controls="controls" src="'+ url + '"></video><br></div>';
            $("#previewCloudVideo").append(html);
            $("#previewCloudVideo").parent().show();
            form.render();
        });

        var uploadMsg;

        //上传图片
        layui.upload({
            url: AM.ipImg + "/res/upload" //上传接口
            ,elem: '#fileImage'
            ,before: function(){
                uploadMsg = layer.msg('上传中，请不要刷新页面', {icon: 16,shade: 0.5, time: 100000000 })
            }
            ,success: function(res){ //上传成功后的回调
                console.log(res.data.url);
                var urls = $("#cover").val().split(",");
                if (urls[0] == "") {
                    urls = [];
                }
                urls.push(res.data.url);
                if (updateType == 0) {
                    $("#cover").val(urls.toString());
                    var html = '<div class="preview">' +
                            '<img src="' + AM.ipImg + '/' + res.data.url + '"><br>' +
                            "<button type=\"button\" class=\"layui-btn layui-btn-danger\" cover=\"" + res.data.url + "\" onclick=\"deleteImg(this,"+updateType+")\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                    $("#preview").append(html);
                    $("#preview").parent().show();
                    $("#uploadImgDiv").hide();
                }
                layer.close(uploadMsg);
                form.render();

            }
        });

        //上传高清视频
        layui.upload({
            url: AM.ipVideo + "/res/upload" //上传接口
            ,elem: '#fileVideoG'
            ,before: function(){
                uploadMsg = layer.msg('上传中，请不要刷新页面', {icon: 16,shade: 0.5, time: 100000000 })
            }
            ,success: function(res){
                console.log(res.data.url);
                //上传成功后的回调
                var urls = $("#highDefinition").val().split(",");
                if (urls[0] == "") {
                    urls = [];
                }
                urls.push(res.data.url);
                $("#highDefinition").val(urls.toString());
//                $("#highDefinitionSeconds").val(res.data.ls);
                var html = '<div class="preview">' +
                        '<video id="videoG" controls="controls" src="'+AM.ipVideo + '/' + res.data.url+'"></video><br>' +
                        "<button type=\"button\" class=\"layui-btn layui-btn-danger\" highDefinition=\"" + res.data.url + "\" " +
                        "onclick=\"deleteImg(this,"+updateType+")\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
//                var html = "<a href='"+ AM.ipVideo + '/' + res.data.url +"' class='layui-btn layui-btn-danger'>点击预览</a>";
//                alert(html);
//                document.getElementById('videoG').setAttribute("src", AM.ipVideo + '/' + res.data.url );


                $("#previewVideoG").append(html);
                $("#previewVideoG").parent().show();
                $("#uploadVideoG").hide();
                layer.close(uploadMsg);
                form.render();
            }
        });

        //上传流畅视频
        layui.upload({
            url: AM.ipVideo + "/res/upload" //上传接口
            ,elem: '#fileVideoL'
            ,before: function(){
                uploadMsg = layer.msg('上传中，请不要刷新页面', {icon: 16,shade: 0.5, time: 100000000 })
            }
            ,success: function(res){
                //上传成功后的回调
                var urls = $("#lowDefinition").val().split(",");
                if (urls[0] == "") {
                    urls = [];
                }
                urls.push(res.data.url);
                $("#lowDefinition").val(urls.toString());
                var html = '<div class="preview">' +
                        '<video id="videoL" controls="controls" src="' + AM.ipVideo + '/' + res.data.url + '"></video><br>' +
                        "<button type=\"button\" class=\"layui-btn layui-btn-danger\" lowDefinition=\"" + res.data.url + "\" onclick=\"deleteImg(this,"+updateType+")\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                $("#previewVideoL").append(html);
                $("#previewVideoL").parent().show();
                $("#uploadVideoL").hide();
                layer.close(uploadMsg);
                form.render();
            }
        });

        //自定义验证规则
        form.verify({
            isNumber: function(value) {
                if(value.length > 0 && !AM.isNumber.test(value)) {
                    return "请输入一个整数";
                }
            },
        });

        form.render();



        //监听提交
        form.on('submit(demo1)', function(data) {

            if($("#changeVideo").val() == 0){
                if (data.field.highDefinition == "" && data.field.lowDefinition == "") {
                    layer.msg('请至少上传一种视频', {icon: 2,anim: 6});
                    return false;
                }

                if (data.field.sourceHigh == "" && data.field.sourceLow == "") {
                    layer.msg('请至少选择一种视频来源', {icon: 2,anim: 6});
                    return false;
                }

                if (data.field.sourceHigh == "") {
                    data.field.sourceHigh = data.field.sourceLow;
                }
                if (data.field.sourceLow == "") {
                    data.field.sourceLow = data.field.sourceHigh;
                }

                if (data.field.highDefinition == "") {
                    data.field.highDefinition = data.field.lowDefinition;
                    data.field.highDefinitionSeconds = parseInt(Number(document.getElementById("videoL").duration));
                    window.onload = function() {
                    }
                } else {
                    data.field.highDefinitionSeconds = parseInt(Number(document.getElementById("videoG").duration));
                    window.onload = function() {
                    }
                }
                if (data.field.lowDefinition == "") {
                    data.field.lowDefinition = data.field.highDefinition;
                    data.field.lowDefinitionSeconds = parseInt(Number(document.getElementById("videoG").duration));
                    window.onload = function() {
                    }
                } else {
                    data.field.lowDefinitionSeconds = parseInt(Number(document.getElementById("videoL").duration));
                    window.onload = function() {
                    }
                }

                if (Number((data.field.highDefinitionSeconds - data.field.lowDefinitionSeconds).toString().replace("-","")) >= 3){
                    layer.msg('对不起，两个视频之间的播放时长间隔请在3秒之内', {icon: 2,anim: 6});
                    return false;
                }
                AM.ajaxRequestData("post", false, AM.ip + "/video/save", data.field , function(result) {
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
                    }
                });

            }
            else{
                // 云视频选项提交
                var arr = {
                    name : $("#name").val(),
                    courseWareId : $("#courseWareId").val(),
                    cover : $("#cover").val(),
                    cloudVideoId : $("#cloudVideo").val()
                }
                AM.ajaxRequestData("post", false, AM.ip + "/video/saveCloud", arr , function(result) {
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
                    }
                });
            }
            return false;
        });
    });

    //删除图片
    function deleteImg (object,type) {
        if (type == 0) {
            var url = $(object).attr("cover");
            var covers = $("#cover").val().split(",");
            for (var i = 0; i < covers.length; i++) {
                if (covers[i] == url) {
                    covers.splice(i, 1);
                    $(object).parent().fadeOut();
                    break;
                }
            }
            if (covers.length == 0) $("#preview").parent().hide();
            console.log(covers);
            $("#cover").val(covers.toString());
            $("#uploadImgDiv").show();
        } else if (type == 1){
            var url = $(object).attr("highDefinition");
            var highDefinitions = $("#highDefinition").val().split(",");
            for (var i = 0; i < highDefinitions.length; i++) {
                if (highDefinitions[i] == url) {
                    highDefinitions.splice(i, 1);
                    $(object).parent().fadeOut();
                    break;
                }
            }
            if (highDefinitions.length == 0) $("#previewVideoG").parent().hide();
            console.log(highDefinitions);
            $("#highDefinition").val(highDefinitions.toString());
            $("#uploadVideoG").show();
            deleteVideo(url);
        } else {
            var url = $(object).attr("lowDefinition");
            var lowDefinitions = $("#lowDefinition").val().split(",");
            for (var i = 0; i < lowDefinitions.length; i++) {
                if (lowDefinitions[i] == url) {
                    lowDefinitions.splice(i, 1);
                    $(object).parent().fadeOut();
                    break;
                }
            }
            if (lowDefinitions.length == 0) $("#previewVideoL").parent().hide();
            console.log(lowDefinitions);
            $("#lowDefinition").val(lowDefinitions.toString());
            $("#uploadVideoL").show();
            deleteVideo(url);
        }

    }

    //删除视频
    function deleteVideo(url) {
        AM.ajaxRequestData("post", false, AM.ipVideo + "/res/delete", {url: url}, function (result) {

        });
    }
    /**
     * 获取视频库数据
     */
    function getVideoHouse(selectId,name,isCloud) {
        // 获取视频库
        AM.ajaxRequestData("get", false, AM.ip + "/videoWareHouse/listSel", {id:selectId,isCloud:isCloud,isBand:null/*0*/} , function(result){
            if(result.flag == 0 && result.code == 200){
                var html = "<option value=\"\">请选择视频</option>";
                for (var i = 0; i < result.data.length; i++) {
                    var url = "";
                    if(isCloud == 1){
                        url = result.data[i].od;
                    }
                    else{
                        url = result.data[i].url;
                    }
                    if (result.data[i].id == selectId) {
                        html += "<option url = '"+ url +"' seconds='" + result.data[i].seconds +"' selected=\"selected\" value=\"" + result.data[i].id + "\">" + result.data[i].name + "</option>";
                    }
                    else {
                        html += "<option url = '"+ url +"' seconds='" + result.data[i].seconds +"' value=\"" + result.data[i].id + "\">" + result.data[i].name + "</option>";
                    }
                }
                if (result.data.length == 0) {
                    html += "<option value=\"0\" disabled>暂无</option>";
                }
                $("select[name='"+name+"']").html(html);
            }
        });
    }






</script>
</body>
</html>
