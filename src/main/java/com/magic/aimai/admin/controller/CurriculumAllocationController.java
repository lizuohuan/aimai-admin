package com.magic.aimai.admin.controller;

import com.alibaba.fastjson.JSONArray;
import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.CurriculumAllocation;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.entity.User;
import com.magic.aimai.business.exception.InterfaceCommonException;
import com.magic.aimai.business.service.CurriculumAllocationService;
import com.magic.aimai.business.service.OperationLogService;
import com.magic.aimai.business.util.CommonUtil;
import com.magic.aimai.business.util.LoginHelper;
import com.magic.aimai.business.util.StatusConstant;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.io.FileNotFoundException;
import java.util.List;

/**
 *
 * 课程分配记录
 * @author lzh
 * @create 2017/8/17 17:20
 */
@RestController
@RequestMapping("/curriculumAllocation")
public class CurriculumAllocationController extends BaseController {


    @Resource
    private CurriculumAllocationService curriculumAllocationService;

    @Resource
    private OperationLogService operationLogService;

    /**
     * 后台页面 课程分配记录 列表
     * @param pageArgs 分页属性
     * @param phone 手机号
     * @param orderId 订单
     * @return
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , String phone , Integer orderId ) {
        try {
            if (null == orderId) {
                return buildFailureJsonPage(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            PageList pageList = curriculumAllocationService.listForAdmin(pageArgs, phone, orderId);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }



    /**
     * 导入用户分配
     * @param url 导入用户的excel地址
     * @throws Exception
     */
    @RequestMapping("/addExcel")
    public ViewData addExcel(String url , Integer orderId) {
        try {
            User user = LoginHelper.getCurrentUser();
            if (null == user) {
                return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
            }
            //操作日志
            operationLogService.save2(user.getId(),user.getRoleId(),"导入了分配课程的用户");
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"导入成功 ",
                    curriculumAllocationService.importExcelCurriculumAllocation(url,orderId));
        } catch (FileNotFoundException e) {
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，解析失败");
        }  catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，导入失败");
        }
    }


    @RequestMapping("/bind")
    public ViewData bind(String curriculumAllocations,Integer orderId){

        if(CommonUtil.isEmpty(curriculumAllocations,orderId)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        try {
            User user = LoginHelper.getCurrentUser();
            if (null == user) {
                return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
            }
            //操作日志
            operationLogService.save2(user.getId(),user.getRoleId(),"为用户分配了课程");
            List<CurriculumAllocation> list = JSONArray.parseArray(curriculumAllocations,CurriculumAllocation.class);
            curriculumAllocationService.addAllocation(list,orderId);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"设置失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }


    /**
     * 更新分配的课程 用户是否可以学习
     * @param studyStatus
     * @param userId
     * @param orderId
     * @return
     */
    @RequestMapping("/updateIsCanStudy")
    public ViewData updateIsCanStudy(Integer studyStatus , Integer userId, Integer orderId){

        if(CommonUtil.isEmpty(studyStatus,orderId,userId)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        try {
            curriculumAllocationService.updateIsCanStudy(studyStatus, userId, orderId);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"设置失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }

    /**
     * 更新分配的课程 用户是否可以学习 2
     * @param studyStatus
     * @param id
     * @return
     */
    @RequestMapping("/updateIsCanStudy2")
    public ViewData updateIsCanStudy2(Integer studyStatus , Integer id){

        if(CommonUtil.isEmpty(studyStatus,id)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        try {
            curriculumAllocationService.updateIsCanStudy2(studyStatus, id);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"设置失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }

}
