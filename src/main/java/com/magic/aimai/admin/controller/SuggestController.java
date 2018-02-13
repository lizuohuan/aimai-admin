package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.entity.Suggest;
import com.magic.aimai.business.service.SuggestService;
import com.magic.aimai.business.util.StatusConstant;
import com.magic.aimai.business.util.Timestamp;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

/**
 * 意见反馈
 * @author lzh
 * @create 2017/8/3 10:17
 */
@RestController
@RequestMapping("/suggest")
public class SuggestController extends BaseController {


    @Resource
    private SuggestService suggestService;


    /**
     * 后台页面 分页获取意见反馈
     * @param pageArgs 分页属性
     * @param userName 反馈人
     * @param startTimes  创建开始时间
     * @param endTimes 创建结束时间
     * @return
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , String userName ,String startTimes , String endTimes ) {
        try {
            Date startTime = null;
            Date endTime = null;
            if (null != startTimes && !startTimes.equals("")) {
                startTime = Timestamp.parseDate2(startTimes,"yyyy-MM-dd HH:mm:ss");
            }
            if (null != endTimes && !endTimes.equals("")) {
                endTime = Timestamp.parseDate2(endTimes,"yyyy-MM-dd HH:mm:ss");
            }
            PageList pageList = suggestService.listForAdmin(pageArgs, userName, startTime ,endTime);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }



    /**
     * 删除意见反馈
     * @return
     */
    @RequestMapping("/delete")
    public ViewData delete(Integer id) {
        try {
            if (null == id) {
                return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空 ");
            }
            suggestService.delete(id);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，删除失败");
        }
    }

}
