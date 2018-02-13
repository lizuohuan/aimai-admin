<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>课程列表</title>
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
                            <label class="layui-form-label">行业名称</label>
                            <div class="layui-input-inline">
                                <select name="tradeId" id="tradeId" lay-search>
                                    <option value="">请选择或搜索行业</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">发布人</label>
                            <div class="layui-input-inline">
                                <input type="text" id="releaseUserName" lay-verify="" placeholder="请输入发布人" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">培训阶段</label>
                            <div class="layui-input-inline">
                                <select name="curriculumStageId" id="curriculumStageId" lay-verify="required" lay-search>
                                    <option value="">请选择或搜索培训阶段</option>
                                    <option value="1">初训</option>
                                    <option value="2">复训</option>
                                    <option value="3">全培</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">发布的开始时间</label>
                            <div class="layui-input-inline">
                                <input type="text" id="releaseTimeStarts"  readonly lay-verify="" placeholder="请输入开始时间" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">发布的结束时间</label>
                            <div class="layui-input-inline">
                                <input type="text" id="releaseTimeEnds"  readonly lay-verify="" placeholder="请输入结束时间" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">是否发布</label>
                            <div class="layui-input-inline">
                                <select name="curriculumStageId" id="releaseStatus" lay-verify="required" lay-search>
                                    <option value="">请选择或搜索是否发布</option>
                                    <option value="0">未发布</option>
                                    <option value="1">已发布</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">是否推荐</label>
                            <div class="layui-input-inline">
                                <select name="curriculumStageId" id="isRecommend" lay-verify="required" lay-search>
                                    <option value="">请选择或搜索是否推荐</option>
                                    <option value="0">未推荐</option>
                                    <option value="1">已推荐</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">课程类型</label>
                            <div class="layui-input-inline">
                                <select name="curriculumStageId" id="type" lay-verify="required" lay-search>
                                    <option value="">请选择或搜索课程类型</option>
                                    <option value="0">试听课程</option>
                                    <option value="1">收费课程</option>
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
        <legend>课程列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend>
        </legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <button onclick="addData()" class="layui-btn layui-btn layui-btn-small layui-btn-normal hide checkBtn_25"><i class="layui-icon">
                    &#xe608;</i> 添加课程
                </button>
            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>课程编号</th>
                    <th class="nosort">封面图-横</th>
                    <th class="nosort">封面图-竖</th>
                    <th class="nosort">课程名</th>
                    <th class="nosort">行业名称</th>
                    <th class="nosort">培训阶段</th>
                    <th class="nosort">课程类型</th>
                    <th class="nosort">发布人</th>
                    <th class="nosort">是否收费</th>
                    <th class="nosort">发布状态</th>
                    <th class="nosort">是否有效</th>
                    <th class="nosort">是否是推荐课程</th>
                    <th class="nosort">单价</th>
                    <th class="nosort">发布时间</th>
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
            "bLengthChange": false, "bSort": true, //关闭排序功能
            "sPaginationType" : "full_numbers",
