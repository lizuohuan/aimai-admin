<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>题库管理</title>

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
                            <label class="layui-form-label">题目</label>
                            <div class="layui-input-inline">
                                <input type="text" id="title" lay-verify="" placeholder="请输入题目" autocomplete="off" class="layui-input" maxlength="20">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">选择试题类型</label>
                            <div class="layui-input-inline">
                                <select name="type" id="type" lay-verify="required" lay-search>
                                    <!--0:单选题 1:多选题  2:判断题  -->
                                    <option value="">选择试题类型</option>
                                    <option value="0">单选题</option>
                                    <option value="1">多选题</option>
                                    <option value="2">判断题</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">选择类型</label>
                            <div class="layui-input-inline">
                                <select name="category" id="category" lay-verify="required" lay-search>
                                    <!--0：练习题  1：模拟题 2：考试题  -->
                                    <option value="">选择类型</option>
                                    <option value="0">练习题</option>
                                    <option value="1">模拟题</option>
                                    <option value="2">考试题</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">选择行业</label>
                            <div class="layui-input-inline">
                                <select name="tradeId" id="tradeId" lay-verify="required" lay-search>
                                    <option value="">选择行业</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">选择课程</label>
                            <div class="layui-input-inline">
                                <select name="curriculumId" id="curriculumId" lay-verify="required" lay-search>
                                    <option value="">选择课程</option>
                                </select>
                            </div>
                        </div>
                        <%--<div class="layui-inline">
                            <label class="layui-form-label">选择公司</label>
                            <div class="layui-input-inline">
                                <select name="cityId" id="companyId" lay-verify="required" lay-search>
                                    <option value="">选择类型</option>
                                </select>
                            </div>
                        </div>--%>
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
        <legend>题库列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend></legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <button onclick="addData()" class="layui-btn layui-btn layui-btn-small layui-btn-normal hide checkBtn_43"><i class="layui-icon">&#xe608;</i> 添加试题</button>
                <span class="hide checkBtn_44">
                    <input type="file" name="file" id="fileEx" lay-title="导入试题">
                </span>
                <button onclick="window.location.href=AM.ip+'/resources/topicTemplate.xls'" class="layui-btn layui-btn layui-btn-small layui-btn-warm hide checkBtn_73"><i class="layui-icon">&#xe601;</i> 下载试题模板</button>
            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th width="300">题目</th>
                        <th>试题类型</th>
                        <th>所属类型</th>
                        <th>所属行业</th>
                        <th>所属课程</th>
                        <th>所属城市</th>
                        <th>所属公司</th>
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
                url: AM.ip + "/examination/list",
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
                    data.type = $("#type").val();
                    data.category = $("#category").val();
                    data.tradeId = $("#tradeId").val();
                    data.curriculumId = $("#curriculumId").val();
                    data.cityId = $("#cityId").val();
                    data.companyId = $("#companyId").val();
                    data.provinceId = $("#provinceId").val();
                    data.districtId = $("#districtId").val();
                }
            },
            "columns": [
                { "data": "title" },
                { "data": "type" },
                { "data": "category" },
                { "data": "tradeName" },
                { "data": "curriculumName" },
                {"data": "cityName"},
                {"data": "companyName"},
                {"data": "createTime"},
            ],
            "columnDefs": [
                {
                    "render": function(data, type, row) {

                        //  试题类型 0:单选题 1:多选题  2:判断题
                        if(data == 0){
                            return "单选题";
                        }
                        else if(data == 1){
                            return "多选题";
                        }
                        else if(data == 2){
                            return "判断题";
                        }
                        else {
                            return "-";
                        }
                    },
                    "targets": 1
                },
                {
                    "render": function(data, type, row) {
                        //   0：练习题  1：模拟题 2：考试题 只用于筛选
                        if(data == 0){
                            return "练习题";
                        }
                        else if(data == 1){
                            return "模拟题";
                        }
                        else if(data == 2){
                            return "考试题";
                        }
                        else {
                            return "-";
                        }
                    },
                    "targets": 2
                },
                {
                    "render": function (data, type, row) {
                        if (data == null || data == "") {
                            return "-";
                        }
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    },
                    "targets": 7
                },
                {
                    "render": function (data, type, row) {
                        return "<button onclick='updateData(" + row.id + ")' class='layui-btn layui-btn-small hide checkBtn_45'><i class='fa fa-list fa-edit'></i>&nbsp;查看/修改</button>"+
                               "<button onclick=\"checkKey('" + row.examinationKey + "')\" class='layui-btn layui-btn-small hide checkBtn_46'><i class='fa fa-list fa-edit'></i>&nbsp;查看题解</button>"+
                               "<button onclick=\"deleteExamination('" + row.id + "')\" class='layui-btn layui-btn-small layui-btn-danger hide checkBtn_93'><i class='fa fa-list fa-edit'></i>&nbsp;删除试题</button>"+
                               "<button onclick='checkItems(" + row.id + ")' class='layui-btn layui-btn-small hide checkBtn_47'><i class='fa fa-list fa-edit'></i>&nbsp;查看选项</button>"
                                ;
                    },
                    "targets": 8
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

    //查看/修改数据
    function checkItems(id) {
        var index = layer.open({
            type: 2,
            title: '查看选项',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/examination/items/list?id=" + id
        });
        layer.full(index);
    }

    //删除课时
    function deleteExamination(id) {
        var index = layer.confirm("删除此试题，同时也将删除试题下所有选项，且无法恢复，请谨慎操作，是否删除？", {
            btn: ['确认', '取消'] //按钮
        }, function () {
            var arr = {
                id: id
            }
            AM.ajaxRequestData("post", false, AM.ip + "/examination/delete", arr, function (result) {
                if (result.flag == 0 && result.code == 200) {
                    dataTable.ajax.reload();
                    layer.close(index);
                }
            });
        }, function () {
        });
    }


    function checkKey(text){
        text = null == text || text.length == 0 ? "暂无题解" : text;
        console.log(text);
        var html = "<div>" +
                "<div style='padding: 5px;'>" + text + "</div>" +
                "</div>";

        layer.open({
            type: 1,
            title: '查看题解',
            shadeClose: true,
            shade: 0.5,
            area: ["600px", "300px"], //宽高
            content: html
        });

    }


    //添加
    function addData () {
        var index = layer.open({
            type: 2,
            title: '添加题库',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/examination/save"
        });
        layer.full(index);
    }

    //查看/修改数据
    function updateData(id) {
        var index = layer.open({
            type: 2,
            title: '修改题库',
            shadeClose: true,
            maxmin: true, //开启最大化最小化按钮
            area: ['400px', '500px'],
            content: AM.ip + "/page/examination/edit?id=" + id
        });
        layer.full(index);
    }




    layui.use(['form', 'layedit','upload', 'laydate'], function() {
        form = layui.form(),
                layer = layui.layer,
                laydate = layui.laydate;
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

        getTradeList(0); //行业列表
        getCurriculumList(0,null,null,null);//课程
        selectProvince(0,"list"); //默认调用省







        //上传图片
        layui.upload({
            url: AM.ipImg + "/res/upload" //上传接口
            ,elem: "#fileEx"
            ,ext:"xlsx|xls"
            ,success: function(res){ //上传成功后的回调
                console.log(res.data.url);
                $.ajax({
                    type: "post",
                    async: false,
                    url: AM.ip + "/examination/addExcel",
                    data: {url:AM.ipImg+"/"+res.data.url},
                    success:function(json){
                        deleteExcel(res.data.url);
                        if (json.flag == 0 && json.code == 200) {
                            var index = layer.alert('导入成功.', {
                                skin: 'layui-layer-molv' //样式类名
                                ,closeBtn: 0
                                ,anim: 3 //动画类型
                            }, function(){
                                layer.close(index);
                                dataTable.ajax.reload();
                            });
                        } else {
                            layer.alert(json.msg);

                        }
                    },
                    error: function(json) {
                        layer.alert(json.responseText);
                        console.log("请求出错了.");
                    }
                })


            }
        });
    });

    //无论导入成功或失败  都进行删除
    function deleteExcel(url){
        AM.ajaxRequestData("post", false, AM.ipImg + "/res/delete", {url:url}  , function(result) {

        });
    }

</script>
</body>
</html>
