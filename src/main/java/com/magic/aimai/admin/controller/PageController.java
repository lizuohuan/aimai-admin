package com.magic.aimai.admin.controller;

import com.magic.aimai.business.entity.Examination;
import com.magic.aimai.business.service.CurriculumService;
import com.magic.aimai.business.service.ExaminationService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

/**
 * 页面请求控制器
 * Created by Eric Xie on 2017/7/12 0012.
 */

@Controller
@RequestMapping("/page")
public class PageController {

    @Resource
    private ExaminationService examinationService;

    @RequestMapping("/login")
    public String loginPage(){
        return "login";
    }

    @RequestMapping("/index")
    public String indexPage(){
        return "index";
    }

    /**
     * 进入主页
     * @return
     */
    @RequestMapping("/main")
    public String main(){
        return "main";
    }

    /**
     * 课程列表
     * @return
     */
    @RequestMapping("/curriculum/list")
    public String curriculumList(){
        return "/curriculum/list";
    }

    /**
     * 进入详情更新课程
     * @return
     */
    @RequestMapping("/curriculum/edit")
    public String curriculumUpdate(Integer id , ModelMap modelMap){
        modelMap.addAttribute("id",id);
        return "/curriculum/edit";
    }

    /**
     * 添加课程
     * @return
     */
    @RequestMapping("/curriculum/save")
    public String curriculumSave(){
        return "/curriculum/save";
    }


    /**
     * banner列表
     * @return
     */
    @RequestMapping("/banner/list")
    public String bannerList(){return "/banner/list";}

    /**
     * banner添加
     * @return
     */
    @RequestMapping("/banner/add")
    public String bannerAdd(){ return "/banner/add";}

    /**
     * banner修改
     * @return
     */
    @RequestMapping("/banner/edit")
    public String bannerEdit(Integer id , ModelMap modelMap){
        modelMap.addAttribute("id",id);
        return "/banner/edit";
    }

    /**
     * 权限
     * @return
     */
    @RequestMapping("/jurisdiction/add")
    public String jurisdiction(){return "/jurisdiction/add";}


    /**
     * 课件列表
     * @return
     */
    @RequestMapping("/courseWare/list")
    public String courseWareList(Integer id ,ModelMap modelMap){
        modelMap.addAttribute("curriculumId",id);
        return "/courseWare/list";
    }

    /**
     * 进入详情更新课件
     * @return
     */
    @RequestMapping("/courseWare/edit")
    public String courseWareUpdate(Integer id , ModelMap modelMap){
        modelMap.addAttribute("id",id);
        return "/courseWare/edit";
    }

    /**
     * 添加课件
     * @return
     */
    @RequestMapping("/courseWare/save")
    public String courseWareSave(Integer curriculumId ,ModelMap modelMap){
        modelMap.addAttribute("curriculumId",curriculumId);
        return "/courseWare/save";
    }

    /**
     * 视频列表
     * @return
     */
    @RequestMapping("/video/list")
    public String videoList(Integer id ,ModelMap modelMap){
        modelMap.addAttribute("courseWareId",id);
        return "/video/list";
    }

    /**
     * 进入详情更新视频
     * @return
     */
    @RequestMapping("/video/edit")
    public String videoUpdate(Integer id , ModelMap modelMap){
        modelMap.addAttribute("id",id);
        return "/video/edit";
    }

    /**
     * 添加视频
     * @return
     */
    @RequestMapping("/video/save")
    public String videoSave(Integer courseWareId ,ModelMap modelMap){
        modelMap.addAttribute("courseWareId",courseWareId);
        return "/video/save";
    }

    /**
     * 行业列表
     * @return
     */
    @RequestMapping("/trade/list")
    public String tradeList(){
        return "/trade/list";
    }

    /**
     * 进入行业
     * @return
     */
    @RequestMapping("/trade/edit")
    public String tradeUpdate(Integer id ,String tradeName , ModelMap modelMap){
        modelMap.addAttribute("id",id);
        modelMap.addAttribute("tradeName",tradeName);
        return "/trade/edit";
    }

    /**
     * 添加行业
     * @return
     */
    @RequestMapping("/trade/save")
    public String tradeSave(){
        return "/trade/save";
    }


    /**
     * 试卷列表
     * @return
     */
    @RequestMapping("/paper/list")
    public String paperList(){
        return "/paper/list";
    }

    /**
     * 添加试卷
     * @return
     */
    @RequestMapping("/paper/save")
    public String paperSave(){
        return "/paper/save";
    }

    /**
     * 更新试卷
     * @return
     */
    @RequestMapping("/paper/edit")
    public String paperEdit(Integer id,Model model){
        model.addAttribute("id",id);
        return "/paper/edit";
    }


