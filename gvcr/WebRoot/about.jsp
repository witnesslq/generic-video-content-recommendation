<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>关于泛视频智能推荐系统</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="/gvcr/css/style.css">
	

  </head>
  
  <body>
 
  <section class="panel">
    <p class="avatar">
      <img src="http://img.hb.aicdn.com/3975e2eba12db8bb501584e6229d196b7155116d1fd726-xWn96B_fw658" alt="">
    </p><br>
    <h1><a href="/gvcr/index.jsp" style="text-decoration:none">泛视频智能推荐系统</a></h1>
    <p class="lead">根据 DouBan 影评网站提供的视频内容信息向用户进行个性化推荐。 </p>
    <strong><p style="text-align:left; font-size:25px">由 来</p></strong>
       &nbsp;&nbsp;<p style="text-align:left">该系统根据<a href="https://cloud.seu.edu.cn/contest/" style="text-decoration:none"> 第三届云计算竞赛命题赛二</a> 尽力实现</p>
    <strong><p style="text-align:left; font-size:25px">介 绍</p></strong><br>
    &nbsp;&nbsp;随着国内外的影视娱乐业蓬勃发展，视频类信息和资源成为人们休闲娱乐甚至学习分享的重要部分。各种在线视频网站为广大观众提供了丰富的内容和服务，备受青睐。然而，在线视频网站众多，资源不同，分类方式也不同，
    观众若想观看到自己喜欢的视频资源，往往需要在多个视频网站反复搜索和筛选相应的影片和关键字，最后做出选择。同时，由于每人的兴趣、年龄等不同，观众很难得到个性化的精准视频推荐。<br>因此，鉴于此，泛视频智能推荐系统会根据用户的喜好
    给出相关的视频。
  </section>
  </body>
</html>
