package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.entity.PaperRecord;
import com.magic.aimai.business.service.PaperRecordService;
import com.magic.aimai.business.util.StatusConstant;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @author lzh
 * @create 2017/8/17 15:20
 */
@RestController
@RequestMapping("/paperRecord")
public class PaperRecordController extends BaseController {

    @Resource
    private PaperRecordService paperRecordService;


    /**
     * 后台页面 获取考试记录
     * @return
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , Integer userId) {
        try {
            if (null == userId ){
                return buildFailureJsonPage(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            PageList pageList = paperRecordService.listForAdmin(pageArgs, userId);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    /**
     * 后台页面 获取考试记录
     * @return
     */
    @RequestMapping("/updateIsPass")
    public ViewData updateIsPass(PaperRecord record) {
        try {
            if (null == record.getId() || null == record.getResultScore() ){
                return buildFailureJsonPage(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            paperRecordService.updateIsPass(record);
            return buildFailureJson(StatusConstant.SUCCESS_CODE,"操作成功");
        } catch (Exception e) {
            logger.error("服务器超时，操作失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，操作失败");
        }
    }


    /**
     * 没有考试记录  但是需要进行通过或不通过操作  直接进行新增记录
     * @return
     */
    @RequestMapping("/save")
    public ViewData save(PaperRecord record) {
        try {
            if (null == record.getResultScore() ||
                    null == record.getPassScore() ||
                    null == record.getUserId() ||
                    null == record.getOrderId() ||
                    null == record.getType() ||
                    null == record.getPaperId()){
                return buildFailureJsonPage(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            paperRecordService.save(record);
            return buildFailureJson(StatusConstant.SUCCESS_CODE,"操作成功");
        } catch (Exception e) {
            logger.error("服务器超时，操作失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，操作失败");
        }
    }



}
