package forum;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Login extends HttpServlet {

        DBConnectie db = new DBConnectie();

        public void doPost (HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        		request.setCharacterEncoding("utf-8");	
        		PrintWriter out = response.getWriter();
        
        	    try{ 
        	     
					String loginUser = request.getParameter("username");
                    String loginPass = request.getParameter("password");
                    
                    db.connect();
                    
                    String password = "null";
                    String password2 = "zero";
                    String type = "null";
                    
                    ResultSet rs = db.selectQuery(
                    	"SELECT * "+
                    	"FROM forum_users "+
                    	"WHERE user_name =\"" + loginUser + "\"");
                    while(rs.next()){
                    	password = rs.getString("password");
                    	type = rs.getString("type");
                    }
                    
                    
                    ResultSet rs2 = db.selectQuery(
                    	"SELECT "+
                    	"password(\""+ loginPass +"\") password");
                    while(rs2.next()){
                    	password2 = rs2.getString("password");	
					}

					
                    if(password2.equals(password)){
                    	HttpSession session = request.getSession(true);
                    	
                    	session.setAttribute("username",loginUser);
                    	session.setAttribute("password",password);
                    	session.setAttribute("type",type);
                    
                    	response.sendRedirect(Variable.getForumPath() + "index.jsp");
                    }else{
						response.sendRedirect(Variable.getForumPath() + "info.jsp?action=wrongpass");
                    }
                    
 					
                    db.close();
                    
                }catch(Exception e){out.println(e);}
                
             
        }
        public void doGet (HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{      
                doPost(request, response);
        }

}