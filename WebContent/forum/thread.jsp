<%@ page contentType='text/html; charset=UTF-8' %>
<%@ page import='java.io.*' %>
<%@ page import='javax.servlet.*' %>
<%@ page import='javax.servlet.http.*' %>
<%@ page import='java.sql.*' %>
<%@ page import='java.sql.Connection' %>
<%@ page import='java.sql.Statement' %>
<%@ page import='java.sql.ResultSet' %>
<%@ page import='forum.*' %>

<% String sessionUsername = (String)session.getAttribute("username"); %>
<% String user_id = null; %>
<% String sessionPassword = (String)session.getAttribute("password"); %>
<% String sessionType = (String)session.getAttribute("type"); %>
<% String forum_id = request.getParameter("forum_id"); %> 

 <jsp:include page="./include/header.jsp" flush="true">
	<jsp:param name="title" value="Read Thread" /> 
</jsp:include>	 
<jsp:include page="./include/body.jsp" flush="true" />
<% if( sessionUsername != null){%>
	<table width="100%" height="20" border="0" cellpadding="1" cellspacing="1">
		<tr> 
			<td height="20" valign="top" class="pathBar">
				<a href="./index.jsp" class="pathBarLink"><%= Variable.getForumName() %></a><span class="pathBarSeperator"> > </span>
				<a href="./index.jsp?page=thread&forum_id=<%= forum_id %>" class="pathBarLink"><%= Utilities.getforumTile(forum_id) %></a>
			</td>
			<td height="20" align="right" class="pathBar">	
						<a href="./addthread.jsp?forum_id=<%= forum_id %>" class="pathBarLink">发布交易信息</a>&nbsp;&nbsp;&nbsp;&nbsp;					
                        <a href="./search.jsp" class="pathBarLink">进入搜索页面</a>					
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
		<jsp:param name="title" value="点击数" /> 
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

	String message_id = null;
	ResultSet rs = db.selectQuery("SELECT DISTINCT thread_id FROM forum_message WHERE forum_id=\""+ forum_id +"\" ORDER BY date_time DESC");

	while(rs.next()){
		String thread_id = rs.getString("thread_id");
		
		ResultSet rs2 = db.selectQuery("SELECT MIN(id) message_id FROM forum_message WHERE thread_id=\""+ thread_id +"\"");	
		while(rs2.next()){
			message_id = rs2.getString("message_id");
		}
		
		ResultSet rs3 = db.selectQuery(
			"SELECT user_id,date_time "+
			"FROM forum_message "+
			"WHERE id=\"" + message_id + "\" ");
								
		while(rs3.next()){
			String title = Utilities.getThreadTile(thread_id);
			String user = Utilities.getUser(rs3.getString("user_id"));
			String date_time = rs3.getString("date_time");
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
	<% } %>
	<jsp:include page="./include/table_close_body.jsp" flush="true" /> 						

	<jsp:include page="./include/table_start_title.jsp" flush="true" /> 
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="<a href=\"./index.jsp\">返回</a>" /> 
		<jsp:param name="colspan" value="7" /> 
		<jsp:param name="align" value="left" /> 
	</jsp:include>			
	<jsp:include page="./include/table_close.jsp" flush="true" /> 
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