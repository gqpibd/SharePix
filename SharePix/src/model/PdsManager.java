package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.MemberBean;
import dto.PagingBean;
import dto.PdsBean;
import dto.pagingUtil;

public class PdsManager implements iPdsManager {

<<<<<<< HEAD
            System.out.println("getMyPdsAll 로부터 나오는 dto " + dto.toString());
         }
         System.out.println("3/6 getMyPdsAll success");
         
      } catch (SQLException e) {
         System.out.println("getMyPdsAll fail");
         e.printStackTrace();
      } finally {
         DBClose.close(psmt, conn, rs);
      }
      
      return dto;
   }
   // YH -> 검색 기능 : ID 와 TAG검색
   @Override
   public List<PdsBean> getSearchPds(String keyword) {
      String sql = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
            + " FROM PDSALL "
            + " WHERE (CATEGORY LIKE ? OR TAGS LIKE ?) "; 
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;

      List<PdsBean> list =  new ArrayList<PdsBean>(); // 결과를 저장할 목록

      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6 getPdsDetail Success");

         psmt = conn.prepareStatement(sql);
         
         psmt.setString(1, "%" + keyword +  "%");
         psmt.setString(2, "%" + keyword +  "%");
         
         System.out.println("2/6 getPdsDetail Success");

         rs = psmt.executeQuery();
         System.out.println("3/6 getPdsDetail Success");
         
         while (rs.next()) {
            String regdate = rs.getString("UPLOADDATE");
            regdate = regdate.substring(0, regdate.lastIndexOf('.'));
            // SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGDATE
            PdsBean pds = new PdsBean(rs.getInt("SEQ"), 
                          rs.getString("ID"), 
                          rs.getString("CATEGORY"), 
                          rs.getString("TAGS").substring(1).split("#"),
                          regdate, 
                          rs.getString("FILENAME"), 
                          rs.getInt("READCOUNT"), 
                          rs.getInt("DOWNCOUNT"), 
                          rs.getInt("LIKECOUNT"),
                          rs.getInt("REPLYCOUNT"),
                          rs.getString("FSAVENAME")
                          );
            list.add(pds);
         }
         System.out.println("4/6 getPdsDetail Success");

      } catch (SQLException e) {
         e.printStackTrace();
         System.out.println("getPdsDetail Fail");
      } finally {
         DBClose.close(psmt, conn, rs);
      }
      return list;
   }
    
   @Override
   public PdsBean getPdsDetail(int seq) {
      // SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT
      String sql = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
            + " FROM PDSALL " + " WHERE SEQ = ? ";

      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;

      PdsBean pds = null; // 결과를 저장할 목록

      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6 getPdsDetail Success");

         psmt = conn.prepareStatement(sql);
         psmt.setInt(1, seq);
         System.out.println("2/6 getPdsDetail Success");

         rs = psmt.executeQuery();
         System.out.println("3/6 getPdsDetail Success");
         
         if (rs.next()) {
            String regdate = rs.getString("UPLOADDATE");
            regdate = regdate.substring(0, regdate.lastIndexOf('.'));
            // SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGDATE
            pds = new PdsBean(rs.getInt("SEQ"), 
                          rs.getString("ID"), 
                          rs.getString("CATEGORY"), 
                          rs.getString("TAGS").substring(1).split("#"),
                          regdate, 
                          rs.getString("FILENAME"), 
                          rs.getInt("READCOUNT"), 
                          rs.getInt("DOWNCOUNT"), 
                          rs.getInt("LIKECOUNT"),
                          rs.getInt("REPLYCOUNT"),
                          rs.getString("FSAVENAME")
                          );
         }
         System.out.println("4/6 getPdsDetail Success");

      } catch (SQLException e) {
         e.printStackTrace();
         System.out.println("getPdsDetail Fail");
      } finally {
         DBClose.close(psmt, conn, rs);
      }
      return pds;
   }

   @Override
   public boolean checkPdsLike(String id, int pdsSeq) {
      String sql = " SELECT * "
               + " FROM PDSLIKE " 
               + " WHERE PDSSEQ = ? AND ID = ?";

      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;


      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6 checkPdsLike Success");

         psmt = conn.prepareStatement(sql);
         psmt.setInt(1, pdsSeq);
         psmt.setString(2, id);
         System.out.println("2/6 checkPdsLike Success");

         rs = psmt.executeQuery();
         System.out.println("3/6 checkPdsLike Success");

         if (rs.next()) {
            System.out.println("있음");
            return true;
         }
         System.out.println("없음");
         System.out.println("4/6 checkPdsLike Success");

      } catch (SQLException e) {
         e.printStackTrace();
         System.out.println("checkPdsLike Fail");
      } finally {
         DBClose.close(psmt, conn, rs);
      }
      return false;
   }

   @Override
   public boolean chageLike(String id, int pdsSeq, boolean isLike) {
      String sql = "";
      if (isLike) { // 좋아요를 누르면 row 추가
         sql = " INSERT INTO PDSLIKE " + " VALUES (?, ?) ";
      } else {
         sql = " DELETE FROM PDSLIKE " + " WHERE PDSSEQ = ? AND ID = ? ";
      }

      Connection conn = null;
      PreparedStatement psmt = null;

      int count = 0;

      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6 chageLike Success");

         psmt = conn.prepareStatement(sql);
         psmt.setInt(1, pdsSeq);
         psmt.setString(2, id);
         System.out.println("2/6 chageLike Success");

         count = psmt.executeUpdate();
         System.out.println("3/6 chageLike Success");

      } catch (SQLException e) {
         e.printStackTrace();
         System.out.println("chageLike Fail");
      } finally {
         DBClose.close(psmt, conn, null);
      }
      return count > 0 ? true : false;
   }
   
   
   @Override
   public int getLikeCount(int pdsSeq) {
      String sql = " SELECT count(*) "
               + " FROM PDSLIKE " 
               + " WHERE PDSSEQ = ? ";

      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      
      int count = 0;

      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6 getLikeCount Success");

         psmt = conn.prepareStatement(sql);
         psmt.setInt(1, pdsSeq);
         System.out.println("2/6 getLikeCount Success");

         rs = psmt.executeQuery();
         System.out.println("3/6 getLikeCount Success");

         if (rs.next()) {
            count = rs.getInt(1);
         }
         System.out.println("4/6 getLikeCount Success");

      } catch (SQLException e) {
         e.printStackTrace();
         System.out.println("getLikeCount Fail");
      } finally {
         DBClose.close(psmt, conn, rs);
      }
      return count;
      
   }

   @Override
   public List<PdsBean> getMyPdsAllList(String id) {// 아이디에 해당하는 것들 list로 뽑아오기
      
      List<PdsBean> list = new ArrayList<>();
      
      String sql  = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, "
               + " READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
               + " FROM PDSALL "  
               + " WHERE ID=? ";
   
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      
      PdsBean dto = null;
      
      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6 getMyPdsAllList success");
         psmt = conn.prepareStatement(sql);
         psmt.setString(1, id);
         
         rs = psmt.executeQuery();
         System.out.println("2/6 getMyPdsAllList success");
         
         while(rs.next()) {
            
            String[] tag = rs.getString(4).substring(1).split("#");
            
            dto = new PdsBean(rs.getInt(1),             // seq
                    rs.getString(2),        //   id
                    rs.getString(3),       // CATEGORY
                    tag,        
                    rs.getString(5),     // uploaddate
                    rs.getString(6),    // filename     
                    rs.getInt(7),              // readcount    
                    rs.getInt(8),              // downcount    
                    rs.getInt(10),       // likeCount
                    rs.getInt(11),      //replyCount
                    rs.getString(9));      // fileSaveName
            
            list.add(dto);
            
         }
         
         System.out.println("3/6 getMyPdsAllList success");
         
      } catch (SQLException e) {
         System.out.println("getMyPdsAllList fail");
         e.printStackTrace();
      } finally {
         DBClose.close(psmt, conn, rs);
      }
      return list;
   }
   
   //빈문자였을경우
   @Override
   public List<PdsBean> getSearchPdsNull() {
      String sql = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
            + " FROM PDSALL "
            + "ORDER BY SEQ DESC ";
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;

      List<PdsBean> list =  new ArrayList<PdsBean>();  // 결과를 저장할 목록

      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6 getPdsDetail Success");

         psmt = conn.prepareStatement(sql);
                  
         System.out.println("2/6 getPdsDetail Success");

         rs = psmt.executeQuery();
         System.out.println("3/6 getPdsDetail Success");
         
         while (rs.next()) {
            String regdate = rs.getString("UPLOADDATE");
            regdate = regdate.substring(0, regdate.lastIndexOf('.'));
            // SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGDATE
            PdsBean pds = new PdsBean(rs.getInt("SEQ"), 
                          rs.getString("ID"), 
                          rs.getString("CATEGORY"), 
                          rs.getString("TAGS").substring(1).split("#"),
                          regdate, 
                          rs.getString("FILENAME"), 
                          rs.getInt("READCOUNT"), 
                          rs.getInt("DOWNCOUNT"), 
                          rs.getInt("LIKECOUNT"),
                          rs.getInt("REPLYCOUNT"),
                          rs.getString("FSAVENAME")
                          );
            list.add(pds);
         }
         System.out.println("4/6 getPdsDetail Success");

      } catch (SQLException e) {
         e.printStackTrace();
         System.out.println("getPdsDetail Fail");
      } finally {
         DBClose.close(psmt, conn, rs);
      }
      return list;
   }
   
   @Override
   public List<PdsBean> getPdsPagingList(PagingBean paging, String keyword){
      
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      
      List<PdsBean> pdslist = new ArrayList<>();
      
      String kWord = "";
      
      kWord = " WHERE (TAGS LIKE '%" + keyword + "%' OR CATEGORY LIKE '%" + keyword +  "%')";
      
      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6");
         
         String totalSql = " SELECT COUNT(SEQ) "
               + " FROM PDSALL "
               + kWord;
         
         psmt = conn.prepareStatement(totalSql);
         rs = psmt.executeQuery();
         
         int totalCount = 0;
         rs.next();
         totalCount = rs.getInt(1);      // row의 총갯수
         paging.setTotalCount(totalCount);
         paging = pagingUtil.setPagingInfo(paging);
         
         psmt.close();
         rs.close();
         
         String sql = " SELECT * FROM "
               + " ( SELECT * FROM "
               + "   (SELECT * FROM PDSALL "
               + " " + kWord
               + " ORDER BY SEQ)"
               + " WHERE ROWNUM <=" + paging.getStartNum() + ""
               + " ORDER BY SEQ DESC) "
               + " WHERE ROWNUM <=" + paging.getCountPerPage();


         System.out.println("페이징 시작넘버" + paging.getStartNum());
         System.out.println("페이징 카운터 페이지" + paging.getCountPerPage());
         
         psmt = conn.prepareStatement(sql);         
         System.out.println("2/6 getBbsPagingList Success");      
         
         rs = psmt.executeQuery();
         System.out.println("3/6 getBbsPagingList Success");
         
         while(rs.next()) {
             String regdate = rs.getString("UPLOADDATE");
             regdate = regdate.substring(0, regdate.lastIndexOf('.'));
             // SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGDATE
             PdsBean pds = new PdsBean(rs.getInt("SEQ"), 
                           rs.getString("ID"), 
                           rs.getString("CATEGORY"), 
                           rs.getString("TAGS").substring(1).split("#"),
                           regdate, 
                           rs.getString("FILENAME"), 
                           rs.getInt("READCOUNT"), 
                           rs.getInt("DOWNCOUNT"), 
                           rs.getInt("LIKECOUNT"),
                           rs.getInt("REPLYCOUNT"),
                           rs.getString("FSAVENAME")
                           );
             pdslist.add(pds);           
         }
         System.out.println("4/6 getBbsPagingList Success");
         
      } catch (Exception e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      } finally {
         DBClose.close(psmt, conn, rs);         
      }
      
      
      return pdslist;
      
   }
   
   @Override
   public boolean writePds(PdsBean pds) {
      
      String sql = " INSERT INTO PICPDS( "
            + " SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME) "
            + " VALUES(PICPDS_SEQ.NEXTVAL, ?,?,?,SYSDATE,?,0,0,?) ";
      
      String tagStr ="";
      
      for (int i = 0; i < pds.getTags().length; i++) {
         tagStr += "#" + pds.getTags()[i]; 
      }
      
      Connection conn = null;
      PreparedStatement psmt = null;
      
      int count = 0;
      
      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6 writePds Success");
         
         psmt = conn.prepareStatement(sql);
         psmt.setString(1, pds.getId());
         psmt.setString(2, pds.getCategory());
         psmt.setString(3, tagStr);
         psmt.setString(4, pds.getFileName());
         psmt.setString(5, pds.getfSaveName());
         
         System.out.println("2/6 writePds Success");
         
         count = psmt.executeUpdate();
         System.out.println("3/6 writePds Success");
         
      } catch (Exception e) {
         System.out.println("writePds Fail");
         e.printStackTrace();
      } finally {
         DBClose.close(psmt, conn, null);         
      }      
      
      return count>0?true:false;
   }

   
   @Override
	public boolean delPDS(int seq) {
		int count=0;
		String sql=" DELETE FROM PICPDS  " +
				" WHERE  SEQ = ? " ;
		Connection conn=null;
		PreparedStatement psmt=null;
		
		try {
			conn=DBConnection.getConnection();
			System.out.println("2/6 S delPDS");
			psmt=conn.prepareStatement(sql);
			
			int i=1;
			psmt.setInt(i++, seq );
			System.out.println("3/6 S delPDS");
			
			count=psmt.executeUpdate();
			System.out.println("4/6 S delPDS");
			
		} catch (Exception e) {
			System.out.println("F delPDS");
		}finally{
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
=======
	public PdsManager() {
		DBConnection.initConnection();
>>>>>>> branch 'JAEWOO' of https://github.com/gqpibd/SharePix.git
	}

	@Override
	public PdsBean getMyPdsAll(String id) {

		String sql = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, "
				+ " READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT " + " FROM PDSALL " + " WHERE ID=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		PdsBean dto = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getMyPdsAll success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);

			rs = psmt.executeQuery();
			System.out.println("2/6 getMyPdsAll success");

			if (rs.next()) {

				String[] tag = rs.getString(4).substring(1).split("#");

				dto = new PdsBean(rs.getInt(1), // seq
						rs.getString(2), // id
						rs.getString(3), // CATEGORY
						tag, rs.getString(5), // uploaddate
						rs.getString(6), // filename
						rs.getInt(7), // readcount
						rs.getInt(8), // downcount
						rs.getInt(10), // likeCount
						rs.getInt(11), // replyCount
						rs.getString(9)); // fileSaveName

				System.out.println("getMyPdsAll 로부터 나오는 dto " + dto.toString());
			}
			System.out.println("3/6 getMyPdsAll success");

		} catch (SQLException e) {
			System.out.println("getMyPdsAll fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}

		return dto;
	}

	// YH -> 검색 기능 : ID 와 TAG검색
	@Override
	public List<PdsBean> getSearchPds(String keyword) {
		String sql = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
				+ " FROM PDSALL " + " WHERE (CATEGORY LIKE ? OR TAGS LIKE ?) ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<PdsBean> list = new ArrayList<PdsBean>(); // 결과를 저장할 목록

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getPdsDetail Success");

			psmt = conn.prepareStatement(sql);

			psmt.setString(1, "%" + keyword + "%");
			psmt.setString(2, "%" + keyword + "%");

			System.out.println("2/6 getPdsDetail Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getPdsDetail Success");

			while (rs.next()) {
				String regdate = rs.getString("UPLOADDATE");
				regdate = regdate.substring(0, regdate.lastIndexOf('.'));
				// SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGDATE
				PdsBean pds = new PdsBean(rs.getInt("SEQ"), rs.getString("ID"), rs.getString("CATEGORY"),
						rs.getString("TAGS").substring(1).split("#"), regdate, rs.getString("FILENAME"),
						rs.getInt("READCOUNT"), rs.getInt("DOWNCOUNT"), rs.getInt("LIKECOUNT"), rs.getInt("REPLYCOUNT"),
						rs.getString("FSAVENAME"));
				list.add(pds);
			}
			System.out.println("4/6 getPdsDetail Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getPdsDetail Fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}

	@Override
	public PdsBean getPdsDetail(int seq) {
		// SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT,
		// FSAVENAME, LIKECOUNT, REPLYCOUNT
		String sql = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
				+ " FROM PDSALL " + " WHERE SEQ = ? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		PdsBean pds = null; // 결과를 저장할 목록

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getPdsDetail Success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getPdsDetail Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getPdsDetail Success");

			if (rs.next()) {
				String regdate = rs.getString("UPLOADDATE");
				regdate = regdate.substring(0, regdate.lastIndexOf('.'));
				// SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGDATE
				pds = new PdsBean(rs.getInt("SEQ"), rs.getString("ID"), rs.getString("CATEGORY"),
						rs.getString("TAGS").substring(1).split("#"), regdate, rs.getString("FILENAME"),
						rs.getInt("READCOUNT"), rs.getInt("DOWNCOUNT"), rs.getInt("LIKECOUNT"), rs.getInt("REPLYCOUNT"),
						rs.getString("FSAVENAME"));
			}
			System.out.println("4/6 getPdsDetail Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getPdsDetail Fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return pds;
	}

	@Override
	public boolean checkPdsLike(String id, int pdsSeq) {
		String sql = " SELECT * " + " FROM PDSLIKE " + " WHERE PDSSEQ = ? AND ID = ?";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 checkPdsLike Success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, pdsSeq);
			psmt.setString(2, id);
			System.out.println("2/6 checkPdsLike Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 checkPdsLike Success");

			if (rs.next()) {
				System.out.println("있음");
				return true;
			}
			System.out.println("없음");
			System.out.println("4/6 checkPdsLike Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("checkPdsLike Fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return false;
	}

	@Override
	public boolean chageLike(String id, int pdsSeq, boolean isLike) {
		String sql = "";
		if (isLike) { // 좋아요를 누르면 row 추가
			sql = " INSERT INTO PDSLIKE " + " VALUES (?, ?) ";
		} else {
			sql = " DELETE FROM PDSLIKE " + " WHERE PDSSEQ = ? AND ID = ? ";
		}

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 chageLike Success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, pdsSeq);
			psmt.setString(2, id);
			System.out.println("2/6 chageLike Success");

			count = psmt.executeUpdate();
			System.out.println("3/6 chageLike Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("chageLike Fail");
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count > 0 ? true : false;
	}

	@Override
	public int getLikeCount(int pdsSeq) {
		String sql = " SELECT count(*) " + " FROM PDSLIKE " + " WHERE PDSSEQ = ? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getLikeCount Success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, pdsSeq);
			System.out.println("2/6 getLikeCount Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getLikeCount Success");

			if (rs.next()) {
				count = rs.getInt(1);
			}
			System.out.println("4/6 getLikeCount Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getLikeCount Fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return count;

	}

	@Override
	public List<PdsBean> getMyPdsAllList(String id) {// 아이디에 해당하는 것들 list로 뽑아오기

		List<PdsBean> list = new ArrayList<>();

		String sql = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, "
				+ " READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT " + " FROM PDSALL " + " WHERE ID=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		PdsBean dto = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getMyPdsAllList success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);

			rs = psmt.executeQuery();
			System.out.println("2/6 getMyPdsAllList success");

			while (rs.next()) {

				String[] tag = rs.getString(4).substring(1).split("#");

				dto = new PdsBean(rs.getInt(1), // seq
						rs.getString(2), // id
						rs.getString(3), // CATEGORY
						tag, rs.getString(5), // uploaddate
						rs.getString(6), // filename
						rs.getInt(7), // readcount
						rs.getInt(8), // downcount
						rs.getInt(10), // likeCount
						rs.getInt(11), // replyCount
						rs.getString(9)); // fileSaveName

				list.add(dto);

			}

			System.out.println("3/6 getMyPdsAllList success");

		} catch (SQLException e) {
			System.out.println("getMyPdsAllList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}

		return list;
	}

	// 빈문자였을경우
	@Override
	public List<PdsBean> getSearchPdsNull() {
		String sql = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
				+ " FROM PDSALL ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<PdsBean> list = new ArrayList<PdsBean>(); // 결과를 저장할 목록

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getPdsDetail Success");

			psmt = conn.prepareStatement(sql);

			System.out.println("2/6 getPdsDetail Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getPdsDetail Success");

			while (rs.next()) {
				String regdate = rs.getString("UPLOADDATE");
				regdate = regdate.substring(0, regdate.lastIndexOf('.'));
				// SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGDATE
				PdsBean pds = new PdsBean(rs.getInt("SEQ"), rs.getString("ID"), rs.getString("CATEGORY"),
						rs.getString("TAGS").substring(1).split("#"), regdate, rs.getString("FILENAME"),
						rs.getInt("READCOUNT"), rs.getInt("DOWNCOUNT"), rs.getInt("LIKECOUNT"), rs.getInt("REPLYCOUNT"),
						rs.getString("FSAVENAME"));
				list.add(pds);
			}
			System.out.println("4/6 getPdsDetail Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getPdsDetail Fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}

	@Override
	public List<PdsBean> getPdsPagingList(PagingBean paging, String keyword) {

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<PdsBean> pdslist = new ArrayList<>();

		String kWord = "";

		kWord = " WHERE (TAGS LIKE '%" + keyword + "%' OR CATEGORY LIKE '%" + kWord + "%')";

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6");

			String totalSql = " SELECT COUNT(SEQ) " + " FROM PDSALL " + kWord;

			psmt = conn.prepareStatement(totalSql);
			rs = psmt.executeQuery();

			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1); // row의 총갯수
			paging.setTotalCount(totalCount);
			paging = pagingUtil.setPagingInfo(paging);

			psmt.close();
			rs.close();

			String sql = " SELECT * FROM " + " ( SELECT * FROM " + "   (SELECT * FROM PDSALL " + " " + kWord + " )"
					+ " WHERE ROWNUM <=" + paging.getStartNum() + ")" + " WHERE ROWNUM <=" + paging.getCountPerPage();

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getBbsPagingList Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getBbsPagingList Success");

			while (rs.next()) {
				String regdate = rs.getString("UPLOADDATE");
				regdate = regdate.substring(0, regdate.lastIndexOf('.'));
				PdsBean pds = new PdsBean(rs.getInt(1), rs.getString(2), rs.getString(3),
						rs.getString(4).substring(1).split("#"), regdate, rs.getString(6), rs.getInt(7), rs.getInt(8),
						rs.getInt(9), rs.getInt(10), rs.getString(11));
				pdslist.add(pds);
			}
			System.out.println("4/6 getBbsPagingList Success");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}

		return pdslist;

	}

	@Override
	public boolean writePds(PdsBean pds) {

		String sql = " INSERT INTO PICPDS( "
				+ " SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME) "
				+ " VALUES(PICPDS_SEQ.NEXTVAL, ?,?,?,SYSDATE,?,0,0,?) ";

		String tagStr = "";

		for (int i = 0; i < pds.getTags().length; i++) {
			tagStr += "#" + pds.getTags()[i];
		}

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 writePds Success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, pds.getId());
			psmt.setString(2, pds.getCategory());
			psmt.setString(3, tagStr);
			psmt.setString(4, pds.getFileName());
			psmt.setString(5, pds.getfSaveName());

			System.out.println("2/6 writePds Success");

			count = psmt.executeUpdate();
			System.out.println("3/6 writePds Success");

		} catch (Exception e) {
			System.out.println("writePds Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}

		return count > 0 ? true : false;
	}

	@Override
	public boolean delPDS(int seq) {
		int count = 0;
		String sql = " DELETE FROM PICPDS  " + " WHERE  SEQ = ? ";
		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("2/6 S delPDS");
			psmt = conn.prepareStatement(sql);

			int i = 1;
			psmt.setInt(i++, seq);
			System.out.println("3/6 S delPDS");

			count = psmt.executeUpdate();
			System.out.println("4/6 S delPDS");

		} catch (Exception e) {
			System.out.println("F delPDS");
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count > 0 ? true : false;
	}

	@Override
	public boolean updatePDS(PdsBean pds) {

		System.out.println(pds.toString());

		String sql = " UPDATE PICPDS " + " SET CATEGORY=?, TAGS=?" + " WHERE SEQ=? ";
		String tagStr = "";

		for (int i = 0; i < pds.getTags().length; i++) {
			tagStr += "#" + pds.getTags()[i];
		}

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/6 updatePDS Success");
			psmt.setString(1, pds.getCategory().trim());
			psmt.setString(2, tagStr);
			psmt.setInt(3, pds.getSeq());
			System.out.println("2/6 updatePDS Success");
			count = psmt.executeUpdate();
			System.out.println("3/6 updatePDS Success");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}

		return count > 0 ? true : false;
	}


	@Override
	public boolean increaseDowncount(int pdsSeq) {
		String sql = " UPDATE PICPDS " + " SET DOWNCOUNT = DOWNCOUNT+1 " + " WHERE SEQ = ? ";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 increaseDowncount Success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, pdsSeq);
			System.out.println("2/6 increaseDowncount Success");

			count = psmt.executeUpdate();
			System.out.println("3/6 increaseDowncount Success");

		} catch (SQLException e) {
			System.out.println("increaseDowncount Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count > 0 ? true : false;
	}

	@Override
	public List<PdsBean> myLikePdsList(String id) {
		String sql = " SELECT P.SEQ, P.ID, P.CATEGORY, P.TAGS, P.UPLOADDATE, P.FILENAME, P.READCOUNT, P.DOWNCOUNT, P.FSAVENAME, P.LIKECOUNT, P.REPLYCOUNT "
				+ " FROM PDSALL P, PDSLIKE " + " WHERE P.SEQ = PDSLIKE.PDSSEQ AND PDSLIKE.ID = ? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

<<<<<<< HEAD
	@Override
	public boolean increaseReadcount(int seq) {
			String sql = " UPDATE PICPDS " 
					   + " SET READCOUNT = READCOUNT + 1 " 
					   + " WHERE SEQ = ? ";
	
			Connection conn = null;
			PreparedStatement psmt = null;
	
			int count = 0;
	
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/6 increaseReadcount Success");
	
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, seq);
				System.out.println("2/6 increaseReadcount Success");
	
				count = psmt.executeUpdate();
				System.out.println("3/6 increaseReadcount Success");
	
			} catch (SQLException e) {
				System.out.println("increaseReadcount Fail");
				e.printStackTrace();
			} finally {
				DBClose.close(psmt, conn, null);
			}
			return count > 0 ? true : false;		
	}  
}
=======
		List<PdsBean> list = new ArrayList<>(); // 검색 결과를 저장할 목록

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 myLikePdsList Success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/6 myLikePdsList Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 myLikePdsList Success");

			while (rs.next()) {
				String regdate = rs.getString("UPLOADDATE");
				regdate = regdate.substring(0, regdate.lastIndexOf('.'));

				// SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT,
				// FSAVENAME, LIKECOUNT, REPLYCOUNT
				PdsBean bean = new PdsBean(rs.getInt("SEQ"), rs.getString("ID"), rs.getString("CATEGORY"),
						rs.getString("TAGS").substring(1).split("#"), regdate, rs.getString("FILENAME"),
						rs.getInt("READCOUNT"), rs.getInt("DOWNCOUNT"), rs.getInt("LIKECOUNT"), rs.getInt("REPLYCOUNT"),
						rs.getString("FSAVENAME"));
				list.add(bean);
			}
			System.out.println("4/6 myLikePdsList Success");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}

	@Override
	public List<PdsBean> relatedList(String category) {
		/*
		 * String sql =
		 * " SELECT RNUM, SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
		 * + " FROM ( " +
		 * " SELECT ROWNUM as rnum, SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
		 * + " FROM " +
		 * " (SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
		 * + " FROM PDSALL "+ " WHERE CATEGORY = ? " + " ORDER BY UPLOADDATE DESC) " +
		 * " ) " + " WHERE RNUM>=1 AND RNUM <=6 ";
		 */
		String sql = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
				+ " FROM PDSALL " + " WHERE CATEGORY = ? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<PdsBean> list = new ArrayList<>(); // 검색 결과를 저장할 목록

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 relatedList Success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, category);
			System.out.println("2/6 relatedList Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 relatedList Success");

			while (rs.next()) {
				String regdate = rs.getString("UPLOADDATE");
				regdate = regdate.substring(0, regdate.lastIndexOf('.'));

				// SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT,
				// FSAVENAME, LIKECOUNT, REPLYCOUNT
				PdsBean bean = new PdsBean(rs.getInt("SEQ"), rs.getString("ID"), rs.getString("CATEGORY"),
						rs.getString("TAGS").substring(1).split("#"), regdate, rs.getString("FILENAME"),
						rs.getInt("READCOUNT"), rs.getInt("DOWNCOUNT"), rs.getInt("LIKECOUNT"), rs.getInt("REPLYCOUNT"),
						rs.getString("FSAVENAME"));
				list.add(bean);
			}
			System.out.println("4/6 relatedList Success");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}

	@Override
	public List<PdsBean> getMyLikeList(String id) { // 내가 좋아요한 리스트
		String sql = " SELECT DISTINCT P.SEQ, P.ID, P.CATEGORY, P.TAGS, P.UPLOADDATE, P.FILENAME, P.READCOUNT, P.DOWNCOUNT, P.FSAVENAME "
				+ " FROM PICPDS P, (SELECT * FROM PDSLIKE WHERE ID=?) L " + " WHERE P.SEQ = L.PDSSEQ ";

		List<PdsBean> list = new ArrayList<>();

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getMyLikeList Success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);

			rs = psmt.executeQuery();
			System.out.println("2/6 getMyLikeList Success");

			while (rs.next()) {
				String regdate = rs.getString("UPLOADDATE");
				regdate = regdate.substring(0, regdate.lastIndexOf('.'));

				// SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT,
				// FSAVENAME, LIKECOUNT, REPLYCOUNT
				PdsBean bean = new PdsBean(rs.getInt("SEQ"), rs.getString("ID"), rs.getString("CATEGORY"),
						rs.getString("TAGS").substring(1).split("#"), regdate, rs.getString("FILENAME"),
						rs.getInt("READCOUNT"), rs.getInt("DOWNCOUNT"), 0, // LIKECOUNT
						0, // REPLYCOUNT
						rs.getString("FSAVENAME"));
				list.add(bean);
			}
			System.out.println("3/6 getMyLikeList Success");
		} catch (SQLException e) {
			System.out.println("getMyLikeList Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}

		return list;
	}

	@Override
	public boolean increaseReadcount(int seq) {
		String sql = " UPDATE PICPDS " + " SET READCOUNT = READCOUNT + 1 " + " WHERE SEQ = ? ";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 increaseReadcount Success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 increaseReadcount Success");

			count = psmt.executeUpdate();
			System.out.println("3/6 increaseReadcount Success");

		} catch (SQLException e) {
			System.out.println("increaseReadcount Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count > 0 ? true : false;
	}
}
>>>>>>> branch 'JAEWOO' of https://github.com/gqpibd/SharePix.git
