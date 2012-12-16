<%@ page contentType='text/html; charset=UTF-8' %>
<%@ page import='java.io.*' %>
<%@ page import='javax.servlet.*' %>
<%@ page import='javax.servlet.http.*' %>
<%@ page import='java.sql.*' %>
<%@ page import='java.sql.Connection' %>
<%@ page import='java.sql.Statement' %>
<%@ page import='java.sql.ResultSet' %>
<%@ page import='java.util.*' %>
<%@ page import='forum.*' %>

<% String sessionUsername = (String)session.getAttribute("username"); %>
<% String sessionPassword = (String)session.getAttribute("password"); %>
<% String sessionType = (String)session.getAttribute("type"); %>

<jsp:include page="./include/header.jsp" flush="true">
	<jsp:param name="title" value="Welcome" /> 
</jsp:include>
<jsp:include page="./include/body.jsp" flush="true" />

<% if( sessionUsername != null){%>
	<table width="100%" height="20" border="0" cellpadding="1" cellspacing="1">
		<tr> 
			<td height="20"  class="pathBar">
				<a href="index.jsp" class="pathBarLink"><%= Variable.getForumName() %></a>
			</td>
			<td height="20" align="right" class="pathBar">						
                        <a href="search.jsp" class="pathBarLink">进入搜索页面</a>					
             </td>
		</tr>
	</table>   
	<jsp:include page="./include/table_start.jsp" flush="true" />                   
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="物品交易分类" /> 
		<jsp:param name="colspan" value="1" /> 
		<jsp:param name="align" value="middle" /> 
	</jsp:include>	               
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="交易信息数" /> 
		<jsp:param name="colspan" value="1" /> 
		<jsp:param name="align" value="middle" /> 
	</jsp:include>	
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="信息评论数" /> 
		<jsp:param name="colspan" value="1" /> 
		<jsp:param name="align" value="middle" /> 
	</jsp:include>	
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="最新发表" /> 
		<jsp:param name="colspan" value="1" /> 
		<jsp:param name="align" value="middle" /> 
	</jsp:include>	   

	<% if(sessionType.equals("Admin")){ %>
		<jsp:include page="./include/table_title.jsp" flush="true">
			<jsp:param name="title" value="删除分类" /> 
			<jsp:param name="colspan" value="1" /> 
			<jsp:param name="align" value="middle" /> 
		</jsp:include>
	<% } %>	

	<%
		
		DBConnectie db = new DBConnectie();
			
		db.connect();

		ResultSet rs = db.selectQuery(
			"SELECT * FROM forum_forums ORDER BY title");

		while(rs.next()){
			String forum_id = rs.getString("id");
			String title = Utilities.getforumTile(forum_id);
			String info = Utilities.getforumInfo(forum_id);
			String topics = Utilities.getTopics(forum_id);
			String forumReplies = Utilities.getforumReplies(forum_id);
			String lastPostInfo = Utilities.lastPostInfo(forum_id);
	%>						
		<jsp:include page="./include/table_start_body.jsp" flush="true" />
		<jsp:include page="./include/table_body.jsp" flush="true">
			<jsp:param name="width" value="0" /> 
		</jsp:include>						
		<a href="./index.jsp?page=thread&forum_id=<%= forum_id %>" class="forumLink"><%= title %></a>
		<br>
		<span class="forumInfo"><%= info %></span>
		<jsp:include page="./include/table_body.jsp" flush="true">
			<jsp:param name="width" value="0" /> 
		</jsp:include>	
		<span class="forumTopics"><%= topics %></span>
		<jsp:include page="./include/table_body.jsp" flush="true">
			<jsp:param name="width" value="0" /> 
		</jsp:include>
		<span class="forumReplies"><%= forumReplies %></span>
		<jsp:include page="./include/table_body.jsp" flush="true">
			<jsp:param name="width" value="0" /> 
		</jsp:include>					
		<span class="forumPostInfo"><%= lastPostInfo %></span>

		<% if(sessionType.equals("Admin")){ %>
			<jsp:include page="./include/table_body.jsp" flush="true">
				<jsp:param name="width" value="0" /> 
			</jsp:include>
			<a href="../servlet/forum.DeleteForum?forum_id=<%= forum_id %>" class="forumDelete">删除</a>
		<% } %>	 
	<% } %>
	<jsp:include page="./include/table_close_body.jsp" flush="true" /> 						

	<jsp:include page="./include/table_start_title.jsp" flush="true" /> 
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="&nbsp;" /> 
		<jsp:param name="colspan" value="5" /> 
		<jsp:param name="align" value="left" /> 
	</jsp:include>			
	<jsp:include page="./include/table_close.jsp" flush="true" /> 
	<br>
	<% if(sessionType.equals("Admin")){ %>					
					
		<jsp:include page="./include/table_start.jsp" flush="true" /> 
		<jsp:include page="./include/table_title.jsp" flush="true">
			<jsp:param name="title" value="增加物品交易分类" /> 
			<jsp:param name="colspan" value="2" /> 
			<jsp:param name="align" value="left" /> 
		</jsp:include>						
		<jsp:include page="./include/table_start_body.jsp" flush="true" />
		<jsp:include page="./include/table_body.jsp" flush="true">
			<jsp:param name="width" value="200" /> 
		</jsp:include>
		
		<form action="../servlet/forum.AddForum" method=POST name=form><br>
		分类名称:<br>
		<input type="text" name="title" size="62" maxlength="60"><br>
		分类介绍:<br>
		<textarea name="forum_info" cols="47" rows="10" maxlength="500"></textarea><br>
		<input type="submit" value="提交"><br>
		</form><br>
		
		<jsp:include page="./include/table_close_body.jsp" flush="true" />				 
		<jsp:include page="./include/table_close.jsp" flush="true" />
	<% } %>              
<% }else { %>
	<br>
	<jsp:include page="./include/table_start.jsp" flush="true" /> 
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="出错啦 :(" /> 
		<jsp:param name="colspan" value="1" /> 
		<jsp:param name="align" value="left" /> 
	</jsp:include>						
	<jsp:include page="./include/table_start_body.jsp" flush="true" />
	<jsp:include page="./include/table_body.jsp" flush="true">
		<jsp:param name="width" value="200" /> 
	</jsp:include>
	请先登录!
	<br>
	<br>
	<a href="./register.jsp">注册</a>
	<jsp:include page="./include/table_close_body.jsp" flush="true" />				 
	<jsp:include page="./include/table_close.jsp" flush="true" />
<% } %>   
<jsp:include page="./include/footer.jsp" flush="true" />