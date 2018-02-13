    <!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>课件列表</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>

<body>

<div class="admin-main">

    <blockquote class="layui-elem-quote">
        <fieldset class="layui-elem-field">
            <legend>高级筛选</legend>
            <div class="layui-field-box layui-form">
                <form class="layui-form" action="" id="formData">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <input type="text" id="curriculumId" value="${curriculumId}" style="display: none;">
                            <label class="layui-form-label">课时名</label>
                            <div class="layui-input-inline">
                                 <input type="text" id="courseWareName" lay-verify="" placeholder="请输入课程名" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">创建的开始时间</label>
                            <div class="layui-input-inline">
                                <input type="text" id="createTimeStart"  readonly lay-verify="" placeholder="请输入开始时间" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">创建的结束时间</label>
                            <div class="layui-input-inline">
                                <input type="text" id="createTimeEnd"  readonly lay-verify="" placeholder="请输入结束时间" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                    </div>

                    <div class="layui-form-item">
                    <%--<div class="layui-inline">--%>
                            <%--<label class="layui-form-label">课程名</label>--%>
                            <%--<div class="layui-input-inline">--%>
                                <%--<input type="text" id="curriculumName" lay-verify="" placeholder="请输入课程名" autocomplete="off" class="layui-input" maxlength="20">--%>
                            <%--</div>--%>
                        <%--</div>--%>
                        <%--<div class="layui-inline">--%>
                            <%--<label class="layui-form-label">行业名称</label>--%>
                            <%--<div class="layui-input-inline">--%>
                                <%--<input type="text" id="tradeName" lay-verify="" placeholder="请输入行业名称" autocomplete="off" class="layui-input" maxlength="20">--%>
                            <%--</div>--%>
                        <%--</div>--%>
                        <%--<div class="layui-inline">--%>
                            <%--<label class="layui-form-label">发布人</label>--%>
                            <%--<div class="layui-input-inline">--%>
                                <%--<input type="text" id="releaseUserName" lay-verify="" placeholder="请输入发布人" autocomplete="off" class="layui-input" maxlength="20">--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
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
        <legend>课件列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend>
        </legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <button onclick="addData()" class="layui-btn layui-btn layui-btn-small layui-btn-normal hide checkBtn_30"><i class="layui-icon">
                    &#xe608;</i> 添加课件
                </button>
            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>封面图</th>
                    <th>课程名</th>
                    <th>课件名</th>
                    <th>行业名称</th>
                    <%--<th>讲师名称</th>--%>
                    <%--<th>讲师介绍</th>--%>
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
                url: AM.ip + "/courseWare/list",
                "dataSrc": function (json) {
                    console.log(json);
                    if (json.code == 200) {
                        return json.data;
                    }
                    return [];
                },
                "data": function (data) {
                    //高级查询参数
                    data.courseWareName = $("#courseWareName").val();
                    data.isValid = $("#isValid").val();
                    data.createTimeStarts = $("#createTimeStart").val();
                    data.createTimeEnds = $("#createTimeEnd").val();
                    data.curriculumId = $("#curriculumId").val();
                }
            },
            "columns": [
                {"data": "cover"},
                {"data": "curriculumName"},
                {"data": "courseWareName"},
                {"data": "tradeName"},
//                {"data": "teacherName"},
//                {"data": "teacherIntroduce"},
            ],
            "columnDefs": [
                {
                    "render": function (data, type, row) {
                        if (null != data) {
                            return "<img height='auto' width='100' src='"+ AM.ipImg + "/" + data + "'>";
                        } else {
                            return "";
                        }

                    },
                    "targets": 0
                },
                {
                    "render": function (data, type, row) {
                        var obj = JSON.stringify(row);
                        var btn = "";
                        return "<button onclick='updateData(" + obj + ")' class='layui-btn layui-btn-small hide checkBtn_31'><i class='fa fa-list fa-edit'></i>&nbsp;查看/修改</button>"
                                + "<button onclick='goVideo(" + row.id + ")' class='layui-btn layui-btn-small layui-btn-warm hide checkBtn_32'><i class='fa fa-list fa-edit'></i>&nbsp;查看视频</button>"
                                + "<button onclick='deleteCourseWare(" + row.id + ")' class='layui-btn layui-btn-small layui-btn-danger hide checkBtn_92'><i class='fa fa-list fa-edit'></i>&nbsp;删除课件</button>"
                                + btn
                                ;
                    },
                    "targets": 4
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
            title: '添加课件',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/courseWare/save?curriculumId="+$("#curriculumId").val()
        });
        layer.full(index);
    }

    //查看/修改数据
    function updateData(obj) {
        //sessionStorage.setItem("curriculum", JSON.stringify(obj));
        var index = layer.open({
            type: 2,
            title: '修改课件',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/courseWare/edit?id=" + obj.id
        });
        layer.full(index);
    }


    //查看视频
    function goVideo(id) {
        //sessionStorage.setItem("curriculum", JSON.stringify(obj));
        var index = layer.open({
            type: 2,
            title: '查看视频',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/video/list?id=" + id
        });
        layer.full(index);
    }


    //删除课时
    function deleteCourseWare(id) {
        var index = layer.confirm("删除此课件，同时也将删除课时下所有视频，且无法恢复，请谨慎操作，是否删除？", {
            btn: ['确认', '取消'] //按钮
        }, function () {
            var arr = {
                id: id
            }
            AM.ajaxRequestData("post", false, AM.ip + "/courseWare/delete", arr, function (result) {
                if (result.flag == 0 && result.code == 200) {
                    dataTable.ajax.reload();
                    layer.close(index);
                }
            });
        }, function () {
        });
    }


    layui.use(['form', 'layedit', 'laydate'], function () {
        form = layui.form(),
                layer = layui.layer,
                laydate = layui.laydate;

        form.on("switch(isShow)", function (data) {
            console.log(data);
            var bannerId = $(this).attr("bannerId");
            if (data.elem.checked) {
                updateStatus(bannerId, 1);
            }
            else {
                updateStatus(bannerId, 0);
            }
            form.render();
        });
        var start = {max: '2099-06-16 23:59:59'
            ,istoday: false
            ,format: 'YYYY-MM-DD hh:mm:ss'
            ,choose: function(datas){
                end.min = datas; //开始日选好后，重置结束日的最小日期
                end.start = datas //将结束日的初始值设定为开始日
            }
        };

        var end = {
            max: '2099-06-16 23:59:59'
            ,format: 'YYYY-MM-DD hh:mm:ss'
            ,istoday: false
            ,choose: function(datas){
                start.max = datas; //结束日选好后，重置开始日的最大日期
            }
        };

        document.getElementById('createTimeStart').onclick = function(){
            start.elem = this;
            laydate(start);
        }
        document.getElementById('createTimeEnd').onclick = function(){
            end.elem = this
            laydate(end);
        }

    });


</script>
</body>
</head></html>
