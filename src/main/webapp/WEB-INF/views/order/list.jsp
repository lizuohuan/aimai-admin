<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>订单列表</title>
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
                            <label class="layui-form-label">订单号</label>
                            <div class="layui-input-inline">
                                <input type="text" id="orderNumber" lay-verify="" placeholder="请输入订单号" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">支付方式</label>
                            <div class="layui-input-inline">
                                <select name="payMethod" id="payMethod" lay-verify="required" lay-search>
                                    <option value="">请选择支付方式</option>
                                    <option value="0">支付宝</option>
                                    <option value="1">微信</option>
                                    <option value="2">公众号支付</option>
                                    <option value="3">线下支付</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">支付状态</label>
                            <div class="layui-input-inline">
                                <select name="payStatus" id="payStatus" lay-verify="required" lay-search>
                                    <option value="">请选择支付状态</option>
                                    <option value="0">未支付</option>
                                    <option value="1">已支付</option>
                                </select>
                            </div>
                        </div>

                    </div>

                    <div class="layui-form-item">

                        <div class="layui-inline">
                            <label class="layui-form-label">购买方名称</label>
                            <div class="layui-input-inline">
                                <input type="text" id="userName" lay-verify="" placeholder="请输入购买方名称" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">支付的开始时间</label>
                            <div class="layui-input-inline">
                                <input type="text" id="startTimes"  readonly lay-verify="" placeholder="请输入开始时间" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">支付的结束时间</label>
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
                            <input type="radio" value="" name="isPlatformCreate" checked lay-skin="primary" lay-filter="allChoose" title="全部">
                            <input type="radio" value="1" name="isPlatformCreate"  lay-skin="primary" lay-filter="allChoose" title="平台创建">
                            <input type="radio" value="0" name="isPlatformCreate"  lay-skin="primary" lay-filter="allChoose" title="非平台创建">
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
        <legend>订单列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend>
        </legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <button onclick="addData()" class="layui-btn layui-btn layui-btn-small layui-btn-normal hide checkBtn_58"><i class="layui-icon">
                    &#xe608;</i> 新增订单
                </button>
            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>订单号</th>
                    <th>用户名</th>
                    <th>课程名</th>
                    <th>地区</th>
                    <th>购买数量</th>
                    <th>支付费用(￥)</th>
                    <th>支付方式</th>
                    <th>支付状态</th>
                    <th>支付时间</th>
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
                url: AM.ip + "/order/list",
                "dataSrc": function (json) {
                    console.log(json);
                    if (json.code == 200) {
                        return json.data;
                    }
                    return [];
                },
                "data": function (data) {
                    //高级查询参数
                    data.orderNumber = $("#orderNumber").val();
                    data.payMethod = $("#payMethod").val();
                    data.payStatus = $("#payStatus").val();
                    data.userName = $("#userName").val();
                    data.startTimes = $("#startTimes").val();
                    data.endTimes = $("#endTimes").val();
                    data.provinceId = $("#provinceId").val();
                    data.cityId = $("#cityId").val();
                    data.districtId = $("#districtId").val();
                    data.isPlatformCreate = $("input [type='radio']:checked").val();
                }
            },
            "columns": [
                {"data": "orderNumber"},
                {"data": "user.showName"},
                {"data": "curriculumName"},
                {"data": "cityName"},
                {"data": "number"},
                {"data": "price"},
                {"data": "payMethod"},
                {"data": "payStatus"},
                {"data": "createTime"},
            ],
            "columnDefs": [

                {
                    "render": function (data, type, row) {
                        if (data == 0) {
                            return "支付宝";
                        }
                        if (data == 1) {
                            return "微信";
                        }
                        if (data == 2) {
                            return "公众号支付";
                        }
                        if (data == 3) {
                            return "线下支付";
                        }
                        return "--";
                    },
                    "targets": 6
                },
                {
                    "render": function (data, type, row) {
                        if (data == 0) {
                            return "未支付";
                        }
                        if (data == 1) {
                            return "已支付";
                        }
                        return "--";
                    },
                    "targets": 7
                },
                {
                    "render": function (data, type, row) {
                        if (data == null || data == "") {
                            return "--";
                        }
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    },
                    "targets": 8
                },
                {
                    "render": function (data, type, row) {

                        var btn = "";
                        if (row.roleId == 2 || row.roleId == 3) {
                            btn += "";
                        }
                        return  "<button onclick='updateData(" + row.id + ")' class='layui-btn layui-btn-small hide checkBtn_59'><i class='fa fa-list fa-edit'></i>&nbsp;查看</button>"
                                + "<button onclick='goCurriculumAllocation(" + row.id + ")' class='layui-btn layui-btn-small hide checkBtn_82'><i class='fa fa-list fa-edit'></i>&nbsp;课程分配列表</button>"
                                + btn
                                ;
                    },
                    "targets": 9
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
            title: '创建订单',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/order/save"
        });
        layer.full(index);
    }

    //查看/修改数据
    function updateData(id) {
        //sessionStorage.setItem("curriculum", JSON.stringify(obj));
        var index = layer.open({
            type: 2,
            title: '订单详情',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/order/edit?id=" + id
        });
        layer.full(index);
    }


    //查看/修改数据
    function goCurriculumAllocation(id) {
        //sessionStorage.setItem("curriculum", JSON.stringify(obj));
        var index = layer.open({
            type: 2,
            title: '订单详情',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/curriculumAllocation/list?orderId=" + id
        });
        layer.full(index);
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
        selectProvince(0); //默认调用省

        getTradeList(0); //行业列表

    });


</script>
</body>
</head></html>
