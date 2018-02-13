package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.service.ExaminationPaperService;
import com.magic.aimai.business.util.StatusConstant;
import com.magic.aimai.business.util.Timestamp;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

/**
 * 试卷 试题
 * @author lzh
 * @create 2017/8/3 17:04
 */
@RestController
@RequestMapping("/examinationPaper")
public class ExaminationPaperController extends BaseController {

    @Resource
    private ExaminationPaperService examinationPaperService;


    /**
     * 考题列表(试卷)
     * @param pageArgs 分页工具
     * @param title 考题名
     * @param type 试题类型 0:单选题 1:多选题  2:判断题
     * @param startTimes 开始时间
     * @param endTimes 结束时间
     * @return 考题列表
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , String title , Integer type , String startTimes , String endTimes,
                             Integer category, Integer tradeId, Integer curriculumId, Integer companyId,
                             Integer provinceId, Integer cityId, Integer districtId, Integer paperId) {
        try {
            Date startTime = null;
            Date endTime = null;
            if (null != startTimes && startTimes.equals("")) {
                startTime = Timestamp.parseDate2(startTimes,"yyyy-MM-dd HH:mm:ss");
            }
            if (null != endTimes && endTimes.equals("")) {
                endTime = Timestamp.parseDate2(endTimes,"yyyy-MM-dd HH:mm:ss");
            }
            PageList pageList = examinationPaperService.listForAdmin(pageArgs,
                     title ,  type ,  startTime ,  endTime,
                    category,  tradeId,  curriculumId,  companyId,
                     provinceId,  cityId,  districtId,  paperId);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    /**
     * 删除试卷中的试题
     * @return
     */
    @RequestMapping("/delete")
    public ViewData delete(Integer id) {
        try {
            if (null == id) {
                return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空 ");
            }
            examinationPaperService.delete(id);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"删除成功 ");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，删除失败");
        }
    }

}
