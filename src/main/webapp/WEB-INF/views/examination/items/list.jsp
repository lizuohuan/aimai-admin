<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>选项列表</title>
    <!--引入抽取css文件-->
    <%@include file="../../common/public-css.jsp" %>
<body>

<div class="admin-main">

    <blockquote class="layui-elem-quote">
        <fieldset class="layui-elem-field">

        </fieldset>
    </blockquote>

    <fieldset class="layui-elem-field">
        <legend>选项列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend></legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <c:if test="${type != 2}">
                    <button onclick="addData()" class="layui-btn layui-btn layui-btn-small layui-btn-normal hide checkBtn_48"><i class="layui-icon">&#xe608;</i> 添加试题选项</button>
                </c:if>
            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th width="300">试题题目</th>
                        <th>选项标题</th>
                        <th>是否正确答案</th>
                        <th>排序(升序)</th>
                        <th>操作</th>
                    </tr>
                </thead>
            </table>
        </div>
    </fieldset>
    <input type="hidden" value="${id}" id="examinationId">
</div>

<!--引入抽取公共js-->
<%@include file="../../common/public-js.jsp" %>
<script>

    var form = null;
    var dataTable = null;
    var examinationId = $("#examinationId").val();
    console.log("examinationId    "+examinationId);
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
                url: AM.ip + "/examination/listItems",
                "dataSrc": function(json) {
                    console.log(json);
                    if (json.code == 200) {
                        return json.data;
                    }
                    return [];
                },
                "data": function(data) {
                    data.examinationId=examinationId
                }
            },
            "columns": [
                { "data": "examinationName" },
                { "data": "itemTitle" },
                { "data": "isCorrect" },
                { "data": "sortNum" },
            ],
            "columnDefs": [
                {
                    "render": function(data, type, row) {
                        if(null == data){
                            return "-";
                        }
                        return data == 0 ? "错误答案" : "正确答案";
                    },
                    "targets": 2
                },
                {
                    "render": function (data, type, row) {
                        var isCorrectName = row.isCorrect == 0 ? "设为正确答案" : "设为错误答案";
                        return "<button onclick=\"updateIsCorrect(" + row.id + ","+row.isCorrect+","+row.examinationId+")\" class='layui-btn layui-btn-small hide checkBtn_49'><i class='fa fa-list fa-edit'></i>&nbsp;"+isCorrectName+"</button>"+
                         "<button onclick='updateData(" + row.id + ")' class='layui-btn layui-btn-small hide checkBtn_50'><i class='fa fa-list fa-edit'></i>&nbsp;修改标题</button>"
                                ;
                    },
                    "targets": 4
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

    function updateIsCorrect(id,isCorrect,examinationId){
        isCorrect = 0 == isCorrect ? 1 : 0;
        var arr = {
            id:id,
            isCorrect:isCorrect,
            examinationId:examinationId
        }
        AM.ajaxRequestData("POST", false, AM.ip + "/examination/updateExaminationItems", arr , function(result){
            dataTable.ajax.reload();
        });
    }


    function updateItemTitle(id,title){
//        text = null == text || text.length == 0 ? "暂无题解" : text;
//        console.log(text);
//        var html = "<div>" +
//                "<div style='padding: 5px;'>" + text + "</div>" +
//                "</div>";
//        layer.open({
//            type: 1,
//            title: '查看题解',
//            shadeClose: true,
//            shade: 0.5,
//            area: ["600px", "300px"], //宽高
//            content: html
//        });

    }


    //添加
    function addData () {
        var examinationId = $("#examinationId").val();
        var index = layer.open({
            type: 2,
            title: '添加题库',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/examination/items/save?examinationId="+examinationId
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
            content: AM.ip + "/page/examination/items/edit?id=" + id
        });
        layer.full(index);
    }




    layui.use(['form', 'layedit', 'laydate'], function() {
        form = layui.form(),
                layer = layui.layer,
                laydate = layui.laydate;

    });


</script>
</body>
</html>
