package sboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import sboard.BoardBean;

//DB작업
public class BoardDAO {
	String sql;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	
	private Connection getConnection() throws Exception{		
		Context init = new InitialContext();
		
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		
		Connection con = ds.getConnection();
		
		return con;
	}//getConnection끝
	
	public void freeResource() {
		try {
			if(con !=null) { con.close();}
			if(pstmt !=null) { pstmt.close();}
			if(rs !=null) { rs.close();}
			
		} catch (Exception e) {
			System.out.println("freeResource에서 오류"+e.getMessage());
		}
	}//freeResource();
	

	
	
	//게시판board테이블에 새글정보를 추가 시키는 메소드 
	public void insertBoard(BoardBean bean) {
		
		
		int num = 0;
		
		try {
			con = getConnection();
			
			sql = "select max(num) from board"; 
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num =  rs.getInt("max(num)") + 1;		 
			}else {		
				
				num = 1; 
			}
			
			
			sql = "insert into board(num,id,passwd,subject,content,re_ref,re_lev,re_seq,readcount,date,ip)"
						    +" values(?,?,?,?,?,?,?,?,?,now(),?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bean.getId());
			pstmt.setString(3, bean.getPasswd());
			pstmt.setString(4, bean.getSubject());
			pstmt.setString(5, bean.getContent());
			pstmt.setInt(6, num);//주글(새글)의 글번호를  그룹번호로 지정
			pstmt.setInt(7, 0);//주글(새글)의 들여쓰기 정도값 0
			pstmt.setInt(8, 0);//주글 순서
			pstmt.setInt(9, 0);//주글(새글)을 추가시 조회수 0
			pstmt.setString(10, bean.getIp());//새글을 작성한 사람의 IP주소 
			
			pstmt.executeUpdate();//insert실행

		} catch (Exception e) {
				System.out.println("insertBoard메소드내부에서 예외발생 : " + e.getMessage());
		}finally {
			freeResource();
		}
	}//insertBoard
	
	
	//board테이블에 저장되어 있는 전체글수를 검색해서 반환 하는 메소드
	public int getBoardCount() {
		
		
		int count = 0;//검색한 전체 글수를 저장할 용도
		
		try {
			//DB연결
			con = getConnection();
			//SQL문 : 전체글개수 검색해서 가져오기
			sql = "select count(*) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();//select문 실행
			
			if(rs.next()) {
				count = rs.getInt(1);//검색한 전체 글개수 얻기
			}
			
		} catch (Exception e) {
			System.out.println("getBoardCount메소드에서 예외발생 : " + e.getMessage());
		}finally {
			freeResource();	
		}
		return count; //검색한 전체 글수 notice.jsp로 반환
	}
	
	
	
	public List<BoardBean> getBoardList(int startRow,int pageSize , String keyWord, String keyField ){
		
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try {
			
			con = getConnection();
			
			
			
			if(keyWord.isEmpty() || keyField.isEmpty()) {
			
				sql="select * from board order by re_ref desc, re_seq asc limit ?,?";
            			
           
			}else{
				sql = "select * from board  where "+keyField
						+ " like '%" +keyWord + "%' order by re_ref desc, re_seq asc limit ?,?";
			
				
			}
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			
			
			rs = pstmt.executeQuery();//검색후 결과 데이터 받아오기 
			
			while (rs.next()) {
				BoardBean bBean = new BoardBean();
				
				
				
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setIp(rs.getString("ip"));
				bBean.setId(rs.getString("id"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));			
				
				boardList.add(bBean);
			}//while반복문		
		} catch (Exception e) {
			System.out.println("getBoardList메소드 에서 예외발생 : " + e);
		} finally {
			if(rs != null) try{rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(con != null) try{con.close();}catch(Exception e) {e.printStackTrace();}
		}
		return boardList;
	
	}//getBoardList메소드 끝
	
	
	public void updateReadCount(int num) {
		try {
			
			con=getConnection();
			sql="update board set readcount = readcount+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			freeResource();
		}
	}//updateReadCount()
	
	public BoardBean getboard(int num) {
		
		BoardBean bean=new BoardBean();
		
		try {
			
			con=getConnection();
			
			sql="select * from board where num=?";
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
		if(rs.next()) {
			
			
			
			bean.setSubject(rs.getString("subject"));
			bean.setContent(rs.getString("content"));
			bean.setId(rs.getString("id"));
			bean.setDate(rs.getTimestamp("date"));
			bean.setReadcount(rs.getInt("readcount"));
			bean.setRe_ref(rs.getInt("re_ref"));
			bean.setRe_lev(rs.getInt("re_lev"));
			bean.setRe_seq(rs.getInt("re_seq"));
		}
		
		} catch (Exception e) {
		
			System.out.println("getoard에서 오류"+e.getMessage());
		}finally {
			freeResource();
		}
		
		return bean;
	}//getboard()끝
	
	
	public void updateboard(BoardBean bean){
		try {
			con=getConnection();
			
			sql="update board set subject=? , content=?, date=now()  where   num= ?";
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, bean.getSubject());
			
			pstmt.setString(2, bean.getContent());
			
			pstmt.setInt(3, bean.getNum());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("updateboard내부에서오류"+e.getMessage());
		}finally {
			freeResource();
		}
		
	}//updateboard()끝
	
	
	
	public void deleteboard(int num) {
		try {
			con=getConnection();
			
			sql="delete from board where num=?";
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("deleteboard에서 오류"+e.getMessage());
		}finally {
			freeResource();
		}
	}//deleteboard()끝
	
	
	public void reInsertBoard(BoardBean bean){
		
		 
		 try {

				con = getConnection();
			 int num = 0;
					
		sql = "select max(num) from board";
					
		pstmt = con.prepareStatement(sql);
					
		rs = pstmt.executeQuery();
					
		if(rs.next()){
			num = rs.getInt(1) + 1; 
			}else{
				num = 1;
			}
					
		sql ="update board set re_seq = re_seq+1 where re_ref=? and re_seq > ?";
	 		pstmt = con.prepareStatement(sql);
	    	pstmt.setInt(1, bean.getRe_ref());
			pstmt.setInt(2, bean.getRe_seq());
			pstmt.executeUpdate();
					
					
		sql = "insert into board (num,id,passwd,subject,content,"
				+"re_ref,re_lev,re_seq,readcount,date,ip)"
			    +" values(?,?,?,?,?,?,?,?,?,now(),?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.setString(2, bean.getId());
		pstmt.setString(3, bean.getPasswd());
		pstmt.setString(4, bean.getSubject());
		pstmt.setString(5, bean.getContent());
		pstmt.setInt(6, bean.getRe_ref());
		pstmt.setInt(7, bean.getRe_lev()+1);
		pstmt.setInt(8, bean.getRe_seq()+1);
		pstmt.setInt(9, 0);
		pstmt.setString(10,bean.getIp());
		pstmt.executeUpdate();
		 }catch (Exception e) {
			 System.out.println("reinsert내부에서 오류"+e.getMessage());
		}finally {
			freeResource();
		}
    }//reinsertboard끝



}//BoardDAO클래스끝