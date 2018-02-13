package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.business.entity.Company;
import com.magic.aimai.business.entity.Content;
import com.magic.aimai.business.service.ContentService;
import com.magic.aimai.business.util.StatusConstant;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * 公司内容管理
 * @author lzh
 * @create 2017/8/3 21:29
 */
@RestController
@RequestMapping("/content")
public class ContentController extends BaseController {

    @Resource
    private ContentService contentService;


    /**
     * 更新公司内容
     * @param content 公司信息
     * @return
     */
    @RequestMapping("/update")
    public ViewData update(Content content) {
        try {
            contentService.update(content);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功 ");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败 ");
        }
    }

    /**
     * 安培公司信息详情
     * @return
     */
    @RequestMapping("/info")
    public ViewData info(Integer id) {
        try {
            if (null == id) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",contentService.info(id));
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }
}
