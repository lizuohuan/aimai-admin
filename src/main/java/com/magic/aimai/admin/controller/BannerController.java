package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.Banner;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.entity.User;
import com.magic.aimai.business.exception.InterfaceCommonException;
import com.magic.aimai.business.service.BannerService;
import com.magic.aimai.business.util.LoginHelper;
import com.magic.aimai.business.util.StatusConstant;
import com.magic.aimai.business.util.Timestamp;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Banner
 * @author lzh
 * @create 2017/8/1 15:46
 */
@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/banner")
public class BannerController extends BaseController {

    @Resource
    private BannerService bannerService;

    /**
     * 后台页面 分页获取banner
     * @param pageArgs 分页属性
     * @param title 标题
     * @param editor 责任编辑人
     * @param isLink 是否是外链
     * @param startTimes  创建开始时间
     * @param endTimes 创建结束时间
     * @param validityStartTimes 到期开始时间
     * @param validityEndTimes 到期结束时间
     * @param isBanner PC广告: 0  banner: 1
     * @return
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , String title ,  String editor , Integer isLink ,
                             String startTimes , String endTimes ,String validityStartTimes , String validityEndTimes ,Integer isBanner) {
        try {
            Date startTime = null;
            Date endTime = null;
            Date validityStartTime = null;
            Date validityEndTime = null;
            if (null != startTimes && !startTimes.equals("")) {
                startTime = Timestamp.parseDate2(startTimes,"yyyy-MM-dd HH:mm:ss");
            }
            if (null != endTimes && !endTimes.equals("")) {
                endTime = Timestamp.parseDate2(endTimes,"yyyy-MM-dd HH:mm:ss");
            }
            if (null != validityStartTimes && !validityStartTimes.equals("")) {
                validityStartTime = Timestamp.parseDate2(validityStartTimes,"yyyy-MM-dd HH:mm:ss");
            }
            if (null != validityEndTimes && !validityEndTimes.equals("")) {
                validityEndTime = Timestamp.parseDate2(validityEndTimes,"yyyy-MM-dd HH:mm:ss");
            }
            PageList pageList = bannerService.listForAdmin(pageArgs,
                    title, editor, isLink, startTime ,endTime,validityStartTime,validityEndTime,isBanner);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }





    /**
     * 添加banner
     * @param banner banner
     * @param validitys 到期时间
     * @return
     */
    @RequestMapping("/save")
    public ViewData save(Banner banner ,String validitys) {
        try {
            User user = LoginHelper.getCurrentUser();
            if (null == user) {
                return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
            }
            if (null == validitys || validitys.equals("")) {
                return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            banner.setCreateUserId(user.getId());
            banner.setValidity(Timestamp.parseDate2(validitys,"yyyy-MM-dd HH:mm:ss"));
            banner.setValidity(Timestamp.setDateHH(banner.getValidity()));
            bannerService.addBanner(banner);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"添加成功");
        } catch (InterfaceCommonException e){
            e.printStackTrace();
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，添加失败");
        }
    }


    /**
     * 更新banner
     * @param banner banner
     * @param validitys 到期时间
     * @return
     */
    @RequestMapping("/update")
    public ViewData update(Banner banner ,String validitys) {
        try {
            if (null == validitys || validitys.equals("")) {
                return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            banner.setValidity(Timestamp.parseDate2(validitys,"yyyy-MM-dd HH:mm:ss"));
            banner.setValidity(Timestamp.setDateHH(banner.getValidity()));
            bannerService.update(banner);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功");
        } catch (InterfaceCommonException e){
            e.printStackTrace();
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }

    /**
     * banner详情
     * @return
     */
    @RequestMapping("/info")
    public ViewData info(Integer id) {
        try {
            if (null == id) {
                return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"更新成功",bannerService.queryBannerById(id));
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }


    /**
     * banner详情
     * @return
     */
    @RequestMapping("/delete")
    public ViewData delete(Integer id) {
        try {
            if (null == id) {
                return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            bannerService.delBanner(id);
            return buildFailureJson(StatusConstant.SUCCESS_CODE,"删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }



}
