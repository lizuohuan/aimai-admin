<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
</head>

<body>
<table width="100%" border="1" cellspacing="0">
    <tr>
        <th scope="col">姓名</th>
        <th scope="col">联系方式</th>
        <th scope="col">所在地</th>
        <th scope="col">行业</th>
        <th scope="col">身份证</th>
        <th scope="col">所属公司</th>
        <th scope="col">课程</th>
        <th scope="col">课程学习总进度</th>
        <th scope="col">课程学习开始时间</th>
        <th scope="col">课程学习完成时间</th>
        <th scope="col">正式考试时间</th>
        <th scope="col">考试用时</th>
        <th scope="col">此次考试得分</th>
        <th scope="col">及格分数</th>
        <th scope="col">是否通过</th>
        <th scope="col">课件名称</th>
        <th scope="col">课件学习进度</th>
        <th scope="col">课件学习开始时间</th>
        <th scope="col">课件学习完成时间</th>
    </tr>
    [#list userList as user]
        <tr>
            <td rowspan="${user.excelNum}">${user.showName?default('--')}</td>
            <td rowspan="${user.excelNum}">${user.phone?default('--')}</td>
            <td rowspan="${user.excelNum}">${user.cityMergerName?default('--')}</td>
            <td rowspan="${user.excelNum}">${user.tradeName?default('--')}</td>
            <td rowspan="${user.excelNum}" style="mso-number-format:'\@';">${user.pid?default('--')}</td>
            <td rowspan="${user.excelNum}">${user.companyName?default('--')}</td>
            [#list user.curriculumList as curriculum]
                [#if curriculum_index = 0]
                        <td rowspan="${curriculum.excelNum}">${curriculum.curriculumName?default('--')}</td>
                        <td rowspan="${curriculum.excelNum}">
                        [#if (curriculum.curriculumName)??]
                            ${curriculum.studyNum}/#{curriculum.excelNum}课</td>
                        [#else ]
                            --
                        [/#if]
                        <td rowspan="${curriculum.excelNum}">
                            [#if (curriculum.studyStartTime)??] ${curriculum.studyStartTime?string("yyyy/MM/dd HH:mm")} [#else ] -- [/#if]
                        </td>
                        <td rowspan="${curriculum.excelNum}">
                            [#if (curriculum.studyEndTime)??] ${curriculum.studyEndTime?string("yyyy/MM/dd HH:mm")} [#else ] -- [/#if]
                        </td>
                        <td rowspan="${curriculum.excelNum}">
                            [#if (curriculum.examTime)??] ${curriculum.examTime?string("yyyy/MM/dd HH:mm")} [#else ] -- [/#if]
                        </td>
                        <td rowspan="${curriculum.excelNum}">${curriculum.useTime?default('--')}</td>
                        <td rowspan="${curriculum.excelNum}">${curriculum.resultScore?default('--')}</td>
                        <td rowspan="${curriculum.excelNum}">${curriculum.passScore?default('--')}</td>
                        <td rowspan="${curriculum.excelNum}">[#if curriculum.isPass==1] 是 [#else ] 否 [/#if]</td>
                        [#list curriculum.courseWares as courseWare ]
                            [#if courseWare_index = 0]
                                <td rowspan="1">${courseWare.courseWareName?default('--')}</td>
                                <td rowspan="1">[#if courseWare.hdSeconds??]${courseWare.expendSeconds / courseWare.hdSeconds * 100}%[#else ]--[/#if]</td>
                                <td rowspan="1">
                                    [#if (courseWare.studyStartTime)??] ${courseWare.studyStartTime?string("yyyy/MM/dd HH:mm")} [#else ] -- [/#if]
                                </td>
                                <td>
                                    [#if (courseWare.studyEndTime)??] ${courseWare.studyEndTime?string("yyyy/MM/dd HH:mm")} [#else ] -- [/#if]
                                </td>
                            [/#if]
                        [/#list]

                [/#if]
            [/#list]
        </tr>
        [#list user.curriculumList as curriculum]
            [#if curriculum_index = 0]
                [#list curriculum.courseWares as courseWare ]
                    [#if courseWare_index > 0]
                        <tr>
                            <td rowspan="1">${courseWare.courseWareName?default('--')}</td>
                            <td rowspan="1">[#if courseWare.hdSeconds??]${courseWare.expendSeconds / courseWare.hdSeconds * 100}%[#else ]--[/#if]</td>
                            <td rowspan="1">
                                [#if (courseWare.studyStartTime)??] ${courseWare.studyStartTime?string("yyyy/MM/dd HH:mm")} [#elseif (curriculum.curriculumName)?? ] 未学习 [#else ] -- [/#if]
                            </td>
                            <td>
                                [#if (courseWare.studyEndTime)??] ${courseWare.studyEndTime?string("yyyy/MM/dd HH:mm")} [#else ] -- [/#if]
                            </td>
                        </tr>
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
        [#list user.curriculumList as curriculum]
            [#if curriculum_index > 0]
                <tr>
                    <td rowspan="${curriculum.excelNum}">${curriculum.curriculumName?default('--')}</td>
                    <td rowspan="${curriculum.excelNum}">
                    [#if (curriculum.curriculumName)??]
                    ${curriculum.studyNum}/#{curriculum.excelNum}课</td>
                    [#else ]
                        --
                    [/#if]
                    </td>
                    <td rowspan="${curriculum.excelNum}">
                        [#if (curriculum.studyStartTime)??] ${curriculum.studyStartTime?string("yyyy/MM/dd HH:mm")} [#else ] -- [/#if]
                    </td>
                    <td rowspan="${curriculum.excelNum}">
                        [#if (curriculum.studyEndTime)??] ${curriculum.studyEndTime?string("yyyy/MM/dd HH:mm")} [#else ] -- [/#if]
                    </td>
                    <td rowspan="${curriculum.excelNum}">
                        [#if (curriculum.examTime)??] ${curriculum.examTime?string("yyyy/MM/dd HH:mm")} [#else ] -- [/#if]
                    </td>
                    <td rowspan="${curriculum.excelNum}">${curriculum.useTime?default('--')}</td>
                    <td rowspan="${curriculum.excelNum}">${curriculum.resultScore?default('--')}</td>
                    <td rowspan="${curriculum.excelNum}">${curriculum.passScore?default('--')}</td>
                    <td rowspan="${curriculum.excelNum}">[#if curriculum.isPass==1] 是 [#else ] 否 [/#if]</td>
                    [#list curriculum.courseWares as courseWare ]
                        [#if courseWare_index = 0]
                            <td>${courseWare.courseWareName?default('--')}</td>
                            <td>[#if courseWare.hdSeconds??]${courseWare.expendSeconds / courseWare.hdSeconds * 100}%[#else ]--[/#if]</td>
                            <td>
                                [#if (courseWare.studyStartTime)??] ${courseWare.studyStartTime?string("yyyy/MM/dd HH:mm")} [#elseif (curriculum.curriculumName)?? ] 未学习 [#else ] -- [/#if]
                            </td>
                            <td>
                                [#if (courseWare.studyEndTime)??] ${courseWare.studyEndTime?string("yyyy/MM/dd HH:mm")} [#else ] -- [/#if]
                            </td>
                        [/#if]
                    [/#list]
                </tr>
                [#list curriculum.courseWares as courseWare ]
                    [#if courseWare_index > 0]
                        <tr>
                            <td>${courseWare.courseWareName?default('--')}</td>
                            <td>
                                [#if courseWare.hdSeconds??]${courseWare.expendSeconds / courseWare.hdSeconds * 100}%[#else ]--[/#if]
                            </td>
                            <td>
                                [#if (courseWare.studyStartTime)??] ${courseWare.studyStartTime?string("yyyy/MM/dd HH:mm")} [#elseif (curriculum.curriculumName)?? ] 未学习 [#else ] -- [/#if]
                            </td>
                            <td>
                                [#if (courseWare.studyEndTime)??] ${courseWare.studyEndTime?string("yyyy/MM/dd HH:mm")} [#else ] -- [/#if]
                            </td>
                        </tr>
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
    [/#list]
</table>

</body>
</html>
