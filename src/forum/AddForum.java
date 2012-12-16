package forum;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddForum extends HttpServlet {

        DBConnectie db = new DBConnectie();

        public void doPost (HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        	request.setCharacterEncoding("utf-8");
        	PrintWriter out = response.getWriter();
        	    try{    
					
					String title = request.getParameter("title");
					
					if(title.equals("")){
						title = "No title";
					}else{
						title = Filter.filterAll(title);
					}
					
					String forum_info = request.getParameter("forum_info");
					
					if(forum_info.equals("")){
						forum_info = "No forum_info";
					}else{
						forum_info = Filter.filterAll(forum_info);
					}
                                                            
                   	db.connect();
                    
                    db.query(
                    	"INSERT INTO forum_forums(title,forum_info) "+
                    	"VALUES(\""+ title + 
                    	"\",\"" + forum_info + "\")");
					 					 
                    db.close();
           		
              		response.sendRedirect(Variable.getForumPath() + "index.jsp");
              		
              	
                }catch(Exception e){out.println(e);}
                
             
        }
        public void doGet (HttpServletRequest request, HttpServletResponse response)//{
        throws ServletException, IOException{ 
                doPost(request, response);
        }

}