package forum;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;



public class DBConnectie {

	String dbName, dbUserName, dbPassword, SQLQuery;
	Connection conn;
	Statement stmt;
	ResultSet result;

	public DBConnectie() {
		this.dbName = Variable.getDbName();
		this.dbUserName = Variable.getDbUserNmae();
		this.dbPassword = Variable.getDbPassword();
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void connect() {
		try {
			String url = "jdbc:mysql://localhost:3306/"
					+ dbName
					+ "?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=utf-8";
			conn = DriverManager.getConnection(url, dbUserName, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ResultSet selectQuery(String SQLQuery) {
		System.out.println(SQLQuery);
		this.SQLQuery = SQLQuery;
		try {
			stmt = conn.createStatement();
			result = stmt.executeQuery(SQLQuery);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public void query(String SQLQuery) {
		System.out.println(SQLQuery);
		this.SQLQuery = SQLQuery;
		try {
			stmt = conn.createStatement();
			stmt.executeUpdate(SQLQuery);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			try{
			if (result != null)
				result.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
			try{
				if (stmt != null)
					stmt.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
			try{
				if (conn != null)
					conn.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

}
