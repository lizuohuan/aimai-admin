package com.magic.aimai.admin.util;

/**
 * 转换
 * @author lzh
 * @create 2017/6/27 15:08
 */
public class ClassConvert {

    /**
     * String数组转Long数组
     * @param strs
     * @return
     */
    public static Long[] strToLongGather(String[] strs) {
        Long[] ls = new Long[strs.length];
        for (int i = 0 ; i < strs.length ; i ++) {
            ls[i] = Long.valueOf(strs[i]);
        }
        return ls;
    }
    /**
     * String数组转Integer数组
     * @param strs
     * @return
     */
    public static Integer[] strToIntegerGather(String[] strs) {
        Integer[] ls = new Integer[strs.length];
        for (int i = 0 ; i < strs.length ; i ++) {
            ls[i] = Integer.valueOf(strs[i]);
        }
        return ls;
    }

}
