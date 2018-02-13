<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>用户考试记录列表</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>

<body>

<div class="admin-main">
    <input type="text" name="userId" id="userId" lay-verify="" value="${userId}" style="display: none;">
    <fieldset class="layui-elem-field">
        <legend>用户考试记录列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend>
        </legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <button onclick="addData()" class="layui-btn layui-btn layui-btn-small layui-btn-normal"><i class="layui-icon">
                    &#xe608;</i> 新增考试记录
                </button>
            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>考试名称</th>
                    <th>考试时间</th>
                    <th>用时</th>
                    <th>课程名</th>
                    <th>此次考试得分</th>
                    <th>及格分数</th>
                    <th>是否通过</th>
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
                url: AM.ip + "/paperRecord/list",
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
                {"data": "paperTitle"},
                {"data": "createTime"},
                {"data": "seconds"},
                {"data": "curriculumName"},
                {"data": "resultScore"},
                {"data": "passScore"},
                {"data": ""},
            ],
            "columnDefs": [
                {
                    "render": function (data, type, row) {
                        if (data == null || data == "") {
                            return "--";
                        }
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    },
                    "targets": 1
                },
                {
                    "render": function (data, type, row) {
                        if (row.resultScore >= row.passScore) {
                            return "是";
                        } else {
                            return "否";
                        }
                    },
                    "targets": 6
                },
                {
                    "render": function (data, type, row) {
                        var btn = "";
                        return "<button onclick='updateIsPass(" + row.id + ")' class='layui-btn layui-btn-small hide checkBtn_81'><i class='fa fa-list fa-edit'></i>&nbsp;设置分数</button>"
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

    //提供给子页面
    var closeNodeIframe = function () {
        dataTable.ajax.reload();
        var index = layer.load(1, {shade: [0.5, '#eee']});
        setTimeout(function () {
            layer.close(index);
        }, 600);
    }



    //查看/修改数据
    function updateIsPass(id) {
        var html = '<form class="layui-form" action="" style="height: 100px;">' +
                '<div class="layui-form-item">' +
                '<div class="layui-inline">' +
                '<label class="layui-form-label">设置分数</label>' +
                '<div class="layui-input-inline">' +
                '<input type="text"  onkeydown=if(event.keyCode==13)event.keyCode=9 onkeyup="value=value.replace(/[^0-9- ]/g,\'\');"  id="score" lay-verify="" placeholder="设置分数" autocomplete="off" maxlength="3" class="layui-input">' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</form>';


        var index = layer.confirm(html, {
            btn: ['确认','取消'],
            title: "导入用户",
            area: ["600px", "100px"], //宽高
        }, function () {
            if ($("#score").val() == "") {
                layer.msg('请输入分数.', {icon: 2, anim: 6});
                $("#score").focus();
                return false;
            }
            var arr={
                id:id,
                resultScore:$("#score").val()
            }
            AM.ajaxRequestData("post", false, AM.ip + "/paperRecord/updateIsPass", arr  , function(result) {
                if (result.flag == 0 && result.code == 200) {
                    var index = layer.alert('操作成功.', {
                        skin: 'layui-layer-molv' //样式类名
                        ,closeBtn: 0
                        ,anim: 3 //动画类型
                    }, function(){
                        layer.close(index);
                        dataTable.ajax.reload();
                    });
                }
            });
            layer.close(index);
        }, function () {

        });

    }


    layui.use(['form', 'layedit', 'laydate'], function () {
        form = layui.form(),
                layer = layui.layer,
                laydate = layui.laydate;

    });


    var paperId;
    var orderId;

    //查看/修改数据
    function addData() {
        var html = '<form class="layui-form" action="" style="height: 200px;">' +
            '<div class="layui-form-item">' +

            '<div class="layui-inline">' +
            '<label class="layui-form-label">选择课程</label>' +
            '<div class="layui-input-inline">' +
            '<select name="curriculumId" id="curriculumId" lay-filter="curriculumId" lay-verify="required" lay-search>' +
            '<option value="">请选择选择课程</option>' +
            '</select>' +
            '</div>' +
            '</div>' +

            '<div class="layui-inline">' +
            '<label class="layui-form-label">及格分数</label>' +
            '<div class="layui-input-inline">' +
            '<input type="text" readonly id="passScore" lay-verify="" placeholder="及格分数" autocomplete="off" maxlength="3" class="layui-input">' +
            '</div>' +
            '</div>' +

            '<div class="layui-inline">' +
            '<label class="layui-form-label">设置分数</label>' +
            '<div class="layui-input-inline">' +
            '<input type="text"  onkeydown=if(event.keyCode==13)event.keyCode=9 ' +
            'onkeyup="value=value.replace(/[^0-9- ]/g,\'\');"  id="score2" lay-verify="" ' +
            'placeholder="设置分数" autocomplete="off" maxlength="3" class="layui-input">' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</form>';


        var index = layer.confirm(html, {
            btn: ['确认','取消'],
            title: "添加考试记录",
            area: ["600px", "100px"], //宽高
        }, function () {
            if ($("#curriculumId").val() == "") {
                layer.msg('请选择课程.', {icon: 2, anim: 6});
                $("#curriculumId").focus();
                return false;
            }
            if ($("#score2").val() == "") {
                layer.msg('请输入分数.', {icon: 2, anim: 6});
                $("#score2").focus();
                return false;
            }
            if ($("#passScore").val() > $("#score2").val()) {
                layer.msg('请输入大于或等于及格分数的分数.', {icon: 2, anim: 6});
                $("#score2").focus();
                return false;
            }

            var arr={
                passScore:$("#passScore").val(),
                orderId:orderId,
                paperId:paperId,
                type:0,
                userId:$("#userId").val(),
                resultScore:$("#score2").val()
            }
            AM.ajaxRequestData("post", false, AM.ip + "/paperRecord/save", arr  , function(result) {
                if (result.flag == 0 && result.code == 200) {
                    var index = layer.alert('操作成功.', {
                        skin: 'layui-layer-molv' //样式类名
                        ,closeBtn: 0
                        ,anim: 3 //动画类型
                    }, function(){
                        layer.close(index);
                        dataTable.ajax.reload();
                    });
                }
            });
            layer.close(index);
        }, function () {

        });

        getCurriculumId($("#userId").val());

        //监听省
        form.on('select(curriculumId)', function (data) {
            var index = data.elem.selectedIndex;
            paperId = data.elem.options[index].getAttribute("paperId");
            orderId = data.elem.options[index].getAttribute("orderId");
            $("#passScore").val(data.elem.options[index].getAttribute("passScore"));
            form.render();
        });

        form.render();
    }

    /**
     * 获取用户可添加考试记录的课程
     */
    var getCurriculumId = function (userId) {
        AM.ajaxRequestData("get", false, AM.ip + "/curriculum/getUserCurriculum", { userId : userId} , function(result){
            if(result.flag == 0 && result.code == 200){
                var html = "<option value=\"\">请选择课程</option>";
                for (var i = 0; i < result.data.length; i++) {
                    html += "<option" +
                        " passScore = "+ result.data[i].passScore +
                        " paperId = "+ result.data[i].paperId +
                        " orderId = "+ result.data[i].orderId +
                        " value=\"" + result.data[i].id + "\">" + result.data[i].curriculumName + "</option>";
                }
                if (result.data.length == 0) {
                    html += "<option value=\"0\" disabled>暂无</option>";
                }
                $("select[name='curriculumId']").html(html);
                $("select[name='curriculumId']").parent().parent().show();
                form.render();
            }
        });
    }

</script>
</body>
</head></html>