    /**
     * 试卷绑定试题
     * @return
     */
    @RequestMapping("/paper/bind")
    public String paperBind(Integer paperId,Model model){
        model.addAttribute("paperId",paperId);
        return "/paper/bind";
    }

    /**
     * 试卷的试题
     * @return
     */
    @RequestMapping("/examinationPaper/list")
    public String examinationPaperList(Integer paperId,Model model){
        model.addAttribute("paperId",paperId);
        return "/examinationPaper/list";
    }


    /**
     * 考题列表
     * @return
     */
    @RequestMapping("/examination/list")
    public String examinationList(){
        return "/examination/list";
    }


    /**
     * 进入考题详情
     * @return
     */
    @RequestMapping("/examination/edit")
    public String examinationUpdate(Integer id , ModelMap modelMap){
        modelMap.addAttribute("id",id);
        return "/examination/edit";
    }

    /**
     * 添加考题
     * @return
     */
    @RequestMapping("/examination/save")
    public String examinationSave(){
        return "/examination/save";
    }

    /**
     * 考题选项列表
     * @return
     */
    @RequestMapping("/examination/items/list")
    public String examinationItemsList(Integer id, Model model){
        Examination examination = examinationService.queryBaseExamination(id);
        model.addAttribute("type",examination.getType());
        model.addAttribute("id",id);
        return "/examination/items/list";
    }


    /**
     * 添加考题
     * @return
     */
    @RequestMapping("/examination/items/save")
    public String examinationItemsSave(Integer examinationId,Model model){
        model.addAttribute("examinationId",examinationId);
        return "/examination/items/save";
    }

    /**
     * 更新考题答案信息
     * @return
     */
    @RequestMapping("/examination/items/edit")
    public String examinationItemsEdit(Integer id,Model model){
        model.addAttribute("id",id);
        return "/examination/items/edit";
    }


    /**
     * 用户列表
     * @return
     */
    @RequestMapping("/user/list")
    public String userList(){
        return "/user/list";
    }

    /**
     * 用户回收站
     * @return
     */
    @RequestMapping("/user/list2")
    public String userList2(){
        return "/user/list2";
    }

    /**
     * 进入用户详情
     * @return
     */
    @RequestMapping("/user/edit")
    public String userUpdate(Integer id , ModelMap modelMap){
        modelMap.addAttribute("id",id);
        return "/user/edit";
    }

    /**
     * 添加用户
     * @return
     */
    @RequestMapping("/user/save")
    public String userSave(){
        return "/user/save";
    }


    /**
     * 用户列表 (档案管理)
     * @return
     */
    @RequestMapping("/user/listForAdminRecord")
    public String userListRecord(){
        return "/userRecord/list";
    }

    /**
     * 用户详情 (档案管理)
     * @return
     */
    @RequestMapping("/user/infoRecord")
    public String userInfoRecord(Integer id , ModelMap modelMap){
        modelMap.addAttribute("id",id);
        return "/userRecord/edit";
    }

    /**
     * 用户课程列表 (档案管理)
     * @return
     */
    @RequestMapping("/curriculum/userCurriculumList")
    public String userCurriculumList(Integer userId , ModelMap modelMap){
        modelMap.addAttribute("userId",userId);
        return "/curriculumRecord/list";
    }

    /**
     * 用户课件列表 (档案管理)
     * @return
     */
    @RequestMapping("/userCourseWare/list")
    public String userCourseWareList(Integer curriculumId ,Integer orderId ,Integer userId, ModelMap modelMap){
        modelMap.addAttribute("curriculumId",curriculumId);
        modelMap.addAttribute("orderId",orderId);
        modelMap.addAttribute("userId",userId);
        return "/userCourseWare/list";
    }
    /**
     * 用户课件人脸采集列表 (档案管理)
     * @return
     */
    @RequestMapping("/faceRecord/list")
    public String faceRecordList(Integer courseWareId ,Integer orderId, Integer userId, ModelMap modelMap){
        modelMap.addAttribute("courseWareId",courseWareId);
        modelMap.addAttribute("orderId",orderId);
        modelMap.addAttribute("userId",userId);
        return "/faceRecord/list";
    }


    /**
     * 订单列表
     * @return
     */
    @RequestMapping("/order/list")
    public String orderList(){
        return "/order/list";
    }

    /**
     * 进入订单详情
     * @return
     */
    @RequestMapping("/order/edit")
    public String orderUpdate(Integer id , ModelMap modelMap){
        modelMap.addAttribute("id",id);
        return "/order/edit";
    }

    /**
     * 添加订单
     * @return
     */
    @RequestMapping("/order/save")
    public String orderSave(){
        return "/order/save";
    }


