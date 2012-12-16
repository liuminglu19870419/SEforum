package forum;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddReply extends HttpServlet {

        DBConnectie db = new DBConnectie();

        public void doPost (HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        	 request.setCharacterEncoding("utf-8");
        	PrintWriter out = response.getWriter();
        	    try{    
     				String start = request.getParameter("start");
                    String forum_id = request.getParameter("forum_id");
					String thread_id = request.getParameter("thread_id");
					String message = request.getParameter("message");
					if(message.equals("")){
						message = "No title";
					}else{
						message = Filter.filterAll(message);
					}
					
					String user = request.getParameter("user");
                    
                    db.connect();

                    db.query(
                    	"INSERT INTO forum_message(forum_id,thread_id,message,user_id,date_time) "+
                    	"VALUES(\"" + forum_id + 
                    	"\",\"" + thread_id +
                    	"\",\"" + message + 
                    	"\",\"" + Utilities.getUserID(user) +
                    	"\",SYSDATE())");
                    					 
                    db.close();
           		
              		response.sendRedirect(Variable.getForumPath() + "index.jsp?page=message&forum_id="+ forum_id +"&thread_id=" + thread_id +"&start=" + start);
              		
                }catch(Exception e){out.println(e);}
                
             
        }
        public void doGet (HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{ 
                doPost(request, response);
        }

}