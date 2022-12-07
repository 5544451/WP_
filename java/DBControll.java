package com.lowCO2.web;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
	    	URL = "jdbc:mysql://localhost:3306/jeju";
	    }
	    
	    private void connect() {
	    	try {
	            System.out.println("DBControll()"+ URL);
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
	            System.out.println("success");
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
	    
	    //db에 데이터 삽입하는 메서드
	    public void insertDB(String[] mem, String table){
	        //쿼리문 준비
	    	connect();
	        String sql = String.format("insert into %s values(?,?,?)", table);
	        
	        PreparedStatement pstmt = null;
	        try {
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, mem[0]);
	            pstmt.setString(2, mem[1]);
	            pstmt.setString(3, mem[2]);
	            int result = pstmt.executeUpdate();
	            if(result==1) {
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
	    }
	    
	    //1행만 가져오는 메서드
		public String[] selectOne(String id, String table) {
			connect();
	        String sql = String.format("select * from %s where email = ?", table);
	        PreparedStatement pstmt = null;
	        String[] info = new String[3];
	        
	        try {
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, id);
	            ResultSet rs = pstmt.executeQuery();
	            if(rs.next()) {
	            	info[0] = rs.getString("email");
	            	info[1] = rs.getString("pswd");
	            	info[2] = rs.getString("list");  
	            }
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
	    
	    //데베 전체가져옴
		public List<Place> selectTable(String table) {
			connect();
			String sql ="";
			if(table =="tourist_destination" || table =="lodgment")
				sql = String.format("select * from %s order by 조회수 desc", table);
			else
				sql = String.format("select * from %s", table);
	        PreparedStatement pstmt = null;
	        List<Place> info = new ArrayList<Place>();
	        System.out.print(sql);
	        try {
	            pstmt = conn.prepareStatement(sql);
	            ResultSet rs = pstmt.executeQuery();
	            while (rs.next()) {
	            	Place P = new Place();
					
					P.type = rs.getString("콘텐츠분류"); 
					P.view = rs.getInt("조회수");
	            	P.name = rs.getString("제목");
	            	P.roadaddress = rs.getString("지번주소");
	            	P.lotaddress = rs.getString("도로명주소");
	            	P.latitude = Double.parseDouble(rs.getString("위도"));
	            	P.longitude = Double.parseDouble(rs.getString("위도"));
	            	info.add(P);
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
		
		
	  
		//조건에 맞는 행을 DB에서 수정(갱신)    하는 메서드
	    public void updateDB(String id) {
	    	connect();
	        String sql = "update member set name =?, password =?, email =?, list =? where id=?";
	        PreparedStatement pstmt = null;
	        try {
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1,"nickname");
	            pstmt.setString(2,id);
	            pstmt.setString(3,"pswd");
	            pstmt.setString(4,"email");
	            pstmt.setString(5,"list");
	            pstmt.setString(6,"sendmail");
	            pstmt.executeUpdate();
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
