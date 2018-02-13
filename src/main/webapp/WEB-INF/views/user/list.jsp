<!-- 解决layer.open 不居中问题 -->
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
                            <label class="layui-form-label">名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="showName" id="showName" lay-verify=""
                                       placeholder="个人：姓名 政府：机构名称 企业：企业名称" autocomplete="off" class="layui-input"
                                       maxlength="20">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">手机号</label>
                            <div class="layui-input-inline">
                                <input type="text" id="phone" lay-verify="" placeholder="请输入手机号" autocomplete="off"
                                       class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">审核状态</label>
                            <div class="layui-input-inline">
                                <select name="status" id="status" lay-verify="required" lay-search>
                                    <option value="">请选择审核状态</option>
                                    <option value="0">未通过</option>
                                    <option value="1">审核通过</option>
                                    <option value="2">审核中</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">行业名称</label>
                            <div class="layui-input-inline">
                                <select name="tradeId" id="tradeId" lay-verify="required" lay-search>
                                    <option value="">请选择或搜索行业</option>
                                </select>
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
                        <div class="layui-form-item">
                            <label class="layui-form-label">选择地区</label>
                            <div class="layui-input-inline">
                                <select name="province" id="provinceId" lay-search lay-filter="province">
                                    <option value="">请选择或搜索省</option>
                                </select>
                            </div>
                            <div class="layui-input-inline">
                                <select name="city" id="cityId" lay-search lay-filter="city">
                                    <option value="">请选择或搜索市</option>
                                </select>
                            </div>
                            <div class="layui-input-inline">
                                <select name="district" id="districtId" lay-search lay-filter="district">
                                    <option value="">请选择或搜索县/区</option>
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
        <legend>用户列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend>
        </legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <button onclick="addData()"
                        class="layui-btn layui-btn layui-btn-small layui-btn-normal hide checkBtn_37"><i
                        class="layui-icon">
                    &#xe608;</i> 添加用户
                </button>
                <button onclick="userExcel()"
                        class="layui-btn layui-btn layui-btn-small layui-btn-normal hide checkBtn_37"><i
                        class="layui-icon">
                    &#xe608;</i> 选择导入用户类型
                </button>
                <a class="layui-btn layui-btn layui-btn-small layui-btn-normal" href="<%=request.getContextPath()%>/resources/template/template.xls" ><i class="layui-icon">&#xe601;</i>下载企业导入模版</a>
            </blockquote>
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
    <div class="hide">
        <input type="file" name="file" id="fileExcelUser"  style="display: none">
    </div>

</div>

