package com.memory_yancy.utils;

import java.sql.ResultSet;
import java.sql.SQLException;

public interface ObjectMapper
{
	public Object rowMapper(ResultSet rs) throws SQLException;
}
