package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//DB작업
public class MemberDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql ="";
	
private Connection getConnection() throws Exception{
	
	
		Context init=new InitialContext();
		
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		
		Connection con =ds.getConnection();
	return con;
}//getConnection끝

public void freeResource() {
	try {
		
		if(rs !=null) { rs.close();}
		if(pstmt !=null) { pstmt.close();}
		if(con !=null) { con.close();}
	} catch (Exception e) {
		// TODO: handle exception
	}
}//freeResource끝;

public int idCheck(String id) {
	int check=0;
	try {
		con=getConnection();
		
		sql= "select * from member where id=?";
		
		pstmt=con.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		rs=pstmt.executeQuery();
		
		if(rs.next()) {//아이디가 존재 한다면
			
			check=1;
		}else {//아이디가 없을때
			check=0;
		}
		
	} catch (Exception e) {
		// TODO: handle exception
	}
	
	return check;
}//idcheck끝


public int usercheck(String id, String passwd) {
	
	int check=0;
	
	try {
		con=getConnection();
		
		sql="select * from member where id=?";
		
		pstmt=con.prepareStatement(sql);
		
		pstmt.setString(1,id );
		
		rs =pstmt.executeQuery();
		
		if(rs.next()){//id일치하면
		  if(passwd.equals(rs.getString("passwd"))){
			  
			  check=1;
		  }else{//비번이 틀릴경우
			  check=0;
		  }
		}else{ 
			check=-1;}
	} catch (Exception e) {
		System.out.println("usercheck내부에서 오류"+e.getMessage());
	}finally {
		freeResource();
	}
	return check;
}//usercheck끝

public void  insertMember(MemberBean bean) {
	try {
		con=getConnection();
		
		sql="insert into member(regdate,id,passwd,name,email,postcode,address,address1,address2,tel)"
				+ "values(now(),?,?,?,?,?,?,?,?,?)";
		pstmt=con.prepareStatement(sql);
		
		pstmt.setString(1, bean.getId());
		pstmt.setString(2, bean.getPasswd());
		pstmt.setString(3,bean.getName() );
		pstmt.setString(4, bean.getEmail());
		pstmt.setString(5,bean.getPostcode() );
		pstmt.setString(6,bean.getAddress() );
		pstmt.setString(7,bean.getAddress1() );
		pstmt.setString(8,bean.getAddress2() );
		pstmt.setString(9, bean.getTel());
		
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		System.out.println("insert내부에서 오류"+e.getMessage());
	}finally {
		freeResource();
	}
}//insertMember()

public MemberBean Memberinfo(String id){
	
	 MemberBean bean = new MemberBean();
	
	try {
		con=getConnection();
		
		sql="select * from member where id=?";
		
		pstmt=con.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		rs=pstmt.executeQuery();
		
		if(rs.next()) {
		
			
			bean.setId(rs.getString("id"));
			bean.setEmail(rs.getString("email"));
			bean.setPasswd(rs.getString("passwd"));
			bean.setName(rs.getString("name"));
			bean.setPostcode(rs.getString("postcode"));
			bean.setAddress(rs.getString("address"));
			bean.setAddress1(rs.getString("address1"));
			bean.setAddress2(rs.getString("address2"));
	        bean.setRegdate(rs.getTimestamp("regdate"));
	        bean.setTel(rs.getString("tel"));
		}
		
	} catch (Exception e) {
	     System.out.println("memberinfo내부에서 오류"+e.getMessage());
	}finally {
		freeResource();
	}
	
	return bean;
}//Memberinfo()

public void updateMember(MemberBean bean) {
	
	try {
		con=getConnection();
		
		sql="update member set regdate = now() , name = ? , email = ? ,"
				+ " postcode = ? , address = ?, address1 = ?, address2 = ?, tel = ?  where id = ?";
						
	    pstmt=con.prepareStatement(sql);
			
	    pstmt.setString(1,bean.getName() );
	    pstmt.setString(2, bean.getEmail());
	    pstmt.setString(3,bean.getPostcode() );
	    pstmt.setString(4,bean.getAddress() ); 
	    pstmt.setString(5,bean.getAddress1() );
	    pstmt.setString(6,bean.getAddress2() ); 
	    pstmt.setString(7, bean.getTel());
		pstmt.setString(8, bean.getId());
						
	   pstmt.executeUpdate();
		
	} catch (Exception e) {
	
		System.out.println("update에서오류"+e.getMessage());
		
	}finally {
		
	}
}//update구문 끝

  public void deletemyinfo(String id){
	  try {
		con=getConnection();
		
		sql=" delete from member where id = ? ";
		
		pstmt=con.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		pstmt.executeUpdate();
		
	} catch (Exception e) {
	   System.out.println("deletemyinfo에서 오류"+e.getMessage());
	}finally {
		freeResource();
	}
  }//deletemyinfo끝
	
}//MemberDAO클래스 








