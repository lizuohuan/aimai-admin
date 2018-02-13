package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.*;
import com.magic.aimai.business.exception.InterfaceCommonException;
import com.magic.aimai.business.service.ExaminationService;
import com.magic.aimai.business.util.CommonUtil;
import com.magic.aimai.business.util.LoginHelper;
import com.magic.aimai.business.util.StatusConstant;
import com.magic.aimai.business.util.Timestamp;
import net.sf.json.JSONArray;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.io.FileNotFoundException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 考题
 * @author lzh
 * @create 2017/7/25 17:02
 */
@RestController
@RequestMapping("/examination")
public class ExaminationController extends BaseController {

    @Resource
    private ExaminationService examinationService;


    /**
     * 新增试题选项
     * @param items
     * @return
     */
    @RequestMapping("/saveItems")
    public ViewData saveItems(ExaminationItems items){
        if(CommonUtil.isEmpty(items.getExaminationId(),items.getIsCorrect(),items.getItemTitle(),items.getSortNum())){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        try {
            examinationService.addExaminationItems(items);
        } catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"新增失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }

    /**
     * 考题  选项列表
     * @param pageArgs 分页工具
     */
    @RequestMapping("/listItems")
    public ViewDataPage listItems(PageArgs pageArgs , Integer examinationId) {
        try {
            if(null == examinationId){
                return buildFailureJsonPage(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            PageList pageList = examinationService.queryExaminationItems(examinationId,pageArgs);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }

    /**
     * 考题列表
     * @param pageArgs 分页工具
     * @param title 考题名
     * @param type 试题类型 0:单选题 1:多选题  2:判断题
     * @param startTimes 开始时间
     * @param endTimes 结束时间
     * @param source 请求来源 0：绑定题目 1：其他
     * @return 考题列表
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , String title , Integer type , String startTimes , String endTimes,
                             Integer category,Integer tradeId,Integer curriculumId,Integer companyId,
                             Integer provinceId,Integer cityId,Integer districtId,Integer paperId,Integer source) {
        try {
            Date startTime = null;
            Date endTime = null;
            if (null != startTimes && startTimes.equals("")) {
                startTime = Timestamp.parseDate2(startTimes,"yyyy-MM-dd HH:mm:ss");
            }
            if (null != endTimes && endTimes.equals("")) {
                endTime = Timestamp.parseDate2(endTimes,"yyyy-MM-dd HH:mm:ss");
            }
            Map<String,Object> params = new HashMap<String, Object>();
            params.put("title",title);
            params.put("type",type);
            params.put("startTime",startTime);
            params.put("endTime",endTime);
            params.put("category",category);
            params.put("tradeId",tradeId);
            params.put("curriculumId",curriculumId);
            params.put("companyId",companyId);
            params.put("provinceId",provinceId);
            params.put("cityId",cityId);
            params.put("districtId",districtId);
            params.put("paperId",paperId);
            params.put("source",source);
            PageList pageList = examinationService.listForAdmin(pageArgs, params);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }

    /**
     * 添加考题
     * @param examination 考题
     * @return
     */
    @RequestMapping("/save")
    public ViewData save(Examination examination) {
        try {
            User user = LoginHelper.getCurrentUser();
            if (null == user) {
                return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
            }
            examinationService.addExamination(examination);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，添加失败");
        }
    }


    /**
     * 更新考题
     * @param examination 考题
     * @param itemListArray 考题选项 以及 答案等信息
     * @return
     */
    @RequestMapping("/update")
    public ViewData update(Examination examination, JSONArray itemListArray) {
        try {
            if (null == itemListArray || itemListArray.size() < 0) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"请至少添加一个答案");
            }
            List<ExaminationItems> itemList = JSONArray.toList(itemListArray);
            examinationService.updateExamination(examination,itemList);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }

    
    /**
     * 删除考题
     * @param id 考题id
     * @return
     */
    @RequestMapping("/delete")
    public ViewData delete(Integer id) {
        try {
            if (null == id) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            examinationService.delete(id);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"删除成功 ");
        } catch (InterfaceCommonException e) {
            e.printStackTrace();
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，删除失败");
        }
    }


    /**
     * 考题详情
     * @param id 考题id
     * @return
     */
    @RequestMapping("/info")
    public ViewData info(Integer id) {
        try {
            if (null == id) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",examinationService.info(id));
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }



    /**
     * 更新考题
     * @param examination 考题
     * @return
     */
    @RequestMapping("/updateExamination")
    public ViewData updateExamination(Examination examination) {
        try {
            examinationService.update(examination);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功 ");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }

    /**
     * 更新考题单项答案信息
     * @param examinationItems 答案
     * @throws Exception
     */
    @RequestMapping("/updateExaminationItems")
    public ViewData updateExaminationItems(ExaminationItems examinationItems) {
        try {
            examinationService.updateExaminationItems(examinationItems);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功 ");
        } catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }

    /**
     * 答案详情
     * @param examinationItemsId 答案id
     * @throws Exception
     */
    @RequestMapping("/examinationItemsInfo")
    public ViewData examinationItemsInfo(Integer examinationItemsId) {
        try {

            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功 ",examinationService.examinationItemsInfo(examinationItemsId));
        } catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }



    /**
     * 导入考题到题库
     * @param url 导入考题的excel地址
     * @throws Exception
     */
    @RequestMapping("/addExcel")
    public ViewData addExcel(String url) {
        try {
            examinationService.addExcel(url);
            return buildFailureJson(StatusConstant.SUCCESS_CODE,"导入成功 ");
        } catch (FileNotFoundException e) {
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，解析失败");
        }  catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，导入失败");
        }
    }


}
