<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加权限</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>.dx-manage-info{padding-top:23px!important;padding-left:38px;padding-right:38px;position:relative}.dx-manage-info .btn-box{position:absolute;right:0}.dx-manage-info .btn-box .layui-btn{width:120px}.dx-manage-info h2.title{font-size:16px;color:#333;border-left:solid 5px #fab530;padding-left:7px}.dx-manage-info .waterfall-box{-webkit-column-width:300px;-moz-column-width:300px;-o-colum-width:300px}.dx-manage-info .function-box{background-color:#f0f2f5;border:solid 1px #e4e4e4;margin-top:15px;margin-bottom:15px;width:300px;position:relative;padding-top:50px;display:inline-block;margin-right:10px}.dx-manage-info .function-box h5.title{width:100%;border:solid 1px #a5abb7;background-color:#a5abb7;color:#fff;font-size:14px;line-height:30px;position:absolute;top:-1px;left:-1px}.dx-manage-info .function-box h5.title i{margin-right:5px;margin-left:10px}.dx-manage-info .function-box .list-item{padding-bottom:5px}.dx-manage-info .function-box .list-item li{padding-left:30px}.dx-manage-info .function-box .list-item li:first-child{padding-left:0}.dx-manage-info .function-box .list-item .layui-form-checkbox{padding-left:30px;padding-right:0}.dx-manage-info .function-box .list-item .layui-form-checkbox i{left:-7px}.dx-manage-info.type-info .btn-box{display:none}.dx-manage-info.dx-info-box.type-info input{border:solid 1px #e6e6e6!important}.dx-manage-info.dx-info-box.type-info .layui-checkbox-disbaled.layui-form-checked:hover i{color:#e2e2e2!important}.dx-manage-info.dx-info-box.type-info .layui-checkbox-disbaled.layui-form-checked{border-color:#e2e2e2!important}.dx-manage-info.dx-info-box.type-info .layui-checkbox-disbaled.layui-form-checked span{background-color:#e2e2e2!important}.layui-form-checkbox.layui-form-checked.layui-checkbox-disbaled.layui-disabled i{color: #e2e2e2!important}</style>

</head>
<body>
<div style="margin: 15px;">
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>添加权限&nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></legend>
    </fieldset>
    <section class="dx-info-default">
        <div class="dx-info-box dx-manage-info">
            <form class="layui-form layui-form-pane dx-form-pane" id="dataForm">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">角色</label>
                        <div class="layui-input-block">
                            <select id="roleId" name="roleId" lay-verify="required" lay-search="" lay-filter="role">
                                <option value="">选择或搜索角色</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>
                </div>

                <h2 class="title">角色功能选择</h2>
                <div class="waterfall-box" id="menuList">

                    <%--<div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>角色管理</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="1" title="角色管理" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li><input type="checkbox" value="47" title="添加角色" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="48" title="修改角色" lay-filter="checkbox"></li>
                        </ul>
                    </div>

                    <div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>公司管理</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="2" title="公司管理" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li><input type="checkbox" value="49" title="添加公司" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="50" title="修改公司" lay-filter="checkbox"></li>
                        </ul>
                    </div>

                    <div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>部门管理</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="3" title="部门管理" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li><input type="checkbox" value="51" title="添加部门" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="52" title="修改部门" lay-filter="checkbox"></li>
                        </ul>
                    </div>

                    <div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>用户管理</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="4" title="用户管理" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li><input type="checkbox" value="53" title="添加用户" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="54" title="修改用户" lay-filter="checkbox"></li>
                        </ul>
                    </div>

                    <div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>工作类型管理</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="5" title="工作类型管理" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li><input type="checkbox" value="55" title="添加工作类型" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="56" title="修改工作类型" lay-filter="checkbox"></li>
                        </ul>
                    </div>

                    <div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>事务类型管理</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="6" title="事务类型管理" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li><input type="checkbox" value="57" title="添加事务类型" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="58" title="修改事务类型" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="59" title="显示/隐藏" lay-filter="checkbox"></li>
                        </ul>
                    </div>

                    <div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>传递卡管理</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="7" title="传递卡管理" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li><input type="checkbox" value="60" title="批量通过已选传递卡" lay-filter="checkbox"></li>
                            <li><input type="checkbox" name="61" title="综合部通过审核传递卡" lay-filter="checkbox"></li>
                            <li><input type="checkbox" name="62" title="综合部打回传递卡" lay-filter="checkbox"></li>
                            <li><input type="checkbox" name="63" title="团队长通过审核传递卡" lay-filter="checkbox"></li>
                            <li><input type="checkbox" name="64" title="团队长打回传递卡" lay-filter="checkbox"></li>
                        </ul>
                    </div>

                    <div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>项目管理</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="8" title="项目管理" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="9" title="内部项目专业管理" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="65" title="添加内部项目专业" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="66" title="修改内部项目专业" lay-filter="checkbox"></li>
                                </ul>
                            </li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="10" title="项目组管理" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="67" title="添加项目组" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="68" title="修改项目组" lay-filter="checkbox"></li>
                                </ul>
                            </li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="11" title="内部项目管理" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="69" title="添加内部项目" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="70" title="修改内部项目" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="71" title="审核通过" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="72" title="审核不通过" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="73" title="分配项目组" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="74" title="重新提交" lay-filter="checkbox"></li>
                                    <li>
                                        <ul class="list-item">
                                            <li><input type="checkbox" value="75" title="查看详情" lay-filter="checkbox" parentCheckBox="true"></li>
                                            <li><input type="checkbox" value="76" title="查看周验收详情" lay-filter="checkbox"></li>
                                            <li><input type="checkbox" value="77" title="申请周验收" lay-filter="checkbox"></li>
                                            <li><input type="checkbox" value="78" title="进行周验收" lay-filter="checkbox"></li>
                                            <li><input type="checkbox" value="79" title="成员比例分配" lay-filter="checkbox"></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="12" title="项目类型管理" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="80" title="添加项目类型" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="81" title="查看/修改阶段" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="82" title="显示/隐藏" lay-filter="checkbox"></li>
                                </ul>
                            </li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="13" title="外部项目管理" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="83" title="添加外部项目" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="84" title="批量处理" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="85" title="项目分配" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="86" title="重新项目分配" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="87" title="审核通过" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="88" title="审核不通过" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="89" title="修改外部项目" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="90" title="分配项目组" lay-filter="checkbox"></li>
                                    <li>
                                        <ul class="list-item">
                                            <li><input type="checkbox" value="91" title="查看详情" lay-filter="checkbox" parentCheckBox="true"></li>
                                            <li><input type="checkbox" value="92" title="查看周验收详情" lay-filter="checkbox"></li>
                                            <li><input type="checkbox" value="93" title="查看内部验收详情" lay-filter="checkbox"></li>
                                            <li><input type="checkbox" value="94" title="查看外部验收详情" lay-filter="checkbox"></li>
                                            <li><input type="checkbox" value="95" title="申请周验收" lay-filter="checkbox"></li>
                                            <li><input type="checkbox" value="96" title="进行周验收" lay-filter="checkbox"></li>
                                            <li><input type="checkbox" value="97" title="申请内部结项" lay-filter="checkbox"></li>
                                            <li><input type="checkbox" value="98" title="进行内部结项验收" lay-filter="checkbox"></li>
                                            <li><input type="checkbox" value="99" title="通过内部结项" lay-filter="checkbox"></li>
                                            <li><input type="checkbox" value="100" title="C导师进行抽查" lay-filter="checkbox"></li>
                                            <li><input type="checkbox" value="101" title="申请外部结项" lay-filter="checkbox"></li>
                                            <li><input type="checkbox" value="102" title="进行外部结项验收" lay-filter="checkbox"></li>
                                            <li><input type="checkbox" value="103" title="进行外部结项验收" lay-filter="checkbox"></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>

                    <div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>统计管理</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="14" title="统计管理" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li><input type="checkbox" value="15" title="个人工作时间" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="16" title="个人学习时间" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="17" title="个人运动时间" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="18" title="个人工作学习总时间" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="19" title="个人K可比" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="20" title="团队K总完成率" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="21" title="团队结项完成率" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="22" title="文化工程" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="23" title="三维绩效考核得分" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="24" title="三维绩效汇总表" lay-filter="checkbox"></li>
                        </ul>
                    </div>

                    <div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>荣誉时刻</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="25" title="荣誉时刻" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li><input type="checkbox" value="26" title="月度K王" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="27" title="月度优秀团队" lay-filter="checkbox"></li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="28" title="一真精神奖/优秀执委" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="114" title="评选一次" lay-filter="checkbox"></li>
                                </ul>
                            </li>
                        </ul>
                    </div>

                    <div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>三维管理</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="29" title="三维管理" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="30" title="一维管理" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="115" title="一维发布" lay-filter="checkbox"></li>
                                </ul>
                            </li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="31" title="二维管理" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="116" title="二维发布" lay-filter="checkbox"></li>
                                </ul>
                            </li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="32" title="三维管理" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="117" title="三维发布" lay-filter="checkbox"></li>
                                </ul>
                            </li>
                        </ul>
                    </div>

                    <div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>配置管理</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="33" title="配置管理" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li><input type="checkbox" value="34" title="全局配置" lay-filter="checkbox"></li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="35" title="目标指标配置" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="118" title="添加" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="119" title="修改" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="120" title="删除" lay-filter="checkbox"></li>
                                </ul>
                            </li>
                            <li><input type="checkbox" value="36" title="第二维配置" lay-filter="checkbox"></li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="37" title="第三维配置" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="121" title="修改" lay-filter="checkbox"></li>
                                </ul>
                            </li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="38" title="第三维评分" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="122" title="添加" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="123" title="修改" lay-filter="checkbox"></li>
                                </ul>
                            </li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="39" title="配置应出勤天数" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="124" title="添加" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="125" title="修改" lay-filter="checkbox"></li>
                                </ul>
                            </li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="40" title="员工出勤情况" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="126" title="添加" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="127" title="修改" lay-filter="checkbox"></li>
                                </ul>
                            </li>
                            <li>
                                <ul class="list-item">
                                    <li><input type="checkbox" value="41" title="员工请假情况" lay-filter="checkbox" parentCheckBox="true"></li>
                                    <li><input type="checkbox" value="128" title="添加" lay-filter="checkbox"></li>
                                    <li><input type="checkbox" value="129" title="修改" lay-filter="checkbox"></li>
                                </ul>
                            </li>
                        </ul>
                    </div>

                    <div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>文章管理</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="42" title="文章管理" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li><input type="checkbox" value="43" title="使用协议与隐私政策" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="44" title="关于一真" lay-filter="checkbox"></li>
                        </ul>
                    </div>

                    <div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>Banner管理</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="45" title="Banner管理" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li><input type="checkbox" value="130" title="添加" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="131" title="修改" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="132" title="删除" lay-filter="checkbox"></li>
                        </ul>
                    </div>

                    <div class="function-box">
                        <h5 class="title"><i class="fa fa-cube"></i>权限管理</h5>
                        <ul class="list-item">
                            <li><input type="checkbox" value="46" title="权限管理" lay-filter="checkbox" parentCheckBox="true"></li>
                            <li><input type="checkbox" value="133" title="添加" lay-filter="checkbox"></li>
                            <li><input type="checkbox" value="134" title="修改" lay-filter="checkbox"></li>
                        </ul>
                    </div>--%>

                </div>
            </form>
        </div>
    </section>
</div>
<!--引入抽取公共js-->
<%@include file="../common/public-js.jsp" %>
<script>

    var form = null;
    function initData (roleId) {
        //监听select事件--用户类型过滤器
        AM.ajaxRequestData("get", false, AM.ip + "/menu/findAllMenu", {roleId : roleId} , function(result) {
            if (result.flag == 0 && result.code == 200) {
                var menuList = result.data;
                var html = "";
                for (var i = 0; i < menuList.length; i++) { //第一级
                    var oneChildHtml = menuPackaging(menuList[i].child);
                    var oneInput = "";
                    if (menuList[i].spread) {
                        oneInput = '<input type="checkbox" value="' + menuList[i].id + '" title="' + menuList[i].title + '" lay-filter="checkbox" parentCheckBox="true" checked>';
                    }
                    else {
                        oneInput = '<input type="checkbox" value="' + menuList[i].id + '" title="' + menuList[i].title + '" lay-filter="checkbox" parentCheckBox="true">';
                    }
                    html += '<div class="function-box">' +
                            '<h5 class="title"><i class="fa ' + menuList[i].icon + '"></i>' + menuList[i].title + '</h5>' +
                            '<ul class="list-item">' +
                            '<li>' + oneInput + '</li>' +
                            oneChildHtml +
                            '</ul>' +
                            '</div>';
                }
                $("#menuList").html(html);
                form.render(); //重新渲染
            }
        });

    }

    layui.use(['form', 'layedit', 'laydate'], function() {
        form = layui.form(),
                layer = layui.layer;

        getRoleList(0);
        initData(null);
        form.render(); //重新渲染

        form.on('select(role)', function(data){
            var index = layer.load(1, {shade: [0.5,'#eee']});
            initData(data.value);
            setTimeout(function () {layer.close(index);}, 600);
            form.render(); //重新渲染
        });

        /*// 监听checkbox点击
        form.on('checkbox(checkbox)', function (data) {
            var pck = $(data.elem).parent().parent();
            // 判断是否全选
            if ($(data.elem).attr('parentCheckBox')) {
                if (data.elem.checked) {
                    pck.find('.layui-form-checkbox').addClass('layui-form-checked');
                    pck.find('input[type="checkbox"]'), function (val) {
                        val.checked = true;
                        form.render(); //重新渲染
                    }
                } else {
                    pck.find('.layui-form-checkbox').removeClass('layui-form-checked');
                    pck.find('input[type="checkbox"]'), function (val) {
                        val.checked = false;
                        form.render(); //重新渲染
                    }
                }
            } else {
                if (!data.elem.checked) {
                    pck.find('input[parentCheckBox]').eq(0).next('.layui-form-checkbox').removeClass('layui-form-checked')[0].checked = false;
                    form.render(); //重新渲染
                }
            }

            //form.render(); //重新渲染
        });*/

        //监听提交
        form.on('submit(demo1)', function(data) {
            console.log(data);
            console.log(data.elem)
            console.log(data.field);
            var arr = [];
            $("#dataForm input[type='checkbox']").each(function () {
                if ($(this).is(':checked')) {
                    arr.push($(this).val());
                }
            });
            data.field.keyIds = JSON.stringify(arr);
            console.log(data.field);
            AM.ajaxRequestData("post", false, AM.ip + "/roleUrl/addRoleUrl", data.field , function(result) {
                if (result.flag == 0 && result.code == 200) {
                    var index = layer.alert('添加成功.', {
                        skin: 'layui-layer-molv' //样式类名
                        ,closeBtn: 0
                        ,anim: 3 //动画类型
                    }, function(){
                        //location.reload();
                        layer.close(index);
                    });
                }
            });
            return false;
        });
    });


    /**
     * 给菜单封包  拼接菜单
     *
     * @param menuList
     */
    function menuPackaging(menuList) {
        var html = "";
        for (var i = 0 ; i < menuList.length ; i ++) {
            var childHtml = "";
            if (menuList[i].spread) {
                if ($("#roleId").val() == 1 && menuList[i].id == 99) {
                    childHtml = '<input type="checkbox" value="' + menuList[i].id + '" title="' + menuList[i].title + '" lay-filter="checkbox" parentCheckBox="true" checked disabled>';
                    $(".dx-info-box").addClass('type-info');
                }
                else {
                    childHtml = '<input type="checkbox" value="' + menuList[i].id + '" title="' + menuList[i].title + '" lay-filter="checkbox" checked>';
                }
            }
            else {
                childHtml = '<input type="checkbox" value="' + menuList[i].id + '" title="' + menuList[i].title + '" lay-filter="checkbox">';
            }
            html += '<li>' +
                    '<ul class="list-item">' +
                    '<li>' + childHtml + '</li>' +
                    menuPackaging(menuList[i].child) +
                    '</ul>' +
                    '</li>';
        }
        return html;
    }



</script>
</body>
</html>
