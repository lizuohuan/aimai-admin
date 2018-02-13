<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>登录日志列表</title>

    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>
        .coverImg{width: 200px;height: 100px;border: 1px solid #eee;}
    </style>
<body>

<div class="admin-main">

    <blockquote class="layui-elem-quote">
        <fieldset class="layui-elem-field">
            <legend>高级筛选</legend>
            <div class="layui-field-box layui-form">
                <form class="layui-form" action="" id="formData">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">登录人</label>
                            <div class="layui-input-inline">
                                <input type="text" id="userName" lay-verify="" placeholder="请输入操作人" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">登录来源</label>
                            <div class="layui-input-inline">
                                <select name="roleId" id="source" lay-verify="required" lay-search>
                                    <option value="">请选择或搜索登录来源</option>
                                    <option value="0">移动端</option>
                                    <option value="1">微信</option>
                                    <option value="2">PC</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">创建的开始时间</label>
                            <div class="layui-input-inline">
                                <input type="text" id="startTimes"  readonly lay-verify="" placeholder="请输入开始时间" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">创建的结束时间</label>
                            <div class="layui-input-inline">
                                <input type="text" id="endTimes"  readonly lay-verify="" placeholder="请输入结束时间" autocomplete="off" class="layui-input" maxlength="20">
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
        <legend>登录日志列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend></legend>
        <div class="layui-field-box layui-form">

            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>登录人</th>
                        <th>登录来源</th>
                        <%--<th>内容</th>--%>
                        <th>登录时间</th>
                        <%--<th>操作</th>--%>
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
                url: AM.ip + "/loginLog/list",
                headers: {
                    "token" : AM.getUserInfo() == null ? null : AM.getUserInfo().token,
                },
                "dataSrc": function(json) {
                    console.log(json);
                    if (json.code == 200) {
                        return json.data;
                    }
                    return [];
                },
                "data": function(data) {
                    //高级查询参数
                    data.userName = $("#userName").val();
                    data.source = $("#source").val();
                    data.startTimes = $("#startTimes").val();
                    data.endTimes = $("#endTimes").val();
                }
            },
            "columns": [
                { "data": "userName" },
                { "data": "source" },
                // { "data": "content" },
                { "data": "createTime" },
            ],
            "columnDefs": [
                {
                    "render": function (data, type, row) {
                        if (null == data) {
                            return "--";
                        }
                        return data;

                    },
                    "targets": 0
                },
                {
                    "render": function(data, type, row) {
                        if (null == data) {
                            return "--";
                        }
                        if (data == 0) {
                            return "移动端";
                        }
                        if (data == 1) {
                            return "微信";
                        }
                        if (data == 2) {
                            return "PC";
                        }
                        return data;
                    },
                    "targets": 1
                },
                // {
                //     "render": function(data, type, row) {
                //         if (null == data || data == "") return "--";
                //         return data;
                //     },
                //     "targets": 2
                // },
                {
                    "render": function(data, type, row) {
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    },
                    "targets": 2
                },
                /*{
                    "render": function(data, type, row) {
                        var btn = "";
                        return "<button onclick='updateData(" + row.id + ")' class='layui-btn layui-btn-small hide checkBtn_63'><i class='fa fa-list fa-edit'></i>&nbsp;查看/修改</button>"
                                + "<button onclick='deleteNews(" + row.id +")' class='layui-btn layui-btn-small layui-btn-danger hide checkBtn_88'><i class='fa fa-list fa-edit'></i>&nbsp;删除</button>"
                                + btn
                                ;
                    },
                    "targets": 4
                },*/
            ]
        } );

        $("#search").click(function(){
            dataTable.ajax.reload();
            return false;
        });

    } );

    //提供给子页面
    var closeNodeIframe = function () {
        dataTable.ajax.reload();
        var index = layer.load(1, {shade: [0.5,'#eee']});
        setTimeout(function () {layer.close(index);}, 600);
    }

    layui.use(['form', 'layedit', 'laydate'], function() {
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
        // getRoleList(0); //角色列表
    });

    //删除新闻资讯
   /* function deleteNews(id) {
        var index = layer.confirm("是否删除此新闻资讯", {
            btn: ['确认', '取消'] //按钮
        }, function () {
            var arr = {
                id: id
            }
            AM.ajaxRequestData("post", false, AM.ip + "/news/delete", arr, function (result) {
                if (result.flag == 0 && result.code == 200) {
                    dataTable.ajax.reload();
                    layer.close(index);
                }
            });
        }, function () {
        });
    }*/

</script>
</body>
</html>
