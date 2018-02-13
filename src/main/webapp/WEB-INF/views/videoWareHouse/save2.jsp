<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加视频库视频</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <style>
        .preview{height: 350px;width: 400px;margin-right: 10px;margin-bottom: 10px;float: left;text-align: center}
        .preview img{width: 100%;height:210px;border: 1px solid #eee;}
        .preview video{width: 100%;height:210px;border: 1px solid #eee;}
        .layui-bg-cyan{color: white}
    </style>
</head>
<body>
<div style="margin: 15px;">
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>添加视频库视频</legend>
    </fieldset>
    <form class="layui-form" action=""  >
        <div class="layui-form-item" id="uploadImgDiv">
            <label class="layui-form-label">选择上传视频<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="file"  id="files" name="file"  lay-title="请上传视频" >
            </div>
        </div>
        <div class="layui-form-item" id="previewDiv">
            <label class="layui-form-label">视频列表</label>
            <div class="layui-input-block" id="preview">

            </div>
        </div>
        <div class="layui-form-item layui-hide" id="jindu">
            <label class="layui-form-label"></label>
            <div class="layui-input-inline">
                <div class="layui-progress layui-progress-big ">
                    <div class="layui-progress-bar layui-bg-cyan" lay-percent="0%"></div>
                </div>
            </div>
        </div>




        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<!--引入抽取公共js-->
<%@include file="../common/public-js.jsp" %>
<script src="<%=request.getContextPath()%>/resources/media/lib/es6-promise.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/media/lib/aliyun-oss-sdk.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/media/aliyun-upload-sdk-1.3.0.min.js"></script>
<script>


    $(function(){
        setInterval(function(){
            $(".previewContent").each(function () {
                var button = $(this).find("input[name=btn2]");
                var objDiv = $(this);
                if(typeof(button.val()) != 'undefined'){
                    var videoId = $(this).find("input[name=videoId]").val();
                    var fileName = $(this).find("input[name=fileName]").val();
                    var arr = {
                        videoId : videoId
                    };
                    $.ajax({
                        type: "POST",
                        async: false,
                        url: AM.ip + "/media/getVideoInfo",
                        data: arr,
                        success:function(result){
                            if (!AM.isJson(result)) {
                                result = JSON.parse(result);
                            }
                            if(result.flag == 0 && result.code == 200){
                                var url = "";
                                var urlFD = "";
                                for(var i = 0; i < result.data.infoList.length; i++){
                                    if(result.data.infoList[i].definition == 'FD' && result.data.infoList[i].format == 'mp4'){
                                        urlFD = result.data.infoList[i].playURL;
                                    }
                                    if(result.data.infoList[i].definition == 'LD' && result.data.infoList[i].format == 'mp4'){
                                        url = result.data.infoList[i].playURL;
                                        break;
                                    }
                                }
                                if("" == url || "" == urlFD){
                                    return;
                                }
                                var obj = JSON.stringify(result.data);
                                var html =
                                    // '<div class="preview previewContent">' +
                                    '<video videoUrl="'+url+'" id="video" controls="controls" src="'+url +'"></video><br>' +
                                    '<input type="text" name="videoName" value="'+fileName+'" placeholder="请输入视频名字" autocomplete="off" class="layui-input" maxlength="50"><br>' +
                                    '<input type="hidden" name="duration"  value="'+result.data.videoBase.duration+'"><br>' +
                                    '<input type="hidden" name="videoId"  value="'+result.data.videoBase.videoId+'"><br>' +
                                    '<input type="hidden" name="videoObj"  value='+obj.toString()+'><br>' +
                                    "<button type=\"button\" class=\"layui-btn layui-btn-danger\" onclick=\"deleteVideo(this)\"><i class=\"layui-icon\">&#xe640;</i>删除</button>" ;
                                // "</div>";
                                console.debug(html)
                                console.log(objDiv.html());
                                objDiv.html(html)
                            }
                        },
                        error: function(json) {
                            layer.msg(json.responseText);
                        }
                    })
                }
            })
        },5000);
    });
    

    var form;
    var element;
    var layer;
    layui.use(['form', 'element'], function() {
        form = layui.form(),
            layer = layui.layer,
            element = layui.element;


            //监听提交
        form.on('submit(demo1)', function(data) {
            var divs = $("#preview").find("div");
            var videos = [];
            for (var i = 0; i < divs.length; i++){
                var obj = {};
                var videoDiv = divs[i];
                if($(videoDiv).find("input[name='videoName']").val() == ''){
                    layer.msg("视频名称不能为空");
                    return false;
                }
                obj.videoName = $(videoDiv).find("input[name='videoName']").val();
                if(null == $(videoDiv).find("input[name='videoObj']").val() || "" == $(videoDiv).find("input[name='videoObj']").val()){
                    layer.msg("还有视频没有处理完成");
                    return false;
                }
                obj.videoObj = JSON.parse($(videoDiv).find("input[name='videoObj']").val());
                videos.push(obj);
            }
            if(videos.length == 0){
                layer.msg("没有上传视频");
                return false;
            }
            var arr = {
                videos : JSON.stringify(videos)
            }
            AM.ajaxRequestData("POST", false, AM.ip + "/videoWareHouse/addVideoOfAliYun", arr , function(result) {
                if (result.flag == 0 && result.code == 200) {
                    var index =layer.alert('添加成功.', {
                        skin: 'layui-layer-molv' //样式类名
                        ,closeBtn: 0
                        ,anim: 4 //动画类型
                    }, function(){
                        //关闭iframe页面
                        var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                        parent.layer.close(index);
                        window.parent.closeNodeIframe();
                    });
                }
            });
            return false;
        });

    });


    var uploader = new AliyunUpload.Vod({
        // 文件上传失败
        'onUploadFailed': function (uploadInfo, code, message) {
            layer.msg("上传失败！")
            $("#jindu").hide();
            $(".layui-bg-cyan").css("width",  "0%").html("0%");
            $("#files").show();
        },
        // 文件上传完成
        'onUploadSucceed': function (uploadInfo) {

            clearInputFile();

            var html = '<div class="preview previewContent">' +
                '<span>正在转码处理中,请稍候</span>' +
                '<input type="button" class="layui-btn layui-btn-xs" value="刷新获取" name="btn2" onclick="getVideo(this,\''+uploadInfo.videoInfo.UserData.videoId+'\',\''+uploadInfo.videoInfo.UserData.fileName+'\')"/>' +
                '<input type="hidden" name="videoId"  value="'+uploadInfo.videoInfo.UserData.videoId+'"><br>' +
                '<input type="hidden" name="fileName"  value="'+uploadInfo.videoInfo.UserData.fileName+'"><br>' +
                "<button type=\"button\" class=\"layui-btn layui-btn-danger\" onclick=\"deleteVideo(this)\"><i class=\"layui-icon\">&#xe640;</i>删除</button>" +
                "</div>";
            $("#preview").append(html);
            $("#preview").parent().show();
            $("#jindu").hide();
            $(".layui-bg-cyan").css("width",  "0%").html("0%");
            $("#files").show();

            // setTimeout(function(){
            //     AM.ajaxRequestData("post", false, AM.ip + "/media/getVideoInfo", arr , function(result) {
            //         if (result.code == 200) {
            //             var url = "";
            //             for(var i = 0; i < result.data.infoList.length; i++){
            //                 if(result.data.infoList[i].definition == 'OD' && result.data.infoList[i].format == 'mp4'){
            //                     url = result.data.infoList[i].playURL;
            //                     break;
            //                 }
            //             }
            //             var obj = JSON.stringify(result.data);
            //             var html = '<div class="preview previewContent">' +
            //                             '<video videoUrl="'+url+'" id="video" controls="controls" src="'+url +'"></video><br>' +
            //                             '<input type="text" name="videoName" value="'+uploadInfo.videoInfo.UserData.fileName+'" placeholder="请输入视频名字" autocomplete="off" class="layui-input" maxlength="50"><br>' +
            //                             '<input type="hidden" name="duration"  value="'+result.data.videoBase.duration+'"><br>' +
            //                             '<input type="hidden" name="videoId"  value="'+result.data.videoBase.videoId+'"><br>' +
            //                             '<input type="hidden" name="videoObj"  value='+obj+'><br>' +
            //                             "<button type=\"button\" class=\"layui-btn layui-btn-danger\" onclick=\"deleteVideo(this)\"><i class=\"layui-icon\">&#xe640;</i>删除</button>" +
            //                         "</div>";
            //             $("#preview").append(html);
            //             $("#preview").parent().show();
            //         }
            //         $("#jindu").hide();
            //         $(".layui-bg-cyan").css("width",  "0%").html("0%");
            //         $("#files").show();
            //     });
            // },2000)
        },
        // 文件上传进度
        'onUploadProgress': function (uploadInfo, totalSize, loadedPercent) {
            $(".layui-bg-cyan").css("width", Math.ceil(loadedPercent * 100.00) + "%").html(Math.ceil(loadedPercent * 100.00) + "%");
        },
        onUploadCanceled:function(uploadInfo)
        {
            console.debug("onUploadCanceled:file:" + uploadInfo.file.name);
        },
        // 开始上传
        'onUploadstarted': function (uploadInfo) {

            var arr = {
                fileName : uploadInfo.file.name
            }
            var uploadAuth = "";
            var uploadAddress = "";
            var videoId = "";
            AM.ajaxRequestData("post", false, AM.ip + "/media/getMediaAuthAndAddress", arr , function(result) {
                if (result.code == 200) {
                    uploadAuth = result.data.uploadAuth;
                    uploadAddress = result.data.uploadAddress;
                    videoId = result.data.videoId;
                }
            });
            uploadInfo.videoInfo.UserData.videoId = videoId;
            uploader.setUploadAuthAndAddress(uploadInfo, uploadAuth, uploadAddress);
            console.debug("onUploadStarted:" + uploadInfo.file.name + ", endpoint:" + uploadInfo.endpoint + ", bucket:" + uploadInfo.bucket + ", object:" + uploadInfo.object);
        }
    });


    var selectFile = function (event) {

        for(var i=0; i<event.target.files.length; i++) {
            console.debug("添加文件: " + event.target.files[i].name);
            var userData = '{"Vod":{"UserData":{"IsShowWaterMark":"false","Priority":"7","fileName":"'+event.target.files[i].name+'"}}}';
            // 点播上传。每次上传都是独立的OSS object，所以添加文件时，不需要设置OSS的属性
            uploader.addFile(event.target.files[i], null, null, null, userData);
        }
        $("#jindu").show();
        $("#files").hide();
        uploader.startUpload();
        /*fileList();*/
    };

    document.getElementById("files")
        .addEventListener('change', selectFile);



    /**
     * delete Video
     * @param obj
     */
    function deleteVideo(obj) {
        $(obj).parent().remove();

        var videoId = $(obj).parent().find("input[name='videoId']").val();
        var arr = {
            videoIds : videoId
        }
        AM.ajaxRequestData("post", false, AM.ip + "/media/delVideo", arr , function(result) {

        });

    }



    
    function getVideo(objThis,videoId,fileName) {
        var arr = {
            videoId : videoId
        };
        $.ajax({
            type: "POST",
            async: false,
            url: AM.ip + "/media/getVideoInfo",
            data: arr,
            headers: {
                // "token" : AM.aiMaiUser() == null ? null : AM.aiMaiUser().token,
            },
            success:function(result){
                if (!AM.isJson(result)) {
                    result = JSON.parse(result);
                }
                if(result.flag == 0 && result.code == 200){
                    var url = "";
                    var urlFD = "";
                    for(var i = 0; i < result.data.infoList.length; i++){
                        if(result.data.infoList[i].definition == 'FD' && result.data.infoList[i].format == 'mp4'){
                            urlFD = result.data.infoList[i].playURL;
                        }
                        if(result.data.infoList[i].definition == 'LD' && result.data.infoList[i].format == 'mp4'){
                            url = result.data.infoList[i].playURL;
                            break;
                        }
                    }
                    if("" == url || "" == urlFD){
                        layer.msg("正在处理中.请耐心等待...");
                        return;
                    }
                    console.debug(result.data);
                    var obj = JSON.stringify(result.data);
                    console.debug(result.data);
                    var html =
                        // '<div class="preview previewContent">' +
                        '<video videoUrl="'+url+'" id="video" controls="controls" src="'+url +'"></video><br>' +
                        '<input type="text" name="videoName" value="'+fileName+'" placeholder="请输入视频名字" autocomplete="off" class="layui-input" maxlength="50"><br>' +
                        '<input type="hidden" name="duration"  value="'+result.data.videoBase.duration+'"><br>' +
                        '<input type="hidden" name="videoId"  value="'+result.data.videoBase.videoId+'"><br>' +
                        '<input type="hidden" name="videoObj"  value='+obj.toString()+'><br>' +
                        "<button type=\"button\" class=\"layui-btn layui-btn-danger\" onclick=\"deleteVideo(this)\"><i class=\"layui-icon\">&#xe640;</i>删除</button>" ;
                        // "</div>";
                    console.debug(html)
                    console.log($(objThis).parent().html());
                    $(objThis).parent().html(html)
                    // $("#preview").append(html);
                    // $("#preview").parent().show();
                }
                else {
                    layer.msg("正在处理中.请耐心等待...");
                }
            },
            error: function(json) {
                layer.msg(json.responseText);
            }
        })
    }

    function clearInputFile()
    {
        var ie = (navigator.appVersion.indexOf("MSIE")!=-1);
        if( ie ){
            var file = document.getElementById("files");
            var file2= file.cloneNode(false);
            file2.addEventListener('change', selectFile);
            file.parentNode.replaceChild(file2,file);
        }
        else
        {
            document.getElementById("files").value = '';
        }

    }

</script>
</body>
</html>
