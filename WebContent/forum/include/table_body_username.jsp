<%@ page contentType='text/html; charset=UTF-8' %>
<%@ page import='java.util.*' %>

<jsp:include page="table_start.jsp" flush="true" />
<jsp:include page="table_title.jsp" flush="true">
	<jsp:param name="title" value="信息条" /> 
	<jsp:param name="colspan" value="1" /> 
	<jsp:param name="align" value="left" /> 
</jsp:include>		
<jsp:include page="table_start_body.jsp" flush="true" />
<jsp:include page="table_body.jsp" flush="true">
	<jsp:param name="width" value="0" /> 
</jsp:include>
<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#FFFFFF" border="0" align="center">
	<TR>
		<TD>
			<FONT face="Verdana,Arial,Helvetica" color="#003366" size="1"><%= new Date().toString() %></font>
		</TD>
		<TD align="right">
			<FONT face="Verdana,Arial,Helvetica" color="#003366" size="1"><a href="../servlet/forum.Logout">登出</a></font>
		</TD>
	</TR>
</TABLE>
<jsp:include page="table_close_body.jsp" flush="true" />
<jsp:include page="table_close.jsp" flush="true" />

<Body>
 <center>
<a href="index.jsp">
<img src=".\logo.jpg" border="0">
</a>
</center>
<jsp:include page="table_start.jsp" flush="true" />
 <jsp:include page="table_title.jsp" flush="true">
	<jsp:param name="title" value="工具条" /> 
	<jsp:param name="colspan" value="1" /> 
	<jsp:param name="align" value="left" /> 
</jsp:include>		
<jsp:include page="table_start_body.jsp" flush="true" />
<jsp:include page="table_body.jsp" flush="true">
	<jsp:param name="width" value="0" /> 
</jsp:include>
<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#FFFFFF" border="0" align="center">
	<TR>
		<TD>
			<% String sessionUsername = (String)session.getAttribute("username"); %>
			<FONT face="Verdana,Arial,Helvetica" color="#003366" size="1">用户: <b><%= sessionUsername.toUpperCase() %></b></font>	
		</TD>
		<TD align="right">
			<FONT face="Verdana,Arial,Helvetica" color="#003366" size="1"><a href="profile.jsp">我的属性</a></font>
		</TD>
	</TR>
</TABLE>
<jsp:include page="table_close_body.jsp" flush="true" /> 		 
<jsp:include page="table_close.jsp" flush="true" />
<br>