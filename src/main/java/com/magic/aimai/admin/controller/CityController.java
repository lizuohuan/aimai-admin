package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.business.entity.City;
import com.magic.aimai.business.service.CityService;
import com.magic.aimai.business.util.StatusConstant;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * 地区
 * @author lzh
 * @create 2017/7/21 10:16
 */
@RestController
@RequestMapping("/city")
public class CityController extends BaseController {

    @Resource
    private CityService cityService;



    /**
     * 通过城市ID 查询 城市下面 该级别的所有城市
     * @param cityId
     * @param levelType  1:省级  2：市级  3：区县级
     * @return
     */
    @RequestMapping("/queryCityByParentId")
    public ViewData queryCityByParentId(Integer cityId,Integer levelType){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功",
                cityService.queryCityByParentId(cityId,levelType));
    }



    /**
     * 获取地区
     * @return
     */
    @RequestMapping("/list")
    public ViewData list() {
        try {
            List<City> list = cityService.queryAllCity();
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",list);
        } catch (Exception e) {
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,"获取失败");
        }
    }
}
