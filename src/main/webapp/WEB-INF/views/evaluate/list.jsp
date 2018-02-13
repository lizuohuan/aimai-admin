<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>评论列表</title>
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
                            <label class="layui-form-label">课程名</label>
                            <div class="layui-input-inline">
                                <input type="text" id="curriculumName" lay-verify="" placeholder="请输入课程名" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">评论人</label>
                            <div class="layui-input-inline">
                                <input type="text" id="userName" lay-verify="" placeholder="请输入评论人" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">是否有效</label>
                            <div class="layui-input-inline">
                                <select name="isValid" id="isValid" lay-verify="required" lay-search>
                                    <option value="">请选择是否有效</option>
                                    <option value="0">无效</option>
                                    <option value="1">有效</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">发布的开始时间</label>
                            <div class="layui-input-inline">
                                <input type="text" id="startTimes"  readonly lay-verify="" placeholder="请输入开始时间" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">发布的结束时间</label>
                            <div class="layui-input-inline">
                                <input type="text" id="endTimes"  readonly lay-verify="" placeholder="请输入结束时间" autocomplete="off" class="layui-input" maxlength="20">
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
        <legend>评论列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend>
        </legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <%--<button onclick="addData()" class="layui-btn layui-btn layui-btn-small layui-btn-normal"><i class="layui-icon">--%>
                    <%--&#xe608;</i> 添加评论--%>
                <%--</button>--%>
                <button onclick="updateOrDelete('passSubmit',1)" lay-submit="" lay-filter="passSubmit" class="layui-btn layui-btn layui-btn-small layui-btn"><i class="layui-icon">
                    &#xe616;</i> 批量通过
                </button>
                <%--<button onclick="updateOrDelete('deleteSubmit',0)" lay-submit="" lay-filter="deleteSubmit" class="layui-btn layui-btn layui-btn-small layui-btn-warm"><i class="layui-icon">--%>
                    <%--&#x1007;</i> 批量取消--%>
                <%--</button>--%>
                <button onclick="updateOrDelete('deleteSubmit',2)" lay-submit="" lay-filter="deleteSubmit" class="layui-btn layui-btn layui-btn-small layui-btn-danger"><i class="layui-icon">
                    &#xe640;</i> 批量删除
                </button>
            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th><input type="checkbox" name="" lay-skin="primary" lay-filter="allChoose" title="勾选本页"></th>
                    <th>课程名</th>
                    <th>评论人</th>
                    <th>所在地</th>
                    <th>评论内容</th>
                    <th>是否有效</th>
                    <th>评论时间</th>
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
                url: AM.ip + "/evaluate/list",
                "dataSrc": function (json) {
                    console.log(json);
                    if (json.code == 200) {
                        return json.data;
                    }
                    return [];
                },
                "data": function (data) {
                    //高级查询参数
                    data.curriculumName = $("#curriculumName").val();
                    data.userName = $("#userName").val();
                    data.isValid = $("#isValid").val();
                    data.startTimes = $("#startTimes").val();
                    data.endTimes = $("#endTimes").val();
                    data.provinceId = $("#provinceId").val();
                    data.cityId = $("#cityId").val();
                    data.districtId = $("#districtId").val();
                }
            },
            "columns": [
                {"data": "" },
                {"data": "curriculumName"},
                {"data": "userName"},
                {"data": "cityName"},
                {"data": "content"},
                {"data": "isValid"},
                {"data": "createTime"},
            ],
            "columnDefs": [
                {
                    "render": function(data, type, row) {
                        return "<input userId='"+ row.userId +"' isValid='"+ row.isValid +"'  type=\"checkbox\" name=\"\" value=\"" + row.id + "\"  lay-skin=\"primary\" title=\"勾选\">";
                    },
                    "targets": 0
                },
                {
                    "render": function (data, type, row) {
                        if (data == 0) return "无效";
                        else if (data == 1) return "有效";
                        else return "--";
                    },
                    "targets": 5
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
                        var btn = "";
                        //是否有效  0:无效  1:有效
                        var isValid = 0;
                        var isValidMsg = "取消通过";
                        var btnColor = "layui-btn-warm";
                        if (row.isValid == 0) {
                            isValid = 1;
                            isValidMsg = "通过";
                            btnColor = "layui-btn";
                            btn += "<button onclick='auditEvaluate(" + row.id + "," + isValid + ")' class='layui-btn layui-btn-small "+btnColor+" hide checkBtn_64'><i class='fa fa-list fa-edit'></i>&nbsp;"+ isValidMsg +"</button>";
                        }
                        btn += "<button onclick='deleteEvaluate(" + row.id +")' class='layui-btn layui-btn-small layui-btn-danger hide checkBtn_65'><i class='fa fa-list fa-edit'></i>&nbsp;删除</button>";
                        return  btn
                                ;
                    },
                    "targets": 7
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
//
//    //添加
//    function addData() {
//        var index = layer.open({
//            type: 2,
//            title: '添加课程',
//            shadeClose: true,
//            maxmin: true, //开启最大化最小化按钮
//            area: ['400px', '500px'],
//            content: AM.ip + "/page/curriculum/save"
//        });
//        layer.full(index);
//    }



//    function updateStatus(){
//
//    }



    //修改评论通过状态
    function auditEvaluate(id ,isValid) {
        var isValidMsg = "是否取消通过";
        if (isValid == 1) {
            isValidMsg = "是否确认通过";
        }
        var index = layer.confirm(isValidMsg, {
            btn: ['确认', '取消'] //按钮
        }, function () {
            var arr = {
                id: id,
                isValid: isValid
            }
            AM.ajaxRequestData("post", false, AM.ip + "/evaluate/auditEvaluate", arr, function (result) {
                if (result.flag == 0 && result.code == 200) {
                    dataTable.ajax.reload();
                    layer.close(index);
                }
            });
        }, function () {
        });
    }



    //修改评论通过状态
    function deleteEvaluate(id) {
        var index = layer.confirm("是否删除此评论", {
            btn: ['确认', '取消'] //按钮
        }, function () {
            var arr = {
                id: id
            }
            AM.ajaxRequestData("post", false, AM.ip + "/evaluate/delete", arr, function (result) {
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

        var start = {
            max: '2099-06-16 23:59:59'
            ,format: 'YYYY-MM-DD hh:mm:ss'
            ,istoday: false
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

        document.getElementById('startTimes').onclick = function(){
            start.elem = this;
            laydate(start);
        }
        document.getElementById('endTimes').onclick = function(){
            end.elem = this
            laydate(end);
        }


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
        selectProvince(0,"list"); //默认调用省

        getTradeList(0); //行业列表
        //全选
        form.on('checkbox(allChoose)', function(data){
            var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]');
            child.each(function(index, item){
                item.checked = data.elem.checked;
            });
            form.render('checkbox');
        });
    });

    var updateOrDelete = function (sub,type) {
        form.on('submit('+sub+')', function(data){
            var child = $("#dataTable").find('tbody input[type="checkbox"]');
            var ids=[];
            child.each(function(){
                if ($(this).is(':checked')) {
                    var id = $(this).val();

                    if (type == 2) {
                        ids += id + ",";
                    } else {
                        var isValid = $(this).attr("isValid");
                        var userId = $(this).attr("userId");
                        if (isValid != type) {
                            var obj = {
                                id : id,
                                isValid : type,
                                userId : userId
                            }
                            ids.push(obj);
                        }

                    }

                }
            });
            if (ids.length == 0) {
                layer.msg('至少勾选一个.', {icon: 2, anim: 6});
                return false;
            }


            else {
                console.log("******************");
                console.log(ids);
                console.log("************");

                var url = "/evaluate/auditEvaluateList";
                var idsAndIsValid = JSON.stringify(ids);
                if (type == 2) {
                    url = "/evaluate/deleteList";
                    idsAndIsValid = ids;
                }

                var arr = {
                    idsAndIsValid : idsAndIsValid
                }

                AM.ajaxRequestData("post", false, AM.ip + url, arr, function(result){
                    if(result.flag == 0 && result.code == 200){
                        var index = layer.alert('操作成功.', {
                            skin: 'layui-layer-molv' //样式类名
                            ,closeBtn: 0
                            ,anim: 3 //动画类型
                        }, function(){
                            layer.close(index);
                            //关闭iframe页面
                            dataTable.ajax.reload();
                        });
                    }
                });
            }
        });
        //layer.msg('等我开发.', {icon: 1});
    }

</script>
</body>
</head></html>
