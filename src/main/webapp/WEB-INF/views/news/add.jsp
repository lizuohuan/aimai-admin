<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加新闻资讯</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>
        .preview{height: 250px;width: 400px;margin-right: 10px;margin-bottom: 10px;float: left;text-align: center}
        .preview img{width: 100%;height:210px;border: 1px solid #eee;}
        #edui1{z-index: 9 !important;}
    </style>
</head>
<body>
<div style="margin: 15px;">
    <blockquote class="layui-elem-quote"><i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;表单带有 <span class="font-red">“*”</span> 号的为必填项.</blockquote>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>添加新闻资讯</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData">


        <div class="layui-form-item" id="uploadImgDiv">
            <label class="layui-form-label">封面图<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <div>
                    <input type="file" id="fileImg" name="file" class="layui-upload-file" lay-title="上传封面图">
                </div>
                <label class="" style="margin-left: 20px">建议尺寸300*200</label>
            </div>
        </div>

        <div class="layui-form-item layui-hide">
            <label class="layui-form-label">封面图预览</label>
            <div class="layui-input-block" id="preview">

            </div>
        </div>

        <div class="layui-form-item ">
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

        <div class="layui-form-item">
            <label class="layui-form-label">类型 <span class="font-red">*</span></label>
            <div class="layui-input-block">
                <select name="type" id="type" readonly="" lay-verify="required" lay-search>
                    <option value="">请选择类型</option>
                    <option value="1">行业动态</option>
                    <option value="2">重大新闻</option>
                    <option value="3">安全事故</option>
                    <option value="4">安全常识</option>
                    <option value="5">考试</option>
                    <option value="6">其他</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">标题 <span class="font-red">*</span></label>
            <div class="layui-input-block">
                <input type="text" name="title" lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">作者</label>
            <div class="layui-input-block">
                <input type="text" name="editor" placeholder="请输入作者" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">摘要</label>
            <div class="layui-input-block">
                <input type="text" name="digest" placeholder="请输入摘要" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">内容<span class="font-red">*</span></label>
            <div class="layui-input-block">
                <script id="editor" style="height:500px;width:100%" name="content" type="text/plain"></script>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">来源</label>
            <div class="layui-input-block">
                <input type="text" name="source" placeholder="请输入来源" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">是否是外链</label>
            <div class="layui-input-block">
                <input type="radio" name="isLink" value="0" title="否" checked="">
                <input type="radio" name="isLink" value="1" title="是">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">外链地址</label>
            <div class="layui-input-block">
                <input type="text" name="linkUrl" placeholder="请输入外链地址" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">是否推荐</label>
            <div class="layui-input-block">
                <input type="radio" name="isRecommend" value="0" title="否" checked="">
                <input type="radio" name="isRecommend" value="1" title="是">
            </div>
        </div>

        <input type="hidden" name="image" id="image">
                <input type="hidden" name="cityId">
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
<script type="text/javascript" src="<%=request.getContextPath()%>/ue/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/ue/ueditor.all.js"></script>
<script src="<%=request.getContextPath()%>/ue/lang/zh-cn/zh-cn.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ue/themes/default/css/ueditor.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ue/themes/default/css/ueditor.min.css" />
<script>

    UE.getEditor('editor');
    layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
        var form = layui.form(),
                layer = layui.layer,
                layedit = layui.layedit
                ,$ = layui.jquery,
                laydate = layui.laydate;


        selectProvince(0); //默认调用省

        var uploadMsg;
        //上传封面图
        layui.upload({
            url: AM.ipImg + "/res/upload" //上传接口
            ,elem: '#fileImg'
            ,before: function(){
                uploadMsg = layer.msg('上传中，请不要刷新页面', {icon: 16,shade: 0.5, time: 100000000 })
            }
            ,success: function(res){ //上传成功后的回调
                console.log(res.data.url);
                var urls = $("#image").val().split(",");
                if (urls[0] == "") {
                    urls = [];
                }
                urls.push(res.data.url);
                $("#image").val(urls.toString());
                var html = '<div class="preview">' +
                        '<img src="' + AM.ipImg + '/' + res.data.url + '"><br>' +
                        "<button type=\"button\" class=\"layui-btn layui-btn-danger\" image=\"" + res.data.url + "\" onclick=\"deleteImg(this)\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                $("#preview").append(html);
                $("#preview").parent().show();
                $("#uploadImgDiv").hide();
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


        //监听省
        form.on('select(province)', function(data) {
            $("select[name='district']").html("<option value=\"\">请选择或搜索县/区</option>");
            if ($("#roleId").val() == 4) {
                $("input[name='cityId']").val("");
            } else {
                $("input[name='cityId']").val(data.value);
            }
            selectCity(data.value);

            form.render();
        });

        //监听市
        form.on('select(city)', function(data) {
            if ($("#roleId").val() == 4) {
                $("input[name='cityId']").val("");
            } else {
                $("input[name='cityId']").val(data.value);
            }
            selectCounty(data.value);

            form.render();
        });

        //监听区
        form.on('select(district)', function(data) {
            $("input[name='cityId']").val(data.value);

            form.render();
        });


        //监听提交
        form.on('submit(demo1)', function(data) {
            data.field.content = UE.getEditor('editor').getContent();
            if (data.field.images == "") {
                layer.msg('请上传封面图.', {icon: 2,anim: 6});
                return false;
            }
            if (data.field.content == "") {
                layer.msg('请输入内容.', {icon: 2,anim: 6});
                return false;
            }
            if(data.field.isLink == 1 && data.field.linkUrl == ""){
                layer.msg('输入外链地址.', {icon: 2,anim: 6});
                return false;
            }
            AM.ajaxRequestData("post", false, AM.ip + "/news/save", data.field , function(result) {
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
    function deleteImg (object) {
        var url = $(object).attr("image");
        var images = $("#image").val().split(",");
        for (var i = 0; i < images.length; i++) {
            if (images[i] == url) {
                images.splice(i, 1);
                $(object).parent().fadeOut();
                break;
            }
        }
        if (images.length == 0) $("#preview").parent().hide();
        console.log(images);
        $("#image").val(images.toString());
        $("#uploadImgDiv").show();

    }
</script>
</body>
</html>
