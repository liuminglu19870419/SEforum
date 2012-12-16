<%@ page contentType='text/html; charset=UTF-8' %>
<jsp:include page="./include/header.jsp" flush="true">
	<jsp:param name="title" value="Forum" /> 
</jsp:include>
<jsp:include page="./include/body.jsp" flush="true" />
<br>
<jsp:include page="./include/table_start.jsp" flush="true" /> 
<jsp:include page="./include/table_title.jsp" flush="true">
	<jsp:param name="title" value="反馈信息" /> 
	<jsp:param name="colspan" value="1" /> 
	<jsp:param name="align" value="left" /> 
</jsp:include>						
<jsp:include page="./include/table_start_body.jsp" flush="true" />
<jsp:include page="./include/table_body.jsp" flush="true">
	<jsp:param name="width" value="0" /> 
</jsp:include>
<% String action = request.getParameter("action"); %>
<% if(action.equals("regcomplete")){ %>
	恭喜您，注册成功 :)
	<br><br>
	<a href="./index.jsp">返回首页</a>
<% }else if(action.equals("wrongpass")){ %>
	抱歉，输入的密码可能不匹配 :(
	<br><br>
<a href="javascript:history.go(-1)">返回</a>
<% }else if(action.equals("userexists")){ %>
	抱歉，用户名已经存在了 :(
	<br><br>
	<a href=javascript:history.go(-1)>返回</a>
<% }else{ %>
	您输入的是什么内容，我2bit的CPU处理不了啦 :(
<% } %>

<jsp:include page="./include/table_close_body.jsp" flush="true" />				 
<jsp:include page="./include/table_close.jsp" flush="true" />
<jsp:include page="./include/footer.jsp" flush="true" />