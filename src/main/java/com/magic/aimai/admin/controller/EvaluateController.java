package com.magic.aimai.admin.controller;

import com.alibaba.fastjson.JSONArray;
import com.magic.aimai.admin.util.ClassConvert;
import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.service.EvaluateService;
import com.magic.aimai.business.util.StatusConstant;
import com.magic.aimai.business.util.Timestamp;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * 评价
 * @author lzh
 * @create 2017/8/2 13:55
 */
@RestController
@RequestMapping("/evaluate")
public class EvaluateController extends BaseController {

    @Resource
    private EvaluateService evaluateService;


    /**
     * 后台页面 分页获取评论
     * @param pageArgs 分页属性
     * @param userName 评论用户
     * @param curriculumName 课程名
     * @param provinceId 省
     * @param cityId 市
     * @param districtId 区
     * @param isValid 是否有效  0:无效  1:有效
     * @param startTimes  创建开始时间
     * @param endTimes 创建结束时间
     * @return
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , String userName , String curriculumName,
                             Integer provinceId , Integer cityId , Integer districtId ,
                             Integer isValid ,String startTimes , String endTimes ) {
        try {
            Date startTime = null;
            Date endTime = null;
            if (null != startTimes && !startTimes.equals("")) {
                startTime = Timestamp.parseDate2(startTimes,"yyyy-MM-dd HH:mm:ss");
            }
            if (null != endTimes && !endTimes.equals("")) {
                endTime = Timestamp.parseDate2(endTimes,"yyyy-MM-dd HH:mm:ss");
            }
            PageList pageList = evaluateService.listForAdmin(pageArgs,
                    userName, curriculumName, provinceId, cityId ,districtId,isValid,startTime,endTime);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    /**
     * 删除评论
     * @return
     */
    @RequestMapping("/delete")
    public ViewData delete(Integer id) {
        try {
            if (null == id) {
                return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            evaluateService.delete(id);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，删除失败");
        }
    }

    /**
     * 评论审核通过
     * @param isValid 1 审核通过  0:不通过
     */
    @RequestMapping("/auditEvaluate")
    public ViewData auditEvaluate(Integer id ,Integer isValid) {
        try {
            if (null == id || null == isValid) {
                return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            evaluateService.auditEvaluate(id,isValid);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，操作失败");
        }
    }


    /**
     * 批量评论审核
     * @param idsAndIsValid json字符串 [{id,isValid},..]
     */
    @RequestMapping("/auditEvaluateList")
    public ViewData auditEvaluateList(String idsAndIsValid) {
        try {
            if (null == idsAndIsValid) {
                return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            evaluateService.updateList(idsAndIsValid);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，操作失败");
        }
    }
    /**
     * 批量评论审核
     * @param idsAndIsValid json字符串 [{id,isValid},..]
     */
    @RequestMapping("/deleteList")
    public ViewData deleteList(String idsAndIsValid) {
        try {
            if (null == idsAndIsValid) {
                return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            List<Integer> list = Arrays.asList(ClassConvert.strToIntegerGather(idsAndIsValid.split(",")));
            evaluateService.deleteList(list);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，操作失败");
        }
    }
}
