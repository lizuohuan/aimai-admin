<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>用户课时列表</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>

<body>

<div class="admin-main">
    <input type="text" name="orderId" id="orderId" lay-verify="" value="${orderId}" style="display: none;">
    <input type="text" name="userId" id="userId" lay-verify="" value="${userId}" style="display: none;">
    <input type="text" name="curriculumId" id="curriculumId" lay-verify="" value="${curriculumId}" style="display: none;">
    <fieldset class="layui-elem-field">
        <legend>用户课时列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend>
        </legend>
        <div class="layui-field-box layui-form">
            <%--<blockquote class="layui-elem-quote">--%>
                <%--<button onclick="addData()" class="layui-btn layui-btn layui-btn-small layui-btn-normal"><i class="layui-icon">--%>
                    <%--&#xe608;</i> 添加用户--%>
                <%--</button>--%>
            <%--</blockquote>--%>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>课件名称</th>
                    <th>学习进度</th>
                    <th>学习开始时间</th>
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
                url: AM.ip + "/courseWare/listForAdminUser",
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
                    data.curriculumId = $("#curriculumId").val();
                    data.userId = $("#userId").val();
                }
            },
            "columns": [
                {"data": "courseWareName"},
                {"data": "hdSeconds"},
                {"data": "studyStartTime"},
            ],
            "columnDefs": [
                {
                    "render": function (data, type, row) {
                        return (row.expendSeconds / data * 100).toFixed(2) + "%"
                    },
                    "targets": 1
                },
                {
                    "render": function (data, type, row) {
                        if (data == null || data == "") {
                            return "--";
                        }
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    },
                    "targets": 2
                },
                {
                    "render": function (data, type, row) {
                        var btn = "";
                        return "<button onclick='goFaceRecordList(" + row.id + "," + row.orderId +")' class='layui-btn layui-btn-small hide checkBtn_42'><i class='fa fa-list fa-edit'></i>&nbsp;人脸验证列表</button>"
                                + btn
                                ;
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

    //查看/修改数据
    function updateData(obj) {
        //sessionStorage.setItem("curriculum", JSON.stringify(obj));
//        var index = layer.open({
//            type: 2,
//            title: '修改课程',
//            shadeClose: true,
//            maxmin: true, //开启最大化最小化按钮
//            area: ['400px', '500px'],
//            content: AM.ip + "/page/user/edit?id=" + obj.id
//        });
//        layer.full(index);
    }



    //查看用户的课程
    function goFaceRecordList(courseWareId) {
        var index = layer.open({
            type: 2,
            title: '人脸采集列表',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/faceRecord/list?courseWareId=" + courseWareId + "&orderId="+$("#orderId").val() + "&userId="+$("#userId").val()
        });
        layer.full(index);
    }

    layui.use(['form', 'layedit', 'laydate'], function () {
        form = layui.form(),
                layer = layui.layer,
                laydate = layui.laydate;

    });


</script>
</body>
</head></html>
