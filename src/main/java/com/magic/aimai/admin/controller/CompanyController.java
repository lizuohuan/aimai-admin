package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.business.entity.Company;
import com.magic.aimai.business.service.CompanyService;
import com.magic.aimai.business.util.StatusConstant;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * 安培公司信息
 * @author lzh
 * @create 2017/8/3 20:03
 */
@RestController
@RequestMapping("/company")
public class CompanyController extends BaseController {

    @Resource
    private CompanyService companyService;


    /**
     * 更新安培公司信息
     * @param company 公司信息
     * @return
     */
    @RequestMapping("/update")
    public ViewData update(Company company) {
        try {
            companyService.update(company);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功");
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
    public ViewData info() {
        try {
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"更新成功",companyService.info());
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }

}
