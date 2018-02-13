package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.entity.Trade;
import com.magic.aimai.business.service.TradeService;
import com.magic.aimai.business.util.StatusConstant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * 行业分类 控制器
 * @author lzh
 * @create 2017/7/17 14:42
 */
@RestController
@RequestMapping("/trade")
public class TradeController extends BaseController {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Resource
    private TradeService tradeService;


    /**
     * 后台页面 分页获取行业分类
     * @param pageArgs 分页属性
     * @param tradeName 课程名
     * @return 行业分类
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs ,String tradeName) {
        try {
            PageList pageList = tradeService.listForAdmin(pageArgs, tradeName);
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }

    /**
     * 后台页面 分页行业分类 下拉列表
     * @return 行业分类
     */
    @RequestMapping("/listForSelect")
    public ViewData listForSelect() {
        try {
            PageList pageList = tradeService.listForAdmin(null, null);
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }

    /**
     * 添加行业分类
     * @param trade
     * @return
     */
    @RequestMapping("/save")
    public ViewData save(Trade trade){
        try {
            tradeService.save(trade);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"添加成功");
        } catch (Exception e) {
            logger.error("服务器超时，添加失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，添加失败");
        }
    }

    /**
     * 更新行业分类
     * @param trade
     * @return
     */
    @RequestMapping("/update")
    public ViewData update(Trade trade){
        try {
            if (null == trade || null == trade.getId()) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            tradeService.update(trade);
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功");
        } catch (Exception e) {
            logger.error("服务器超时，更新失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }
}
