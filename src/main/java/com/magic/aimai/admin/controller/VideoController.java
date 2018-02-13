package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.entity.Trade;
import com.magic.aimai.business.entity.Video;
import com.magic.aimai.business.exception.InterfaceCommonException;
import com.magic.aimai.business.service.VideoService;
import com.magic.aimai.business.util.CommonUtil;
import com.magic.aimai.business.util.StatusConstant;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * 课时视频
 * @author lzh
 * @create 2017/7/21 14:45
 */
@RestController
@RequestMapping("/video")
public class VideoController extends BaseController {

    @Resource
    private VideoService videoService;

    /**
     * 后台页面 分页获取课时视频
     * @param pageArgs 分页属性
     * @param name 课时视频名
     * @return 行业分类
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , String name ,Integer courseWareId ,Integer source) {
        try {
            PageList pageList = videoService.listForAdmin(pageArgs, name,courseWareId,source);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }
    /**
     * 添加课时视频
     * @param video
     * @return
     */
    @RequestMapping("/save")
    public ViewData save(Video video){
        try {
            if (null == video.getSourceHigh() || null == video.getSourceLow()) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            videoService.save(video);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"添加成功");
        } catch (InterfaceCommonException e) {
            logger.error(e.getMessage(),e.getErrorCode());
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        }catch (Exception e) {
            logger.error("服务器超时，添加失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，添加失败");
        }
    }

    /**
     * 添加课时视频
     * @return
     */
    @RequestMapping("/saveCloud")
    public ViewData saveCloud(String name,String cover,Integer courseWareId,Integer cloudVideoId){
        try {
            if (CommonUtil.isEmpty(name,courseWareId,cloudVideoId)) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            videoService.saveCloud(name,cover,courseWareId,cloudVideoId);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"添加成功");
        } catch (InterfaceCommonException e) {
            logger.error(e.getMessage(),e.getErrorCode());
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        }catch (Exception e) {
            logger.error("服务器超时，添加失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，添加失败");
        }
    }

    /**
     * 添加课时视频
     * @return
     */
    @RequestMapping("/updateCloud")
    public ViewData updateCloud(String name,String cover,Integer courseWareId,Integer cloudVideoId,Integer id){
        try {
            if (CommonUtil.isEmpty(name,courseWareId,cloudVideoId)) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            videoService.updateCloud(name,cover,courseWareId,cloudVideoId,id);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"添加成功");
        } catch (InterfaceCommonException e) {
            logger.error(e.getMessage(),e.getErrorCode());
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        }catch (Exception e) {
            logger.error("服务器超时，添加失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，添加失败");
        }
    }

    /**
     * 更新课时视频
     * @param video
     * @return
     */
    @RequestMapping("/update")
    public ViewData update(Video video){
        try {
            if (null == video || null == video.getId()) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            videoService.update(video);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功");
        } catch (Exception e) {
            logger.error("服务器超时，更新失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }

    /**
     * 课时视频详情
     * @param id
     * @return
     */
    @RequestMapping("/info")
    public ViewData info(Integer id){
        try {
            if (null == id) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",videoService.info(id));
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }

    /**
     * 删除课时视频
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    public ViewData delete(Integer id){
        try {
            if (null == id) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            videoService.delete(id);
            return buildFailureJson(StatusConstant.SUCCESS_CODE,"删除成功");
        } catch (Exception e) {
            logger.error("服务器超时，删除失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，删除失败");
        }
    }
}
