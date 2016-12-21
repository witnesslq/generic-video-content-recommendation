package com.memory_yancy.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSourceFactory;

//JDBC��һ��������
public class JDBCUtil
{
	//�ܹ���������ݿ�
	//���ļ�   datasource.properties  ������Ǽ�ֵ�ԣ�
	private static DataSource ds;//���Դ
	
	//�̱߳���
	private static ThreadLocal<Connection> local = new ThreadLocal<Connection>();
	
	//��������
	static
	{
		Properties p = new Properties();//��������һ�������ļ�xx.properties
		try {
			p.load(JDBCUtil.class.getClassLoader().getResourceAsStream("datasource.properties"));
			//ͨ�������ļ�������Դ����
			ds = BasicDataSourceFactory.createDataSource(p);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//������Ӷ���
	public static Connection getConn()
	{
		Connection conn = null;
		try {
			conn = local.get();
			if(null == conn)
			{
				conn = ds.getConnection();
				local.set(conn);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	//�ͷ���Դ
	public static void close(ResultSet rs,PreparedStatement pstmt,Connection conn)
	{
		if(null != rs)
		{
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(null != pstmt)
		{
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(null != conn)
		{
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	//���������ͷ�����
	public static void close()
	{
		try {
			local.get().close();
			local.remove();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
