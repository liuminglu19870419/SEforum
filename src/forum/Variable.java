package forum;

public class Variable {
	
	static String dbName = "trade";
	static String dbUserNmae = "root";
	static String dbPassword = "root";
	static String forumPath = "../forum/";
	static String forumName = "��ˮ��ɳ�ӽ���ϵͳ";
	static String messagePerPage = "10";
	
	
	
	public static String getDbName(){
		return dbName;
	}
	
	public static String getDbUserNmae(){
		return dbUserNmae;
	}	
	
	public static String getDbPassword(){
		return dbPassword;
	}

	public static String getForumPath(){
		return forumPath;
	}
	
	public static String getForumName(){
		return forumName;
	}
	
	public static String getMessagePerPage(){
		return messagePerPage;
	}
}