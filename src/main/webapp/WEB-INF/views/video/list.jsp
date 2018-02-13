<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>视频列表</title>
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
                            <input type="text" id="courseWareId" value="${courseWareId}" style="display: none;">
                            <label class="layui-form-label">视频名</label>
                            <div class="layui-input-inline">
                                 <input type="text" id="name" lay-verify="" placeholder="请输入视频名" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">视频来源</label>
                            <div class="layui-input-inline">
                                <select name="source" id="source">
                                    <option value="">请选择来源类型</option>
                                    <option value="0">直接上传</option>
                                    <option value="1">视频库选择</option>
                                    <option value="2">云视频库</option>
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
        <legend>视频列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend>
        </legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <button onclick="addData()" class="layui-btn layui-btn layui-btn-small layui-btn-normal hide checkBtn_33"><i class="layui-icon">
                    &#xe608;</i> 添加视频
                </button>
            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>封面图</th>
                    <th>视频名</th>
                    <%--<th>高清视频地址</th>--%>
                    <th>高清视频时间(秒)</th>
                    <%--<th>流畅视频地址</th>--%>
                    <th>流畅视频时间(秒)</th>
                    <th>高清视频来源</th>
                    <th>流畅视频来源</th>
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
                url: AM.ip + "/video/list",
                "dataSrc": function (json) {
                    console.log(json);
                    if (json.code == 200) {
                        return json.data;
                    }
                    return [];
                },
                "data": function (data) {
                    //高级查询参数
                    data.name = $("#name").val();
                    data.courseWareId = $("#courseWareId").val();
                    data.source = $("#source").val();
                }
            },
            "columns": [
                {"data": "cover"},
                {"data": "name"},
//                {"data": "highDefinition"},
                {"data": "highDefinitionSeconds"},
//                {"data": "lowDefinition"},
                {"data": "lowDefinitionSeconds"},
                {"data": "sourceHigh"},
                {"data": "sourceLow"},
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
                    "render": function (data, type, row)
                    {
                        if (null == data){return "--"}
                        if (data == 0) {
                            return "直接上传";
                        } else if(data == 1) {
                            return "视频库选择";
                        }
                        else if(data == 2){
                            return "云视频库";
                        }

                    },
                    "targets": 4
                },
                {
                    "render": function (data, type, row)
                    {
                        if (null == data){return "--"}
                        if (data == 0) {
                            return "直接上传";
                        } else if(data == 1) {
                            return "视频库选择";
                        }
                        else if(data == 2){
                            return "云视频库";
                        }

                    },
                    "targets": 5
                },
                {
                    "render": function (data, type, row) {
                        var obj = JSON.stringify(row);
                        var btn = "";
                        return "<button onclick='updateData(" + obj + ")' class='layui-btn layui-btn-small hide checkBtn_34'><i class='fa fa-list fa-edit'></i>&nbsp;查看/修改</button>"
//                                + "<button onclick='deleteById(" + row.id + ")' class='layui-btn layui-btn-small layui-btn-danger'><i class='fa fa-list fa-edit'></i>&nbsp;删除</button>"
                                + btn
                                ;
                    },
                    "targets": 6
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
            title: '添加视频',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/video/save?courseWareId="+$("#courseWareId").val()
        });
        layer.full(index);
    }

    //查看/修改数据
    function updateData(obj) {
        //sessionStorage.setItem("curriculum", JSON.stringify(obj));
        var index = layer.open({
            type: 2,
            title: '修改视频',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/video/edit?id=" + obj.id
        });
        layer.full(index);
    }



    layui.use(['form', 'layedit', 'laydate'], function () {
        form = layui.form(),
                layer = layui.layer,
                laydate = layui.laydate;

    });

    //删除视频
    function deleteById(id) {
        layer.confirm('是否删除？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            AM.ajaxRequestData("post", false, AM.ip + "/video/delete", {id:id} , function(result) {
                if (result.flag == 0 && result.code == 200) {
                    layer.alert('删除成功.', {
                        skin: 'layui-layer-molv' //样式类名
                        ,closeBtn: 0
                        ,anim: 3 //动画类型
                    }, function(){
                        dataTable.ajax.reload();
                    });
                }
            });
        }, function(){

        });
    }


</script>
</body>
</head></html>
