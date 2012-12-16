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
	
<%

DBConnectie db = new DBConnectie();

db.connect();

ResultSet rs = db.selectQuery(
	"SELECT * FROM forum_users " +
    "WHERE user_name =\"" + sessionUsername + "\"");
                    	
String avatar = "no Avatar";
String member_title = "no Custom member title";
String signature = "no Signature";
					
while(rs.next()){
	avatar = rs.getString("avatar");
	member_title = rs.getString("member_title");
	signature = rs.getString("signature");
}
			
if(avatar == null){
	avatar = "";
}
if(member_title == null){
	member_title = "";
}
if(signature == null){
	signature = "";
}

db.close();
%>			 
<jsp:include page="./include/header.jsp" flush="true">
	<jsp:param name="title" value="Profile" /> 
</jsp:include>
<jsp:include page="./include/body.jsp" flush="true" />
<% if( sessionUsername != null){%>
	<table width="100%" height="20" border="0" cellpadding="1" cellspacing="1">
		<tr> 
			<td height="20" valign="top" class="pathBar">
				<a href="./index.jsp" class="pathBarLink"><%= Variable.getForumName() %></a>
				<span class="pathBarSeperator"> > </span>
				<a href="./index.jsp?page=profile" class="pathBarLink">修改属性</a>
			</td>
		</tr>
	</table>   
	<jsp:include page="./include/table_start.jsp" flush="true" />        
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="我的属性" /> 
		<jsp:param name="colspan" value="2" /> 
		<jsp:param name="align" value="left" /> 
	</jsp:include>	    
	<jsp:include page="./include/table_start_body.jsp" flush="true" />
	<jsp:include page="./include/table_body.jsp" flush="true">
		<jsp:param name="width" value="0" /> 
	</jsp:include>
	<b>更改头像:</b>
	<form action="../servlet/forum.ChangeProfile" method="POST" name="profile">

	<jsp:include page="./include/avatars.jsp" flush="true" />
	<img src="<%= avatar %>" name="img" width="65" height="65" border="0" hspace="15">
	<br>
	<br>
	<b>头像链接</b>
	<br>
	允许的图片后缀为:
	<br>
	<i>.gif .jpeg .jpg .png</i>
	<br>
	<input type="text" name="link_avatar" value="<%= avatar %>" size="30">
	<jsp:include page="./include/table_body.jsp" flush="true">
		<jsp:param name="width" value="0" /> 
	</jsp:include>
	<b>自我简介:</b>
	<br>
	<input type="text" name="member_title" value="<%= member_title %>" maxlenght="30" size="30">
	<br>
	<br>
	<b>签名信息:</b>
	<br>
	<textarea name="signature" maxlenght="1000" cols="23" rows="5"><%= signature %></textarea>
	<br>
	<jsp:include page="./include/table_close_body.jsp" flush="true" />		
	<jsp:include page="./include/table_start_body.jsp" flush="true" />
	<jsp:include page="./include/table_body.jsp" flush="true">
		<jsp:param name="width" value="0" /> 
	</jsp:include>
	<input type="submit" value="更改">
	</form>
	<jsp:include page="./include/table_body.jsp" flush="true">
		<jsp:param name="width" value="0" /> 
	</jsp:include>
	<jsp:include page="./include/table_close_body.jsp" flush="true" />	
	<jsp:include page="./include/table_start_title.jsp" flush="true" />
	<jsp:include page="./include/table_title.jsp" flush="true">
		<jsp:param name="title" value="<a href=javascript:history.go(-1);>返回</a>" /> 
		<jsp:param name="colspan" value="2" /> 
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