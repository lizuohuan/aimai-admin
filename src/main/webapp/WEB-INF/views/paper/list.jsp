<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>试卷管理</title>

    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>
        .coverImg{width: 200px;height: 100px;border: 1px solid #eee;}
    </style>
<body>

<div class="admin-main">

    <blockquote class="layui-elem-quote">
        <fieldset class="layui-elem-field">
            <legend>高级筛选</legend>
            <div class="layui-field-box layui-form">
                <form class="layui-form" action="" id="formData">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">试卷名称</label>
                            <div class="layui-input-inline">
                                <input type="text" id="paperTitle" lay-verify="" placeholder="请输入试卷名称" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">选择试卷类型</label>
                            <div class="layui-input-inline">
                                <select name="type" id="type" lay-filter="typeChange"  lay-verify="required" lay-search>
                                    <!--0：练习题  1：模拟题 2：考试题  -->
                                    <option value="">选择类型</option>
                                    <option value="0">练习题</option>
                                    <option value="1">模拟题</option>
                                    <option value="2">考试题</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">选择课程/课件</label>
                            <div class="layui-input-inline">
                                <select name="targetId" id="targetId" lay-verify="required" lay-search>
                                    <option value="">请先选择试卷类型</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button class="layui-btn" id="search"><i class="layui-icon">&#xe615;</i> 搜索</button>
                            <button type="reset" class="layui-btn layui-btn-primary">清空</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>
    </blockquote>

    <fieldset class="layui-elem-field">
        <legend>试卷列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend></legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <button onclick="addData()" class="layui-btn layui-btn layui-btn-small layui-btn-normal hide checkBtn_51"><i class="layui-icon">&#xe608;</i> 添加试卷</button>
            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>试卷名称</th>
                        <th>试卷类型</th>
                        <th>所属课程/课件</th>
                        <th>用时(小时)</th>
                        <th>及格分数</th>
                        <th>开启</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
            </table>
        </div>
    </fieldset>
</div>

<!--引入抽取公共js-->
<%@include file="../common/public-js.jsp" %>
<script>

    var form = null;
    var dataTable = null;
    $(document).ready(function() {
        dataTable = $('#dataTable').DataTable( {
            "searching": false,"bStateSave": true, //状态保存，使用了翻页或者改变了每页显示数据数量，会保存在cookie中，下回访问时会显示上一次关闭页面时的内容。
            "processing": true,
            "serverSide": true,
            "bLengthChange": false,"bSort": false, //关闭排序功能
            "sPaginationType" : "full_numbers",
            //"pagingType": "bootstrap_full_number",
            'language': {
                'emptyTable': '没有数据',
                'loadingRecords': '加载中...',
                'processing': '查询中...',
                'search': '全局搜索:',
                'lengthMenu': '每页 _MENU_ 件',
                'zeroRecords': '没有您要搜索的内容',
                'paginate': {
                    'first':      '第一页',
                    'last':       '最后一页',
                    'next':       '下一页',
                    'previous':   '上一页'
                },
                'info': '第 _PAGE_ 页 / 总 _PAGES_ 页',
                'infoEmpty': '没有数据',
                'infoFiltered': '(过滤总件数 _MAX_ 条)'
            },
            //dataTable 加载加载完成回调函数
            "fnDrawCallback": function (sName, oData, sExpires, sPath) {
                checkJurisdiction(); //调用权限
                form.render();
            },
            "ajax":  {
                url: AM.ip + "/paper/paperList",
                "dataSrc": function(json) {
                    if (json.code == 200) {
                        return json.data;
                    }
                    return [];
                },
                "data": function(data) {
                    //高级查询参数
                    data.type = $("#type").val();
                    data.paperTitle = $("#paperTitle").val();
                    data.targetId = $("#targetId").val();
                }
            },
            "columns": [
                { "data": "paperTitle" },
                { "data": "type" },
                { "data": "targetName" },
                { "data": "useTime" },
                { "data": "passScore" },
                { "data": "isValid" },
                {"data": "createTime"},
            ],
            "columnDefs": [
                {
                    "render": function(data, type, row) {

                        if(null == data){
                            return "-";
                        }
                        //  试题类型 0:单选题 1:多选题  2:判断题
                        else if(data == 0){
                            return "练习题";
                        }
                        else if(data == 1){
                            return "模拟题";
                        }
                        else if(data == 2){
                            return "考试题";
                        }
                        else {
                            return "-";
                        }
                    },
                    "targets": 1
                },
                {
                    "render": function(data, type, row) {

                        if(null == data){
                            return "-";
                        }
                        if(row.type == 0){
                            return data+"("+row.curriculumName+")";
                        }
                        return data;
                    },
                    "targets": 2
                },
                {
                    "render": function(data, type, row) {

                        if(null == data){
                            return "-";
                        }
                        return AM.getFormatTime(data);
                    },
                    "targets": 3
                },
                {
                    "render": function(data, type, row) {

                        if(null == data){
                            return "-";
                        }
                        return data == 0 ? "关闭" : "开启";
                    },
                    "targets": 5
                },
                {
                    "render": function (data, type, row) {
                        if (data == null || data == "") {
                            return "-";
                        }
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    },
                    "targets": 6
                },
                {
                    "render": function (data, type, row) {
                        var btn = "";
                        if(row.isValid == 0){
                            btn = "<button onclick='updatePaperStatus(" + row.id + ","+row.isValid+")' class='layui-btn layui-btn-small hide checkBtn_55'><i class='fa fa-list fa-edit'></i>&nbsp;开启试卷</button>";
                        }else{
                            btn = "<button onclick='updatePaperStatus(" + row.id + ","+row.isValid+")' class='layui-btn layui-btn-small hide checkBtn_55'><i class='fa fa-list fa-edit'></i>&nbsp;关闭试卷</button>"
                        }
                        return  "<button onclick=\"updateData('" + row.id + "')\" class='layui-btn layui-btn-small hide checkBtn_52'><i class='fa fa-list fa-edit'></i>&nbsp;查看/修改</button>"+
                                "<button onclick=\"checkExamination('" + row.id + "')\" class='layui-btn layui-btn-small hide checkBtn_53'><i class='fa fa-list fa-edit'></i>&nbsp;查看试题</button>"+
                                "<button onclick=\"bindExamination('" + row.id + "')\" class='layui-btn layui-btn-small hide checkBtn_54'><i class='fa fa-list fa-edit'></i>&nbsp;设置试题</button>"+
                                btn
                                ;
                    },
                    "targets": 7
                },
            ]
        } );


        $("#search").click(function(){
            dataTable.ajax.reload();
            return false;
        });

    } );

    //提供给子页面
    var closeNodeIframe = function () {
        dataTable.ajax.reload();
        var index = layer.load(1, {shade: [0.5,'#eee']});
        setTimeout(function () {layer.close(index);}, 600);
    }

    //查看试题
    function checkExamination(id) {
        var index = layer.open({
            type: 2,
            title: '查看试题',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/examinationPaper/list?paperId=" + id
        });
        layer.full(index);
    }


    //查看/修改数据
    function bindExamination(id) {
        var index = layer.open({
            type: 2,
            title: '查看选项',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/paper/bind?paperId=" + id
        });
        layer.full(index);
    }


    function updatePaperStatus(id,isValid){
        isValid = 0 == isValid ? 1 : 0;
        var arr = {
            paperId:id,
            isValid:isValid
        }
        AM.ajaxRequestData("POST", false, AM.ip + "/paper/updatePaper", arr , function(result){
            if(result.flag == 0 && result.code == 200){
                dataTable.ajax.reload();
            }else{

            }
        });
    }


    function checkKey(text){
        text = null == text || text.length == 0 ? "暂无题解" : text;
        console.log(text);
        var html = "<div>" +
                "<div style='padding: 5px;'>" + text + "</div>" +
                "</div>";

        layer.open({
            type: 1,
            title: '查看题解',
            shadeClose: true,
            shade: 0.5,
            area: ["600px", "300px"], //宽高
            content: html
        });

    }


    //添加
    function addData () {
        var index = layer.open({
            type: 2,
            title: '添加题库',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/paper/save"
        });
        layer.full(index);
    }

    //查看/修改数据
    function updateData(id) {
        var index = layer.open({
            type: 2,
            title: '修改题库',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/paper/edit?id=" + id
        });
        layer.full(index);
    }




    layui.use(['form', 'layedit', 'laydate'], function() {
        form = layui.form(),
                layer = layui.layer,
                laydate = layui.laydate;
        var curriculumList = null;
        var courseWareList = null;

        form.on('select(typeChange)', function(data){

            var type = data.value;
            if(type == "" || null == type){
                return;
            }

            if(type == 0 ){

                $("#useTimeDiv").hide();
                $("#useTimeInput").removeAttr("lay-verify");

                if(null == courseWareList){
                    // 课件列表
                    AM.ajaxRequestData("get", false, AM.ip + "/courseWare/queryBaseCourseWare", {} , function(result){
                        if(result.flag == 0 && result.code == 200){
                            courseWareList = result.data;
                        }
                    });
                }
                var html = "<option value=\"\">选择或搜索课件</option>";
                for (var i = 0; i < courseWareList.length; i++) {
                    html += "<option value=\"" + courseWareList[i].id + "\">" + courseWareList[i].courseWareName + "("+courseWareList[i].curriculumName+")</option>";
                }
                if (courseWareList.length == 0) {
                    html += "<option value=\"0\" disabled>暂无</option>";
                }
                $("select[name='targetId']").html(html)
            }
            if(type == 1 || type == 2){
                $("#useTimeDiv").show();
                $("#useTimeInput").attr("lay-verify","required");

                if(null == curriculumList){
                    // 课程列表
                    AM.ajaxRequestData("get", false, AM.ip + "/curriculum/queryCurriculum", {} , function(result){
                        if(result.flag == 0 && result.code == 200){
                            curriculumList = result.data;
                        }
                    });
                }
                var html = "<option value=\"\">选择或搜索课程</option>";
                for (var i = 0; i < curriculumList.length; i++) {
                    html += "<option value=\"" + curriculumList[i].id + "\">" + curriculumList[i].curriculumName + "</option>";
                }
                if (curriculumList.length == 0) {
                    html += "<option value=\"0\" disabled>暂无</option>";
                }
                $("select[name='targetId']").html(html);
            }
            form.render();
        });

    });


</script>
</body>
</html>
