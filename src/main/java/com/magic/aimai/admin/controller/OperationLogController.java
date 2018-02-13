package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.OperationLog;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.service.OperationLogService;
import com.magic.aimai.business.util.StatusConstant;
import com.magic.aimai.business.util.Timestamp;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

/**
 * 操作日志
 * @author lzh
 * @create 2018/1/23 9:34
 */
@RestController
@RequestMapping("/operationLog")
public class OperationLogController extends BaseController {

    @Resource
    private OperationLogService operationLogService;

    /**
     * 后台页面 分页操作日志
     * @param pageArgs 分页属性
     * @param userName 操作人
     * @param roleId 角色id
     * @param startTimes  创建开始时间
     * @param endTimes 创建结束时间
     * @return
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , String userName , Integer roleId ,
                             String startTimes , String endTimes ) {
        try {
            Date startTime = null;
            Date endTime = null;
            if (null != startTimes && !startTimes.equals("")) {
                startTime = Timestamp.parseDate2(startTimes,"yyyy-MM-dd HH:mm:ss");
            }
            if (null != endTimes && !endTimes.equals("")) {
                endTime = Timestamp.parseDate2(endTimes,"yyyy-MM-dd HH:mm:ss");
            }
            PageList pageList = operationLogService.list(pageArgs,
                    userName, roleId, startTime ,endTime);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }
}
