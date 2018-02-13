<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>用户列表</title>
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
                            <label class="layui-form-label">身份证号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="pid" id="pid" lay-verify="" placeholder="请输入身份证" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">手机号</label>
                            <div class="layui-input-inline">
                                <input type="text" id="phone" lay-verify="" placeholder="请输入手机号" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">公司名称</label>
                            <div class="layui-input-inline">
                                <input type="text" id="companyName" lay-verify="" placeholder="请输入公司名称" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">完成开始时间</label>
                            <div class="layui-input-inline">
                                <input type="text" id="startTime"  readonly lay-verify="" placeholder="请输入开始时间" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">完成结束时间</label>
                            <div class="layui-input-inline">
                                <input type="text" id="endTime"  readonly lay-verify="" placeholder="请输入结束时间" autocomplete="off" class="layui-input" maxlength="20">
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
        <legend>用户列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend>
        </legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <button class="layui-btn layui-btn-small layui-btn-default hide checkBtn_90" onclick="userExcel()"><i class="layui-icon">&#xe601;</i>导出用户<i class="fa fa-file-text-o"></i></button>
            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>头像</th>
                    <th>人脸识别采集图</th>
                    <th>姓名</th>
                    <th>联系方式</th>
                    <th>所在地</th>
                    <th>行业</th>
                    <th>身份证</th>
                    <th>所属公司</th>
                    <th>部门</th>
                    <th>职位</th>
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
                url: AM.ip + "/user/listForAdminRecord",
                "dataSrc": function (json) {
                    console.log(json);
                    if (json.code == 200) {
                        return json.data;
                    }
                    return [];
                },
                "data": function (data) {
                    //高级查询参数
                    data.companyName = $("#companyName").val();
                    data.startTime = $("#startTime").val();
                    data.endTime = $("#endTime").val();
                    data.phone = $("#phone").val();
                    data.pid = $("#pid").val();
                    data.roleId = 4;
                }
            },
            "columns": [
                {"data": "avatar"},
                {"data": "veriFaceImages"},
                {"data": "showName"},
                {"data": "phone"},
                {"data": "city.mergerName"},
                {"data": "tradeName"},
                {"data": "pid"},
                {"data": "companyName"},
                {"data": "departmentName"},
                {"data": "jobTitle"},
                {"data": "createTime"},
            ],
            "columnDefs": [
                {
                    "render": function (data, type, row) {
                        if (null != data) {
                            return "<img height='auto' width='100' src='"+ AM.ipImg + "/" + data + "'>";
                        } else {
                            return "--";
                        }
                    },
                    "targets": 0
                },
                {
                    "render": function (data, type, row) {
                        if (null != data) {
                            return "<img height='auto' width='100' src='"+ AM.ipImg + "/" + data + "'>";
                        } else {
                            return "--";
                        }
                    },
                    "targets": 1
                },
                {
                    "render": function(data, type, row) {
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    },
                    "targets": 10
                },
                {
                    "render": function (data, type, row) {
                        var btn = "";
                        return "<button onclick='updateData(" + row.id + ")' class='layui-btn layui-btn-small hide checkBtn_39'><i class='fa fa-list fa-edit'></i>&nbsp;查看信息</button>" +
                                "<button onclick='goCurriculumList(" + row.id + ")' class='layui-btn layui-btn-small hide checkBtn_40'><i class='fa fa-list fa-edit'></i>&nbsp;学习情况列表</button>"+
                                "<button onclick='goPaperRecordList(" + row.id + ")' class='layui-btn layui-btn-small hide checkBtn_80'><i class='fa fa-list fa-edit'></i>&nbsp;考试记录列表</button>"
                                + btn
                                ;
                    },
                    "targets": 11
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

    //查看
    function updateData(id) {
        //sessionStorage.setItem("curriculum", JSON.stringify(obj));
        var index = layer.open({
            type: 2,
            title: '用户详情',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/user/infoRecord?id=" + id
        });
        layer.full(index);
    }



    //查看用户的课程
    function goCurriculumList(id) {
        var index = layer.open({
            type: 2,
            title: '课程列表',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/curriculum/userCurriculumList?userId=" + id
        });
        layer.full(index);
    }

    //查看用户的考试记录
    function goPaperRecordList(id) {
        var index = layer.open({
            type: 2,
            title: '考试记录列表',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/paperRecord/list?userId=" + id
        });
        layer.full(index);
    }

    layui.use(['form', 'layedit', 'laydate'], function () {
        form = layui.form(),
                layer = layui.layer,
                laydate = layui.laydate;
        var start = {
          /*  min: laydate.now()
            ,*/max: '2099-06-16 23:59:59'
            ,istoday: false
            ,choose: function(datas){
                end.min = datas; //开始日选好后，重置结束日的最小日期
                //end.start = datas //将结束日的初始值设定为开始日
            }
        };

        var end = {
            /*min: laydate.now()
            ,*/max: '2099-06-16 23:59:59'
            ,istoday: false
            ,choose: function(datas){
                start.max = datas; //结束日选好后，重置开始日的最大日期
            }
        };

        document.getElementById('startTime').onclick = function(){
            start.elem = this;
            laydate(start);
        }
        document.getElementById('endTime').onclick = function(){
            end.elem = this
            laydate(end);
        }

    });

    //外部项目报表导出
    function userExcel () {



        window.location.href = AM.ip + "/excel/excelUser"
                + "?phone=" + $("#phone").val()
                + "&roleId=4"
                + "&pid=" + $("#pid").val()
                + "&companyName=" + $("#companyName").val()
                + "&startTimes=" + $("#startTime").val()
                + "&endTimes=" + $("#endTime").val()
    }
</script>
</body>
</head></html>