    /**
     * 新闻资讯列表
     * @return
     */
    @RequestMapping("/news/list")
    public String newsList(){return "/news/list";}

    /**
     * 新闻资讯添加
     * @return
     */
    @RequestMapping("/news/add")
    public String newsAdd(){ return "/news/add";}

    /**
     * 新闻资讯修改
     * @return
     */
    @RequestMapping("/news/edit")
    public String newsEdit(Integer id , ModelMap modelMap){
        modelMap.addAttribute("id",id);
        return "/news/edit";
    }


    /**
     * 评论列表
     * @return
     */
    @RequestMapping("/evaluate/list")
    public String evaluateList(){return "/evaluate/list";}



    /**
     * 禁词列表
     * @return
     */
    @RequestMapping("/forbiddenWords/list")
    public String forbiddenWordsList(){return "/forbiddenWords/list";}

    /**
     * 禁词添加
     * @return
     */
    @RequestMapping("/forbiddenWords/add")
    public String forbiddenWordsAdd(){ return "/forbiddenWords/save";}

    /**
     * 禁词修改
     * @return
     */
    @RequestMapping("/forbiddenWords/edit")
    public String forbiddenWordsEdit(Integer id , ModelMap modelMap){
        modelMap.addAttribute("id",id);
        return "/forbiddenWords/edit";
    }


    /**
     * 意见反馈列表
     * @return
     */
    @RequestMapping("/suggest/list")
    public String suggestList(){return "/suggest/list";}




    /**
     * 角色列表
     * @return
     */
    @RequestMapping("/role/list")
    public String roleList(){return "/role/list";}
    /**
     * 角色列表
     * @return
     */
    @RequestMapping("/role/add")
    public String addRoleList(){return "/role/add";}

    /**
     * 公司信息
     * @return
     */
    @RequestMapping("/company/edit")
    public String companyInfo(){return "/company/edit";}

    /**
     * 公司内容
     * @return
     */
    @RequestMapping("/content/edit")
    public String contentInfo(Integer id,String name, ModelMap modelMap){
        modelMap.addAttribute("id",id);
        modelMap.addAttribute("name",name);
        return "/content/edit";
    }


    /**
     * 视频库列表
     * @return
     */
    @RequestMapping("/videoWareHouse/list")
    public String videoWareHouseList(){
        return "/videoWareHouse/list";
    }

    /**
     * 测试上传视频库列表
     * @return
     */
    @RequestMapping("/videoWareHouse/media")
    public String videoWareMediaHouseList(){
        return "/videoWareHouse/media";
    }

    /**
     * 添加视频库
     * @return
     */
    @RequestMapping("/videoWareHouse/save2")
    public String videoWareHouseSave2(){return "/videoWareHouse/save2";}

    /**
     * 添加视频库
     * @return
     */
    @RequestMapping("/videoWareHouse/save")
    public String videoWareHouseSave(){return "/videoWareHouse/save";}
    /**
     * 添加视频库
     * @return
     */
    @RequestMapping("/videoWareHouse/edit")
    public String videoWareHouseSave(Integer id, ModelMap modelMap,Integer flag){
        modelMap.addAttribute("id",id);
        if(null != flag && flag == 0){
            return "/videoWareHouse/edit2";
        }
        return "/videoWareHouse/edit";
    }


    /**
     * 考试记录列表
     * @return
     */
    @RequestMapping("/paperRecord/list")
    public String paperRecordList(Integer userId, ModelMap modelMap){
        modelMap.addAttribute("userId",userId);
        return "/paperRecord/list";
    }


    /**
     * 课程分配列表
     * @return
     */
    @RequestMapping("/curriculumAllocation/list")
    public String curriculumAllocationList(Integer orderId, ModelMap modelMap){
        modelMap.addAttribute("orderId",orderId);
        return "/curriculumAllocation/list";
    }


    /**
     * 课程分配列表
     * @return
     */
    @RequestMapping("/curriculumAllocation/bind")
    public String findUserByPhone2List(Integer orderId, ModelMap modelMap){
        modelMap.addAttribute("orderId",orderId);
        return "/curriculumAllocation/bind";
    }

    /**用户管理--修改密码页面*/
    @RequestMapping("/user/updatePassword")
    public String updatePassword() { return "/user/updatePassword"; }




    /**
     * 操作日志
     * @return
     */
    @RequestMapping("/operationLog/list")
    public String operationLogList(){
        return "/operationLog/list";
    }

    /**
     * 登录日志
     * @return
     */
    @RequestMapping("/loginLog/list")
    public String loginLogList(){
        return "/loginLog/list";
    }
}
