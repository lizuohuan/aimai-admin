package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.Curriculum;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.entity.User;
import com.magic.aimai.business.enums.RoleEnum;
import com.magic.aimai.business.exception.InterfaceCommonException;
import com.magic.aimai.business.service.OperationLogService;
import com.magic.aimai.business.service.UserService;
import com.magic.aimai.business.util.CommonUtil;
import com.magic.aimai.business.util.LoginHelper;
import com.magic.aimai.business.util.StatusConstant;
import com.magic.aimai.business.util.Timestamp;
import net.sf.json.JSONArray;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.*;

/**
 * User Controller
 * Created by Eric Xie on 2017/7/21 0021.
 */
@RestController
@RequestMapping("/user")
public class UserController extends BaseController {

    @Resource
    private UserService userService;

    @Resource
    private OperationLogService operationLogService;


    /**
     * 后台导入用户 增加到企业下
     * @param url
     * @return
     */
    @RequestMapping("/importUserExcel")
    public ViewData importExcel(String url,Integer companyId){
        if(CommonUtil.isEmpty(url,companyId)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        {
            User user = LoginHelper.getCurrentUser();
            if (null == user) {
                return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
            }
            //操作日志
            operationLogService.save2(user.getId(),user.getRoleId(),"为企业导入了用户");
        }
        try {
            User user = userService.queryBaseInfo(companyId);
            if(null == user){
                return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,"企业用户不存在");
            }
            if(!user.getRoleId().equals(RoleEnum.COMPANY_USER.ordinal())){
                return buildFailureJson(StatusConstant.Fail_CODE,"不是企业用户");
            }
            Map<String, Object> data = userService.importExcelUser(url, companyId);


            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"操作成功",
                    data);
        } catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"数据读取失败");
        }
    }



    /**
     * 获取公司列表
     * @return
     */
    @RequestMapping("/queryCompanyList")
    public ViewData queryCompanyList(){
        return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",
                userService.queryCompanyList());
    }

    @RequestMapping("/login")
    public ViewData login(String account, String password, HttpServletRequest request,HttpServletResponse response){
        response.setHeader("Access-Control-Allow-Origin", "*");
        if(CommonUtil.isEmpty(account,password)){
            return buildFailureJson(StatusConstant.Fail_CODE,"帐号密码不能为空");
        }
        try {
            User user = userService.login(account, password);

            if ((user.getRoleId() > 1 && user.getRoleId() < 3) || (user.getRoleId() > 3 && user.getRoleId() < 6)) {
                return buildFailureJson(StatusConstant.NOT_AGREE,"对不起，您不是平台用户或企业用户，不能登录平台管理系统");
            }

            request.getSession().setAttribute(LoginHelper.SESSION_USER,user);
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,"登录成功",user);
        } catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"登录失败");
        }
    }



    @RequestMapping("/logout")
    public ViewData logout(){
        LoginHelper.clearToken(null);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");

    }

    /**
     * 后台页面 分页获取用户
     * @param pageArgs 分页属性
     * @param phone 手机号
     * @param roleId 角色id
     * @param provinceId 省id
     * @param cityId 城市id
     * @param cityId 区id
     * @param tradeId 行业id
     * @param status 状态 企业、政府用户注册 后台审核状态 0：未通过 1：审核通过  2：审核中
     * @param showName 展示名称 个人：姓名 政府：机构名称 企业：企业名称
     * @return
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs ,String phone ,Integer roleId,
                             Integer provinceId ,Integer cityId ,Integer districtId ,
                             Integer tradeId ,Integer status ,String showName) {
        try {
            PageList pageList = userService.listForAdmin(pageArgs, phone, roleId, provinceId, cityId, districtId,
                    tradeId, status, showName);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    @RequestMapping("/getUserByIsValid")
    public ViewDataPage getUserByIsValid(PageArgs pageArgs ,String phone ,Integer roleId) {
        try {
            PageList pageList = userService.getUserByIsValid(pageArgs,0,roleId,phone);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    /**
     * 新增用户
     * @param user
     * @throws Exception
     */
    @Transactional
    @RequestMapping("/save")
    public ViewData save(User user,String cityIds){
        try {
            if (null == user.getAvatar() || user.getAvatar().equals("")) {
                user.setAvatar(null);
            }
            userService.addUser(user,cityIds);
            {
                User user2 = LoginHelper.getCurrentUser();
                if (null == user2) {
                    return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
                }
                //操作日志
                operationLogService.save2(user2.getId(),user2.getRoleId(),"新增了用户");
            }
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"添加成功");
        } catch (InterfaceCommonException e) {
            logger.error(e.getMessage(),e.getErrorCode());
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            logger.error("服务器超时，添加失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，添加失败");
        }
    }

    /**
     * 更新用户 不为空的字段 通过ID
     * @param user
     */
    @RequestMapping("/update")
    public ViewData update(User user,String cityIds){
        try {
            if (null == user || null == user.getId()) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            if (null == user.getAvatar() || user.getAvatar() == "") {
                user.setAvatar(null);
            }
            User user1 = userService.queryBaseInfo(user.getId());
            if(!CommonUtil.isEmpty(user1.getToken())){
                LoginHelper.delObject(user1.getToken());
            }
            {
                User user2 = LoginHelper.getCurrentUser();
                if (null == user2) {
                    return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
                }
                //操作日志
                operationLogService.save2(user2.getId(),user2.getRoleId(),"更新了用户信息");
            }
            userService.updateUser(user,cityIds);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功");
        } catch (Exception e) {
            logger.error("服务器超时，更新失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }

    /**
     * 更新用户 不为空的字段 通过ID
     */
    @RequestMapping("/updateIsValid")
    public ViewData updateIsValid(Integer id,Integer isValid){
        try {
            if (null == isValid || null == id) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            User temp = userService.queryBaseInfo(id);
            if(null == temp){
                return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,"用户不存在");
            }
            User user = new User();
            user.setId(id);
            user.setIsValid(isValid);
            userService.updateUser(user,null);
            if(null != temp.getToken()){
                LoginHelper.clearToken(temp.getToken());
            }
            {
                User user2 = LoginHelper.getCurrentUser();
                if (null == user2) {
                    return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
                }
                //操作日志
                operationLogService.save2(user2.getId(),user2.getRoleId(),"更新了用户信息");
            }
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功");
        } catch (Exception e) {
            logger.error("服务器超时，更新失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }

    /**
     * 查询用户的基础信息
     * @param id
     * @return
     */
    @RequestMapping("/info")
    public ViewData info(Integer id){
        try {
            if (null == id) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功 ",userService.info(id));
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    /**
     * 更新用户审核状态
     * @param id 用户id
     * @param status 审核状态 0：未通过 1：审核通过  2：审核中
     * @param notes 备注
     * @return
     */
    @RequestMapping("/updateStatus")
    public ViewData updateStatus(Integer id,Integer status ,String notes) {
        User user = LoginHelper.getCurrentUser();
        if (null == user) {
            return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
        }
        if (null == id || null == status) {
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        User u = new User();
        u.setId(id);
        u.setNotes(notes);
        u.setStatus(status);
        userService.updateUser(u,null);
        {
            User user2 = LoginHelper.getCurrentUser();
            if (null == user2) {
                return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
            }
            //操作日志
            operationLogService.save2(user2.getId(),user2.getRoleId(),"审核用户信息");
        }
        return buildFailureJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }




    /**
     * 后台页面 分页获取用户(档案管理)
     * @param pageArgs 分页属性
     * @param phone 手机号
     * @param roleId 角色id
     * @param startTimes 开始时间
     * @param endTimes 结束时间
     * @param companyName 公司名
     * @return
     */
    @RequestMapping("/listForAdminRecord")
    public ViewDataPage listForAdminRecord(PageArgs pageArgs , String phone , Integer roleId ,String pid,
                             String companyName, String startTimes , String endTimes,Integer companyId) {
        try {
            Date startTime = null;
            Date endTime = null;
            if (null != startTimes && !startTimes.equals("")) {
                startTime = Timestamp.parseDate(startTimes,"yyyy-MM-dd HH:mm:ss");
            }
            if (null != endTimes && !endTimes.equals("")) {
                endTime = Timestamp.parseDate(endTimes,"yyyy-MM-dd HH:mm:ss");
            }
            User user = LoginHelper.getCurrentUser();
            if (null != user && user.getRoleId() == RoleEnum.COMPANY_USER.ordinal()) {
                companyId = user.getId();
            }
            PageList pageList = userService.listForAdminRecord(pageArgs,phone,roleId,pid,companyName,startTime,endTime,companyId);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }


    /**
     * 后台页面 分页获取用户(档案管理)
     * @param pageArgs 分页属性
     * @param phone 手机号
     * @param orderId 订单id
     * @return
     */
    @RequestMapping("/findUserByPhone2")
    public ViewDataPage findUserByPhone2(PageArgs pageArgs , String phone , Integer orderId) {
        try {
            PageList pageList = userService.findUserByPhone2(pageArgs,phone,orderId);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }





    /**
     * 后台页面 获取用户 下拉列表
     * @param roleId 角色id
     * @param provinceId 省id
     * @param cityId 城市id
     * @param cityId 区id
     * @return
     */
    @RequestMapping("/listForSelect")
    public ViewData listForSelect(Integer roleId,
                             Integer provinceId ,Integer cityId ,Integer districtId) {
        try {
            if (null == roleId) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            PageList pageList = userService.listForAdmin(null, null, roleId, provinceId, cityId, districtId,
                    null, 1, null);
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }




    /**
     * 导入用户
     * @param url 导入用户的excel地址
     * @throws Exception
     */
    @RequestMapping("/addExcel")
    public ViewData addExcel(String url ,Integer parentId,Integer roleId) {
        try {
            {
                User user2 = LoginHelper.getCurrentUser();
                if (null == user2) {
                    return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
                }
                //操作日志
                operationLogService.save2(user2.getId(),user2.getRoleId(),"导入了用户");
            }
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"导入成功 ",
                    userService.importExcenUserWeb(url,parentId,roleId));
        } catch (FileNotFoundException e) {
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，解析失败");
        }  catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，导入失败");
        }
    }


    /**
     *  修改密码 接口
     * @param oldPwd
     * @param newPwd
     * @return
     */
    @RequestMapping("/editPassword")
    public @ResponseBody
    ViewData editPassword(String oldPwd, String newPwd){
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
        }
        User user = (User)obj;

        if(CommonUtil.isEmpty(oldPwd,newPwd)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        User baseUser = userService.queryBaseInfo(user.getId());
        if(null == baseUser){
            return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,"用户不存在");
        }
        if(!oldPwd.equals(baseUser.getPwd())){
            return buildFailureJson(StatusConstant.Fail_CODE,"旧密码不正确");
        }
        User wait = new User();
        try {
            wait.setId(user.getId());
            wait.setPwd(newPwd);
            userService.updateUser(wait,null);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE, "更新失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE, "修改成功");

    }


}
