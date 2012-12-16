<%@ page contentType='text/html; charset=GBK' %>
<%@ page import='java.io.*' %>
<%@ page import='javax.servlet.*' %>
<%@ page import='javax.servlet.http.*' %>
<%@ page import='java.sql.*' %>
<%@ page import='java.sql.Connection' %>
<%@ page import='java.sql.Statement' %>
<%@ page import='java.sql.ResultSet' %>
<%@ page import='forum.*' %>

<%request.setCharacterEncoding("gb2312"); %>
<% String sessionUsername = (String)session.getAttribute("username"); %>
<% String sessionPassword = (String)session.getAttribute("password"); %>
<% String sessionType = (String)session.getAttribute("type"); %>

 <% String searchinfo = request.getParameter("searchinfo"); %> 
 
 <jsp:include page="./include/header.jsp" flush="true">
	<jsp:param name="title" value="Search Result" /> 
</jsp:include>	 
<jsp:include page="./include/body.jsp" flush="true" />
 <% if(searchinfo == null ) {%>
 <form action="./search.jsp" method="post" name="search">
 	<br>
	<div align="center"><input type="text" name="searchinfo" size="62" maxlength="60" >
	<input type="submit" value="搜索"></div>	
	</form>
 <%} else {%>
 <% if( sessionUsername != null){%>
	<table width="100%" height="20" border="0" cellpadding="1" cellspacing="1">
		<tr> 
			<td height="20" valign="top" class="pathBar">
				<a href="./index.jsp" class="pathBarLink"><%= Variable.getForumName() %></a><span class="pathBarSeperator"> > </span>
				 <a href="./search.jsp" class="pathBarLink">搜索页面</a>
			</td>
		</tr>
	</table>
	<jsp:include page="./include/table_start.jsp" flush="true" />                   
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="交易信息" /> 
		<jsp:param name="colspan" value="1" /> 
		<jsp:param name="align" value="middle" /> 
	</jsp:include>	               
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="作者" /> 
		<jsp:param name="colspan" value="1" /> 
		<jsp:param name="align" value="middle" /> 
	</jsp:include>	
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="发表时间" /> 
		<jsp:param name="colspan" value="1" /> 
		<jsp:param name="align" value="middle" /> 
	</jsp:include>	
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="评论数" /> 
		<jsp:param name="colspan" value="1" /> 
		<jsp:param name="align" value="middle" /> 
	</jsp:include>
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="点此数" /> 
		<jsp:param name="colspan" value="1" /> 
		<jsp:param name="align" value="middle" /> 
	</jsp:include>
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="最新回复" /> 
		<jsp:param name="colspan" value="1" /> 
		<jsp:param name="align" value="middle" /> 
	</jsp:include>	   	    	                   
	<% if(sessionType.equals("Admin")){ %>
		<jsp:include page="./include/table_title.jsp" flush="true">
			<jsp:param name="title" value="删除交易信息" /> 
			<jsp:param name="colspan" value="1" /> 
			<jsp:param name="align" value="middle" /> 
		</jsp:include>
	<% } %>	 

	<%
	DBConnectie db = new DBConnectie();
			
	db.connect();

	ResultSet rs = db.selectQuery("SELECT * FROM forum_threads WHERE title like \"%"+searchinfo +"%\" ORDER BY date_time DESC");
								
		while(rs.next()){
			String forum_id = rs.getString("forum_id");
			String thread_id = rs.getString("id");
			String title = rs.getString("title");
			String user = Utilities.getUser(forum_id,thread_id);
			String date_time = rs.getString("date_time");
	%>
			<jsp:include page="./include/table_start_body.jsp" flush="true" />
			<jsp:include page="./include/table_body.jsp" flush="true">
				<jsp:param name="width" value="0" /> 
			</jsp:include>							
			 <a href="./index.jsp?page=message&forum_id=<%= forum_id %>&thread_id=<%= thread_id %>&start=0"><%= title %></a><%= Utilities.getMorePages(Utilities.getReplies(forum_id,thread_id),forum_id,thread_id,true) %>
			<jsp:include page="./include/table_body.jsp" flush="true">
				<jsp:param name="width" value="0" /> 
			</jsp:include>								
			 <%= user %>	
				<jsp:include page="./include/table_body.jsp" flush="true">
					<jsp:param name="width" value="0" /> 
				</jsp:include>							
			<%= date_time %>	
			<jsp:include page="./include/table_body.jsp" flush="true">
				<jsp:param name="width" value="0" /> 
			</jsp:include>								
			<%= Utilities.getReplies(forum_id,thread_id) %>								
			<jsp:include page="./include/table_body.jsp" flush="true">
				<jsp:param name="width" value="0" /> 
			</jsp:include>								
			<%= Utilities.getViews(forum_id,thread_id) %>
			<jsp:include page="./include/table_body.jsp" flush="true">
				<jsp:param name="width" value="0" /> 
			</jsp:include>								
			<%= Utilities.lastActionInfo(forum_id,thread_id) %>
										
			<% if(sessionType.equals("Admin")){ %>
				<jsp:include page="./include/table_body.jsp" flush="true">
					<jsp:param name="width" value="0" /> 
				</jsp:include>
				<a href="../servlet/forum.DeleteThread?forum_id=<%= forum_id %>&thread_id=<%= thread_id %>">删除</a>
			<% } %>
		<% } %>
	<jsp:include page="./include/table_close_body.jsp" flush="true" /> 						

	<jsp:include page="./include/table_start_title.jsp" flush="true" /> 
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="<a href=\"./index.jsp\">返回</a>" /> 
		<jsp:param name="colspan" value="7" /> 
		<jsp:param name="align" value="left" /> 
	</jsp:include>			
	<jsp:include page="./include/table_close.jsp" flush="true" /> 
	<br>
<% } else { %>
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
<% } %>      
<jsp:include page="./include/footer.jsp" flush="true" /> 
