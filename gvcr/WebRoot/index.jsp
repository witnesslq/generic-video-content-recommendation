<%@page import="java.util.*"%>
<%@page import="com.memory_yancy.pojo.Movie"%>
<%@page import="java.sql.*"%>
<%@ page language="java" pageEncoding="UTF-8"%>
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

<title>泛视频智能推荐系统</title>
<style type="text/css">
@font-face {
	font-family: Roboto;
	src: url(/gvcr/pictures/static/js/dist/Roboto-Thin.woff2)
		format("woff2"), url(/gvcr/pictures/static/js/dist/Roboto-Thin.woff)
		format("woff"), url(/gvcr/pictures/static/js/dist//Roboto-Thin.ttf)
		format("truetype");
	font-weight: 200
}

@font-face {
	font-family: Roboto;
	src: url(/gvcr/pictures/static/js/dist/Roboto-Light.woff2)
		format("woff2"), url(/gvcr/pictures/static/js/dist/Roboto-Light.woff)
		format("woff"), url(/gvcr/pictures/static/js/dist//Roboto-Light.ttf)
		format("truetype");
	font-weight: 300
}

@font-face {
	font-family: Roboto;
	src: url(/gvcr/pictures/static/js/dist/Roboto-Regular.woff2)
		format("woff2"),
		url(/gvcr/pictures/static/js/dist/Roboto-Regular.woff) format("woff"),
		url(/gvcr/pictures/static/js/dist//Roboto-Regular.ttf)
		format("truetype");
	font-weight: 400
}

@font-face {
	font-family: Roboto;
	src: url(/gvcr/pictures/static/js/dist/Roboto-Medium.woff2)
		format("woff2"), url(/gvcr/pictures/static/js/dist/Roboto-Medium.woff)
		format("woff"), url(/gvcr/pictures/static/js/dist//Roboto-Medium.ttf)
		format("truetype");
	font-weight: 500
}

@font-face {
	font-family: Roboto;
	src: url(/gvcr/pictures/static/js/dist/Roboto-Bold.woff2)
		format("woff2"), url(/gvcr/pictures/static/js/dist/Roboto-Bold.woff)
		format("woff"), url(/gvcr/pictures/static/js/dist//Roboto-Bold.ttf)
		format("truetype");
	font-weight: 700
}

@font-face {
	font-family: Material Icons;
	font-style: normal;
	font-weight: 400;
	src: url(/gvcr/pictures/static/js/dist//MaterialIcons-Regular.eot);
	src: local('Material Icons'), local('MaterialIcons-Regular'),
		url(/gvcr/pictures/static/js/dist/MaterialIcons-Regular.woff2)
		format('woff2'),
		url(/gvcr/pictures/static/js/dist/MaterialIcons-Regular.woff)
		format('woff'),
		url(/gvcr/pictures/static/js/dist//MaterialIcons-Regular.ttf)
		format('truetype')
}

@font-face {
	font-family: material-ui-icons;
	src:
		url(data:application/font-woff;base64,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)
		format("woff"), url(/pictures/static/js/dist//material-ui-icons.ttf)
		format("truetype");
	font-weight: 300
}

html {
	font-family: Roboto, sans-serif;
	font-weight: 400;
	line-height: 1.5;
	color: rgba(0, 0, 0, .87)
}

body,html {
	padding: 0;
	margin: 0
}

@media only screen and (min-width:0) {
	html {
		font-size: 13px
	}
}

@media only screen and (min-width:992px) {
	html {
		font-size: 13.5px
	}
}

@media only screen and (min-width:1200px) {
	html {
		font-size: 14px
	}
}

.material-icons {
	font-family: Material Icons;
	font-weight: 400;
	font-style: normal;
	font-size: 24px;
	display: inline-block;
	width: 1em;
	height: 1em;
	line-height: 1;
	text-transform: none;
	letter-spacing: normal;
	word-wrap: normal;
	-webkit-font-smoothing: antialiased;
	text-rendering: optimizeLegibility;
	-moz-osx-font-smoothing: grayscale;
	-webkit-font-feature-settings: 'liga';
	font-feature-settings: 'liga'
}

.material-icons.menu-icon {
	line-height: .9;
	vertical-align: middle;
	margin-right: 6px
}

.material-icons.md-12 {
	font-size: 12px
}

.material-icons.md-16 {
	font-size: 16px
}

.material-icons.md-18 {
	font-size: 18px
}

.material-icons.md-24 {
	font-size: 24px
}

.material-icons.md-36 {
	font-size: 36px
}

.material-icons.md-48 {
	font-size: 48px
}

.container {
	margin: 0 auto;
	max-width: 1280px;
	width: 90%
}

ul li {
	float: left;
	padding: 0
}

ul li a {
	color: #fff;
	display: block;
	padding: 0 15px
}

a {
	color: #039be5;
	text-decoration: none;
	-webkit-tap-highlight-color: transparent
}

[class*=" muidocs-icon-"],[class^=muidocs-icon-] {
	font-family: material-ui-icons;
	speak: none;
	font-style: normal;
	font-weight: 400;
	font-variant: normal;
	text-transform: none;
	line-height: 1;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale
}

.muidocs-icon-action-home:before {
	content: "\E605"
}

.muidocs-icon-action-stars:before {
	content: "\E606"
}

.muidocs-icon-action-thumb-up:before {
	content: "\E607"
}

.muidocs-icon-custom-sort:before {
	content: "\E600"
}

.muidocs-icon-custom-github:before {
	content: "\E625"
}

.muidocs-icon-custom-arrow-drop-right:before {
	content: "\E60B"
}

.comment-list {
	padding: 40px 10%
}
</style>
</head>

<body>
	<div data-reactroot="">
		<!-- react-empty: 2 -->
		<div
			style="color: rgba(0, 0, 0, 0.870588); background-color: rgb(0, 188, 212); transition: all 450ms cubic-bezier(0.23, 1, 0.32, 1) 0ms; box-sizing: border-box; font-family: Roboto, sans-serif; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); border-radius: 0px; position: fixed; z-index: 1101; width: 100%; display: flex; padding-left: 24px; padding-right: 24px; top: 0px;">
			<h3>
				<a href="about.html" name="about" id="about"
					style="text-decoration:none; color:#000000">泛视频智能推荐，欢迎使用:-)</a>
			</h3>
			<h1
				style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; margin: 0px; padding-top: 0px; letter-spacing: 0px; font-size: 24px; font-weight: 400; color: rgb(255, 255, 255); height: 64px; line-height: 64px; flex: 1 1 0%;"></h1>
			<div style="margin-top: 8px; margin-right: -16px; margin-left: auto;">
				<a
					href="https://github.com/memory-yancy/genericVideoContentRecommendation"
					tabindex="0" type="button"
					style="border: 10px; box-sizing: border-box; display: inline-block; font-family: Roboto, sans-serif; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); cursor: pointer; text-decoration: none; margin: 0px; padding: 12px; outline: none; font-size: 0px; font-weight: inherit; transform: translate(0px, 0px); vertical-align: middle; position: relative; overflow: visible; transition: all 450ms cubic-bezier(0.23, 1, 0.32, 1) 0ms; width: 48px; height: 48px; background: none;"><div>
						<span class="muidocs-icon-custom-github"
							color="rgba(0, 0, 0, 0.87)"
							style="color: rgb(255, 255, 255); position: relative; font-size: 24px; display: inline-block; transition: all 450ms cubic-bezier(0.23, 1, 0.32, 1) 0ms; fill: rgb(255, 255, 255); -webkit-user-select: none;"></span>
					</div></a>
			</div>
		</div>
		<div style="padding-top: 64px;">
			<div
				style="background-color: rgb(0, 188, 212); overflow: hidden; margin-top: -64px;">
				<div style="position: relative;">
					<div
						style="opacity: 1; background-position: center 41px; position: absolute; height: 100%; width: 100%; background-repeat: no-repeat; background-size: cover; transition: opacity 200ms ease-in-out; background-image: url(&quot;/gvcr/pictures/movie.jpg&quot;);"></div>
					<div
						style="position: absolute; height: 100px; width: 100%; background: url(&quot;&quot;) repeat-x;"></div>
					<div
						style="position: relative; margin: 0px auto; height: 480px; overflow: hidden;">
						<div style="margin: 150px auto 40px; width: 540px; height: 54px;"></div>
						<div style="text-align: center;">
							<form method="post" action="/gvcr/search/search.jsp"
								style="display: inline-block; position: relative;">
								<input type="text" size="27" name="searchName"
									placeholder="请输入你喜欢的电影名， 以下评论供参考"
									style="margin: 0px auto; padding: 0px 10px; width: 536px; height: 34px; border: 1px solid rgba(255, 000, 100, 0.8); border-radius: 2px; color: rgb(255, 255, 000); background: rgba(0, 0, 0, 0.14902);"><a
									href="search.jsp"><input type="submit" name="search"
									id="search" value="搜索"
									style="height:35px;line-height:18px;padding:0 9px!important;padding:0 5px"></a>
							</form>
							<!-- react-text: 24 -->
							<!-- /react-text -->
						</div>
					</div>
				</div>
			</div>
			<div>
				<div style="text-align: center; height: 600px;">
					<h2>向您推荐 && 精彩影评</h2><p style="color:gray; text-align:center"><a href="https://movie.douban.com/" target="_new">
					感谢 DouBan-movie 提供评论</a></p>
					 
<%!public class ConnectDBJDBC {
		public List<Movie> queryData() {

			List<Movie> list = new ArrayList<Movie>();
			try {
				String url = "jdbc:mysql://localhost:3306/douban_movie";
				String user = "root";
				String pwd = "19951210";

				Class.forName("com.mysql.jdbc.Driver");
				// 建立到MySQL的连接
				Connection conn = DriverManager.getConnection(url, user, pwd);

				Double num = Math.random() * 10 + 1;
				Long length = Math.round(num);
				// 执行SQL语句
				Statement stmt = conn.createStatement();// 创建语句对象，用以执行sql语言
				ResultSet rs = stmt.executeQuery("SELECT * FROM movie LIMIT "
						+ length + ",10");

				// 处理结果集
				while (rs.next()) {
					Movie movie = new Movie();
					movie.setMovieTitleString(rs.getString(2));// movie-title
					movie.setMovieShortCommentString(rs.getString(5));//movie-ShortComment
					movie.setMovieURLString(rs.getString(3));//movie-url
					movie.setMovieCommentURL(rs.getString(6));//movie-CommentURL
					movie.setMovieImageString(rs.getString(7));
					list.add(movie);
					//System.out.println(rs.getString(2) + "*****" + rs.getString(7));

				}

				rs.close();// 关闭数据库
				conn.close();
				return list;
			} catch (Exception ex) {
				System.out.println("Error : " + ex.getMessage());
				return null;
			}
		}
	}%>
	
					<table border="0" width="90%" height="90%" align="center" style="border-collapse: collapse;  font-family: Futura, Arial, sans-serif">
					<%
						List<Movie> list = new ConnectDBJDBC().queryData();
						for (Movie movie : list) {
					%>
					<tr><td><img src="<%=movie.getMovieImageString()%>" width="100px" height="143px"></td><td style="border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">
					<a href="<%=movie.getMovieURLString()%>"><strong><%=movie.getMovieTitleString()%></strong>
					</a><br><br>
					<a href="<%=movie.getMovieCommentURL()%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=movie.getMovieShortCommentString()%></a></td>
					</tr>
<%
 	}
 %>	
</table>
			</div>
			</div>
		</div>
</body>
</html>
