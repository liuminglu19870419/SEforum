<%@ page contentType='text/html; charset=UTF-8' %>
<%
request.setCharacterEncoding("utf-8");
%>
<TD align=<%= request.getParameter("align") %> colspan=<%= request.getParameter("colspan") %>>
<FONT face=Verdana,Arial,Helvetica color=#003366 size=1>
<B><%= request.getParameter("title") %></B>
</FONT>
</TD>