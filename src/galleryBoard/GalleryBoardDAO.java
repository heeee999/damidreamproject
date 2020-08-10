package galleryBoard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import sboard.BoardBean;


public class GalleryBoardDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql ="";
	
 private Connection getConnection() throws Exception{
	
	Context init = new InitialContext();
	
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
	
	con = ds.getConnection();
	
	return con;
	
 }//getConnection()
 
 public void freeSource(){
	 try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
			
		} catch (SQLException e) {
			System.out.println("freeSource 에서 오류"+e.getMessage());
			
		}
 }//freeSource끝
 public List<GalleryBoardBean> getBoardList(int startRow,int pageSize){
	List<GalleryBoardBean> boardList = new ArrayList<GalleryBoardBean>();
	
	try {
		con = getConnection();
		
		sql =  "select * from gboard order by re_ref desc,re_seq asc limit ?,?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, startRow);
		pstmt.setInt(2, pageSize);
		rs =pstmt.executeQuery();
		
		while(rs.next()){
			GalleryBoardBean bBean = new GalleryBoardBean();
			bBean.setNum(rs.getInt("num"));
			bBean.setId(rs.getString("id"));
			bBean.setPasswd(rs.getString("passwd"));
			bBean.setSubject(rs.getString("subject"));
			bBean.setImage(rs.getString("image"));
			bBean.setContent(rs.getString("content"));
			bBean.setFile(rs.getString("file"));
			bBean.setRe_ref(rs.getInt("re_ref"));
			bBean.setRe_lev(rs.getInt("re_lev"));
			bBean.setRe_seq(rs.getInt("re_seq"));
			bBean.setReadcount(rs.getInt("readcount"));
			bBean.setDate(rs.getTimestamp("date"));
			bBean.setIp(rs.getString("ip"));
			
			boardList.add(bBean);
			
		}
	} catch (Exception e) {
		System.out.println("getBoardList에서 오류"+e.getMessage());
	} finally {
		freeSource();
	}
	
	return boardList;
			
 }// getBoardList끝
 
 
 public int getBoardCount(){
	
	int count=0;
	
	try {
		con = getConnection();
		sql = "select count(*) from gboard";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			count = rs.getInt(1);
		}
		
	} catch (Exception e) {
		System.out.println("getBoardCount에서 오류"+e.getMessage());
	} finally {
		freeSource();
	}	
	return count;
 } //getBoardCount()끝

 public void insertBoard(GalleryBoardBean bBean){
	
	
	int num = 0;
	
	try {
		con = getConnection();
		
		
				
				sql =" select max(num) from gboard";
				pstmt = con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				
				if(rs.next()){
					num = rs.getInt(1) + 1;
				}else{
					num = 1;
				}		
				
				sql = "insert into gboard (num,id,passwd,image,subject,content,file,"
						+"re_ref,re_lev,re_seq,readcount,date,ip)"
						+" values(?,?,?,?,?,?,?,?,?,?,?,now(),?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, bBean.getId());
				pstmt.setString(3, bBean.getPasswd());
				pstmt.setString(4, bBean.getImage());
				pstmt.setString(5, bBean.getSubject());
				pstmt.setString(6, bBean.getContent());
				pstmt.setString(7, bBean.getFile());
				pstmt.setInt(8, num);
				pstmt.setInt(9, 0);
				pstmt.setInt(10, 0);
				pstmt.setInt(11, 0);
				pstmt.setString(12, bBean.getIp());
				
				pstmt.executeUpdate();
			
		
	} catch (Exception e) {
		System.out.println("insertBoard오류 "+e.getMessage());		
	}finally {
		freeSource();
	}
 }//insertBoard끝
 

 public void updateReadCount(int num){
	
	 try {
		con = getConnection();
		sql = "update gboard set readcount = readcount+1 where num=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		System.out.println("updateReadCount에서 오류"+e.getMessage());
	} finally {
		freeSource();
	}
	
	
 }//updateReadCount

 public GalleryBoardBean getBoard(int num) {
	 
	 GalleryBoardBean bean=new GalleryBoardBean();
	 try {
		con=getConnection();
		
		sql="select * from gboard where num=?";
		
		pstmt=con.prepareStatement(sql);
		
		pstmt.setInt(1, num);
		
		rs=pstmt.executeQuery();
		if(rs.next()) {
			
			bean.setId(rs.getString("id"));
			bean.setPasswd(rs.getString("passwd"));
			bean.setDate(rs.getTimestamp("date"));
			bean.setSubject(rs.getString("subject"));
			bean.setContent(rs.getString("content"));
			bean.setFile(rs.getString("file"));
			bean.setImage(rs.getString("image"));
			bean.setReadcount(rs.getInt("readcount"));
			bean.setRe_ref(rs.getInt("re_ref"));
			bean.setRe_lev(rs.getInt("re_lev"));
			bean.setRe_seq(rs.getInt("re_seq"));
			bean.setIp(rs.getString("ip"));
		}
		
	} catch (Exception e) {
		// TODO: handle exception
	}finally {
		freeSource();
	}
	 
	 return bean;
 }//getboard끝
 
 public void updateBoard(GalleryBoardBean bean) {
	 try {
		con=getConnection();
		
		sql="update gboard set date = now(), subject = ?, content = ?  where num=?";
		
		pstmt=con.prepareStatement(sql);
		
		pstmt.setString(1, bean.getSubject());
		pstmt.setString(2, bean.getContent());
		
		pstmt.setInt(3, bean.getNum());
		
		pstmt.executeUpdate();
	} catch (Exception e) {
		System.out.println("updateboard에서오류"+e.getMessage());
	}finally {
		freeSource();
	}
	 
	 
 }//update끝
 
 
 public void deleteboard(int num) {
	 try {
		con=getConnection();
		
		sql="delete from gboard where num=?";
		
		pstmt=con.prepareStatement(sql);
		
		pstmt.setInt(1, num);
		
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		
		System.out.println("deleteboard에서 오류"+e.getMessage());
	}finally {
		freeSource();
	}
 }//deleteboard끝 
 
 public void reinsert(GalleryBoardBean bean) {
	 
	 try {
		con=getConnection();
		
		int num = 0;
		
		sql = "select max(num) from gboard";
					
		pstmt = con.prepareStatement(sql);
					
		rs = pstmt.executeQuery();
					
		if(rs.next()){
			num = rs.getInt(1) + 1; 
			}else{
				num = 1;
			}
					
		sql ="update gboard set re_seq = re_seq+1 where re_ref=? and re_seq > ?";
	 		pstmt = con.prepareStatement(sql);
	    	pstmt.setInt(1, bean.getRe_ref());
			pstmt.setInt(2, bean.getRe_seq());
			pstmt.executeUpdate();
					
					
			sql = "insert into gboard (num,id,passwd,image,subject,content,file,"
					+"re_ref,re_lev,re_seq,readcount,date,ip)"
					+" values(?,?,?,?,?,?,?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bean.getId());
			pstmt.setString(3, bean.getPasswd());
			pstmt.setString(4, bean.getImage());
			pstmt.setString(5, bean.getSubject());
			pstmt.setString(6, bean.getContent());
			pstmt.setString(7, bean.getFile());
			pstmt.setInt(8, bean.getRe_ref());
			pstmt.setInt(9, bean.getRe_lev()+1);
			pstmt.setInt(10, bean.getRe_seq()+1);
			pstmt.setInt(11, 0);		
			pstmt.setString(12, bean.getIp());
			pstmt.executeUpdate();
	} catch (Exception e) {
		System.out.println("reinsert에서 오류"+e.getMessage());	
	}finally {
		freeSource();
	}
	 
 } 
 
}
