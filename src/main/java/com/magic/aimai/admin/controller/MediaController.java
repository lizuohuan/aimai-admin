package com.magic.aimai.admin.controller;

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.auth.*;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.FormatType;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.vod.model.v20170321.*;
import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.business.cache.MemcachedUtil;
import com.magic.aimai.business.media.MediaConfig;
import com.magic.aimai.business.util.Base64;
import com.magic.aimai.business.util.CommonUtil;
import com.magic.aimai.business.util.LoginHelper;
import com.magic.aimai.business.util.StatusConstant;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

/**
 * Created by Eric Xie on 2018/1/23 0023.
 */
@RestController
@RequestMapping("/media")
public class MediaController extends BaseController {


    /**
     *
     * @param videoId
     * @param definition 视频流清晰度,多个用逗号分隔
     *                   取值：FD(流畅)，LD(标清)，SD(高清)，HD(超清)，OD(原画)，2K(2K)，4K(4K)，默认获取所有清晰度的流
     * @return
     */
    @RequestMapping(value = "/getVideoInfo",method = RequestMethod.POST)
    public ViewData getVideoInfo(String videoId,String definition){
        if(!CommonUtil.isEmpty(definition) && !"FD".equals(definition) && !"LD".equals(definition)
                && !"SD".equals(definition) && !"HD".equals(definition) && !"OD".equals(definition)
                && !"2K".equals(definition) && !"4K".equals(definition)){
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,"参数异常");
        }
        if(CommonUtil.isEmpty(videoId)){
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,"参数异常");
        }
        DefaultAcsClient aliYunClient = MediaConfig.buildAliyunClient();
        GetPlayInfoRequest request = new GetPlayInfoRequest();
        request.setVideoId(videoId);  // 准备播放的视频ID
        request.setFormats("mp4");
        GetPlayInfoResponse response = null;
        try {
            response = aliYunClient.getAcsResponse(request);
        }  catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"获取失败");
        }
        Map<String,Object> map = new HashMap<>();
        map.put("videoBase",response.getVideoBase());
        map.put("infoList",response.getPlayInfoList());
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功",map);
    }


    /**
     *
     * @param fileName 源文件名称.mp4
     *                 视频源文件名称（必须带后缀, 支持 ".3gp", ".asf", ".avi", ".dat", ".dv",
     *                 ".flv", ".f4v", ".gif", ".m2t", ".m3u8", ".m4v", ".mj2", ".mjpeg",
     *                 ".mkv", ".mov", ".mp4", ".mpe", ".mpg", ".mpeg", ".mts", ".ogg", ".qt",
     *                 ".rm", ".rmvb", ".swf", ".ts", ".vob", ".wmv", ".webm"".aac", ".ac3", ".acm",
     *                 ".amr", ".ape", ".caf", ".flac", ".m4a", ".mp3", ".ra", ".wav", ".wma"）
     * @return
     */
    @RequestMapping(value = "/getMediaAuthAndAddress",method = RequestMethod.POST)
    public ViewData getMediaAuthAndAddress(String fileName){

        DefaultAcsClient aliYunClient = MediaConfig.buildAliyunClient();
        CreateUploadVideoRequest request = new CreateUploadVideoRequest();
        CreateUploadVideoResponse response = null;
        try {
            request.setFileName(fileName);
            request.setTitle(UUID.randomUUID().toString());
            response = aliYunClient.getAcsResponse(request);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"获取失败");
        }
        Map<String,Object> map = new HashMap<>();
        map.put("requestId",response.getRequestId());
        map.put("uploadAuth",response.getUploadAuth());
        map.put("uploadAddress",response.getUploadAddress());
        map.put("videoId",response.getVideoId());
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功",map);
    }


    /**
     * 当网络异常导致文件上传失败时
     * 可刷新上传凭证后再次执行上传操作
     * @param videoId 获取的视频ID
     * @return
     */
    @RequestMapping(value = "/refreshMediaAuthAndAddress",method = RequestMethod.POST)
    public ViewData refreshMediaAuthAndAddress(String videoId){
        DefaultAcsClient aliYunClient = MediaConfig.buildAliyunClient();
        RefreshUploadVideoRequest request = new RefreshUploadVideoRequest();
        RefreshUploadVideoResponse response = null;
        try {
            request.setVideoId(videoId);
            response = aliYunClient.getAcsResponse(request);
        }catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"获取失败");
        }
        Map<String,Object> map = new HashMap<>();
        map.put("requestId",response.getRequestId());
        map.put("uploadAuth",response.getUploadAuth());
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功",map);
    }


    @RequestMapping(value = "/getSignDelVideo")
    public ViewData getSignDelVideo(String videoIds){
        Map<String,String> map = new HashMap<>();
        map.put("Version","2017-03-21");
        map.put("Action","DeleteVideo");
        map.put("VideoIds",videoIds);
        Signer signer = new HmacSHA1Signer();
        ISignatureComposer composer = RpcSignatureComposer.getComposer();
        Map<String, String> signParameters = composer.refreshSignParameters(map, signer, MediaConfig.getAccessKeyId(), FormatType.JSON);
        String s = composer.composeStringToSign(MethodType.GET, null, null, signParameters, null, null);
        String sign = signer.signString(s, MediaConfig.getAccessKeySecret());
        signParameters.put("Signature",sign);
        signParameters.put("s",s);
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功", signParameters);
    }


    /**
     *  删除视频接口
     * @param videoIds
     * @return
     */
    @RequestMapping(value = "/delVideo")
    public ViewData delVideo(String videoIds){
        if(CommonUtil.isEmpty(videoIds)){
            return buildFailureJson(StatusConstant.Fail_CODE,"字段不能为空");
        }

        DefaultAcsClient aliYunClient = MediaConfig.buildAliyunClient();
        DeleteVideoRequest request = new DeleteVideoRequest();
        request.setVideoIds(videoIds);
        try {
            DeleteVideoResponse acsResponse = aliYunClient.getAcsResponse(request);
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"操作成功",acsResponse.getRequestId());
        } catch (ClientException e) {
            logger.error(e.getErrCode(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"操作失败");
        }
    }



}
