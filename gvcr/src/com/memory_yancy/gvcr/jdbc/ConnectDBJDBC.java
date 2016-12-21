package com.memory_yancy.gvcr.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import com.memory_yancy.pojo.Movie;

public class ConnectDBJDBC {	
	public Movie queryData() {
		Movie movie = new Movie();
		try {
			String url = "jdbc:mysql://localhost:3306/douban_movie";
			String user = "root";
			String pwd = "19951210";

			Class.forName("com.mysql.jdbc.Driver");
			// 建立到MySQL的连接
			Connection conn = DriverManager.getConnection(url, user, pwd);

			// 执行SQL语句
			Statement stmt = conn.createStatement();// 创建语句对象，用以执行sql语言
			ResultSet rs = stmt.executeQuery("select * from movie");

			// 处理结果集
			while (rs.next()) {
				String movieTitle = rs.getString(2);
				String movieShortComment = rs.getString(5);
				
				movie.setMovieTitleString(movieTitle);
				movie.setMovieShortCommentString(movieShortComment);
				System.out.println(movieTitle + "*****" + movieShortComment);
				return movie;
			}
			rs.close();// 关闭数据库
			conn.close();
			
			return null;
		} catch (Exception ex) {
			System.out.println("Error : " + ex.getMessage());
			return null;
		}
	}
	public static void main(String[] args) {
		ConnectDBJDBC connectDBJDBC = new ConnectDBJDBC();
		connectDBJDBC.queryData();
	}
}
