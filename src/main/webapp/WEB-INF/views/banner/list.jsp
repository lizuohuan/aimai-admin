<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>banner列表</title>

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
                            <label class="layui-form-label">标题</label>
                            <div class="layui-input-inline">
                                <input type="text" id="title" lay-verify="" placeholder="请输入标题" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
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
                        <div class="layui-inline">
                            <label class="layui-form-label">责任编辑人</label>
                            <div class="layui-input-inline">
                                <input type="text" id="editor" lay-verify="" placeholder="请输入标题" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">到期开始时间</label>
                            <div class="layui-input-inline">
                                <input type="text" id="validityStartTimes"  readonly lay-verify="" placeholder="请输入开始时间" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">到期结束时间</label>
                            <div class="layui-input-inline">
                                <input type="text" id="validityEndTimes"  readonly lay-verify="" placeholder="请输入结束时间" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">类型</label>
                            <div class="layui-input-inline">
                                <select name="isBanner" id="isBanner" lay-verify="required" lay-search>
                                    <option value="">请选择类型</option>
                                    <option value="0">PC广告</option>
                                    <option value="1">banner</option>
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
        <legend>banner列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend></legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <button onclick="addData()" class="layui-btn layui-btn layui-btn-small layui-btn-normal hide checkBtn_60"><i class="layui-icon">&#xe608;</i> 添加banner</button>
            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>移动端banner图</th>
                        <th>PC端banner图</th>
                        <th>标题</th>
                        <th>责任编辑人</th>
                        <th>有效期</th>
                        <th>创建时间</th>
                        <th>来源</th>
                        <th>是否是外链</th>
                        <th>外链地址</th>
                        <th>类型</th>
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
                url: AM.ip + "/banner/list",
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
                    data.title = $("#title").val();
                    data.editor = $("#editor").val();
                    data.startTimes = $("#startTimes").val();
                    data.endTimes = $("#endTimes").val();
                    data.validityStartTimes = $("#validityStartTimes").val();
                    data.validityEndTimes = $("#validityEndTimes").val();
                    data.isBanner = $("#isBanner").val();
                }
            },
            "columns": [
                { "data": "apiImage" },
                { "data": "pcImage" },
                { "data": "title" },
                { "data": "editor" },
                { "data": "validity" },
                { "data": "createTime" },
                { "data": "source" },
                { "data": "isLink" },
                { "data": "linkUrl" },
                { "data": "isBanner" },
            ],
            "columnDefs": [
                {
                    "render": function (data, type, row) {
                        if (null != data) {
                            return "<img height='auto' width='100' src='"+ AM.ipImg + "/" + data + "'>";
                        } else {
                            return "";
                        }

                    },
                    "targets": 0
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
                    "render": function(data, type, row) {
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    },
                    "targets": 4
                },
                {
                    "render": function(data, type, row) {
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    },
                    "targets": 5
                },
                {
                    "render": function(data, type, row) {
                        if (null == data) return "--";
                        if (data == 0) return "否";
                        if (data == 1) return "是";
                    },
                    "targets": 7
                },
                {
                    "render": function(data, type, row) {
                        if (null == data || data == "") {return "--"} else {return data};
                    },
                    "targets": 8
                },
                {
                    "render": function(data, type, row) {
                        if (null == data) return "--";
                        if (data == 0) return "PC广告";
                        if (data == 1) return "banner";
                    },
                    "targets": 9
                },
                {
                    "render": function(data, type, row) {
                        var btn = "";
                        return "<button onclick='updateData(" + row.id + ")' class='layui-btn layui-btn-small hide checkBtn_61'><i class='fa fa-list fa-edit'></i>&nbsp;查看/修改</button>"
                                + "<button onclick='delBanner(" + row.id + ")' class='layui-btn layui-btn-danger layui-btn-small hide checkBtn_74'><i class='fa fa-list fa-edit'></i>&nbsp;删除</button>"
                                + btn
                                ;
                    },
                    "targets": 10
                },
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

    //添加
    function addData () {
        var index = layer.open({
            type: 2,
            title: '添加banner',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/banner/add"
        });
        layer.full(index);
    }

    //查看/修改数据
    function updateData(id) {
        var index = layer.open({
            type: 2,
            title: '修改banner',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/banner/edit?id=" + id
        });
        layer.full(index);
    }

    //修改状态
    function updateStatus(id, isShow) {
        var index = layer.load(1, {
            shade: [0.1,'#fff'] //0.1透明度的白色背景
        });
        var arr = {
            id : id,
            isShow : isShow
        }
        AM.ajaxRequestData("post", false, AM.ip + "/banner/update", arr  , function(result) {
            if (result.flag == 0 && result.code == 200) {
                dataTable.ajax.reload();
                layer.close(index);
            }
        });
    }

    //审核通过确认发布
    function adoptToExamine (id) {
        var index = layer.load(1, {shade: [0.5,'#eee']});
        var index2 = layer.confirm('是否确认发布？', {
            btn: ['确认','取消'] //按钮
        }, function(){
            var arr = {
                id : id,
                status : 1
            }
            AM.ajaxRequestData("post", false, AM.ip + "/banner/updateStatus", arr , function(result) {
                if (result.flag == 0 && result.code == 200) {
                    dataTable.ajax.reload();
                    layer.close(index);
                    layer.close(index2);
                }
            });
        }, function(){layer.close(index);});
    }

    //删除
    function delBanner (id) {
        var index = layer.load(1, {shade: [0.5,'#eee']});
        var index2 = layer.confirm('是否确认删除？', {
            btn: ['确认','取消'] //按钮
        }, function(){
            var arr = {
                id : id
            }
            AM.ajaxRequestData("post", false, AM.ip + "/banner/delete", arr , function(result) {
                if (result.flag == 0 && result.code == 200) {
                    dataTable.ajax.reload();
                    layer.close(index);
                    layer.close(index2);
                }
            });
        }, function(){layer.close(index);});
    }

    layui.use(['form', 'layedit', 'laydate'], function() {
        form = layui.form(),
                layer = layui.layer,
                laydate = layui.laydate;
        
        form.on("switch(isShow)", function (data) {
            console.log(data);
            var bannerId = $(this).attr("bannerId");
            if (data.elem.checked) {
                updateStatus(bannerId, 1);
            }
            else {
                updateStatus(bannerId, 0);
            }
            form.render();
        });

        var validityStartTimes = {
            max: '2099-06-16 23:59:59'
            ,format: 'YYYY-MM-DD hh:mm:ss'
            ,istoday: false
            ,choose: function(datas){
                validityEndTimes.min = datas; //开始日选好后，重置结束日的最小日期
                validityEndTimes.start = datas //将结束日的初始值设定为开始日
            }
        };

        var validityEndTimes = {
            max: '2099-06-16 23:59:59'
            ,format: 'YYYY-MM-DD hh:mm:ss'
            ,istoday: false
            ,choose: function(datas){
                validityStartTimes.max = datas; //结束日选好后，重置开始日的最大日期
            }
        };

        document.getElementById('validityStartTimes').onclick = function(){
            validityStartTimes.elem = this;
            laydate(validityStartTimes);
        }
        document.getElementById('validityEndTimes').onclick = function(){
            validityEndTimes.elem = this
            laydate(validityEndTimes);
        }

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
    });


</script>
</body>
</html>
