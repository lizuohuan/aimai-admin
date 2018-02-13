package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.service.FaceRecordService;
import com.magic.aimai.business.util.StatusConstant;
import com.magic.aimai.business.util.Timestamp;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

/**
 * 人脸识别验证记录
 * @author lzh
 * @create 2017/7/27 15:43
 */
@RestController
@RequestMapping("/faceRecord")
public class FaceRecordController extends BaseController {

    @Resource
    private FaceRecordService faceRecordService;


    /**
     * 后台页面 分页获取人脸识别验证记录
     * @param pageArgs 分页属性
     * @param courseWareId 课时id
     * @param orderId 订单id
     * @param videoName 视频名
     * @param courseWareName 课时名
     * @param startTimes 开始时间
     * @param endTimes 结束时间
     * @return
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs, Integer courseWareId ,
                             Integer orderId, String videoName,
                             String courseWareName , String startTimes , String endTimes ,Integer userId) {
        try {
            Date startTime = null;
            Date endTime = null;
            if (null != startTimes && !startTimes.equals("")) {
                startTime = Timestamp.parseDate(startTimes,"yyyy-MM-dd HH:mm:ss");
            }
            if (null != endTimes && endTimes.equals("")) {
                endTime = Timestamp.parseDate(endTimes,"yyyy-MM-dd HH:mm:ss");
            }
            PageList pageList = faceRecordService.listForAdmin(pageArgs,
                    courseWareId, orderId, videoName, courseWareName, startTime, endTime,userId);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }

}
