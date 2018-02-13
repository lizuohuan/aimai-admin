<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加课件</title>
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
        <legend>添加课件</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData">
        <input type="text" id="curriculumId" name="curriculumId" value="${curriculumId}" style="display: none;">
        <div class="layui-form-item">
            <label class="layui-form-label">课件名<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="courseWareName" lay-verify="required" placeholder="请输入课件名" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item" id="uploadImgDiv">
            <label class="layui-form-label">封面图<%--<span class="font-red">*</span>--%></label>
            <div class="layui-input-inline">
                <div>
                    <input type="file" name="file" id="file1" lay-title="上传一张图片" class="layui-upload-file" onclick="uploadCover(0)">
                </div>
                <label class="" style="margin-left: 20px">建议尺寸300*200</label>
                <%--<input type="button" class="layui-upload-file" value="上传封面图" onclick="uploadCover()">--%>
            </div>
        </div>

        <div class="layui-form-item layui-hide">
            <label class="layui-form-label">封面图预览</label>
            <div class="layui-input-block" id="preview">
            </div>
        </div>



        <div class="layui-form-item" id="uploadImgDivPpt">
            <label class="layui-form-label">讲义（PPT）</label>
            <div class="layui-input-inline">
                <div>
                    <input type="file" name="file" class="layui-upload-file" onclick="uploadCover(1)" lay-title="上传PPT图片">
                </div>
                <label class="" style="margin-left: 20px">建议尺寸300*200</label>
            </div>
        </div>

        <div class="layui-form-item layui-hide">
            <label class="layui-form-label">预览</label>
            <div class="layui-input-block" id="previewPpt">
            </div>
        </div>

        <input type="hidden" name="cover" id="cover">
        <input type="hidden" name="ppt" id="ppt">

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

    //上传类型
    var updateType = 0;

    function uploadCover(type){
        updateType = type;
    }

    layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
        var form = layui.form(),
                layer = layui.layer,
                layedit = layui.layedit
                ,$ = layui.jquery,
                laydate = layui.laydate;

        getTradeList(0); //行业列表

        getCurriculumTypeList(0); //课程类型列表

        selectProvince(0); //默认调用省


        var uploadMsg;
        //上传图片
        layui.upload({
            url: AM.ipImg + "/res/upload" //上传接口
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
                    if($("#type").val() != 2){
                        $("#uploadImgDiv").hide();
                    }
                } else {
                    urls = $("#ppt").val().split(",");
                    if (urls[0] == "") {
                        urls = [];
                    }
                    urls.push(res.data.url);
                    $("#ppt").val(urls.toString());
                    var html = '<div class="preview">' +
                            '<img src="' + AM.ipImg + '/' + res.data.url + '"><br>' +
                            "<button type=\"button\" class=\"layui-btn layui-btn-danger\" ppt=\"" + res.data.url + "\" onclick=\"deleteImg(this,"+updateType+")\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                    $("#previewPpt").append(html);
                    $("#previewPpt").parent().show();
                }
                layer.close(uploadMsg);
                form.render();
            }
        });

        //添加富文本编辑器的上传图片接口
//        layedit.set({
//            uploadImage: {
//                url: AM.ipImg + "/res/upload2", //上传接口
//                type: 'post', //默认post
//            }
//        });

        //自定义验证规则
        form.verify({
            isNumber: function(value) {
                if(value.length > 0 && !AM.isNumber.test(value)) {
                    return "请输入一个整数";
                }
            },
        });

        //构建一个默认的编辑器
//        var index = layedit.build('LAY_demo1');

        form.render();


        //课程类型
        form.on('select(type)', function(data) {
            if (data.value == 0) {
                $("input[name='price']").parent().parent().hide();
                $("input[name='price']").removeAttr("lay-verify");
                $("input[name='isRecommend']").parent().parent().hide();
            }
            else {
                $("input[name='price']").parent().parent().show();
                $("input[name='price']").attr("lay-verify", "required");
                $("input[name='isRecommend']").parent().parent().show();
            }
            form.render();
        });

        //监听提交
        form.on('submit(demo1)', function(data) {
//            if (data.field.cover == "") {
//                layer.msg('请上传封面图片.', {icon: 2,anim: 6});
//                return false;
//            }

            AM.ajaxRequestData("post", false, AM.ip + "/courseWare/save", data.field , function(result) {
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
        } else {
            var url = $(object).attr("ppt");
            var ppts = $("#ppt").val().split(",");
            for (var i = 0; i < ppts.length; i++) {
                if (ppts[i] == url) {
                    ppts.splice(i, 1);
                    $(object).parent().fadeOut();
                    break;
                }
            }
            if (ppts.length == 0) $("#previewPpt").parent().hide();
            console.log(ppts);
            $("#ppt").val(ppts.toString());
        }

    }
</script>
</body>
</html>