//            "bSortClasses": true,
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
                url: AM.ip + "/curriculum/list",
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
                    data.tradeId = $("#tradeId").val();
                    data.releaseUserName = $("#releaseUserName").val();
                    data.curriculumStageId = $("#curriculumStageId").val();
                    data.releaseTimeStarts = $("#releaseTimeStarts").val();
                    data.releaseTimeEnds = $("#releaseTimeEnds").val();
                    data.provinceId = $("#provinceId").val();
                    data.cityId = $("#cityId").val();
                    data.districtId = $("#districtId").val();
                    data.type = $("#type").val();
                    data.releaseStatus = $("#releaseStatus").val();
                    data.isRecommend = $("#isRecommend").val();
                }
            },
            "columns": [
                {"data": "sortNum","field":"sortNum" },
                {"data": "cover" },
                {"data": "coverH" },
                {"data": "curriculumName"},
                {"data": "tradeName"},
                {"data": "stageName"},
                {"data": "typeName"},
                {"data": "releaseUserName"},
                {"data": "type"},
                {"data": "releaseStatus"},
                {"data": "isValid"},
                {"data": "isRecommend"},
                {"data": "price"},
                {"data": "releaseTime","field":"c.releaseTime"},
            ],
            "columnDefs": [
                {
                    "targets": 'nosort',  //列的样式名
                    "orderable": false    //包含上样式名‘nosort’的禁止排序
                },
                {
                    "render": function (data, type, row) {
                        if (null != data) {
                            return "<img height='auto' width='100' src='"+ AM.ipImg + "/" + data + "'>";
                        } else {
                            return "";
                        }

                    },
                    "targets": 1
                },
                {
                    "render": function (data, type, row) {
                        if (null != data) {
                            return "<img height='auto' width='100' src='"+ AM.ipImg + "/" + data + "'>";
                        } else {
                            return "";
                        }

                    },
                    "targets": 2
                },
                {
                    "render": function (data, type, row) {
                        if (data == null || data == "") return "--";
                        else return data;

                    },
                    "targets": 7
                },
                {
                    "render": function (data, type, row) {
                        if (data == 0) return "试听课程";
                        else if (data == 1) return "收费课程";
                        else return "--";

                    },
                    "targets": 8
                },
                {
                    "render": function (data, type, row) {

                        if (data == 0) return "未发布";
                        else if (data == 1) return "已发布";
                        else return "--";
                    },
                    "targets": 9
                },
                {
                    "render": function (data, type, row) {
                        if (data == 0) return "无效";
                        else if (data == 1) return "有效";
                        else return "--";
                    },
                    "targets": 10
                },
                {
                    "render": function (data, type, row) {
                        if (data == 0) return "否";
                        else if (data == 1) return "是";
                        else return "--";
                    },
                    "targets": 11
                },
                {
                    "render": function (data, type, row) {
                        return "<span class=\"money\">￥&nbsp;" + data + "</span>";
                    },
                    "targets": 12
                },
                {
                    "render": function (data, type, row) {
                        if (data == null || data == "") {
                            return "--";
                        }
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    },
                    "targets": 13
                },
                {
                    "render": function (data, type, row) {
                        var obj = JSON.stringify(row);
                        //发布状态 0:未发布  1:已发布
                        var releaseStatus = 0;
                        var releaseStatusMsg = "取消发布课程";
                        if (row.releaseStatus == 0) {
                            releaseStatus = 1;
                            releaseStatusMsg = "发布课程";
                        }
                        var btn = "";
                        if (row.type == 1) {
                            var isRecommendMsg = "取消推荐";
                            var isRecommend = 0;
                            if (row.isRecommend == 0) {
                                isRecommendMsg = "推荐";
                                isRecommend = 1;
                            }
                            btn += "<button onclick='updateRecommend(" + row.id + "," + isRecommend + ")' class='layui-btn layui-btn-small  hide checkBtn_29'><i class='fa fa-list fa-edit'></i>&nbsp;"+isRecommendMsg+"</button>";
                        }

                        btn += "<button onclick='updateIsValid(" + row.id + ")' class='layui-btn layui-btn-small layui-btn-danger  hide checkBtn_91'><i class='fa fa-list fa-edit'></i>&nbsp;删除</button>";

                        return    "<button onclick='updateData(" + obj + ")' class='layui-btn layui-btn-small hide checkBtn_26'><i class='fa fa-list fa-edit'></i>&nbsp;查看/修改</button>"
                                + "<button onclick='adoptToExamine(" + row.id + "," + releaseStatus + ")' class='layui-btn layui-btn-small layui-btn-warm hide checkBtn_27'><i class='fa fa-list fa-edit'></i>&nbsp;"+ releaseStatusMsg +"</button>"
                                + "<button onclick='goCourseWareData(" + row.id + ")' class='layui-btn layui-btn-small hide checkBtn_28'><i class='fa fa-list fa-edit'></i>&nbsp;查看课时</button>"
//                                + "<button onclick='deleteCurriculum(" + row.id + ")' class='layui-btn layui-btn-small layui-btn-danger hide checkBtn_91'><i class='fa fa-list fa-edit'></i>&nbsp;删除</button>"
                                + btn
                                ;
                    },
                    "targets": 14
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

    //删除课程
    function deleteCurriculum(id) {
        var index = layer.confirm("删除此课程，同时也将删除课程下所有课时和视频，且无法恢复，请谨慎操作，是否删除？", {
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


    //添加
    function addData() {
        var index = layer.open({
            type: 2,
            title: '添加课程',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/curriculum/save"
        });
        layer.full(index);
    }

    //查看/修改数据
    function updateData(obj) {
        //sessionStorage.setItem("curriculum", JSON.stringify(obj));
        var index = layer.open({
            type: 2,
            title: '修改课程',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/curriculum/edit?id=" + obj.id
        });
        layer.full(index);
    }
    //进入课件列表
    function goCourseWareData(id) {
        //sessionStorage.setItem("curriculum", JSON.stringify(obj));
        var index = layer.open({
            type: 2,
            title: '课件列表',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/courseWare/list?id=" + id
        });
        layer.full(index);
    }

    //修改课程发布状态
    function adoptToExamine(id ,releaseStatus) {
        var releaseStatusMsg = "是否确认发布?";
        if (releaseStatus == 0) {
            releaseStatusMsg = "是否取消发布";
        }
        var index = layer.confirm(releaseStatusMsg, {
            btn: ['确认', '取消'] //按钮
        }, function () {
            var arr = {
                id: id,
                releaseStatus: releaseStatus
            }
            AM.ajaxRequestData("post", false, AM.ip + "/curriculum/updateReleaseStatus", arr, function (result) {
                if (result.flag == 0 && result.code == 200) {
                    dataTable.ajax.reload();
                    layer.close(index);
                }
            });
        }, function () {
        });
    }



    //修改课程发布状态
    function updateRecommend(id ,isRecommend) {
        var isRecommendMsg = "是否取消推荐";
        if (isRecommend == 1) {
            isRecommendMsg = "是否确认推荐";
        }
        var index = layer.confirm(isRecommendMsg, {
            btn: ['确认', '取消'] //按钮
        }, function () {
            var arr = {
                id: id,
                isRecommend: isRecommend
            }
            AM.ajaxRequestData("post", false, AM.ip + "/curriculum/updateRecommend", arr, function (result) {
                if (result.flag == 0 && result.code == 200) {
                    dataTable.ajax.reload();
                    layer.close(index);
                }
            });
        }, function () {
        });
    }



    //修改课程是否有效
    function updateIsValid(id) {
        var index = layer.confirm("是否删除此课程？", {
            btn: ['确认', '取消'] //按钮
        }, function () {
            var arr = {
                id: id,
                isValid: 0
            }
            AM.ajaxRequestData("post", false, AM.ip + "/curriculum/updateIsValid", arr, function (result) {
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

        document.getElementById('releaseTimeStarts').onclick = function(){
            start.elem = this;
            laydate(start);
        }
        document.getElementById('releaseTimeEnds').onclick = function(){
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

    });


</script>
</body>
</head></html>
