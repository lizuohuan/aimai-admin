<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加考题</title>
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
        <legend>添加考题</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData">

        <div class="layui-form-item">
            <label class="layui-form-label">添加考题<span class="font-red">*</span></label>
            <div class="layui-input-block">
                <textarea name="title" placeholder="请输入考题" class="layui-textarea" maxlength="200" lay-verify="required" ></textarea>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">考点<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="emphasis" lay-verify="required" placeholder="请输入考点" autocomplete="off" class="layui-input" maxlength="200">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">选择行业</label>
            <div class="layui-input-inline">
                <select name="tradeId"  lay-search>
                    <option value="">请选择或搜索行业</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">选择地区</label>
            <div class="layui-input-inline">
                <select name="province" lay-search lay-filter="province">
                    <option value="">请选择或搜索省</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select name="city" lay-search lay-filter="city">
                    <option value="">请选择或搜索市</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select name="district" lay-search lay-filter="district">
                    <option value="">请选择或搜索县/区</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">试题类型<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select name="type" lay-verify="required"  lay-filter="typeChange" lay-search>
                    <option value="">请选择试题类型</option>
                    <option value="0">单选题</option>
                    <option value="1">多选题</option>
                    <option value="2">判断题</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item" id = "isCorrectDIV" style="display: none">
            <label class="layui-form-label">设置判断题答案<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select name="isCorrect" lay-search>
                    <option value="">请设置答案</option>
                    <option value="0">错误</option>
                    <option value="1">正确</option>
                </select>
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">选择课程</label>
            <div class="layui-input-inline">
                <select name="curriculumId">
                    <option value="">请选择课程</option>
                </select>
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">选择公司</label>
            <div class="layui-input-inline">
                <select name="companyId">
                    <option value="">请选择公司</option>
                </select>
            </div>
        </div>



        <div class="layui-form-item">
            <label class="layui-form-label">选择类别</label>
            <div class="layui-input-inline">
                <select name="category">
                    <option value="">请选择类别</option>
                    <option value="0">练习题</option>
                    <option value="1">模拟题</option>
                    <option value="2">考试题</option>
                </select>
            </div>
        </div>




        <div class="layui-form-item">
            <label class="layui-form-label">题解解析<span class="font-red">*</span></label>
            <div class="layui-input-block">
                <textarea name="examinationKey" placeholder="请输入解析" class="layui-textarea" lay-verify="required" ></textarea>
            </div>
        </div>


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
<script>


    layui.use(['form', 'layedit', 'laydate', 'upload', 'layedit'], function() {
        var form = layui.form(),
                layer = layui.layer,
                layedit = layui.layedit
                ,$ = layui.jquery,
                laydate = layui.laydate;

        getTradeList(0); //行业列表

//        getCurriculumTypeList(0); //课程类型列表

        selectProvince(0); //默认调用省


//        form.on('select(typeChange)', function(data){
//            var type = data.value;
//            if(type == 2){
//                $("#isCorrectDIV").show("slow");
//            }
//            else{
//                $("#isCorrectDIV").hide("slow");
//            }
//        });



        // 课程列表
        AM.ajaxRequestData("get", false, AM.ip + "/curriculum/queryCurriculum", {} , function(result){
            if(result.flag == 0 && result.code == 200){
                var html = "<option value=\"\">选择或搜索课程</option>";
                for (var i = 0; i < result.data.length; i++) {
                    html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].curriculumName + "</option>";
                }
                if (result.data.length == 0) {
                    html += "<option value=\"0\" disabled>暂无</option>";
                }
                $("select[name='curriculumId']").html(html);
            }
        });


        // 公司列表
        AM.ajaxRequestData("get", false, AM.ip + "/user/queryCompanyList", {} , function(result){
            if(result.flag == 0 && result.code == 200){
                var html = "<option value=\"\">选择或搜索课程</option>";
                for (var i = 0; i < result.data.length; i++) {
                    html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].showName + "</option>";
                }
                if (result.data.length == 0) {
                    html += "<option value=\"0\" disabled>暂无</option>";
                }
                $("select[name='companyId']").html(html);
            }
        });


        //上传图片
        layui.upload({
            url: AM.ipImg + "/res/upload" //上传接口
            ,success: function(res){ //上传成功后的回调
                var urls = $("#cover").val().split(",");
                if (urls[0] == "") {
                    urls = [];
                }
                urls.push(res.data.url);
                $("#cover").val(urls.toString());
                var html = '<div class="preview">' +
                        '<img src="' + AM.ipImg + '/' + res.data.url + '"><br>' +
                        "<button type=\"button\" class=\"layui-btn layui-btn-danger\" cover=\"" + res.data.url + "\" onclick=\"deleteImg(this)\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                $("#preview").append(html);
                $("#preview").parent().show();
                if($("#type").val() != 2){
                    $("#uploadImgDiv").hide();
                }
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
            isZero: function(value) {
                if(value <= 0) {
                    return "请输入一个大于0的金额";
                }
            },
        });

        //构建一个默认的编辑器
//        var index = layedit.build('LAY_demo1');

        form.render();

        //监听省
        form.on('select(province)', function(data) {
            $("select[name='district']").html("<option value=\"\">请选择或搜索县/区</option>");
            $("input[name='cityId']").val(data.value);
            selectCity(data.value);
            form.render();
        });

        //监听市
        form.on('select(city)', function(data) {
            $("input[name='cityId']").val(data.value);
            selectCounty(data.value);
            form.render();
        });

        //监听区
        form.on('select(district)', function(data) {
            $("input[name='cityId']").val(data.value);
            form.render();
        });

        //绑定课程

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
            data.field.cityId = data.field.cityId == '' ? null : data.field.cityId;
            data.field.tradeId = data.field.tradeId == '' ? null : data.field.tradeId;
            data.field.companyId = data.field.companyId == '' ? null : data.field.companyId;
            data.field.curriculumId = data.field.curriculumId == '' ? null : data.field.curriculumId;
            data.field.category = data.field.category == '' ? null : data.field.category;

//            if(data.field.type == 2 && data.field.isCorrect == ""){
//                // 判断题
//                layer.msg('请设置试题答案.', {icon: 2,anim: 6});
//                return false;
//            }
            console.log(data.field);
            AM.ajaxRequestData("post", false, AM.ip + "/examination/save", data.field  , function(result) {
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
    }
</script>
</body>
</html>
