<!-- 解决layer.open 不居中问题 -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>课程分配列表</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>

<body>

<div class="admin-main">

    <fieldset class="layui-elem-field">
        <legend>课程分配列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend>
        </legend>
        <input type="text" style="display: none" id="orderId" value="${orderId}">
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <button onclick="addData()"
                        class="layui-btn layui-btn layui-btn-small layui-btn-normal hide checkBtn_83">
                    <i class="layui-icon">&#xe608;</i> 选择分配用户
                </button>
                <span class="hide checkBtn_84">
                    <input type="file" name="file" id="fileEx" lay-title="导入分配用户列表">
                </span>
                <button onclick="window.location.href=AM.ip+'/resources/curriculumAllocationTemplate.xls'"
                        class="layui-btn layui-btn layui-btn-small layui-btn-warm hide checkBtn_85">
                    <i class="layui-icon">&#xe601;</i> 下载分配用户模板</button>
            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>分配用户</th>
                    <th>分配数量</th>
                    <th>手机号</th>
                    <th>分配时间</th>
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
    $(document).ready(function () {
        dataTable = $('#dataTable').DataTable({
            "searching": false, "bStateSave": true, //状态保存，使用了翻页或者改变了每页显示数据数量，会保存在cookie中，下回访问时会显示上一次关闭页面时的内容。
            "processing": true,
            "serverSide": true,
            "bLengthChange": false, "bSort": false, //关闭排序功能
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
                    'first': '第一页',
                    'last': '最后一页',
                    'next': '下一页',
                    'previous': '上一页'
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
            "ajax": {
                url: AM.ip + "/curriculumAllocation/list",
                "dataSrc": function (json) {
                    console.log(json);
                    if (json.code == 200) {
                        return json.data;
                    }
                    return [];
                },
                "data": function (data) {
                    //高级查询参数
                    data.orderId = $("#orderId").val();
                }
            },
            "columns": [
                {"data": "userName"},
                {"data": "number"},
                {"data": "phone"},
                {"data": "createTime"},
            ],
            "columnDefs": [
                {
                    "render": function (data, type, row) {
                        if (data == null || data == "") {
                            return "--";
                        }
                        return data;
                    },
                    "targets": 0
                },
                {
                    "render": function (data, type, row) {
                        if (data == null || data == "") {
                            return "--";
                        }
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    },
                    "targets": 3
                },
            ]
        });

        $("#search").click(function () {
            dataTable.ajax.reload();
            return false;
        });

    });

    //提供给子页面
    var closeNodeIframe = function () {
        dataTable.ajax.reload();
        var index = layer.load(1, {shade: [0.5, '#eee']});
        setTimeout(function () {
            layer.close(index);
        }, 600);
    }

    //添加
    function addData() {
        var index = layer.open({
            type: 2,
            title: '分配用户',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/curriculumAllocation/bind?orderId="+$("#orderId").val()
        });
        layer.full(index);
    }




    layui.use(['form', 'layedit', 'laydate'], function () {
        form = layui.form(),
                layer = layui.layer,
                laydate = layui.laydate;



        //上传图片
        layui.upload({
            url: AM.ipImg + "/res/upload" //上传接口
            ,data:{type : 1}
            ,elem: "#fileEx"
            ,ext:"xlsx|xls"
            ,success: function(res){ //上传成功后的回调
                console.log(res.data.url);
                $.ajax({
                    type: "post",
                    async: false,
                    url: AM.ip + "/curriculumAllocation/addExcel",
                    data: {url:AM.ipImg+"/"+res.data.url,orderId:$("#orderId").val()},
                    success:function(json){
                        deleteExcel(res.data.url);
                        if (json.flag == 0 && json.code == 200) {
                            console.log(json.data);
                            showResult(json.data);
                        } else {
                            layer.alert(json.msg);

                        }
                    },
                    error: function(json) {
                        layer.alert(json.responseText);
                        console.log("请求出错了.");
                    }
                })


            }
        });
    });


    function showResult(json) {
        var htmlFail = "";
        if (json.failUsers.length > 0) {
            for (var i = 0; i < json.failUsers.length; i++) {
                htmlFail += "<label class='layui-form-label'>" + json.failUsers[i].phone + "</label></br>";
            }
        }

        var html = '<form class="layui-form layui-form-pane" action="">' +
                '<div class="layui-form-item layui-form-text">' +
                '<label class="layui-form-label">导入成功数量：'+json.successNum+'  个</label>' +
                '</div>' +
                '<div class="layui-form-item layui-form-text">' +
                '<label class="layui-form-label">导入失败：'+json.failNum+'  个</label>' +
                '</div>' +
                '<div class="layui-form-item layui-form-text">' +
                '<label class="layui-form-label">导入失败列表:</label>' +
                '<div class="layui-input-block">' + htmlFail + '</div>' +
                '</div>' +
                '</form>';

        AM.confirmPopup(html, "导入结果", ["500px", "300px"], function (index) {
            layer.close(index);
        }, function () {
        });


    }

    //无论导入成功或失败  都进行删除
    function deleteExcel(url) {
        AM.ajaxRequestData("post", false, AM.ipImg + "/res/delete", {url: url}, function (result) {

        });
    }


</script>
</body>
</head>
</html>
