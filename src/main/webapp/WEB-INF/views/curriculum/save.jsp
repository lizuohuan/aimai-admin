<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加课程</title>
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
        <legend>添加课程</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData">

        <div class="layui-form-item">
            <label class="layui-form-label">课程名<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="curriculumName" lay-verify="required" placeholder="请输入课程名" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">年度<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="year" placeholder="请选择时间" class="layui-input" onfocus="WdatePicker({dateFmt:'yyyy'})" readonly>
            </div>
        </div>

        <div class="layui-form-item" id="uploadImgDiv">
            <label class="layui-form-label">封面图-横<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <div>
                    <input type="file" name="file" class="layui-upload-file" lay-title="上传一张图片">
                </div>
                <label class="" style="margin-left: 20px">建议尺寸300*200</label>
            </div>

        </div>

        <div class="layui-form-item layui-hide">
            <label class="layui-form-label">封面图-横预览</label>
            <div class="layui-input-block" id="preview">

            </div>
        </div>

        <div class="layui-form-item" id="uploadImgDiv-H">
            <label class="layui-form-label">封面图-竖<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <div>
                    <input type="file" name="file" id="file-H" class="layui-upload-file" lay-title="上传一张图片">
                </div>
                <label class="" style="margin-left: 20px">建议尺寸200*300</label>
            </div>

        </div>

        <div class="layui-form-item layui-hide">
            <label class="layui-form-label">封面图-竖预览</label>
            <div class="layui-input-block" id="preview-H">

            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">选择行业</label>
            <div class="layui-input-inline">
                <select name="tradeId" lay-search>
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
            <label class="layui-form-label">选择培训阶段<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select name="curriculumStageId" lay-verify="required" lay-search>
                    <option value="">请选择或搜索培训阶段</option>
                    <option value="1">初训</option>
                    <option value="2">复训</option>
                    <%--<option value="3">全培</option>--%>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">选择课程类型<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select name="curriculumTypeId" lay-verify="required">
                    <option value="">请选择课程类型</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">选择课程类别<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select name="type" lay-verify="required" lay-filter="type">
                    <option value="">请选择课程类别</option>
                    <option value="0">试听课程</option>
                    <option value="1">收费课程</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item layui-hide">
            <label class="layui-form-label">单价<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="number" name="price" lay-verify="required" placeholder="请输入单价" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">排序编号<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="number" name="sortNum" lay-verify="required|number" placeholder="请输入排序编号" autocomplete="off" class="layui-input" maxlength="11">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">讲师名称<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="teacherName" lay-verify="required" placeholder="请输入讲师名" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">讲师介绍<span class="font-red">*</span></label>
            <div class="layui-input-block">
                <textarea name="teacherIntroduce" class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">适用人群<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="applyPerson" lay-verify="required"  placeholder="请输入适用人群" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">课程介绍<span class="font-red">*</span></label>
            <div class="layui-input-block">
                <textarea name="curriculumDescribe" placeholder="请输入课程介绍" lay-verify="required" class="layui-textarea"></textarea>
            </div>
        </div>


        <div class="layui-form-item layui-hide">
            <label class="layui-form-label">是否是推荐课程</label>
            <div class="layui-input-block">
                <input type="radio" name="isRecommend" value="0" title="否" checked="">
                <input type="radio" name="isRecommend" value="1" title="是">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">是否发布课程</label>
            <div class="layui-input-block">
                <input type="radio" name="releaseStatus" value="0" title="否" checked="">
                <input type="radio" name="releaseStatus" value="1" title="是">
            </div>
        </div>

        <input type="hidden" name="cover" id="cover">
        <input type="hidden" name="coverH" id="coverH">
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
                $("#cover").val(urls.toString());
                var html = '<div class="preview">' +
                        '<img src="' + AM.ipImg + '/' + res.data.url + '"><br>' +
                        "<button type=\"button\" class=\"layui-btn layui-btn-danger\" cover=\"" + res.data.url + "\" onclick=\"deleteImg(this,0)\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                $("#preview").append(html);
                $("#preview").parent().show();
                if($("#type").val() != 2){
                    $("#uploadImgDiv").hide();
                }
                layer.close(uploadMsg);
                form.render();
            }
        });

        //上传图片
        layui.upload({
            url: AM.ipImg + "/res/upload" //上传接口
            ,elem: '#file-H'
            ,before: function(){
                uploadMsg = layer.msg('上传中，请不要刷新页面', {icon: 16,shade: 0.5, time: 100000000 })
            }
            ,success: function(res){ //上传成功后的回调
                console.log(res.data.url);
                var urls = $("#coverH").val().split(",");
                if (urls[0] == "") {
                    urls = [];
                }
                urls.push(res.data.url);
                $("#coverH").val(urls.toString());
                var html = '<div class="preview">' +
                        '<img src="' + AM.ipImg + '/' + res.data.url + '"><br>' +
                        "<button type=\"button\" class=\"layui-btn layui-btn-danger\" coverH=\"" + res.data.url + "\" onclick=\"deleteImg(this,1)\"><i class=\"layui-icon\">&#xe640;</i>删除</button></div>";
                $("#preview-H").append(html);
                $("#preview-H").parent().show();
                if($("#type").val() != 2){
                    $("#uploadImgDiv-H").hide();
                }
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
            isZero: function(value) {
                if(value <= 0) {
                    return "请输入一个大于0的金额";
                }
            },
        });



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
            data.field.year = new Date(data.field.year);
            if (data.field.cover == "") {
                layer.msg('请上传封面图片.', {icon: 2,anim: 6});
                return false;
            }

            if (data.field.type == 0) {
                data.field.price = 0;
            }

            console.log(data.field);

            AM.ajaxRequestData("post", false, AM.ip + "/curriculum/save", data.field  , function(result) {
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

        var objCover = "cover";
        var obj = "#cover";
        var obj1 = "#preview";
        var obj2 = "#uploadImgDiv";

        if (type == 1) {
            objCover = "coverH";
            obj = "#coverH";
            obj1 = "#preview-H";
            obj2 = "#uploadImgDiv-H";
        }
        var url = $(object).attr(objCover);
        var covers = $(obj).val().split(",");
        for (var i = 0; i < covers.length; i++) {
            if (covers[i] == url) {
                covers.splice(i, 1);
                $(object).parent().fadeOut();
                break;
            }
        }
        if (covers.length == 0) $(obj1).parent().hide();
        console.log(covers);
        $(obj).val(covers.toString());
        $(obj2).show();
    }
</script>
</body>
</html>
