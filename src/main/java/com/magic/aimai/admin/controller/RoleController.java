package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.business.entity.Role;
import com.magic.aimai.business.entity.User;
import com.magic.aimai.business.service.OperationLogService;
import com.magic.aimai.business.service.RoleService;
import com.magic.aimai.business.util.CommonUtil;
import com.magic.aimai.business.util.LoginHelper;
import com.magic.aimai.business.util.StatusConstant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author lzh
 * @create 2017/4/20 16:19
 */
@RestController
@RequestMapping("/role")
public class RoleController extends BaseController {


    private Logger logger = LoggerFactory.getLogger(getClass());

    @Resource
    private RoleService roleService;
    @Resource
    private OperationLogService operationLogService;


    /**
     * 角色列表
     * @return
     */
    @RequestMapping("/list")
    public ViewData list() {
        try {
            List<Role> list = roleService.list();
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功",list);
        } catch (Exception e) {
            logger.error("服务器超时，获取角色列表失败",e);
            return buildSuccessCodeJson(StatusConstant.Fail_CODE,"服务器超时，获取角色列表失败");
        }
    }

    /**
     * 添加角色
     * @param role 角色实体
     * @return
     */
    @RequestMapping("/insert")
    public ViewData insert(Role role) {
        try {
            User user = LoginHelper.getCurrentUser();
            if (null == user) {
                return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
            }
            roleService.insert(role);
            //操作日志
            operationLogService.save2(user.getId(),user.getRoleId(),"添加了角色");
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"添加成功");
        } catch (Exception e) {
            logger.error("服务器超时，添加失败",e);
            return buildSuccessCodeJson(StatusConstant.Fail_CODE,"服务器超时，添加失败");
        }
    }

    /**
     * 更新角色
     * @return
     */
    @RequestMapping("/updateRole")
    public ViewData insert(Integer id,String roleName,String describe) {
        if(CommonUtil.isEmpty(id)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        User user = LoginHelper.getCurrentUser();
        if (null == user) {
            return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
        }
        try {
            roleName = CommonUtil.isEmpty(roleName) ? null : roleName;
            describe = CommonUtil.isEmpty(describe) ? null : describe;
            roleService.updateRole(roleName,describe,id);
            //操作日志
            operationLogService.save2(user.getId(),user.getRoleId(),"更新了角色信息");
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功");
        } catch (Exception e) {
            logger.error("服务器超时，更新失败",e);
            return buildSuccessCodeJson(StatusConstant.Fail_CODE,"服务器超时，添加失败");
        }
    }


    /**
     * 删除角色
     * @param id 角色id
     * @return
     */
    @RequestMapping("/delete")
    public ViewData delete(Integer id) {
        try {
            User user = LoginHelper.getCurrentUser();
            if (null == user) {
                return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
            }
            if (null == id ) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            roleService.delete(id);
            //操作日志
            operationLogService.save2(user.getId(),user.getRoleId(),"删除了角色信息");
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"添加成功");
        } catch (Exception e) {
            logger.error("服务器超时，添加失败",e);
            return buildSuccessCodeJson(StatusConstant.Fail_CODE,"服务器超时，添加失败");
        }
    }
}
