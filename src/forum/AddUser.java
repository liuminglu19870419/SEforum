package forum;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddUser extends HttpServlet {

        DBConnectie db = new DBConnectie();

        public void doPost (HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        	    request.setCharacterEncoding("utf-8");
        		PrintWriter out = response.getWriter();
        	    try{    
                	
                    String RegUser = request.getParameter("user");
                    String RegEmail = request.getParameter("email");
                    String RegPass = request.getParameter("password");
                    String RegPass2 = request.getParameter("password2");
                    					
					db.connect();
					ResultSet rs = db.selectQuery(
						"SELECT * "+
						"FROM forum_users "+
						"WHERE user_name=\""+ RegUser + "\"");
						
					String DBUsername = null;
					while(rs.next()){
						DBUsername = rs.getString("user_name");	
					}
						
			if (DBUsername == null){
					
                    	if(RegPass.equals(RegPass2)){
                    	
                    		db.query(
                    			"INSERT INTO "+
                    			"forum_users(USER_NAME,PASSWORD,EMAIL,REGISTERDATE,TYPE) "+
                    			"VALUES('"+ RegUser + "',PASSWORD('" + RegPass +"'),'"+ RegEmail + "',SYSDATE(),'user')");
							db.close();
							response.sendRedirect(Variable.getForumPath() + "info.jsp?action=regcomplete");
							System.out.println("insert user !");
						}else{
						    response.sendRedirect(Variable.getForumPath() + "info.jsp?action=wrongpass");
						}
					}else{
						response.sendRedirect(Variable.getForumPath() + "info.jsp?action=userexists");
                    }
                }catch(Exception e){out.println(e);}
                
             
        }
        public void doGet (HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{
                doPost(request, response);
        }

}