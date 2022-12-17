package com.lowCO2.web;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class DBControll {
	    private Connection conn; //DB 커넥션 연결 객체
	    private static String USERNAME ;//DBMS접속 시 아이디
	    private static String PASSWORD;//DBMS접속 시 비밀번호
	    private static String URL;//DBMS접속할 db명
	    
	    public DBControll() {
	    	USERNAME = "root";
	    	PASSWORD = "root";
	    	URL = "jdbc:mysql://localhost:3306/eco";
	    }
	    
	    private void connect() {
	    	try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
	            System.out.println(" DBControll connect success");
	        } 
	        catch (Exception e) {
	            System.out.println("fail : " + e);
	            try {
	                conn.close();
	            } 
	            catch (SQLException e1) {   
	            	System.out.println(" SQLException fail : " + e1);
	            }
	        }
	    }
	    
	    public void addColumn() {
	    	//2. 다음 Column생성
	    	int columnCount = 0;
	    	String sql = String.format("select * from journey");
	    	connect();
	    	PreparedStatement pstmt = null;
	    	System.out.print(sql);
	    	try {
	    		pstmt = conn.prepareStatement(sql);
	    		ResultSet rs = pstmt.executeQuery();
	    		ResultSetMetaData rsmd = rs.getMetaData();
	    		columnCount = rsmd.getColumnCount(); 
	    		int result = pstmt.executeUpdate();
	    		if(result == 1) {
	    			pstmt.close();
	    		}
	        } catch (Exception e) {
	            System.out.println("addColumn 메서드 예외발생" + e);
	        }    finally {
	            try {
	                if(pstmt!=null && !pstmt.isClosed()) {
	                    pstmt.close();
	                }
	            } catch (Exception e2) {}
	        }
	    	
	    	String newCol = "plan"+ Integer.toString(columnCount);
	    	String oldCol = "plan"+ Integer.toString(columnCount-1);
	    	pstmt = null;
	    	sql = String.format("TABLE journey ADD COLUMN ? TEXT NULL AFTER ?");
	    	try {
	    		pstmt = conn.prepareStatement(sql);
	    		pstmt.setString(1, newCol);
	    		pstmt.setString(2, oldCol);
	            int result = pstmt.executeUpdate();
	            if(result == 1) {
	                System.out.println("TABLE journey ADD COLUMN success!");
	                conn.close();
	            } 
	        } catch (Exception e) {
	            System.out.println("addColumn 메서드 예외발생" + e);
	        }    finally {
	            try {
	                if(pstmt!=null && !pstmt.isClosed()) {
	                    pstmt.close();
	                }
	            } catch (Exception e2) {}
	        }
	    }
	    
	    //db에 멤버 데이터 삽입하는 메서드
	    public boolean insertMember(String[] mem){
	        //쿼리문 준비
	    	connect();
	        String sql = String.format("insert into member values(?,?,?,?,?)");
	        
	        PreparedStatement pstmt = null;
	        try {
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, mem[0]);
	            pstmt.setString(2, mem[1]);
	            pstmt.setString(3, mem[2]);
	            pstmt.setString(4, mem[3]);
	            pstmt.setString(5, mem[4]);
	            int result = pstmt.executeUpdate();
	            if(result == 1) {
	                System.out.println("data insert success!");
	                conn.close();
	            } 
	        } catch (Exception e) {
	            System.out.println("data insert fail!"+ e);
	        }    finally {
	            try {
	                if(pstmt!=null && !pstmt.isClosed()) {
	                    pstmt.close();
	                }
	            } catch (Exception e2) {}
	        }
	        
	        connect();
	        sql = String.format("insert into journey (email) values(?)");
	        pstmt = null;
	        try {
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, mem[0]);
	            int result = pstmt.executeUpdate();
	            if(result == 1) {
	                System.out.println("journey insert success!");
	                conn.close();
	                return true;
	            } 
	        } catch (Exception e) {
	            System.out.println("journey insert fail!"+ e);
	        }    finally {
	            try {
	                if(pstmt!=null && !pstmt.isClosed()) {
	                    pstmt.close();
	                }
	            } catch (Exception e2) {}
	        }
	       
			return false;
	    }
	    
	    //1행만 가져오는 메서드
		public List<String> selectOne(String id, String table) {
			connect();
	        String sql = String.format("select * from %s where email = ?", table);
	        PreparedStatement pstmt = null;
	        List<String> info = new ArrayList<String>();
	        
	        try {
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, id);
	            ResultSet rs = pstmt.executeQuery();
	            if(rs.next()) {
	            	info.add(rs.getString("email"));
	            	info.add(rs.getString("nickname")); 
	            	info.add(rs.getString("pswd"));
	            	info.add(rs.getString("bookmark"));
	            	info.add(rs.getString("cumulative"));
	            }
	            pstmt.close();
	            conn.close();
	        } catch (Exception e) {
	            System.out.println("select 메서드 예외발생" + e);
	        }    finally {
	            try {
	                if(pstmt!=null && !pstmt.isClosed()) {
	                    pstmt.close();
	                }
	            } catch (Exception e2) {}
	        }
	        return info;
	    }
	    
		
	    //1행만 가져오는 메서드
		public List<String> selectJorney(String id) {	
			connect();
	        String sql = String.format("select * from journey where email = ?");
	        PreparedStatement pstmt = null;
	        List<String> info = new ArrayList<String>();
	        
	        try {
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, id);
	            
	    		ResultSet rs = pstmt.executeQuery();
	    		
	    		ResultSetMetaData rsmd = rs.getMetaData();
		    	String[] columnNames = null;
		    	
		        // Get Column Count
		        int columnCount = rsmd.getColumnCount(); 
		     
		        // Initialize array for Column Names
		        columnNames = new String[columnCount]; 
		     
		        for(int i=1; i<=columnCount; i++) {
		            // Put column name into array
		            columnNames[i-1] = rsmd.getColumnName(i); 
		        }
		        
	            if(rs.next()) {
	            	for (String columnName: columnNames) {
            			info.add(String.valueOf(rs.getString(columnName)));
            			System.out.println(rs.getString(columnName));
            		}
	            }
	            pstmt.close();
	            conn.close();
	            return info;
	        } catch (Exception e) {
	            System.out.println("select 메서드 예외발생" + e);
	        }    finally {
	            try {
	                if(pstmt!=null && !pstmt.isClosed()) {
	                    pstmt.close();
	                }
	            } catch (Exception e2) {}
	        }
	        return info;
	    }
		
		
	    //회원가입시 이메일 중복확인
		public List<String> MemberTable() {
			connect();
			String sql = String.format("select * from member");
	        PreparedStatement pstmt = null;
	        List<String> info = new ArrayList<String>();
	        System.out.print(sql);
	        try {
	            pstmt = conn.prepareStatement(sql);
	            ResultSet rs = pstmt.executeQuery();
	            while (rs.next()) {
					String repeated = rs.getString("email"); 
	            	info.add(repeated);
	            }
	            pstmt.close();
	        } catch (Exception e) {
	            System.out.println("select method error : " + e);
	        }    finally {
	            try {
	                if(pstmt!=null && !pstmt.isClosed()) {
	                    conn.close();
	                }
	            } catch (Exception e2) {}
	        }
	        return info;
	    }
		
		//조건에 맞는 회원 테이블 값을 DB에서 수정(갱신) 하는 메서드
	    public void updateMember(String id) {
	    	connect();
	        String sql = "update member set nickname =?, password =?, where email=?";
	        PreparedStatement pstmt = null;
	        try {
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(2,"nickname");
	            pstmt.setString(3,"pswd");
	            int result = pstmt.executeUpdate();
	            if(result == 1) {
	                System.out.println("journey updateMember success!");
	                conn.close();
	            } 
	        } catch (Exception e) {
	            System.out.println("update 예외 발생" + e);
	        }    finally {
	            try {
	                if(pstmt!=null && !pstmt.isClosed()) {
	                    pstmt.close();
	                }
	            } catch (Exception e2) {}
	        }
	    }
	    
		//조건에 맞는 회원 테이블 값을 DB에서 수정(갱신) 하는 메서드
	    public void updateJourney(String id, String col, String Journey) {

	    	connect();
	        String sql = String.format("update journey set %s = ? where email = ?", col);
	        PreparedStatement pstmt = null;
	        try {
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, Journey);
	            pstmt.setString(2, id);
	            int result = pstmt.executeUpdate();
	            if(result == 1) {
	                System.out.println("journey updateJourney success!");
	                conn.close();
	            } 
	        } catch (Exception e) {
	            System.out.println("update 예외 발생" + e);
	        }    finally {
	            try {
	                if(pstmt!=null && !pstmt.isClosed()) {
	                    pstmt.close();
	                }
	            } catch (Exception e2) {}
	        }
	    }
	    
}
