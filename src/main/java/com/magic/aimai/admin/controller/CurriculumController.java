package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.Curriculum;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.entity.User;
import com.magic.aimai.business.service.CurriculumService;
import com.magic.aimai.business.util.LoginHelper;
import com.magic.aimai.business.util.StatusConstant;
import com.magic.aimai.business.util.Timestamp;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * 课程 控制器
 * @author lzh
 * @create 2017/7/17 11:50
 */
@RestController
@RequestMapping("/curriculum")
public class CurriculumController extends BaseController {

    @Resource
    private CurriculumService curriculumService;


    /**
     * 新增课程
     * @param curriculum 课程实体
     * @return
     */
    @RequestMapping("/save")
    public ViewData save(Curriculum curriculum) {
        User user = LoginHelper.getCurrentUser();
        if (null == user) {
            return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
        }
        if (null != curriculum.getReleaseStatus() && 1 == curriculum.getReleaseStatus()) {
            curriculum.setReleaseUserId(user.getId());
        }
        //如果为空  默认为全国
        if (null == curriculum.getCityId()) {
            curriculum.setCityId(100000);
        }
        curriculumService.save(curriculum);
        return buildFailureJson(StatusConstant.SUCCESS_CODE,"新增成功");
    }

    /**
     * 更新课程
     * @param curriculum 课程实体
     * @return
     */
    @RequestMapping("/update")
    public ViewData update(Curriculum curriculum) throws Exception {
        User user = LoginHelper.getCurrentUser();
        if (null == user) {
            return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
        }
        Curriculum curriculum1 = curriculumService.info(curriculum.getId());
        if (null == curriculum1) {
            return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,"未知课程");
        } else {
            if (null == curriculum1.getReleaseStatus() || curriculum1.getReleaseStatus() == 0) {
                if (null != curriculum.getReleaseStatus() && 1 == curriculum.getReleaseStatus()) {
                    curriculum.setReleaseUserId(user.getId());
                }
            }
        }
        curriculumService.updateForAdmin(curriculum);
        return buildFailureJson(StatusConstant.SUCCESS_CODE,"新增成功");
    }

    /**
     * 详情
     * @param id 课程id
     * @return
     */
    @RequestMapping("/info")
    public ViewData info(Integer id) {
        try {
            if (null == id) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功",curriculumService.info(id));
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    /**
     * 后台页面 分页获取课程
     * @param pageArgs 分页工具
     * @param curriculumName 课程名
     * @param cityId 地区id
     * @param curriculumStageId 培训阶段ID
     * @param curriculumTypeId 课程类型ID
     * @param isValid 是否有效 0：无效 1：有效
     * @param year 年度
     * @param type 课程类别  0：试听课程  1：收费课程
     * @param releaseStatus 发布状态 0:未发布  1:已发布
     * @param isRecommend 是否是推荐课程 0：否 1：是
     * @param releaseTimeStarts 发布开始时间
     * @param releaseTimeEnds 发布结束时间
     * @param tradeId 行业类型id
     * @return 课程列表
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs ,String curriculumName , Integer curriculumStageId,
                             Integer provinceId ,Integer cityId ,Integer districtId ,
                             Integer curriculumTypeId , Integer isValid , Date year,
                             Integer type, Integer releaseStatus ,Integer isRecommend ,
                             String releaseTimeStarts, String releaseTimeEnds,Integer tradeId,String releaseUserName) {
        try {
            Date releaseTimeStart = null;
            Date releaseTimeEnd = null;
            if (null != releaseTimeStarts && !releaseTimeStarts.equals("")) {
                releaseTimeStart = Timestamp.parseDate2(releaseTimeStarts,"yyyy-MM-dd HH:mm:ss");
            }
            if (null != releaseTimeEnds && !releaseTimeEnds.equals("")) {
                releaseTimeEnd = Timestamp.parseDate2(releaseTimeEnds,"yyyy-MM-dd HH:mm:ss");
            }
            PageList pageList = curriculumService.listForAdmin(pageArgs, curriculumName, curriculumStageId ,
                    provinceId, cityId , districtId ,curriculumTypeId, isValid,
                    year, type, releaseStatus, isRecommend, releaseTimeStart, releaseTimeEnd,tradeId,releaseUserName);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    /**
     * 更新课程发布状态
     * @param id 课程id
     * @param releaseStatus 发布状态
     * @return
     */
    @RequestMapping("/updateReleaseStatus")
    public ViewData updateReleaseStatus(Integer id,Integer releaseStatus) {
        User user = LoginHelper.getCurrentUser();
        if (null == user) {
            return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
        }
        if (null == id || null == releaseStatus) {
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        Curriculum curriculum = new Curriculum();
        curriculum.setId(id);
        curriculum.setReleaseStatus(releaseStatus);
        if (null != curriculum.getReleaseStatus() && 1 == curriculum.getReleaseStatus()) {
            curriculum.setReleaseUserId(user.getId());
        }
        curriculumService.update(curriculum);
        return buildFailureJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }

    /**
     * 更新课程推荐状态
     * @param id 课程id
     * @param isRecommend 发布状态
     * @return
     */
    @RequestMapping("/updateRecommend")
    public ViewData updateRecommend(Integer id,Integer isRecommend) {
        User user = LoginHelper.getCurrentUser();
        if (null == user) {
            return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
        }
        if (null == id || null == isRecommend) {
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        Curriculum curriculum = new Curriculum();
        curriculum.setId(id);
        curriculum.setIsRecommend(isRecommend);
        if (null != curriculum.getReleaseStatus() && 1 == curriculum.getReleaseStatus()) {
            curriculum.setReleaseUserId(user.getId());
        }
        curriculumService.update(curriculum);
        return buildFailureJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }


    /**
     * 更新课程 启用关闭状态
     * @param id 课程id
     * @param isValid 关闭状态/是否有效 0：无效 1：有效  缺省值 1
     * @return
     */
    @RequestMapping("/updateIsValid")
    public ViewData updateIsValid(Integer id,Integer isValid) {
        User user = LoginHelper.getCurrentUser();
        if (null == user) {
            return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
        }
        if (null == id || null == isValid) {
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        Curriculum curriculum = new Curriculum();
        curriculum.setId(id);
        curriculum.setIsValid(isValid);
        curriculumService.update(curriculum);
        return buildFailureJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }


    /**
     * 后台页面 分页获取用户课程 (档案管理)
     * @param pageArgs 分页工具
     * @param userId 用户id、
     * @return 课程列表
     */
    @RequestMapping("/listForAdminUser")
    public ViewDataPage listForAdminUser(PageArgs pageArgs ,Integer userId ) {
        try {
            if (null  == userId) {
                return buildFailureJsonPage(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            PageList pageList = curriculumService.listForAdminUser(pageArgs, userId);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    @RequestMapping("/queryCurriculum")
    public ViewData queryCurriculum(){
        return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",
                curriculumService.queryCurriculumForSeclect());
    }

    /**
     * 删除课程
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    public ViewData delete(Integer id) {
        try {
            if (null == id) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            curriculumService.delete(id);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，删除失败");
        }
    }




    /**
     * 后台页面 获取课程 （下拉框）
     * @param curriculumName 课程名
     * @param cityId 地区id
     * @return 课程列表
     */
    @RequestMapping("/listForSelect")
    public ViewData listForSelect(String curriculumName ,
                             Integer provinceId ,Integer cityId ,Integer districtId) {
        try {
            PageList pageList = curriculumService.listForAdmin(null, curriculumName, null ,
                    provinceId, cityId , districtId ,null, 1,
                    null, 1, 1, null, null, null,null,null);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    /**
     * 获取用户已购买课程 并有试卷且为考试 获取课程 （下拉框）
     * @param userId 用户id
     * @return 课程列表
     */
    @RequestMapping("/getUserCurriculum")
    public ViewData getUserCurriculum(Integer userId)  {
        try {
            if (null == userId) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",curriculumService.getUserCurriculum(userId));
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


}
