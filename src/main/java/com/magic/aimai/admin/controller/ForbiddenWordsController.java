package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.ForbiddenWords;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.service.ForbiddenWordsService;
import com.magic.aimai.business.util.StatusConstant;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @author lzh
 * @create 2017/8/2 16:31
 */
@RestController
@RequestMapping("/forbiddenWords")
public class ForbiddenWordsController extends BaseController {

    @Resource
    private ForbiddenWordsService forbiddenWordsService;


    /**
     * 后台页面 分页获取禁词
     * @param pageArgs 分页属性
     * @param word 禁词
     * @return
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , String word) {
        try {
            PageList pageList = forbiddenWordsService.listForAdmin(pageArgs,word);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功 ",
                    pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }





    /**
     * 添加禁词
     * @param forbiddenWords 禁词
     * @return
     */
    @RequestMapping("/save")
    public ViewData save(ForbiddenWords forbiddenWords) {
        try {
            forbiddenWordsService.addForbiddenWords(forbiddenWords);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，添加失败");
        }
    }


    /**
     * 更新禁词
     * @param forbiddenWords 禁词
     * @return
     */
    @RequestMapping("/update")
    public ViewData update(ForbiddenWords forbiddenWords) {
        try {
            if (null == forbiddenWords.getId()) {
                return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            forbiddenWordsService.updateForbiddenWords(forbiddenWords);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }


    /**
     * 添加禁词
     * @param id 禁词id
     * @return
     */
    @RequestMapping("/info")
    public ViewData info(Integer id) {
        try {
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",forbiddenWordsService.info(id));
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }

}
