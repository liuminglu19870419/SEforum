package forum;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ChangeMessage extends HttpServlet {
	
	DBConnectie db = new DBConnectie();
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
 	throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
 		PrintWriter out = response.getWriter();
 		
 		try{
			
			HttpSession session = request.getSession(true);
			String sessionUsername = (String)session.getAttribute("username");
			String sessionType = (String)session.getAttribute("type");
						
			String forum_id = request.getParameter("forum_id");
			String start = request.getParameter("start");
			String reqThread_id = request.getParameter("thread_id");
			String message_id = request.getParameter("message_id");
			String message = request.getParameter("message");
			message = Filter.filterAll(message);
						
			int changeDifference = (((100 * message.length()) / Utilities.getMessageLength(forum_id,reqThread_id,message_id)));
			
						
			java.util.Date date_time = new java.util.Date();
			
			
			message += "<!-- begin --!><BR><BR><I> " + sessionUsername + "  ÐÞ¸ÄÓÚ " + date_time + " (" + changeDifference + "%)</I><!-- end --!>";

			db.connect();
			
			if(sessionType.equals("Admin")){
				db.query(
					"UPDATE forum_message " +
            		"SET message =\"" + message + "\"" +
            		"WHERE forum_id=\"" + forum_id + "\" AND thread_id =\"" + reqThread_id + "\" AND id=\"" + message_id + "\"");	
			}else{
				db.query(
					"UPDATE forum_message " +
            		"SET message =\"" + message + "\"" +
            		"WHERE forum_id=\"" + forum_id + "\" AND thread_id =\"" + reqThread_id + "\" AND id=\"" + message_id + "\" AND user_id=\""+ Utilities.getUserID(sessionUsername) + "\"");
			}
			
			response.sendRedirect(Variable.getForumPath() + "index.jsp?page=message&forum_id=" + forum_id + "&thread_id=" + reqThread_id +"&start=" + start);
				
            db.close();
    	}catch(Exception e){out.println(e);}
	}
}