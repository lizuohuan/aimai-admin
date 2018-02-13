<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>未分配用户列表</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>
        .preview{height: 250px;width: 400px;margin-right: 10px;margin-bottom: 10px;float: left;text-align: center}
        .preview img{width: 100%;height:210px;border: 1px solid #eee;}

    </style>
</head>
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
                                <input type="text" id="phone" lay-verify="" placeholder="请输入手机号" autocomplete="off" class="layui-input" maxlength="20">
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
        <legend>未分配用户列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend></legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <button lay-submit="" lay-filter="submitWork" class="layui-btn layui-btn-small layui-btn-default hide checkBtn_86" onclick="passSelected()">分配已选用户</button>
            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th width="200"><input type="checkbox" name="" lay-skin="primary" lay-filter="allChoose" title="勾选本页"></th>
                    <th>用户名</th>
                    <th>手机号</th>
                </tr>
                </thead>
            </table>
        </div>
    </fieldset>
    <input type="hidden" id="orderId" value="${orderId}">
</div>
<!--引入抽取公共js-->
<%@include file="../common/public-js.jsp" %>
<script>

    var form = null;
    var dataTable = null;
    $(document).ready(function() {
        dataTable = $('#dataTable').DataTable( {
            "searching": false,"bStateSave": true, //状态保存，使用了翻页或者改变了每页显示数据数量，会保存在cookie中，下回访问时会显示上一次关闭页面时的内容。
            "processing": true,
            "serverSide": true,
            "bLengthChange": false,"bSort": false, //关闭排序功能
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
                    'first':      '第一页',
                    'last':       '最后一页',
                    'next':       '下一页',
                    'previous':   '上一页'
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
            "ajax":  {
                url: AM.ip + "/user/findUserByPhone2",
                "dataSrc": function(json) {
                    console.log(json);
                    if (json.code == 200) {
                        return json.data;
                    }
                    return [];
                },
                "data": function(data) {
                    //高级查询参数
                    data.phone = $("#phone").val();
                    data.orderId = $("#orderId").val();
                }
            },
            "columns": [
                { "data": "" },
                { "data": "showName" },
                { "data": "phone" },
            ],
            "columnDefs": [
                {
                    "render": function(data, type, row) {
                        return "<input  type=\"checkbox\" name=\"\" value=\"" + row.id + "\"  lay-skin=\"primary\" title=\"勾选\">";
                    },
                    "targets": 0
                },{
                    "render": function(data, type, row) {
                        if (null == data) {return "--"}
                        else {
                            return data;
                        }

                    },
                    "targets": 1
                },

            ]
        } );

        $("#search").click(function(){
            dataTable.ajax.reload();
            return false;
        });
    } );

    layui.use(['form', 'layedit', 'laydate'], function() {
        form = layui.form(),
                layer = layui.layer,
                laydate = layui.laydate;
        //全选
        form.on('checkbox(allChoose)', function(data){
            var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]');
            child.each(function(index, item){
                item.checked = data.elem.checked;
            });
            form.render('checkbox');
        });

    });


    //分配用户
    var passSelected = function () {
        form.on('submit(submitWork)', function(data){
            var child = $("#dataTable").find('tbody input[type="checkbox"]');
            var curriculumAllocations = [];
            var orderId = $("#orderId").val();
            child.each(function(){
                if ($(this).is(':checked')) {
                    var userId = $(this).val();
                    var obj = {
                        userId : userId,
                        number : 1
                    }
                    curriculumAllocations.push(obj);
                }
            });
            if (curriculumAllocations.length == 0) {
                layer.msg('至少勾选一个.', {icon: 2, anim: 6});
                return false;
            }


            else {
                console.log("******************");
                console.log(curriculumAllocations);
                console.log("************");
                var arr = {
                    curriculumAllocations : JSON.stringify(curriculumAllocations),
                    orderId:$("#orderId").val()
                }
                AM.ajaxRequestData("post", false, AM.ip + "/curriculumAllocation/bind", arr, function(result){
                    if(result.flag == 0 && result.code == 200){
                        layer.alert('设置成功.', {
                            skin: 'layui-layer-molv' //样式类名
                            ,closeBtn: 0
                            ,anim: 3 //动画类型
                        }, function(){
                            //关闭iframe页面
                            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                            parent.layer.close(index);
                            window.parent.closeNodeIframe();
                        });
                    }
                });
            }
        });
        //layer.msg('等我开发.', {icon: 1});
    }

</script>
</body>
</html>
