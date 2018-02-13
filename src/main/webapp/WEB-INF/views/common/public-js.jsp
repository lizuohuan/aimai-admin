<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common/jquery-2.1.0.js"></script>
<%--<script type="text/javascript" src="<%=request.getContextPath()%>/resources/plugins/layui/layui.js"></script>--%>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/plugins/layui/lay/dest/layui.all.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/angular.min.js"></script>
<%--<script type="text/javascript" src="<%=request.getContextPath()%>/resources/dataTable/js/jquery.dataTables.min.js"></script>--%>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/datatables/media/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/config.js"></script>
<!--时间控件-->
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/My97DatePicker/WdatePicker.js"></script>

<script>
    $(function () {
        $(".fa-refresh").click(function () {
            location.reload();
        });
    });

    //遍历验证权限
    function checkJurisdiction () {
        var menuList = AM.getLoginUserJurisdiction();
        for (var i = 0; i < menuList.length; i++) {
            var oneChild = menuList[i];
            checkJurisdiction2(oneChild)
        }

    }

    function checkJurisdiction2(menuList) {
        for (var j = 0; j < menuList.child.length; j++) {
            var twoChild = menuList.child[j];
            checkJurisdiction2(twoChild)
            $(".checkBtn_" + twoChild.id).show();
        }
    }

    //获取行业列表
    function getTradeList (selectId) {
        AM.ajaxRequestData("get", false, AM.ip + "/trade/listForSelect", {} , function(result){
            if(result.flag == 0 && result.code == 200){
                var html = "<option value=\"\">不限</option><option value=\"\">不限</option>";

                for (var i = 0; i < result.data.length; i++) {
                    if (result.data[i].id == selectId) {
                        html += "<option selected=\"selected\" value=\"" + result.data[i].id + "\">" + result.data[i].tradeName + "</option>";
                    }
                    else {
                        html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].tradeName + "</option>";
                    }
                }
                if (result.data.length == 0) {
                    html += "<option value=\"0\" disabled>暂无</option>";
                }
                $("select[name='tradeId']").html(html);
                $("select[name='tradeId']").parent().parent().show();
            }
        });
    }

    //获取课程类型列表
    function getCurriculumTypeList (selectId) {
        AM.ajaxRequestData("get", false, AM.ip + "/curriculumType/listForSelect", {} , function(result){
            if(result.flag == 0 && result.code == 200){
                var html = "<option value=''>选择或搜索课程类型</option>";
                for (var i = 0; i < result.data.length; i++) {
                    if (result.data[i].id == selectId) {
                        html += "<option selected=\"selected\" value=\"" + result.data[i].id + "\">" + result.data[i].curriculumTypeName + "</option>";
                    }
                    else {
                        html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].curriculumTypeName + "</option>";
                    }
                }
                if (result.data.length == 0) {
                    html += "<option value=\"0\" disabled>暂无</option>";
                }
                $("select[name='curriculumTypeId']").html(html);
                $("select[name='curriculumTypeId']").parent().parent().show();
            }
        });
    }

    //省
    function selectProvince2(selectId,source) {
        var html = "";
        AM.ajaxRequestData("get", false, AM.ip + "/city/queryCityByParentId", {levelType : 1} , function(result){
            html = "<option value=''>请选择或搜索省</option>";
            // if (selectId == 0) {
            //     if (source == null || source == "") {
            //         html += "<option value=\"100000\" selected=\"selected\">全国</option>";
            //     }
            // }
            // else {
            //     html += "<option value=\"100000\">全国</option>";
            // }
            for (var i = 0; i < result.data.length; i++) {
                if (result.data[i].id == selectId) {
                    html += "<option selected=\"selected\" value=\"" + result.data[i].id + "\">" + result.data[i].shortName + "</option>";
                }
                else {
                    html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].shortName + "</option>";
                }
            }
            if (result.data.length == 0) {
                html += "<option value=\"0\" disabled>暂无</option>";
            }
            $("select[name='provinceUserId']").html(html);
            $("select[name='provinceUserId']").parent().parent().show();
        });
        return html;
    }


    //省
    function selectProvince3(selectId,source) {
        var html = "";
        AM.ajaxRequestData("get", false, AM.ip + "/city/queryCityByParentId", {levelType : 1} , function(result){
            html = "<option value=''>请选择或搜索省</option>";
            // if (selectId == 0) {
            //     if (source == null || source == "") {
            //         html += "<option value=\"100000\" selected=\"selected\">全国</option>";
            //     }
            // }
            // else {
            //     html += "<option value=\"100000\">全国</option>";
            // }
            for (var i = 0; i < result.data.length; i++) {
                if (result.data[i].id == selectId) {
                    html += "<option selected=\"selected\" value=\"" + result.data[i].id + "\">" + result.data[i].shortName + "</option>";
                }
                else {
                    html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].shortName + "</option>";
                }
            }
            if (result.data.length == 0) {
                html += "<option value=\"0\" disabled>暂无</option>";
            }
        });
        return html;
    }

    //省
    function selectProvince(selectId,source) {
        AM.ajaxRequestData("get", false, AM.ip + "/city/queryCityByParentId", {levelType : 1} , function(result){
            var html = "<option value=''>请选择或搜索省</option>";
            if (selectId == 0) {
                if (source == null || source == "") {
                    html += "<option value=\"100000\" selected=\"selected\">全国</option>";
                }
            }
            else {
                html += "<option value=\"100000\">全国</option>";
            }
            for (var i = 0; i < result.data.length; i++) {
                if (result.data[i].id == selectId) {
                    html += "<option selected=\"selected\" value=\"" + result.data[i].id + "\">" + result.data[i].shortName + "</option>";
                }
                else {
                    html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].shortName + "</option>";
                }
            }
            if (result.data.length == 0) {
                html += "<option value=\"0\" disabled>暂无</option>";
            }
            $("select[name='province']").html(html);
            $("select[name='province']").parent().parent().show();
        });
    }

    //市
    function selectCity2(cityId, selectId) {
        var html
        AM.ajaxRequestData("get", false, AM.ip + "/city/queryCityByParentId", {cityId : cityId, levelType : 2} , function(result){
             html = "<option value=\"\">请选择或搜索市</option>";
            for (var i = 0; i < result.data.length; i++) {
                if (result.data[i].id == selectId) {
                    html += "<option selected=\"selected\" value=\"" + result.data[i].id + "\">" + result.data[i].shortName + "</option>";
                }
                else {
                    html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].shortName + "</option>";
                }
            }
            if (result.data.length == 0) {
                html += "<option value=\"0\" disabled>暂无</option>";
            }

        });
        return html;
    }

    //市
    function selectCity(cityId, selectId) {
        AM.ajaxRequestData("get", false, AM.ip + "/city/queryCityByParentId", {cityId : cityId, levelType : 2} , function(result){
            var html = "<option value=\"\">请选择或搜索市</option>";
            for (var i = 0; i < result.data.length; i++) {
                if (result.data[i].id == selectId) {
                    html += "<option selected=\"selected\" value=\"" + result.data[i].id + "\">" + result.data[i].shortName + "</option>";
                }
                else {
                    html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].shortName + "</option>";
                }
            }
            if (result.data.length == 0) {
                html += "<option value=\"0\" disabled>暂无</option>";
            }
            $("select[name='city']").html(html);
            $("select[name='city']").parent().parent().show();
        });
    }

    //区
    function selectCounty(cityId, selectId) {
        AM.ajaxRequestData("get", false, AM.ip + "/city/queryCityByParentId", {cityId : cityId, levelType : 3} , function(result){
            var html = "<option value=\"\">请选择或搜索县/区</option>";
            for (var i = 0; i < result.data.length; i++) {
                if (result.data[i].id == selectId) {
                    html += "<option selected=\"selected\" value=\"" + result.data[i].id + "\">" + result.data[i].shortName + "</option>";
                }
                else {
                    html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].shortName + "</option>";
                }
            }
            if (result.data.length == 0) {
                html += "<option value=\"0\" disabled>暂无</option>";
            }
            $("select[name='district']").html(html);
            $("select[name='district']").parent().parent().show();
        });
    }

    //获取角色列表
    function getRoleList (selectId) {
        AM.ajaxRequestData("get", false, AM.ip + "/role/list", {} , function(result){
            if(result.flag == 0 && result.code == 200){
                var html = "<option value=\"\">请选择角色类型</option>";
                for (var i = 0; i < result.data.length; i++) {
                    if (result.data[i].id == selectId) {
                        html += "<option selected=\"selected\" value=\"" + result.data[i].id + "\">" + result.data[i].roleName + "</option>";
                    }
                    else {
                        html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].roleName + "</option>";
                    }
                }
                if (result.data.length == 0) {
                    html += "<option value=\"0\" disabled>暂无</option>";
                }
                $("select[name='roleId']").html(html);
                $("select[name='roleId']").parent().parent().show();
            }
        });
    }


    //根据角色地区获取用户列表
    function getRoleUserList(selectId,roleId,provinceId , cityId , districtId , msg) {
        var ary = {
            roleId:roleId,
            provinceId : provinceId ,
            cityId : cityId,
            districtId : districtId
        }
        AM.ajaxRequestData("get", false, AM.ip + "/user/listForSelect", ary , function(result){
            if(result.flag == 0 && result.code == 200){
                var html = "<option value=\"\">" + msg + "</option>";
                for (var i = 0; i < result.data.length; i++) {
                    if (result.data[i].id == selectId) {
                        html += "<option selected=\"selected\" value=\"" + result.data[i].id + "\">" + result.data[i].showName + "</option>";
                    }
                    else {
                        html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].showName + "</option>";
                    }
                }
                if (result.data.length == 0) {
                    html += "<option value=\"0\" disabled>暂无</option>";
                }
                $("select[name='parentId']").html(html);
                $("select[name='parentId']").parent().parent().show();
            }
        });
    }

    //根据地区获取课程列表
    function getCurriculumList(selectId,provinceId , cityId , districtId) {
        var ary = {
            provinceId : provinceId ,
            cityId : cityId,
            districtId : districtId
        }
        AM.ajaxRequestData("get", false, AM.ip + "/curriculum/listForSelect", ary , function(result){
            if(result.flag == 0 && result.code == 200){
                var html = "<option value=\"\">请选择课程</option>";
                for (var i = 0; i < result.data.length; i++) {
                    if (result.data[i].id == selectId) {
                        html += "<option title ="+ result.data[i].price +" selected=\"selected\" value=\"" + result.data[i].id + "\">" + result.data[i].curriculumName + "</option>";
                    }
                    else {
                        html += "<option title ="+ result.data[i].price +" value=\"" + result.data[i].id + "\">" + result.data[i].curriculumName + "</option>";
                    }
                }
                if (result.data.length == 0) {
                    html += "<option value=\"0\" disabled>暂无</option>";
                }
                $("select[name='curriculumId']").html(html);
                $("select[name='curriculumId']").parent().parent().show();
            }
        });
    }




    $(function () {
        checkJurisdiction();

        document.onkeydown = function(event) {
            var code;
            if (!event) {
                event = window.event; //针对ie浏览器
                code = event.keyCode;
                if (code == 13) {
                    if (document.getElementsByClassName("layui-layer-btn0").length > 0) {
                        document.getElementsByClassName("layui-layer-btn0")[0].click();
                    }
                    if (document.getElementById("unlock")) {
                        document.getElementById("unlock").click();
                    }
                }
            }
            else {
                code = event.keyCode;
                if (code == 13) {
                    if (document.getElementsByClassName("layui-layer-btn0").length > 0) {
                        document.getElementsByClassName("layui-layer-btn0")[0].click();
                    }
                    if (document.getElementById("unlock")) {
                        document.getElementById("unlock").click();
                    }
                }
            }
        };

        $(".layui-btn").blur();

    });

</script>