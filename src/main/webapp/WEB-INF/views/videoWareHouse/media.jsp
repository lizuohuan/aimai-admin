<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/23 0023
  Time: 11:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>


点播上传配置
<hr />
<table frame=void width="100%">
    <tr>
        <td>uploadAuth:</td>
        <td><input type="text" id="uploadAuth" size="20" value="eyJTZWN1cml0eVRva2VuIjoiQ0FJU3pBUjFxNkZ0NUIyeWZTaklwckxQSFlQTnRLMTUvWktCU1VYQjAxa0ViYmhmbXAvTm9EejJJSHBOZTNocUIrMGZzUGt3bEdsVTZmZ2NsclVxRnNRWUh4U1lONVlxczg4SHExLzhKcGZadjh1ODRZQURpNUNqUWF3YmpQZ0JtSjI4V2Y3d2FmK0FVQm5HQ1RtZDVNY1lvOWJUY1RHbFFDWnVXLy90b0pWN2I5TVJjeENsWkQ1ZGZybC9MUmRqcjhsbzF4R3pVUEcyS1V6U24zYjNCa2hsc1JZZTcyUms4dmFIeGRhQXpSRGNnVmJtcUpjU3ZKK2pDNEM4WXM5Z0c1MTlYdHlwdm9weGJiR1Q4Q05aNXo5QTlxcDlrTTQ5L2l6YzdQNlFIMzViNFJpTkw4L1o3dFFOWHdoaWZmb2JIYTlZcmZIZ21OaGx2dkRTajQzdDF5dFZPZVpjWDBha1E1dTdrdTdaSFArb0x0OGphWXZqUDNQRTNyTHBNWUx1NFQ0OFpYVVNPRHREWWNaRFVIaHJFazRSVWpYZEk2T2Y4VXJXU1FDN1dzcjIxN290ZzdGeXlrM3M4TWFIQWtXTFg3U0IyRHdFQjRjNGFFb2tWVzRSeG5lelc2VUJhUkJwYmxkN0JxNmNWNWxPZEJSWm9LK0t6UXJKVFg5RXoycExtdUQ2ZS9MT3M3b0RWSjM3V1p0S3l1aDRZNDlkNFU4clZFalBRcWl5a1QwdEZncGZUSzFSemJQbU5MS205YmFCMjUvelcrUGREZTBkc1Znb0xGS0twaUdXRzNSTE5uK3p0Sjl4YUZ6ZG9aeUluUFNWcXNJNVRWTjJ1bzRDVlYzQUxjOHpzVnRxNDZydi8xT044ZVB1VlRmbzNCSmhxNFNFcGRFU3N4UThJcWY5MzdiRGhGT0U0aXpNTzV0ZXNkek1SV2hpVFM2d2YzRkUyLzJJamhvRjNVdGJ5ajdsWVVoQ3Nnck1pamJwSUpKRmpPYjM3M2RGRTdwVnArUFVjRDZwNVY1OEV1aU81N3NidWovVzQyV01ocDBhZ0FFVlFsUXoyM0M0MzBoRXpZZWE5Z3pIblczeWNLQ1NMd3ltSHdMa3grK2hPTzVWUnlQNlBIZUNUN1NkMFdqZ0FnWXJKVWx5TEhEQnEwc2pzR2dpZElrZ0pZaGQrOGlBUlN6WE1YZVJVcHJFWWtYWXhkSm91OEF6enZiVG4yeFNHTjJWdmVybUZsQXpkeENCdzhCaXJLNExhcGJHVE0vZ0l3aFdDNnpxV2ZmcUVRPT0iLCJBY2Nlc3NLZXlJZCI6IlNUUy5HcXpWOXlZclhKUGpLY3A3WVFhN3N1WmZCIiwiQWNjZXNzS2V5U2VjcmV0IjoiQWJrOXlHeENzWjdKUXFLYWNzdFc1eGZoczI0TVBUWnBjdXF1b0t2eU5QM0EiLCJFeHBpcmF0aW9uIjoiMzU4NSJ9"></td>
        <td>uploadAddress:</td>
        <td><input type="text" id="uploadAddress" size="20" value="eyJFbmRwb2ludCI6Imh0dHBzOi8vb3NzLWNuLXNoYW5naGFpLmFsaXl1bmNzLmNvbSIsIkJ1Y2tldCI6ImluLTIwMTgwMTE5MTUwMDQ2NTA0LTRxNnZvZGhpNXgiLCJGaWxlTmFtZSI6InZpZGVvL2Q4MWE1NTctMTYxMjFhNTNkNWEtMDAwNS03NDQyLTk4Mi0xNTU4NS5tcDQifQ=="></td>
        <td style="">uploadAuth及uploadAddress参数请查看<a href="https://help.aliyun.com/document_detail/52227.html?spm=5176.doc52200.2.4.yoajJn" target="_blank">获取上传地址和凭证 </a></td>
    </tr>
