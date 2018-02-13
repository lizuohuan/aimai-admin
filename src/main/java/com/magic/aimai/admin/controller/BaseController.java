package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



public class BaseController {

    protected Logger logger = LoggerFactory.getLogger(getClass());

    protected ViewData buildViewData(ViewData.FlagEnum flag, int code, String message, Object data) {
        ViewData viewData = new ViewData();
        viewData.setFlag(flag.ordinal());
        viewData.setCode(Integer.valueOf(code));
        viewData.setMsg(message);
        viewData.setData(data);
        return viewData;
    }

    protected ViewDataPage buildViewDataPage(ViewData.FlagEnum flag, int code, String message, Integer recordsTotal, Object data) {
        ViewDataPage viewData = new ViewDataPage();
        viewData.setFlag(flag.ordinal());
        viewData.setCode(Integer.valueOf(code));
        viewData.setMsg(message);
        viewData.setRecordsTotal(recordsTotal);
        viewData.setData(data);
        return viewData;
    }

    protected ViewData buildSuccessJson(int code, String msg, Object data) {
        return buildViewData(ViewData.FlagEnum.NORMAL, code, msg, data);
    }

    public ViewData buildSuccessCodeJson(int code, String msg) {
        return buildSuccessJson(code, msg, (Object)null);
    }

    protected ViewData buildSuccessViewData(int code, String msg, Object data) {
        return buildViewData(ViewData.FlagEnum.NORMAL, code, msg, data);
    }

    protected ViewData buildSuccessCodeViewData(int code, String msg) {
        return buildSuccessViewData(code, msg, (Object) null);
    }

    protected ViewData buildFailureJson(ViewData.FlagEnum flag, int code, String msg) {
        return buildViewData(flag, code, msg, (Object)null);
    }
    protected ViewData buildFailureJson(int code, String msg) {
        return buildViewData(ViewData.FlagEnum.NORMAL, code, msg, (Object)null);
    }

    protected ViewData buildFailureMessage(String msg) {
        return buildFailureJson(202, msg);
    }


    protected ViewDataPage buildSuccessViewDataPage(int code, String msg, int recordsTotal, Object data) {
        return buildViewDataPage(ViewData.FlagEnum.NORMAL, code, msg,recordsTotal, data);
    }
    protected ViewDataPage buildFailureJsonPage(int code, String msg) {
        return buildViewDataPage(ViewData.FlagEnum.NORMAL, code, msg,0,(Object)null);
    }
    
    
    
}
