package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.service.CurriculumTypeService;
import com.magic.aimai.business.util.StatusConstant;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * 课程分类
 * @author lzh
 * @create 2017/7/21 10:44
 */
@RestController
@RequestMapping("/curriculumType")
public class CurriculumTypeController extends BaseController {

    @Resource
    private CurriculumTypeService curriculumTypeService;

    /**
     * 后台页面 分页获取课程类型
     * @param pageArgs 分页工具
     * @param curriculumTypeName 课程类型
     * @return 课程类型列表
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , String curriculumTypeName) {
        try {
            PageList pageList = curriculumTypeService.listForAdmin(pageArgs,curriculumTypeName);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }

    /**
     * 后台页面 课程分类 下拉列表
     * @return 行业分类
     */
    @RequestMapping("/listForSelect")
    public ViewData listForSelect(String curriculumTypeName) {
        try {
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",
                    curriculumTypeService.listForAdmin(null,curriculumTypeName).getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }
}