</table>
<hr />
STS上传配置
<hr />
<table frame=void width="100%">
    <tr>
        <td>accessKeyId:</td>
        <td><input type="text" id="accessKeyId" size="20" value=""></td>
        <td>accessKeySecret:</td>
        <td><input type="text" id="accessKeySecret" size="40" value=""></td>
    </tr>
    <tr>
        <td>secretToken:</td>
        <td><input type="text" id="secretToken" size="40" value=""></td>
    </tr>
    <tr>
        <td>endpoint:</td>
        <td><input type="text" id="endpoint" size="40" value=""></td>
        <td>bucket:</td>
        <td><input type="text" id="bucket" size="20" value=""></td>
    </tr>
    <tr>
        <td>object路径:</td>
        <td><input type="text" id="objectPre" size="20" value=""></td>

    </tr>
    <tr>
        <td></td>
        <td>以上相关参数如何获取，请查阅<a href="https://help.aliyun.com/document_detail/31867.html?spm=5176.doc31848.2.21.KS9R7q" target="_blakn"> OSS访问与控制文档</a></td>

    </tr>
</table>
<hr />

文件管理
<hr />
<input type="file" name="file" id="files" multiple/>
<button type="button" onclick="clearInputFile()">清空继续选择</button>
<button type="button" onclick="deleteFile()">删除文件</button>
<input type="text" id="deleteIndex" size="3" value="0">
<button type="button" onclick="cancelFile()">取消文件</button>
<input type="text" id="cancelIndex" size="3" value="0">

<button type="button" onclick="resumeFile()">恢复文件</button>
<input type="text" id="resumeIndex" size="3" value="0">
<hr />
列表管理
<hr />
<button type="button" onclick="getList()">获取上传列表</button>
<button type="button" onclick="clearList()">清理上传列表</button>
<hr />
上传管理
<hr/>
<button type="button" onclick="start()">开始上传</button>
<!--  <button type="button" onclick="stop()">停止上传</button> -->
<button type="button" onclick="resumeWithToken()">token过期恢复上传</button>
<hr />
<select multiple="multiple" id="textarea" style="position:relative; width:90%; height:450px; vertical-align:top; border:1px solid #cccccc;"></select>
<button type="button" onclick="clearLog()">清日志</button>



