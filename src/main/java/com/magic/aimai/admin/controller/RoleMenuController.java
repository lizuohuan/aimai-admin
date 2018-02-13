package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.business.cache.MemcachedUtil;
import com.magic.aimai.business.entity.RoleMenu;
import com.magic.aimai.business.service.RoleMenuService;
import com.magic.aimai.business.util.CommonUtil;
import com.magic.aimai.business.util.StatusConstant;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Eric Xie on 2017/6/12 0012.
 */
@Controller
@RequestMapping("/roleUrl")
public class RoleMenuController extends BaseController {

    @Resource
    private RoleMenuService roleUrlService;


    /**
     *  根据角色ID 获取 角色的权限
     * @param roleId 角色ID
     * @return
     */
    @RequestMapping("/queryRoleUrl")
    public @ResponseBody
    ViewData queryRoleUrl(Integer roleId){
        if (null == roleId) {
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, "字段不能为空");
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功",
                roleUrlService.queryUrlByRole(roleId));
    }


    /**
     * 后台 新增配置权限
     * @param keyIds URL Id集合
     * @param roleId 角色ID
     * @return
     */
    @RequestMapping("/addRoleUrl")
    public @ResponseBody ViewData addRoleUrl(String keyIds, Integer roleId) {

        if (null == roleId) {
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, "字段不能为空");
        }
        try {
            List<RoleMenu> roleMenus = new ArrayList<RoleMenu>();
            if (!CommonUtil.isEmpty(keyIds)) {
                JSONArray jsonArray = JSONArray.fromObject(keyIds);
                for (Object o : jsonArray) {
                    RoleMenu roleMenu = new RoleMenu();
                    roleMenu.setRoleId(roleId);
                    roleMenu.setMenuId(Integer.valueOf(o.toString()));
                    roleMenus.add(roleMenu);
                }
            }
            roleUrlService.addRoleUrl(roleMenus, roleId);
            //移除此角色权限缓存信息 在获取角色权限是重新放入缓存
            MemcachedUtil.getInstance().delObj("role_cache_" + roleId.toString());
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildSuccessCodeJson(StatusConstant.Fail_CODE,"操作失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }

}
