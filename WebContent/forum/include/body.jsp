<%@ page contentType='text/html; charset=UTF-8' %>
<%
request.setCharacterEncoding("utf-8");
%>
<% String sessionUsername = (String)session.getAttribute("username"); %>
<% String sessionType = (String)session.getAttribute("type"); %>
<Body>

<center><img src="./images/logo.jpg"></center>
<jsp:include page="table_start.jsp" flush="true" /> 
<jsp:include page="table_title.jsp" flush="true">
	<jsp:param name="title" value="控制条" />  
	<jsp:param name="colspan" value="1" /> 
	<jsp:param name="align" value="left" /> 
</jsp:include>						
<jsp:include page="table_start_body.jsp" flush="true" />
<jsp:include page="table_body.jsp" flush="true">
	<jsp:param name="width" value="0" /> 
</jsp:include>
	<table width="100%" height="0" border="0" cellpadding="0" cellspacing="0" class="infobar">
		<tr> 
			<td width="50%" height="0" align="left" valign="top">
				<% if(sessionUsername != null){ %>
					<a href="./index.jsp?page=profile">更改我的属性</a>
				<% }else{ %>
					<form action="../servlet/forum.Login" method=POST name=form>
							用户名:<input type="text" name="username" size="10" maxlength="60">
							密码:<input type="password" name="password" size="10" maxlength="60">
							<input type="submit" value="登录">
					</form>
				<% } %>
			</td>
			<td width="50%" height="0" align="right" valign="top">
				<% if(sessionUsername != null){ %>
					用户: <%= sessionUsername %>&nbsp;&nbsp;&nbsp;&nbsp;类型: <%= sessionType %>
					&nbsp;&nbsp;[<a href="../servlet/forum.Logout">注销</a>]		
				<% } %>
			</td>
		</tr>
	</table>
<jsp:include page="table_close_body.jsp" flush="true" />				 
<jsp:include page="table_close.jsp" flush="true" />

