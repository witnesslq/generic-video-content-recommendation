<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.memory_yancy.pojo.Movie"%>
<%@page import="java.sql.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>显示结果--泛视频智能推荐系统</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
</head>

<body>
	<%
		
	%>

	<%!public class ConnectDBJDBC {
		public List<Movie> queryData(String name) {

			List<Movie> list = new ArrayList<Movie>();
			try {
				String url = "jdbc:mysql://localhost:3306/douban_movie";
				String user = "root";
				String pwd = "19951210";

				Class.forName("com.mysql.jdbc.Driver");
				// 建立到MySQL的连接
				Connection conn = DriverManager.getConnection(url, user, pwd);

				// 执行SQL语句
				Statement stmt = conn.createStatement();// 创建语句对象，用以执行sql语言
				ResultSet rs = stmt
						.executeQuery("SELECT * FROM movie WHERE movie_title LIKE " + "'%" + name + "%'");
				System.out.print(rs.getFetchSize() + "f88888888888888888888888888888888888888");
				// 处理结果集

				while (rs.next()) {
					Movie movie = new Movie();
					movie.setMovieTitleString(rs.getString(2));// movie-title
					movie.setMovieShortCommentString(rs.getString(5));//movie-ShortComment
					movie.setMovieURLString(rs.getString(3));//movie-url
					movie.setMovieCommentURL(rs.getString(6));//movie-CommentURL
					movie.setMovieImageString(rs.getString(7));
					System.out.print(rs.getString(3));
					list.add(movie);
					
				}

				//System.out.print(list.size());
				rs.close();// 关闭数据库
				conn.close();
				return list;
			} catch (Exception ex) {
				System.out.println("Error : " + ex.getMessage());
				return null;
			}
		}
	}%>

	<table border="0" width="90%" height="90%" align="center"
		style="border-collapse: collapse;  font-family: Futura, Arial, sans-serif">
		<%
			request.setCharacterEncoding("utf-8");
			String name_ = (String) request.getParameter("searchName");
			System.out.println(name_);
			List<Movie> list = new ConnectDBJDBC().queryData(name_);
			for (Movie movie : list) {
		%>
		<tr>
			<td
				style="border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">
				<a href="<%=movie.getMovieURLString()%>"><strong><%=movie.getMovieTitleString()%></strong></a><br>
				<br> <a href="<%=movie.getMovieCommentURL()%>">&nbsp;&nbsp;&nbsp;&nbsp;<%=movie.getMovieShortCommentString()%></a>
			</td>
		</tr>

		<%
			}
		%>
	</table>
</body>
</html>
