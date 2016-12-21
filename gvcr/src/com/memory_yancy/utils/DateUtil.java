package com.memory_yancy.utils;


import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 
 * <p>
 * Title: DateUtil
 * </p>
 * <p>
 * Description: 日期处理封装
 * </p>
 * <p>
 * Copyright: Copyright (c) 2004
 * </p>
 * <p>
 * Company:
 * </p>
 * 
 * @author chirs
 * @version 1.0
 */
public class DateUtil {

	public static final int CanNotGetDays = -1;

	public static Date date = null;

	public static DateFormat dateFormat = null;

	public static Calendar calendar = null;
	
	public static void main( String[] args )
	{
		Date date = new Date();
		Integer year = DateUtil.getYear( date );
		Integer month = DateUtil.getMoon( date );
		System.out.println( year+"  "+month );
	}
	
	/**
	 * 功能描述：日期相加
	 * 
	 * @param date
	 *            Date 日期
	 * @param day
	 *            int 天数
	 * @return 返回相加后的日期
	 */
	public static Date addDate(Date date, int day) {
		calendar = Calendar.getInstance();
		long millis = getMillis(date) + ((long) day) * 24 * 3600 * 1000;
		calendar.setTimeInMillis(millis);
		return calendar.getTime();
	}
	
	/**
	 * 功能描述：返回毫秒
	 * 
	 * @param date
	 *            日期
	 * @return 返回毫秒
	 */
	public static long getMillis(Date date) {
		calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar.getTimeInMillis();
	}


	/**
	 * 功能描述：日期相减
	 * 
	 * @param date
	 *            Date 日期
	 * @param date1
	 *            Date 日期
	 * @return 返回相减后的日期
	 */
	public static int diffDate(Date date, Date date1) {
		return Math.abs( (int) ((getMillis(date) - getMillis(date1)) / (24 * 3600 * 1000)) );
	}
	
	public static int diffHours(Date date, Date date1) {
		int tmp1 = Math.abs( (int) ((getMillis(date) - getMillis(date1)) / (3600 * 1000)));
		return  Math.abs( tmp1 );
	}
	
	public static int diffMins(Date date, Date date1) {
		int tmp1 = Math.abs( (int) ((getMillis(date) - getMillis(date1)) / (60 * 1000)));
		return  Math.abs( tmp1 - 60*diffHours( date,date1 ) );
	}
	/**
	 * 缺省日期转换
	 * 
	 * @param d
	 *            Date
	 * @return String
	 */
	public static String defaultFormat(Date d) {
		return format(d, "yyyy-MM-dd");
	}

	public static String getTime(String parrten) {
		if (parrten == null || parrten.equals("")) {
			parrten = "yyyy-MM-dd HH:mm:ss";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(parrten);
		Date cday = new Date();
		String timestr = sdf.format(cday);
		return timestr;
	}
	/**
	 * 获得UTC格式时间
	 * 
	 * @param s String　format
	 * @throws WebException
	 * @return Long
	 */
	public static Long getUTCDate(String s, String format){
		return parse(s,format).getTime();
	}
	/**
	 * 缺省获得UTC格式时间
	 * 
	 * @param s String　format
	 * @throws WebException
	 * @return Long
	 */
	public static Long getUTCDate(String s){
		return defaultParse(s).getTime();
	}
	public static String format(Date d, String format) {
		if (d == null) {
			return null;
		}
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);
		return dateFormat.format(d);
	}

	public static Date parse(String s, String format){
		if (s == null || "".equals(s) || "null".equals(s)) {
			return null;
		}		
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat(format);
			return dateFormat.parse(s);
		} catch (Exception e) {
			
		}
		return null;
	}

	/**
	 * 缺省日期转换
	 * 
	 * @param s
	 *            String
	 * @throws WebException
	 * @return Date
	 */
	public static Date defaultParse(String s){
		return parse(s, "yyyy-MM-dd");
	}

	/**
	 * 得到日期与现在相距天数
	 * 
	 * @param df
	 *            Date
	 * @return int
	 */
	public static int getDays(Date df) {
		Date d = new Date();
		return (int) ((df.getTime() - d.getTime()) / (24 * 60 * 60 * 1000));

	}

	/**
	 * 得到两个日期间相隔天数
	 * 
	 * @param df1
	 *            Date
	 * @param df2
	 *            Date
	 * @return int
	 */
	public static int getDisDays(Date df1, Date df2) {
		if (df1 == null || df2 == null)
			return CanNotGetDays;
		else
			return (int) ((df1.getTime() - df2.getTime()) / (24 * 60 * 60 * 1000));
	}

	/**
	 * 
	 * @param df1
	 *            Date
	 * @param df2
	 *            Date
	 * @return int
	 */
	public static String getStrDisDays(Date df1, Date df2) {
		if (df1 == null || df2 == null)
			return "";
		else
			return ""
					+ (int) ((df1.getTime() - df2.getTime()) / (24 * 60 * 60 * 1000));
	}

	/**
	 * 日期小于当前日期，返回true
	 * 
	 * @param df
	 *            Date
	 * @return boolean
	 */
	public static boolean isBeforeCurTime(Date df) {
		Date d = new Date();
		if (d.compareTo(df) > 0)
			return true;
		else
			return false;
	}

	/**
	 * 得到当前日期的年份
	 * 
	 * @param df
	 *            Date
	 * @return int
	 */
	public static int getYear(Date df) {
		Calendar c = Calendar.getInstance();
		c.setTime(df);
		return c.get(Calendar.YEAR);
	}

	/**
	 * 得到当前日期的月份
	 * 
	 * @param df
	 *            Date
	 * @return int
	 */
	public static int getMoon(Date df) {
		Calendar c = Calendar.getInstance();
		c.setTime(df);
		return c.get(Calendar.MONTH);
	}

	/**
	 * 得到当前日期的日
	 * 
	 * @param df
	 *            Date
	 * @return int
	 */
	public static int getDay(Date df) {
		Calendar c = Calendar.getInstance();
		c.setTime(df);
		return c.get(Calendar.DAY_OF_MONTH);
	}

	/**
	 * 得到2004/04/01之类的字符串
	 * 
	 * @return String
	 */
	public static String getCurYearMonthFirstDay() {
		Calendar c = Calendar.getInstance();
		c.setTime(new Date());
		return c.get(Calendar.YEAR) + "/" + (c.get(Calendar.MONTH) + 1) + "/01";
	}

	/**
	 * 构造诸出40401之类的序列号
	 * 
	 * @return int
	 */
	public static int getCurYearMonthSeq() {
		Calendar c = Calendar.getInstance();
		c.setTime(new Date());
		int seq;
		if ((seq = c.get(Calendar.YEAR) - 2000) < 0)
			seq = c.get(Calendar.YEAR) - 1000;
		return (seq * 100 + c.get(Calendar.MONTH) + 1) * 100;
	}

	public static Timestamp getTimestamp(Object obj) {
		Timestamp t = null;
		if (obj instanceof Date)
			t = new Timestamp(((Date) obj).getTime());
		else if (obj instanceof Timestamp)
			t = (Timestamp) obj;

		return t;
	}
}