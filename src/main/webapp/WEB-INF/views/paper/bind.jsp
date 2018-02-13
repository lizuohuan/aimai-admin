<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加试题</title>
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
                            <label class="layui-form-label">名称</label>
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
        <legend>试题列表&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend></legend>
        <div class="layui-field-box layui-form">
            <blockquote class="layui-elem-quote">
                <button lay-submit="" lay-filter="submitWork" class="layui-btn layui-btn-small layui-btn-default hide checkBtn_56" onclick="passSelected()">绑定已选试题</button>
            </blockquote>
            <table id="dataTable" class="layui-table admin-table table-bordered display" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th width="120"><input type="checkbox" name="" lay-skin="primary" lay-filter="allChoose" title="勾选本页"></th>
                    <th width="400">题目</th>
                    <th width="120">试题类型</th>
                    <th width="120">所属类型</th>
                    <th width="120">所属行业</th>
                    <th>所属课程</th>
                    <th>所属城市</th>
                    <th>所属公司</th>
                    <th width="90">设置分数</th>
                </tr>
                </thead>
            </table>
        </div>
    </fieldset>
    <input type="hidden" id="paperId" value="${paperId}">
</div>
<!--引入抽取公共js-->
<%@include file="../common/public-js.jsp" %>
<script>

    var form = null;
    var dataTable = null;
    $(document).ready(function() {
        dataTable = $('#dataTable').DataTable( {
            "searching": false,"bStateSave": false, //状态保存，使用了翻页或者改变了每页显示数据数量，会保存在cookie中，下回访问时会显示上一次关闭页面时的内容。
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
                    data.paperId = $("#paperId").val();
                    data.source = 0;
                }
            },
            "columns": [
                { "data": "" },
                { "data": "title" },
                { "data": "type" },
                { "data": "category" },
                { "data": "tradeName" },
                { "data": "curriculumName" },
                {"data": "cityName"},
                {"data": "companyName"},
                {"data": ""},
            ],
            "columnDefs": [
                {
                    "render": function(data, type, row) {
                        return "<input  type=\"checkbox\" name=\"\" value=\"" + row.id + "\"  lay-skin=\"primary\" title=\"勾选\">";
                    },
                    "targets": 0
                },
                {
                    "render": function(data, type, row) {

                        if(null == data){
                            return "-";
                        }
                        //  试题类型 0:单选题 1:多选题  2:判断题
                        else if(data == 0){
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
                    "targets": 2
                },
                {
                    "render": function(data, type, row) {

                        if(null == data){
                            return "-";
                        }
                        //   0：练习题  1：模拟题 2：考试题 只用于筛选
                        else if(data == 0){
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
                    "targets": 3
                },

                {
                    "render": function (data, type, row) {
                        return "<input type='number' value='1' name='score' class='layui-input'>";
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
    });


    //通过已选传递卡
    var passSelected = function () {
        form.on('submit(submitWork)', function(data){
            var child = $("#dataTable").find('tbody input[type="checkbox"]');
            var paperItems = [];
            var paperId = $("#paperId").val();
            child.each(function(){
                if ($(this).is(':checked')) {
                    var exId = $(this).val();
                    var score = $(this).parent().parent().find("input[type='number']").val();
                    var obj = {
                        examinationId : exId,
                        score : score,
                        paperId : paperId
                    }
                    paperItems.push(obj);
                }
            });
            if (paperItems.length == 0) {
                layer.msg('至少勾选一个.', {icon: 2, anim: 6});
                return false;
            }


            else {
                console.log("******************");
                console.log(paperItems);
                console.log("************");
                var arr = {
                    paperItems : JSON.stringify(paperItems)
                }
                AM.ajaxRequestData("post", false, AM.ip + "/paper/bind", arr, function(result){
                    if(result.flag == 0 && result.code == 200){
                        layer.alert('设置成功.', {
                            skin: 'layui-layer-molv' //样式类名
                            ,closeBtn: 0
                            ,anim: 3 //动画类型
                        }, function(){
                            //关闭iframe页面
                            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                            parent.layer.close(index);
//                            window.parent.closeNodeIframe();
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