<script src="<%=request.getContextPath()%>/resources/media/lib/es6-promise.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/media/lib/aliyun-oss-sdk.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/media/aliyun-upload-sdk-1.3.0.min.js"></script>
<script>

    var accessKeyId = document.getElementById("accessKeyId").value;
    var accessKeySecret = document.getElementById("accessKeySecret").value;
    var secretToken = document.getElementById("secretToken").value;
    var secretToken = document.getElementById("secretToken").value;



    var uploader = new AliyunUpload.Vod({
        // 文件上传失败
        'onUploadFailed': function (uploadInfo, code, message) {
            log("onUploadFailed: file:" + uploadInfo.file.name + ",code:" + code + ", message:" + message);
        },
        // 文件上传完成
        'onUploadSucceed': function (uploadInfo) {
            log("--------------------------------");
            log("------OBJ---------------" + JSON.stringify(uploadInfo));
            log("onUploadSucceed: " + uploadInfo.file.name + ", endpoint:" + uploadInfo.endpoint + ", bucket:" + uploadInfo.bucket + ", object:" + uploadInfo.object);
            log("--------------------------------");
        },
        // 文件上传进度
        'onUploadProgress': function (uploadInfo, totalSize, loadedPercent) {
            log("onUploadProgress:file:" + uploadInfo.file.name + ", fileSize:" + totalSize + ", percent:" + Math.ceil(loadedPercent * 100.00) + "%");
        },
        // STS临时账号会过期，过期时触发函数
        'onUploadTokenExpired': function () {
            log("onUploadTokenExpired");
            if (isVodMode()) {
                // 实现时，从新获取UploadAuth
                // uploader.resumeUploadWithAuth(uploadAuth);
            } else if (isSTSMode()) {
                // 实现时，从新获取STS临时账号用于恢复上传
                // uploader.resumeUploadWithSTSToken(accessKeyId, accessKeySecret, secretToken, expireTime);
            }
        },
        onUploadCanceled:function(uploadInfo)
        {
            log("onUploadCanceled:file:" + uploadInfo.file.name);
        },
        // 开始上传
        'onUploadstarted': function (uploadInfo) {
            console.debug(JSON.stringify(uploadInfo));
            if (isVodMode()) {
                var uploadAuth = document.getElementById("uploadAuth").value;
                var uploadAddress = document.getElementById("uploadAddress").value;
                uploader.setUploadAuthAndAddress(uploadInfo, uploadAuth, uploadAddress);
            }
            else if (isSTSMode()) {
                var accessKeyId = document.getElementById("accessKeyId").value;
                var accessKeySecret = document.getElementById("accessKeySecret").value;
                var secretToken = document.getElementById("secretToken").value;
                uploader.setSTSToken(uploadInfo, accessKeyId, accessKeySecret,secretToken);
            }
            log("onUploadStarted:" + uploadInfo.file.name + ", endpoint:" + uploadInfo.endpoint + ", bucket:" + uploadInfo.bucket + ", object:" + uploadInfo.object);
        }
    });

    // 点播上传。每次上传都是独立的鉴权，所以初始化时，不需要设置鉴权
    // 临时账号过期时，在onUploadTokenExpired事件中，用resumeWithToken更新临时账号，上传会续传。
    var selectFile = function (event) {
        var endpoint = document.getElementById("endpoint").value;
        var bucket = document.getElementById("bucket").value;
        var objectPre = document.getElementById("objectPre").value;
        var userData;
        if (isVodMode()) {
            userData = '{"Vod":{"UserData":{"IsShowWaterMark":"false","Priority":"7"}}}';
        } else {
            userData = '{"Vod":{"Title":"this is title.我是标题","Description":"this is desc.我是描述","CateId":"19","Tags":"tag1,tag2,标签3","UserData":"user data"}}';
        }

        for(var i=0; i<event.target.files.length; i++) {
            log("add file: " + event.target.files[i].name);
            if (isVodMode()) {
                // 点播上传。每次上传都是独立的OSS object，所以添加文件时，不需要设置OSS的属性
                uploader.addFile(event.target.files[i], null, null, null, userData);
            } else if(isSTSMode()) {
                // STS的上传方式，需要在userData里指定Title
                var object = "";
                if(objectPre)
                {
                    object = objectPre +"/"+ event.target.files[i].name;
                }
                uploader.addFile(event.target.files[i], endpoint, bucket, object , userData);
            }
        }
    };

    document.getElementById("files")
        .addEventListener('change', selectFile);

    var textarea=document.getElementById("textarea");

    function start() {
        log("start upload.");
        uploader.startUpload();
    }

    function stop() {
        log("stop upload.");
        uploader.stopUpload();
    }

    function resumeWithToken() {
        log("resume upload with token.");
        var uploadAuth = document.getElementById("uploadAuth").value;

        var accessKeyId = document.getElementById("accessKeyId").value;
        var accessKeySecret = document.getElementById("accessKeySecret").value;
        var secretToken = document.getElementById("secretToken").value;

        if (isVodMode()) {
            uploader.resumeUploadWithAuth(uploadAuth);
        } else if (isSTSMode()) {
            uploader.resumeUploadWithSTSToken(accessKeyId, accessKeySecret, secretToken);
        }
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

    function clearList() {
        log("clean upload list.");
        uploader.cleanList();
    }

    function getList() {
        log("get upload list.");
        var list = uploader.listFiles();
        for (var i=0; i<list.length; i++) {
            log("file:" + list[i].file.name + ", status:" + list[i].state + ", endpoint:" + list[i].endpoint + ", bucket:" + list[i].bucket + ", object:" + list[i].object);
        }
    }

    function deleteFile() {
        if (document.getElementById("deleteIndex").value) {
            var index = document.getElementById("deleteIndex").value
            log("delete file index:" + index);
            uploader.deleteFile(index);
        }
    }

    function cancelFile() {
        if (document.getElementById("cancelIndex").value) {
            var index = document.getElementById("cancelIndex").value
            log("cancel file index:" + index);
            uploader.cancelFile(index);
        }
    }

    function resumeFile() {
        if (document.getElementById("resumeIndex").value) {
            var index = document.getElementById("resumeIndex").value
            log("resume file index:" + index);
            uploader.resumeFile(index);
        }
    }

    function clearLog() {
        textarea.options.length = 0;
    }

    function log(value) {
        if (!value) {
            return;
        }

        var len = textarea.options.length;
        if (len > 0 && textarea.options[len-1].value.substring(0, 40) == value.substring(0, 40)) {
            //textarea.remove(len-1);
        } else if (len > 25) {
            textarea.remove(0);
        }

        var option=document.createElement("option");
        option.value=value,option.innerHTML=value;
        textarea.appendChild(option);
    }

    function isVodMode() {
        var uploadAuth = document.getElementById("uploadAuth").value;
        return (uploadAuth && uploadAuth.length > 0);
    }

    function isSTSMode() {
        var secretToken = document.getElementById("secretToken").value;
        if (!isVodMode()) {
            if (secretToken && secretToken.length > 0) {
                return true;
            }
        }
        return false;
    }

    AliyunUpload.__logTestCallback__ = function(logInfo)
    {
        console.log(logInfo);
    }
</script>



</body>
</html>
