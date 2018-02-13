package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.business.cache.MemcachedUtil;
import com.magic.aimai.business.entity.Menu;
import com.magic.aimai.business.entity.User;
import com.magic.aimai.business.service.MenuService;
import com.magic.aimai.business.util.LoginHelper;
import com.magic.aimai.business.util.StatusConstant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * 权限 -- 控制器
 * @author lzh
 * @create 2017/4/20 9:18
 */
@RestController
@RequestMapping("/menu")
public class MenuController extends BaseController{

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Resource
    private MenuService menuService;


    /**
     * 全部权限(菜单)
     * @return
     */
    @RequestMapping("/findAllMenu")
    private ViewData findAllMenu(Integer roleId) {
        try {
            List<Menu> menuList = menuService.findAllMenu(roleId);
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功",menuList);
        } catch (Exception e) {
            logger.error("服务器超时",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时");
        }
    }


    /**
     * 获取当前登录人角色的所有权限(菜单)
     * @return
     */
    @RequestMapping("/getRoleMenu")
    private ViewData getRoleMenu() {
        try {
            User user = LoginHelper.getCurrentUser();
            if(null == user){
                return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
            }
            List<Menu> menuList = (List<Menu>) MemcachedUtil.getInstance().get("role_cache_" + user.getRoleId().toString());
            if (null == menuList || menuList.size() == 0) {
                menuList = menuService.getRoleMenu(user.getId());
                MemcachedUtil.getInstance().add("role_cache_" + user.getRoleId().toString(),menuList);
            }
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功",menuList);
        } catch (Exception e) {
            logger.error("服务器超时",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时");
        }
    }



}
