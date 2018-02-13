package com.magic.aimai.admin.util;


import com.fasterxml.jackson.databind.annotation.JsonSerialize;

/**
 * Created by flyong86 on 2016/4/6.
 */
@JsonSerialize(include=JsonSerialize.Inclusion.NON_NULL)
public class ViewDataPage extends ViewData{
	//数据条目总数
	private int recordsTotal;

	public int getRecordsTotal() {
		return recordsTotal;
	}

	public void setRecordsTotal(int recordsTotal) {
		this.recordsTotal = recordsTotal;
	}

}
