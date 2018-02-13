<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>用户课程列表</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>

<body>

<div class="admin-main">
    <input type="text" name="userId" id="userId" lay-verify="" value="${userId}" style="display: none;">
    <fieldset class="layui-elem-field">
        <legend>用户课程列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend>
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
                    <th>课程名称</th>
                    <th>学习进度</th>
                    <th>学习开始时间</th>
                    <th>学习完成时间</th>
                    <th>是否通过</th>
                    <th>是否有试卷</th>
                    <th>课程状态</th>
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
                url: AM.ip + "/curriculum/listForAdminUser",
                "dataSrc": function (json) {
                    console.log(json);
                    if (json.code == 200) {
                        return json.data;
                    }
                    return [];
                },
                "data": function (data) {
                    //高级查询参数
                    data.userId = $("#userId").val();
                }
            },
            "columns": [
                {"data": "curriculumName"},
                {"data": "hdSeconds"},
                {"data": "studyStartTime"},
                {"data": "studyEndTime"},
                {"data": "isPass"},
                {"data": "isHavePaper"},
                {"data": "studyStatus"},
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
                        if (data == null || data == "") {
                            return "--";
                        }
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    },
                    "targets": 3
                },
                {
                    "render": function (data, type, row) {
                        if (data == null) {
                            return "--";
                        } else {
                            if (data == 1) {
                                return "是";
                            } else {
                                return "否";
                            }
                        }


                    },
                    "targets": 4
                },
                {
                    "render": function (data, type, row) {
                        if (data == null) {
                            return "--";
                        } else {
                            if (data == 1) {
                                return "有";
                            } else {
                                return "无";
                            }
                        }


                    },
                    "targets": 5
                },
                {
                    "render": function (data, type, row) {
                        if (data == null) {
                            return "--";
                        } else {
                            if (data == 1) {
                                return "可学习";
                            } else if(data == 0) {
                                return "停止";
                            } else {
                                return "暂停";
                            }
                        }


                    },
                    "targets": 6
                },
                {
                    "render": function (data, type, row) {

                        var isPass = 0;
                        var isPassMsg = "不通过";
                        if (row.isPass == 0) {
                            isPass = 1;
                            isPassMsg = "通过";
                        }

                        var userId = $("#userId").val();
                        var btn = "";

                        if (row.isHavePaper == null || row.isHavePaper == "") {
                            btn += "<button onclick='updateOrSaveIsPass(" + row.parId + "," + row.orderId + "," + isPass + ")' class='layui-btn layui-btn-small hide checkBtn_102'><i class='fa fa-list fa-edit'></i>&nbsp;"+isPassMsg+"</button>";
                        }
                        if (null == row.studyStatus || row.studyStatus == 1) {
                            btn += "<button onclick='updateStudyStatus(" + userId + "," + row.orderId + "," + row.buyType + ",0)' class='layui-btn layui-btn-danger layui-btn-small hide checkBtn_103'><i class='fa fa-list fa-edit'></i>&nbsp;终止课程</button>";
                            btn += "<button onclick='updateStudyStatus(" + userId + "," + row.orderId + "," + row.buyType + ",2)' class='layui-btn layui-btn-warm layui-btn-small hide checkBtn_105'><i class='fa fa-list fa-edit'></i>&nbsp;暂停课程</button>";
                        } else if (row.studyStatus == 0) {
                            btn += "<button onclick='updateStudyStatus(" + userId + "," + row.orderId + "," + row.buyType + ",1)' class='layui-btn layui-btn-normal layui-btn-small hide checkBtn_104'><i class='fa fa-list fa-edit'></i>&nbsp;恢复学习</button>";
                            btn += "<button onclick='updateStudyStatus(" + userId + "," + row.orderId + "," + row.buyType + ",2)' class='layui-btn layui-btn-warm layui-btn-small hide checkBtn_105'><i class='fa fa-list fa-edit'></i>&nbsp;暂停课程</button>";
                        } else {
                            btn += "<button onclick='updateStudyStatus(" + userId + "," + row.orderId + "," + row.buyType + ",1)' class='layui-btn layui-btn-normal layui-btn-small hide checkBtn_104'><i class='fa fa-list fa-edit'></i>&nbsp;恢复学习</button>";
                            btn += "<button onclick='updateStudyStatus(" + userId + "," + row.orderId + "," + row.buyType + ",0)' class='layui-btn layui-btn-danger layui-btn-small hide checkBtn_103'><i class='fa fa-list fa-edit'></i>&nbsp;终止课程</button>";
                        }


                        return "<button onclick='goUserCourseWareList(" + row.id + "," + row.orderId +")' class='layui-btn layui-btn-small hide checkBtn_41'><i class='fa fa-list fa-edit'></i>&nbsp;课件列表</button>"
                                + btn
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

    
    var updateOrSaveIsPass = function (curriculumId,parId,orderId,isPass) {

        var url;

        var passScore = 0;
        var resultScore = 0;
        if (isPass == 0) {
            passScore = 1;
        } else {
            resultScore = 0;
        }
        var arr = new Array();
        if (null != parId && "" != parId) {
            url = AM.ip + "/paperRecord/updateIsPass";
            arr = {
                id : parId,
                passScore : passScore,
                resultScore : resultScore
            }
        } else {
            url = AM.ip + "/paperRecord/save";
            arr = {
                paperId : curriculumId,
                passScore : passScore,
                resultScore : resultScore,
                orderId : orderId,
                type : 1,
                userId : $("#userId").val()
            }
        }
        AM.ajaxRequestData("post", false, url, arr, function (result) {
            if (result.flag == 0 && result.code == 200) {
                dataTable.ajax.reload();
                layer.close(index);
            }
        });
        
    }

    var updateStudyStatus = function (userId,orderId,buyType,studyStatus) {

        var url;
        var arr = new Array();
        if (buyType == 0) {
            url = AM.ip + "/order/updateIsCanStudy"
            arr = {
                id : orderId,
                studyStatus : studyStatus
            }
        } else {
            url = AM.ip + "/curriculumAllocation/updateIsCanStudy"
            arr = {
                userId : userId,
                orderId : orderId,
                studyStatus : studyStatus
            }
        }
        AM.ajaxRequestData("post", false, url, arr, function (result) {
            if (result.flag == 0 && result.code == 200) {
                dataTable.ajax.reload();
                layer.close(index);
            }
        });

    }
    
    //提供给子页面
    var closeNodeIframe = function () {
        dataTable.ajax.reload();
        var index = layer.load(1, {shade: [0.5, '#eee']});
        setTimeout(function () {
            layer.close(index);
        }, 600);
    }



    //查看用户的课程课件
    function goUserCourseWareList(curriculumId,orderId) {
        var index = layer.open({
            type: 2,
            title: '用户课时列表',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/userCourseWare/list?curriculumId=" + curriculumId + "&orderId="+orderId + "&userId="+$("#userId").val()
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
