package com.magic.aimai.admin.controller;

import com.magic.aimai.admin.util.ViewData;
import com.magic.aimai.admin.util.ViewDataPage;
import com.magic.aimai.business.entity.PageArgs;
import com.magic.aimai.business.entity.PageList;
import com.magic.aimai.business.entity.Paper;
import com.magic.aimai.business.enums.PaperEnum;
import com.magic.aimai.business.service.PaperService;
import com.magic.aimai.business.util.CommonUtil;
import com.magic.aimai.business.util.StatusConstant;
import net.sf.json.JSONArray;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Eric Xie on 2017/7/31 0031.
 */
@RestController
@RequestMapping("/paper")
public class PaperController extends BaseController {

    @Resource
    private PaperService paperService;


    @RequestMapping("/updatePaper")
    public ViewData updatePaper(Integer paperId,Integer isValid){
        if(CommonUtil.isEmpty(paperId,isValid)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        Paper paper = paperService.queryBasePaper(paperId);
        if(null == paper){
            return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,"试卷不存在");
        }
        Paper temp = new Paper();
        temp.setIsValid(isValid);
        temp.setId(paperId);
        paperService.updatePaper(temp);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }


    @RequestMapping("/bind")
    public ViewData bind(String paperItems){

        if(CommonUtil.isEmpty(paperItems)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        try {
            JSONArray jsonArray = JSONArray.fromObject(paperItems);
            paperService.bindPaper(jsonArray);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"设置失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }


    @RequestMapping("/save")
    public ViewData save(Paper paper){
        if(CommonUtil.isEmpty(paper.getTargetId(),paper.getPaperTitle(),paper.getPassScore())){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }

        if (paper.getType() != 0) {
            if(CommonUtil.isEmpty(paper.getUseTime())){
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"没有设置时间");
            }
            paper.setUseTime(paper.getUseTime());
        }
        // 如果添加的习题是 练习题，则练习题 只能有一份
        if(PaperEnum.Exercises.ordinal() == paper.getType() || PaperEnum.ExaminationQuestion.ordinal() == paper.getType() ){
            List<Paper> papers = paperService.queryPaperByItems(paper.getTargetId(), paper.getType());
            if(null != papers &&  papers.size() > 0){
                return buildFailureJson(StatusConstant.OBJECT_EXIST,"该课件下已经存在试卷");
            }
        }
        paperService.addPaper(paper);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }

    @RequestMapping("/paperList")
    public ViewDataPage paperList(PageArgs pageArgs,Integer type,Integer targetId,String paperTitle){
        Map<String,Object> params = new HashMap<String, Object>();
        params.put("type",type);
        params.put("targetId",targetId);
        params.put("paperTitle",paperTitle);
        PageList<Paper> list = paperService.queryPaper(pageArgs, params);
        return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功",list.getTotalSize(),list.getList());
    }


    @RequestMapping("/update")
    public ViewData update(Paper paper){
        if (null == paper.getId()) {
            return buildSuccessCodeJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        if (paper.getType() != 0) {
            paper.setUseTime(paper.getUseTime());
        }
        paperService.updatePaper(paper);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }

    @RequestMapping("/info")
    public ViewData info(Integer id){
        Paper paper = paperService.queryBasePaper(id);
        if (paper.getType() != 0) {
            paper.setUseTime(paper.getUseTime() / 3600);
        }

        return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"操作成功",paper);
    }
}
