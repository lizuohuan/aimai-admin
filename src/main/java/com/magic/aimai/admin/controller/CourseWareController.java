package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.CourseWare;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.entity.User;
import com.magic.aimai.business.service.CourseWareService;
import com.magic.aimai.business.util.LoginHelper;
import com.magic.aimai.business.util.StatusConstant;
import com.magic.aimai.business.util.Timestamp;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

/**
 * 课时
 * @author lzh
 * @create 2017/7/21 14:22
 */
@RestController
@RequestMapping("/courseWare")
public class CourseWareController extends BaseController {

    @Resource
    private CourseWareService courseWareService;



    @RequestMapping("/queryBaseCourseWare")
    public ViewData queryBaseCourseWare(){
        return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",
                courseWareService.queryBaseCourseWare());
    }



    /**
     * 添加课时
     * @param courseWare
     * @return
     */
    @RequestMapping("/save")
    public ViewData save(CourseWare courseWare) {
        try {
            User user = LoginHelper.getCurrentUser();
            if (null == user) {
                return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
            }
            courseWare.setCreateUserId(user.getId());
            courseWare.setIsValid(1);
            courseWareService.save(courseWare);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，添加失败");
        }
    }


    /**
     * 更新课时
     * @param courseWare
     * @return
     */
    @RequestMapping("/update")
    public ViewData update(CourseWare courseWare) {
        try {
            courseWareService.update(courseWare);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }

    /**
     * 删除课时
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    public ViewData delete(Integer id) {
        try {
            if (null == id) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            courseWareService.delete(id);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，删除失败");
        }
    }


    /**
     * 更新课时 包括为空的字段
     * @param courseWare
     * @return
     */
    @RequestMapping("/updateAll")
    public ViewData updateAll(CourseWare courseWare) {
        try {
            courseWareService.updateAll(courseWare);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }


    /**
     * 后台页面 分页获取课时分类
     * @param pageArgs 分页属性
     * @param courseWareName 课时名
     * @param isValid 是否发布
     * @param createTimeStarts 创建的开始时间
     * @param createTimeEnds 创建的结束时间
     * @param curriculumId 课程id
     * @return
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , String courseWareName , Integer isValid ,
                             String  createTimeStarts , String createTimeEnds ,Integer curriculumId) {
        try {
            if (null == curriculumId) {
                return buildFailureJsonPage(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            Date createTimeStart = null;
            Date createTimeEnd = null;
            if (null != createTimeStarts && !createTimeStarts.equals("")) {
                createTimeStart = Timestamp.parseDate2(createTimeStarts,"yyyy-MM-dd HH:mm:ss");
            }
            if (null != createTimeEnds && !createTimeEnds.equals("")) {
                createTimeEnd = Timestamp.parseDate2(createTimeEnds,"yyyy-MM-dd HH:mm:ss");
            }
            PageList pageList = courseWareService.listForAdmin(pageArgs, courseWareName, isValid, createTimeStart, createTimeEnd ,curriculumId);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    /**
     * 后台页面 分页获取用户课时分类
     * @param pageArgs 分页属性
     * @param orderId 订单id
     * @param curriculumId 课程id
     * @return
     */
    @RequestMapping("/listForAdminUser")
    public ViewDataPage listForAdminUser(PageArgs pageArgs , Integer orderId , Integer curriculumId ,Integer userId) {
        try {
            if (null == curriculumId || null == orderId || null == userId) {
                return buildFailureJsonPage(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            PageList pageList = courseWareService.listForAdminUser(pageArgs, orderId ,curriculumId,userId);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    /**
     * 课时详情
     * @param id
     * @return
     */
    @RequestMapping("/info")
    public ViewData info(Integer id) {
        try {
            if (null == id) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",courseWareService.info(id));
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }
}