<!--引入抽取公共js-->
<%@include file="../common/public-js.jsp" %>
<script src="<%=request.getContextPath()%>/resources/js/common/jQuery.md5.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery.form.js" type="text/javascript" charset="UTF-8"></script>
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
                url: AM.ip + "/user/list",
                "dataSrc": function (json) {
                    console.log(json);
                    if (json.code == 200) {
                        return json.data;
                    }
                    return [];
                },
                "data": function (data) {
                    //高级查询参数
                    data.showName = $("#showName").val();
                    data.tradeId = $("#tradeId").val();
                    data.phone = $("#phone").val();
                    data.provinceId = $("#provinceId").val();
                    data.cityId = $("#cityId").val();
                    data.districtId = $("#districtId").val();
                    data.roleId = $("#roleId").val();
                    data.status = $("#status").val();
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
                        var btn = "";
                        if (null != row.status && row.status != "") {
                            if (row.status == 2) {
                                btn += "<button onclick='updateStatus(" + row.id + ",1)' class='layui-btn layui-btn-small layui-btn-normal hide checkBtn_71'><i class='fa fa-list fa-edit'></i>&nbsp;通过</button>" +
                                        "<button onclick='updateStatus(" + row.id + ",0)' class='layui-btn layui-btn-small layui-btn-danger hide checkBtn_71'><i class='fa fa-list fa-edit'></i>&nbsp;拒绝</button>";
                            }
                        }
                        if(row.roleId == 3){
                            btn += "<button onclick='importUser(" + row.id + ")' class='layui-btn layui-btn-small layui-btn-normal hide checkBtn_101'><i class='fa fa-list fa-edit'></i>&nbsp;导入用户</button>" ;
                        }
                        if(row.isValid == 1){
                            btn += "<button onclick='updateIsValid(" + row.id + ",0)' class='layui-btn layui-btn-small layui-btn-normal hide checkBtn_98'><i class='fa fa-list fa-edit'></i>&nbsp;删除用户</button>" ;
                        }
                        return "<button onclick='updateData(" + row.id + ")' class='layui-btn layui-btn-small hide checkBtn_38'><i class='fa fa-list fa-edit'></i>&nbsp;查看/修改</button>"
                                + "<button onclick='updatePassWord(" + row.id + ")' class='layui-btn layui-btn-small hide checkBtn_95'><i class='fa fa-list fa-edit'></i>&nbsp;修改密码</button>"
                                + btn
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

    //添加
    function addData() {
        var index = layer.open({
            type: 2,
            title: '添加课程',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/user/save"
        });
        layer.full(index);
    }

    var companyId = null;
    function importUser(id){
        companyId = id;
        $('#fileExcelUser').click();
    }

    layui.upload({
        url: AM.ipImg + "/res/upload" //上传接口
        , elem: "#fileExcelUser"
        , ext: "xlsx|xls"
        , success: function (res) { //上传成功后的回调
            console.log(res.data.url);
            $.ajax({
                type: "post",
                async: false,
                url: AM.ip + "/user/importUserExcel",
                data: {
                    url: AM.ipImg + "/" + res.data.url,
                    companyId: companyId
                },
                success: function (json) {
                    deleteExcel(res.data.url);
                    if (json.flag == 0 && json.code == 200) {
                        var msg = "<p>成功：" + json.data.successNum + "个</p>";
                        msg += "<p>失败：" + json.data.failNum + "个</p>";
                        if (json.data.failNum != 0) {
                            msg += "<p>失败原因：" + JSON.stringify(json.data.unExistUser) + "</p>";
                        }
                        var index = layer.alert(msg, {
                            title: "温馨提示",
                            closeBtn: 0
                            ,anim: 3
                        }, function(){
                            if (json.data.successNum == 0) {
                                layer.close(index);
                            }
                            else {
                                location.reload();
                            }
                        });
                    } else {
                        layer.alert(json.msg);

                    }
                },
                error: function (json) {
                    layer.alert(json.responseText);
                    console.log("请求出错了.");
                }
            })
        }
    });


    //修改课程是否有效
    function updateIsValid(id,isValid) {
        var index = layer.confirm("是否删除此用户？", {
            btn: ['确认', '取消'] //按钮
        }, function () {
            var arr = {
                id: id,
                isValid: isValid
            }
            AM.ajaxRequestData("post", false, AM.ip + "/user/updateIsValid", arr, function (result) {
                if (result.flag == 0 && result.code == 200) {
                    dataTable.ajax.reload();
                    layer.close(index);
                }
            });
        }, function () {
        });
    }

    //查看/修改数据
    function updateData(id) {
        //sessionStorage.setItem("curriculum", JSON.stringify(obj));
        var index = layer.open({
            type: 2,
            title: '修改课程',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/user/edit?id=" + id
        });
        layer.full(index);
    }


    //修改用户状态
    function updateStatus(id, status) {
        var statusMsg = "是否审核通过?";
        if (status == 0) {
            statusMsg = "是否拒绝通过?";
        }

        var html = '<form class="layui-form layui-form-pane" action="">' +
                '<div class="layui-form-item layui-form-text">' +
                '<label class="layui-form-label">备注</label>' +
                '<div class="layui-input-block">' +
                '<textarea type="text" id="notes" autocomplete="off" placeholder="请输入备注" class="layui-input" maxlength="60"></textarea>' +
                '</div>' +
                '</div>' +
                '</form>';
        AM.formPopup(html, statusMsg, ["500px", "300px"], function () {
            var arr = {
                status: status,
                id: id,
                notes: $("#notes").val()
            }
            AM.ajaxRequestData("post", false, AM.ip + "/user/updateStatus", arr, function (result) {
                if (result.flag == 0 && result.code == 200) {
                    dataTable.ajax.reload();
                    layer.msg('操作成功.', {icon: 1});
                    var index = layer.load(1, {shade: [0.5, '#eee']});
                    setTimeout(function () {
                        layer.close(index);
                    }, 600);
                }
            });
        }, function () {
            //layer.msg('已取消.', {icon: 2, anim: 6});
        });
    }

    layui.use(['form', 'layedit', 'laydate'], function () {
        form = layui.form(),
                layer = layui.layer,
                laydate = layui.laydate;

        //监听省
        form.on('select(province)', function (data) {
            $("select[name='district']").html("<option value=\"\">请选择或搜索县/区</option>");
            $("input[name='cityId']").val(data.value);
            selectCity(data.value);
            form.render();
        });

        //监听市
        form.on('select(city)', function (data) {
            $("input[name='cityId']").val(data.value);
            selectCounty(data.value);
            form.render();
        });

        //监听区
        form.on('select(district)', function (data) {
            $("input[name='cityId']").val(data.value);
            form.render();
        });

        getTradeList(0); //行业列表

        selectProvince(0,"list"); //默认调用省

        getRoleList(0); //角色列表
    });
    //导入用户
    function userExcel() {


        var html = '<form class="layui-form" action="" style="height: 400px;">' +
                '<div class="layui-form-item">' +
                '<div class="layui-inline">' +
                '<label class="layui-form-label">导入类型</label>' +
                '<div class="layui-input-inline">' +
                '<select name="roleId2" id="roleId2" lay-filter="roleId2" lay-verify="required" lay-search>' +
                '<option value="">请选择导入类型</option>' +
                '<option value="2">政府</option>' +
                '<option value="3">企业</option>' +
                '<option value="4">普通用户</option>' +
                '</select>' +
                '</div>' +
                '</div>' +
                '<div class="layui-inline">' +
                '<label class="layui-form-label">导入</label>' +
                '<div class="layui-input-inline">' +
                '<span class="layui-hide"><input type="file" name="file" id="fileEx" lay-title="导入用户"></span>' +
                '<div class="layui-box layui-upload-button" id="btnFile">' +
                '<span class="layui-upload-icon"><i class="layui-icon"></i>导入</span></div>' +
                '<a style="float: right" href="' + AM.ip + '/resources/userTemplate.xls" class="layui-btn layui-btn layui-btn-small layui-btn-warm"><i class="layui-icon">&#xe601;</i> 下载模板</a>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</form>';


        var index = layer.confirm(html, {
            btn: ['取消'],//'确认',
            title: "导入用户",
            area: ["600px", "400px"], //宽高
        }, function () {
            if ($("#password").val() == "") {
                layer.msg('密码不能为空.', {icon: 2, anim: 6});
                $("#password").focus();
                return false;
            }
            layer.close(index);
        }, function () {
        });


        //监听省
//        form.on('select(roleId2)', function(data) {
//            var ary = {
//                roleId:data.value
//            }
//            AM.ajaxRequestData("get", false, AM.ip + "/user/listForSelect", ary , function(result){
//                if(result.flag == 0 && result.code == 200){
//                    var html = "<option value=\"\">请选择企业/政府</option>";
//                    for (var i = 0; i < result.data.length; i++) {
//                        html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].showName + "</option>";
//                    }
//                    if (result.data.length == 0) {
//                        html += "<option value=\"0\" disabled>暂无</option>";
//                    }
//                    $("select[name='parentId2']").html(html);
//                    $("select[name='parentId2']").parent().parent().show();
//                }
//            });
//            form.render();
//        });

        //上传图片
        layui.upload({
            url: AM.ipImg + "/res/upload" //上传接口
            , elem: "#fileEx"
            , ext: "xlsx|xls"
            , success: function (res) { //上传成功后的回调
                console.log(res.data.url);
                $.ajax({
                    type: "post",
                    async: false,
                    url: AM.ip + "/user/addExcel",
                    data: {
                        url: AM.ipImg + "/" + res.data.url,
                        parentId: $("#parentId2").val(), roleId: $("#roleId2").val()
                    },
                    success: function (json) {
                        deleteExcel(res.data.url);
                        if (json.flag == 0 && json.code == 200) {
                            console.log(json.data);
                            showResult(json.data);
                        } else {
                            layer.alert(json.msg);

                        }
                    },
                    error: function (json) {
                        layer.alert(json.responseText);
                        console.log("请求出错了.");
                    }
                })
            }
        });

        $("#btnFile").click(function () {
            if ($("#roleId2").val() == null || $("#roleId2").val() == "") {
                alert('请选择导入类型')
                return false;
            }
            $("#fileEx").click();
        });


        form.render();
    }

    function showResult(json) {
        var htmlFail = "";
        if (json.failUsers.length > 0) {
            for (var i = 0; i < json.failUsers.length; i++) {
                htmlFail += "<label class='layui-form-label'>" + json.failUsers[i].showName + "</label></br>";
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

        AM.confirmPopup(html, "导入结果", ["500px", "300px"], function () {
            dataTable.ajax.reload();
        }, function () {
        });


    }

    //无论导入成功或失败  都进行删除
    function deleteExcel(url) {
        AM.ajaxRequestData("post", false, AM.ipImg + "/res/delete", {url: url}, function (result) {

        });
    }


    function updatePassWord(id) {
        layer.prompt({
            formType: 3,
            title: '请输入密码',
            area: ['400px', '200px'] //自定义文本域宽高
        }, function(value, index, elem){
            var arr = {
                id: id,
                pwd: $.md5(value)
            }
            AM.ajaxRequestData("post", false, AM.ip + "/user/update", arr, function (result) {
                if (result.flag == 0 && result.code == 200) {
                    dataTable.ajax.reload();
                    layer.msg('操作成功.', {icon: 1});
                    layer.load(1, {shade: [0.5, '#eee']});
                    setTimeout(function () {
                        layer.closeAll();
                    }, 600);
                }
            });
        });


    }

</script>
</body>
</head>
</html>
