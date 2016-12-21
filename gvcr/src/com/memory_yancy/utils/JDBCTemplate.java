package com.memory_yancy.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCTemplate
{
	//��ɾ��
	public boolean update(String sql,Object...params)
	{
		PreparedStatement pstmt = null;
		try {
			Connection conn = JDBCUtil.getConn();
			pstmt = conn.prepareStatement(sql);
			setParams(pstmt, params);
			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally
		{
			JDBCUtil.close(null, pstmt, null);
		}
		return false;
	}
	
	public List query(String sql,ObjectMapper om,Object...params)
	{
		List list = new ArrayList();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Connection conn = JDBCUtil.getConn();
			pstmt = conn.prepareStatement(sql);
			setParams(pstmt, params);
			rs = pstmt.executeQuery();
			if(null != rs)
			{
				while(rs.next())
				{
					Object obj = om.rowMapper(rs);
					list.add(obj);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally
		{
			JDBCUtil.close(rs, pstmt, null);
		}
		return list;
	}
	
	//Ϊռλ��ֵ
	private void setParams(PreparedStatement pstmt,Object...params)
	{
		try {
			if(null != params && params.length > 0)
			{
				for(int i = 0; i < params.length; i++)
				{
					if( params[i] == null )
						params[i] = "";
					pstmt.setString(i+1, params[i].toString());
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
