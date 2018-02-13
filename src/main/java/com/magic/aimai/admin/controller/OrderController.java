package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.*;
import com.magic.aimai.business.enums.Common;
import com.magic.aimai.business.exception.InterfaceCommonException;
import com.magic.aimai.business.service.OperationLogService;
import com.magic.aimai.business.service.OrderService;
import com.magic.aimai.business.util.CommonUtil;
import com.magic.aimai.business.util.LoginHelper;
import com.magic.aimai.business.util.StatusConstant;
import com.magic.aimai.business.util.Timestamp;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

/**
 * 订单
 * @author lzh
 * @create 2017/7/31 16:57
 */
@RestController
@RequestMapping("/order")
public class OrderController extends BaseController {

    @Resource
    private OrderService orderService;
    @Resource
    private OperationLogService operationLogService;


    /**
     * 订单列表
     * @param pageArgs 分页工具
     * @param provinceId 省id
     * @param cityId 市id
     * @param districtId 区县id
     * @param userName 用户名
     * @param orderNumber 订单号
     * @param payStatus 支付状态
     * @param payMethod 支付方式
     * @param startTimes 开始时间
     * @param endTimes 结束时间
     * @return
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs,Integer provinceId ,Integer cityId ,Integer districtId ,
                             String  userName ,String  orderNumber , Integer payStatus ,Integer payMethod ,
                             String startTimes, String endTimes,Integer isPlatformCreate) {
        Date startTime = null;
        Date endTime = null;
        if (null != startTimes && !startTimes.equals("")) {
            startTime = Timestamp.parseDate2(startTimes,"yyyy-MM-dd HH:mm:ss");
        }
        if (null != endTimes && !endTimes.equals("")) {
            endTime = Timestamp.parseDate2(endTimes,"yyyy-MM-dd HH:mm:ss");
        }
        PageList pageList = orderService.listForAdmin(pageArgs,provinceId, cityId , districtId ,userName, orderNumber,
                payStatus, payMethod, startTime, endTime,isPlatformCreate);
        return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
    }

    /**
     * 创建订单
     * @param order 订单
     * @return
     */
    @RequestMapping("/save")
    public ViewData save(Order order) {
        try {
            User user = LoginHelper.getCurrentUser();
            if (null == user) {
                return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
            }
            order.setCreateUserId(user.getId());
            order.setPayStatus(Common.YES.ordinal());
            order.setIsPlatformCreate(1);
            order.setOrderNumber(CommonUtil.buildOrderNumber());
            orderService.save(order);
            //操作日志
            operationLogService.save2(user.getId(),user.getRoleId(),"创建订单");
        } catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，创建失败");
        }
        return buildFailureJson(StatusConstant.SUCCESS_CODE,"创建成功");
    }

    /**
     * 订单详情
     * @param id 订单
     * @return
     */
    @RequestMapping("/info")
    public ViewData info(Integer id) {
        try {
            User user = LoginHelper.getCurrentUser();
            if (null == user) {
                return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
            }
            //操作日志
            operationLogService.save2(user.getId(),user.getRoleId(),"查看订单");
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功", orderService.info(id));
        } catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }

    /**
     * 更新购买的课程 用户是否可以学习
     * @param studyStatus 学习状态  1：可以学习   0：停止  1：暂停
     * @param id
     * @return
     */
    @RequestMapping("/updateIsCanStudy")
    public ViewData updateIsCanStudy(Integer studyStatus , Integer id){

        if(CommonUtil.isEmpty(studyStatus,id)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        try {
            orderService.updateIsCanStudy(studyStatus, id);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"设置失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }



}
