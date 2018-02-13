<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>视频库</title>

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
                            <label class="layui-form-label">视频名</label>
                            <div class="layui-input-inline">
                                <input type="text" id="name" lay-verify="" placeholder="请输入视频名" autocomplete="off" class="layui-input" maxlength="20">
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
                        <%--<div class="layui-inline">
                            <label class="layui-form-label">课程名</label>
                            <div class="layui-input-inline">
                                <input type="text" id="curriculumName" lay-verify="" placeholder="请输入课程名" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">课时名</label>
                            <div class="layui-input-inline">
                                <input type="text" id="courseWareName" lay-verify="" placeholder="请输入课时名" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>--%>

                    </div>
                    <%--<div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">是否绑定</label>
                            <div class="layui-input-inline">
                                <select name="isBand" id="isBand" lay-verify="required" lay-search>
                                    <option value="">选择是否绑定</option>
                                    <option value="1">是</option>
                                    <option value="0">否</option>
                                </select>
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
                    </div>--%>
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
        <legend>视频库&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend></legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <button onclick="addData()" class="layui-btn layui-btn layui-btn-small layui-btn-normal hide checkBtn_76"><i class="layui-icon">&#xe608;</i> 添加视频到本地服务器</button>
                <button onclick='uploadData2()' class='layui-btn layui-btn-danger layui-btn-small hide checkBtn_108'><i class='fa fa-list fa-edit'></i>&nbsp;添加视频到云服务器</button>

            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>视频名</th>
                      <%--  <th>课时名</th>
                        <th>课程名</th>
                        <th>是否绑定</th>--%>
                        <th>创建时间</th>
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
                url: AM.ip + "/videoWareHouse/list",
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
                    data.curriculumName = $("#curriculumName").val();
                    data.courseWareName = $("#courseWareName").val();
                    data.startTimes = $("#startTimes").val();
                    data.endTimes = $("#endTimes").val();
                    data.name = $("#name").val();
                    data.isBand = $("#isBand").val();
                }
            },
            "columns": [
                { "data": "name" },
         /*       { "data": "curriculumName" },
                { "data": "courseWareName" },
                { "data": "isBand" },*/
                { "data": "createTime" },
            ],
            "columnDefs": [
               /* {
                    "render": function(data, type, row) {
                        if (null == data || data == "") return "--";
                        return data;
                    },
                    "targets": 1
                },
                {
                    "render": function(data, type, row) {
                        if (null == data || data == "") return "--";
                        return data;
                    },
                    "targets": 2
                },
                {
                    "render": function(data, type, row) {
                        if (null == data) return "--";
                        if (data == 0) return "否";
                        if (data == 1) return "是";
                    },
                    "targets": 3
                },*/
                {
                    "render": function(data, type, row) {
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    },
                    "targets": 1
                },
                {
                    "render": function(data, type, row) {
                        var btn = "";
                        if (row.isBand == 0) {
                            btn+="<button onclick='delVideo(" + row.id + ")' class='layui-btn layui-btn-danger layui-btn-small hide checkBtn_79'><i class='fa fa-list fa-edit'></i>&nbsp;删除</button>";
                        }
                        // btn+="<button onclick='uploadData(" + row.id + ")' class='layui-btn layui-btn-danger layui-btn-small hide checkBtn_78'><i class='fa fa-list fa-edit'></i>&nbsp;测试上传</button>";
                        // btn+="<button onclick='uploadData2(" + row.id + ")' class='layui-btn layui-btn-danger layui-btn-small hide checkBtn_78'><i class='fa fa-list fa-edit'></i>&nbsp;测试上传ppp</button>";

                        return "<button onclick='updateData(" + row.id + ","+row.flag+")' class='layui-btn layui-btn-small hide checkBtn_78'><i class='fa fa-list fa-edit'></i>&nbsp;查看/修改</button>"
                                + btn
                                ;
                    },
                    "targets": 2
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
            title: '添加视频',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/videoWareHouse/save"
        });
        layer.full(index);
    }

    //查看/修改数据
    function updateData(id,flag) {
        var p = "";
        if(null != flag && 0 == flag){
            p = "&flag="+flag;
        }
        var index = layer.open({
            type: 2,
            title: '修改',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/videoWareHouse/edit?id=" + id+p
        });
        layer.full(index);
    }

    function uploadData(id) {
        var index = layer.open({
            type: 2,
            title: '测试上传',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/videoWareHouse/media?id=" + id
        });
        layer.full(index);
    }

    function uploadData2() {
        var index = layer.open({
            type: 2,
            title: '测试上传',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/videoWareHouse/save2"
        });
        layer.full(index);
    }

    //删除
    function delVideo (id) {
        var index = layer.load(1, {shade: [0.5,'#eee']});
        var index2 = layer.confirm('是否确认删除？', {
            btn: ['确认','取消'] //按钮
        }, function(){
            var arr = {
                id : id
            }
            AM.ajaxRequestData("post", false, AM.ip + "/videoWareHouse/delete", arr , function(result) {
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
