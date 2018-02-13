<!-- 解决layer.open 不居中问题 -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>用户回收站列表</title>
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
                            <label class="layui-form-label">手机号</label>
                            <div class="layui-input-inline">
                                <input type="text" id="phone" lay-verify="" placeholder="请输入手机号" autocomplete="off"
                                       class="layui-input" maxlength="20">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">用户类型</label>
                            <div class="layui-input-inline">
                                <select name="roleId" id="roleId" lay-verify="required" lay-search>
                                    <option value="">请选择或搜索用户类型</option>
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
        <legend>用户回收站列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend>
        </legend>
        <div class="layui-field-box layui-form">

            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>头像</th>
                    <th>名称</th>
                    <th>手机号</th>
                    <th>所在地</th>
                    <th>行业</th>
                    <th>用户类型</th>
                    <th>注册时间</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </fieldset>
</div>

<!--引入抽取公共js-->
<%@include file="../common/public-js.jsp" %>
<script src="<%=request.getContextPath()%>/resources/js/common/jQuery.md5.js"></script>
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
                url: AM.ip + "/user/getUserByIsValid",
                "dataSrc": function (json) {
                    console.log(json);
                    if (json.code == 200) {
                        return json.data;
                    }
                    return [];
                },
                "data": function (data) {
                    //高级查询参数
                    data.phone = $("#phone").val();
                    data.roleId = $("#roleId").val();
                }
            },
            "columns": [
                {"data": "avatar"},
                {"data": "showName"},
                {"data": "phone"},
                {"data": "city.mergerName"},
                {"data": "tradeName"},
                {"data": "roleName"},
                {"data": "createTime"},
                {"data": "status"},
            ],
            "columnDefs": [
                {
                    "render": function (data, type, row) {
                        if (null != data) {
                            return "<img height='auto' width='100' src='" + AM.ipImg + "/" + data + "'>";
                        } else {
                            return "--";
                        }
                    },
                    "targets": 0
                },
                {
                    "render": function (data, type, row) {
                        if (null != data) {
                            return data;
                        } else {
                            return "不限";
                        }
                    },
                    "targets": 4
                },
                {
                    "render": function (data, type, row) {
                        if (data == null || data == "") {
                            return "--";
                        }
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    },
                    "targets": 6
                },
                {
                    "render": function (data, type, row) {
                        if (null != data) {
                            if (data == 0) {
                                return "未通过";
                            }
                            if (data == 1) {
                                return "审核通过";
                            }
                            if (data == 2) {
                                return "审核中";
                            }
                        } else {
                            return "--";
                        }
                    },
                    "targets": 7
                },
                {
                    "render": function (data, type, row) {
                        var btn = "<button onclick='updateStatus(" + row.id + ",1)' class='layui-btn layui-btn-small layui-btn-normal hide checkBtn_97'><i class='fa fa-list fa-edit'></i>&nbsp;还原账户</button>";

                        return btn
                                ;
                    },
                    "targets": 8
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




    //修改用户状态
    function updateStatus(id, status) {

        var statusMsg = "是否还原账户?";
        var index = layer.confirm(statusMsg, {
            btn: ['确认', '取消'] //按钮
        }, function () {
            var arr = {
                id: id,
                isValid: status
            }
            AM.ajaxRequestData("post", false, AM.ip + "/user/update", arr, function (result) {
                if (result.flag == 0 && result.code == 200) {
                    dataTable.ajax.reload();
                    layer.close(index);
                }
            });
        }, function () {
        });


//        var arr = {
//            id : id,
//            isValid : status
//        }
//        layer.open({
//            content: statusMsg,
//            success: function(layero, index){
//                AM.ajaxRequestData("post", false, AM.ip + "/user/update", arr, function (result) {
//                    if (result.flag == 0 && result.code == 200) {
//                        dataTable.ajax.reload();
//                        layer.msg('操作成功.', {icon: 1});
//                        layer.load(1, {shade: [0.5, '#eee']});
//                        setTimeout(function () {
//                            layer.closeAll();
//                        }, 600);
//                    }
//                });
//            }
//        });



    }

    layui.use(['form', 'layedit', 'laydate'], function () {
        form = layui.form(),
                layer = layui.layer,
                laydate = layui.laydate;




        getRoleList(0); //角色列表
    });





</script>
</body>
</head>
</html>
