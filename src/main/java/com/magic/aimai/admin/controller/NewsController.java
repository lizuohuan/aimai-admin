package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.*;
import com.magic.aimai.business.service.NewsService;
import com.magic.aimai.business.util.LoginHelper;
import com.magic.aimai.business.util.StatusConstant;
import com.magic.aimai.business.util.Timestamp;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

/**
 * 新闻资质
 * @author lzh
 * @create 2017/8/8 10:36
 */
@RestController
@RequestMapping("/news")
public class NewsController extends BaseController {

    @Resource
    private NewsService newsService;

    /**
     * 后台页面 分页获取资讯详情
     * @param pageArgs 分页属性
     * @param title 标题
     * @param editor 责任编辑人
     * @param type 是否是外链
     * @param startTimes  创建开始时间
     * @param endTimes 创建结束时间
     * @return
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , String title ,  String editor , Integer type ,
                             String startTimes , String endTimes ) {
        try {
            Date startTime = null;
            Date endTime = null;
            if (null != startTimes && !startTimes.equals("")) {
                startTime = Timestamp.parseDate2(startTimes,"yyyy-MM-dd HH:mm:ss");
            }
            if (null != endTimes && !endTimes.equals("")) {
                endTime = Timestamp.parseDate2(endTimes,"yyyy-MM-dd HH:mm:ss");
            }
            PageList pageList = newsService.listForAdmin(pageArgs,
                    title, editor, type, startTime ,endTime);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }





    /**
     * 添加新闻资讯
     * @param news 资讯详情
     * @return
     */
    @RequestMapping("/save")
    public ViewData save(News news) {
        try {
            User user = LoginHelper.getCurrentUser();
            if (null == user) {
                return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
            }
            news.setCreateUserId(user.getId());
            newsService.save(news);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，添加失败");
        }
    }


    /**
     * 更新资讯详情
     * @param news 资讯详情
     * @return
     */
    @RequestMapping("/update")
    public ViewData update(News news) {
        try {
            if (null == news.getId()) {
                return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            newsService.update(news);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }

    /**
     * 新闻资讯详情
     * @return
     */
    @RequestMapping("/info")
    public ViewData info(Integer id) {
        try {
            if (null == id) {
                return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",newsService.info(id));
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }

    /**
     * 删除
     * @return
     */
    @RequestMapping("/delete")
    public ViewData delete(Integer id) {
        try {
            if (null == id) {
                return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            newsService.delete(id);
            return buildFailureJson(StatusConstant.SUCCESS_CODE,"获取成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }
}
