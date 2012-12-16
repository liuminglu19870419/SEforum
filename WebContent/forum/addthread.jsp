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
<% String sessionPassword = (String)session.getAttribute("password"); %>
<% String sessionType = (String)session.getAttribute("type"); %>

<% String forum_id = request.getParameter("forum_id"); %> 

 <jsp:include page="./include/header.jsp" flush="true">
	<jsp:param name="title" value="Add Thread" /> 
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
                        <a href="search.jsp" class="pathBarLink">进入搜索页面</a>					
             </td>
		</tr>
	</table>
	<jsp:include page="./include/table_start.jsp" flush="true" /> 
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="发表交易信息" /> 
		<jsp:param name="colspan" value="3" /> 
		<jsp:param name="align" value="left" /> 
	</jsp:include>					
	<jsp:include page="./include/table_start_body.jsp" flush="true" />
	<jsp:include page="./include/table_body.jsp" flush="true">
		<jsp:param name="width" value="200" /> 
	</jsp:include>
	
	<form action="../servlet/forum.AddThread" method="POST" name="formmessage">
	<input type="hidden" name="forum_id" value="<%= forum_id %>">
	<input type="hidden" name="user" value="<%= sessionUsername %>">
	标题:<br>
	<input type="text" name="title" size="62" maxlength="60"><br>
	详细内容:<br>
	<textarea name="message" cols="47" rows="10" maxlength=3000></textarea><br>
	<input type="submit" value="发表"><br>
	</form>
	
	<jsp:include page="./include/table_body.jsp" flush="true">
		<jsp:param name="width" value="200" /> 
	</jsp:include>
	<jsp:include page="./include/textStyle.jsp" flush="true" />

	<jsp:include page="./include/table_body.jsp" flush="true">
		<jsp:param name="width" value="200" /> 
	</jsp:include>
	<jsp:include page="./include/emoticons.jsp" flush="true" />
	<jsp:include page="./include/table_close_body.jsp" flush="true" />				 
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