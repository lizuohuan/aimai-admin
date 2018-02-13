package com.magic.aimai.admin.controller;

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.vod.model.v20170321.DeleteVideoRequest;
import com.aliyuncs.vod.model.v20170321.DeleteVideoResponse;
import com.aliyuncs.vod.model.v20170321.GetPlayInfoRequest;
import com.aliyuncs.vod.model.v20170321.GetPlayInfoResponse;
import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.entity.VideoWareHouse;
import com.magic.aimai.business.media.MediaConfig;
import com.magic.aimai.business.service.VideoWareHouseService;
import com.magic.aimai.business.util.CommonUtil;
import com.magic.aimai.business.util.StatusConstant;
import com.magic.aimai.business.util.Timestamp;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author lzh
 * @create 2017/8/15 14:36
 */
@RestController
@RequestMapping("/videoWareHouse")
public class VideoWareHouseController extends BaseController {

    @Resource
    private VideoWareHouseService videoWareHouseService;

    /**
     * 后台页面 分页获取视频库
     * @param pageArgs 分页属性
     * @param curriculumName 课程名
     * @param courseWareName 课时名
     * @param name 视频名
     * @param startTimes  创建开始时间
     * @param endTimes 创建结束时间
     * @param isBand 是否绑定 0：未绑定  1：已绑定
     * @param id 视频id
     * @return
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , String curriculumName , String courseWareName ,
                             String name , String startTimes , String endTimes , Integer isBand ,Integer id,
                             Integer isCloud) {
        try {
            Date startTime = null;
            Date endTime = null;
            if (null != startTimes && !startTimes.equals("")) {
                startTime = Timestamp.parseDate2(startTimes,"yyyy-MM-dd HH:mm:ss");
            }
            if (null != endTimes && !endTimes.equals("")) {
                endTime = Timestamp.parseDate2(endTimes,"yyyy-MM-dd HH:mm:ss");
            }
            PageList pageList = videoWareHouseService.listForAdmin(pageArgs,curriculumName,
                    courseWareName ,name,startTime ,endTime ,isBand,id,isCloud);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    @RequestMapping(value = "/addVideoOfAliYun")
    public ViewData addVideoOfAliYun(String videos){

        if(CommonUtil.isEmpty(videos)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        JSONArray array = JSONArray.fromObject(videos);
        List<VideoWareHouse> videoList = new ArrayList<>();
        for (Object o : array) {
            JSONObject object = JSONObject.fromObject(o);
            VideoWareHouse v = new VideoWareHouse();
            v.setFlag(0);
            v.setIsBand(0);
            v.setName(object.getString("videoName"));
            JSONObject videoObj = object.getJSONObject("videoObj");
            JSONObject videoBase = videoObj.getJSONObject("videoBase");
            v.setCoverURL(videoBase.getString("coverURL"));
            v.setSeconds(videoBase.getInt("duration"));
            v.setVideoId(videoBase.getString("videoId"));
            // 通过videoId 获取详情
            DefaultAcsClient aliYunClient = MediaConfig.buildAliyunClient();
            GetPlayInfoRequest request = new GetPlayInfoRequest();
            request.setVideoId(v.getVideoId());  // 准备播放的视频ID
            request.setFormats("mp4");
            GetPlayInfoResponse response = null;
            try {
                response = aliYunClient.getAcsResponse(request);
            }  catch (Exception e) {
                logger.error(e.getMessage(),e);
                return buildFailureJson(StatusConstant.Fail_CODE,"获取失败");
            }
            List<GetPlayInfoResponse.PlayInfo> playInfoList = response.getPlayInfoList();
            for (GetPlayInfoResponse.PlayInfo playInfo : playInfoList) {
                String playURL = playInfo.getPlayURL();
                switch (playInfo.getDefinition()){
                    case "FD" :
                        v.setFd(playURL);
                        break;
                    case "LD" :
                        v.setLd(playURL);
                        break;
                    case "SD" :
                        v.setSd(playURL);
                        break;
                    case "HD" :
                        v.setHd(playURL);
                        break;
                    case "OD" :
                        v.setOd(playURL);
                        break;
                }
            }
            videoList.add(v);
        }
        if(videoList.size() > 0){
            videoWareHouseService.save(videoList);
        }
        return buildSuccessCodeViewData(StatusConstant.SUCCESS_CODE,"操作成功");
    }


    @RequestMapping(value = "/updateVideoOfAliYun")
    public ViewData updateVideoOfAliYun(Integer id,String videoName,String videos,String videoId){

        if(CommonUtil.isEmpty(id,videoName)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        VideoWareHouse info = videoWareHouseService.info(id);
        if(null == info){
            return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,"视频不存在");
        }
        if(!CommonUtil.isEmpty(videos) && CommonUtil.isEmpty(videoId)){
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,"参数异常");
        }

        VideoWareHouse v = new VideoWareHouse();
        v.setId(id);
        v.setName(videoName);
        if(!CommonUtil.isEmpty(videos)){
            JSONObject object = JSONObject.fromObject(videos);
            JSONObject videoObj = object.getJSONObject("videoObj");
            JSONObject videoBase = videoObj.getJSONObject("videoBase");
            v.setCoverURL(videoBase.getString("coverURL"));
            v.setSeconds(videoBase.getInt("duration"));
            v.setVideoId(videoBase.getString("videoId"));
            // 通过videoId 获取详情
            DefaultAcsClient aliYunClient = MediaConfig.buildAliyunClient();
            GetPlayInfoRequest request = new GetPlayInfoRequest();
            request.setVideoId(v.getVideoId());  // 准备播放的视频ID
            request.setFormats("mp4");
            GetPlayInfoResponse response = null;
            try {
                response = aliYunClient.getAcsResponse(request);
            }  catch (Exception e) {
                logger.error(e.getMessage(),e);
                return buildFailureJson(StatusConstant.Fail_CODE,"获取失败");
            }
            List<GetPlayInfoResponse.PlayInfo> playInfoList = response.getPlayInfoList();
            for (GetPlayInfoResponse.PlayInfo playInfo : playInfoList) {
                String playURL = playInfo.getPlayURL();
                switch (playInfo.getDefinition()){
                    case "FD" :
                        v.setFd(playURL);
                        break;
                    case "LD" :
                        v.setLd(playURL);
                        break;
                    case "SD" :
                        v.setSd(playURL);
                        break;
                    case "HD" :
                        v.setHd(playURL);
                        break;
                    case "OD" :
                        v.setOd(playURL);
                        break;
                }
            }
        }
        videoWareHouseService.updateSigle(v);
        try {
            if(!CommonUtil.isEmpty(videos) && !CommonUtil.isEmpty(info.getVideoId())){
                DefaultAcsClient aliYunClient = MediaConfig.buildAliyunClient();
                DeleteVideoRequest request = new DeleteVideoRequest();
                request.setVideoIds(info.getVideoId());
                aliYunClient.getAcsResponse(request);
            }
        } catch (ClientException e) {
            logger.error("视频删除失败！",e);
        }
        return buildSuccessCodeViewData(StatusConstant.SUCCESS_CODE,"操作成功");
    }


    /**
     * 后台页面 获取视频库下拉列表
     * @param isBand 是否绑定 0：未绑定  1：已绑定
     * @param id 视频id
     * @param isCloud 是否云视频库  0 ： 否  1：是
     * @return
     */
    @RequestMapping("/listSel")
    public ViewDataPage listSel(Integer isBand ,Integer id,Integer isCloud) {
        try {
            PageList pageList = videoWareHouseService.listForAdmin(null,null,
                    null ,null,null ,null ,isBand,id,isCloud);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }

    /**
     * 批量添加课时视频
     * @param videoWareHouses 视频的json字符串
     * @return
     */
    @RequestMapping("/save")
    public ViewData save(String videoWareHouses){
        try {
            if (null == videoWareHouses || "".equals(videoWareHouses)) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            videoWareHouseService.save(videoWareHouses);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"添加成功 ");
        } catch (Exception e) {
            logger.error("服务器超时，添加失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，添加失败");
        }
    }

    /**
     * 更新课时视频
     * @param videoWareHouse
     * @return
     */
    @RequestMapping("/update")
    public ViewData update(VideoWareHouse videoWareHouse){
        try {
            videoWareHouseService.update(videoWareHouse);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功 ");
        } catch (Exception e) {
            logger.error("服务器超时，更新失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }



    /**
     * 视频详情
     * @param id 视频id
     * @return
     */
    @RequestMapping("/info")
    public ViewData info(Integer id){
        try {
            if (null == id) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功 ",videoWareHouseService.info(id));
        } catch (Exception e) {
            logger.error("服务器超时，获取失败 ",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    /**
     * 删除视频
     * @param id 视频id
     * @return
     */
    @RequestMapping("/delete")
    public ViewData delete(Integer id){
        try {
            if (null == id) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            videoWareHouseService.delete(id);
            return buildFailureJson(StatusConstant.SUCCESS_CODE,"删除成功 ");
        } catch (Exception e) {
            logger.error("服务器超时，删除失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，删除失败");
        }
    }


}
