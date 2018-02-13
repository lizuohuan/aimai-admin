<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style>
	table td{padding: 10px;}
</style>
</head>

<body>
<table align="center" width="800px" height="1350" border="1" cellpadding="0" cellspacing="0" style="margin: 0 auto;">
  <tr>
    <th colspan="5" scope="col"><p style="font-size:36px">网 络 在 线 培 训 合 格 证 明</p></th>
  </tr>
  <tr>
    <td colspan="5" align="right"><p >培训单位：${user.companyName?default('--')}</p></td>
  </tr>
  <tr>
    <td colspan="5" align="right"><p ><#--${url}--> www.baidu.com</p></td>
  </tr>
  <tr>
    <td width="20%">&nbsp;</td>
    <td width="20%">&nbsp;</td>
    <td width="20%">&nbsp;</td>
    <td width="20%">&nbsp;</td>
    <td width="20%">&nbsp;</td>
  </tr>
  <tr>
    <td><p >学员姓名：</p></td>
    <td><p >${user.showName?default('--')}</p></td>
    <td>&nbsp;</td>
    <td><p >注册时间：</p></td>
    <td><p ><#if (user.createTime)??> ${user.createTime?string("yyyy/MM/dd HH:mm")} <#else > -- </#if></p></td>
  </tr>
  <tr>
    <td><p >身份证号码：</p></td>
    <td colspan="2"><p >${user.pid?default('--')}</p></td>
    <td><p >联系方式：</p></td>
    <td><p >${user.phone?default('--')}</p></td>
  </tr>
  <tr>
    <td><p >所在地：</p></td>
    <td colspan="2"><p >${user.cityMergerName?default('--')}</p></td>
    <td><p >行业：</p></td>
    <td><p >${user.tradeName?default('--')}</p></td>
  </tr>
    <#list currMap as currMap>
      <tr>
        <td><p >课程名称</p></td>
        <td colspan="4"><p >${currMap.curriculumName?default('--')}</p></td>
      </tr>
    <#list currMap.courseWare as courseWare>
      <tr>
        <td align="center"><p >课件名称</p></td>
          <#list courseWare.courseWareName as cn>
              <td align="center"><p >${cn?default('--')}</p></td>
          </#list>
      </tr>
      <tr>
        <td align="center"><p >学习进度</p></td>
          <#list courseWare.schedule as schedule>
              <td align="center"><p >${schedule?default('--')}</p></td>
          </#list>
      </tr>
    </#list>
      <tr>
        <td align="center"><p >人脸识别</p></td>
          <td align="center">
              <#if (currMap.imgUrl1)??>
                <img src="${currMap.imgUrl1}" alt="" width="90" height="87" />
              <#else > -- </#if>
        </td>
        <td align="center">
            <#if (currMap.imgUrl2)??>
              <img src="${currMap.imgUrl2}" alt="" width="90" height="87" />
            <#else > -- </#if>
        </td>
        <td align="center">
            <#if (currMap.imgUrl3)??>
              <img src="${currMap.imgUrl3}" alt="" width="90" height="87" />
            <#else > -- </#if>
        </td>
        <td align="center">
            <#if (currMap.imgUrl4)??>
              <img src="${currMap.imgUrl4}" alt="" width="90" height="87" />
            <#else > -- </#if>
        </td>
      </tr>
      <tr>
        <td align="center"><p >验证时间</p></td>
        <td align="center"><p >${currMap.time1}</p></td>
        <td align="center"><p >${currMap.time2}</p></td>
        <td align="center"><p >${currMap.time3}</p></td>
        <td align="center"><p >${currMap.time4}</p></td>
      </tr>
    </#list>
  <tr>
    <td colspan="5"><p >培训机构意见：</p></td>
  </tr>
  <tr>
    <td height="200" colspan="5" align="right"><p >（盖章） 年  月   日</p></td>
  </tr>
</table>
</body>
</html>
