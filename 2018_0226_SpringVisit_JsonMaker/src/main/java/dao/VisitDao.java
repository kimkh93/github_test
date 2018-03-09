package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import vo.VisitVo;

public class VisitDao {
	
	
	SqlSession sqlSession;
	
	// setter injection
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	//방명록 목록조회
	public List<VisitVo> selectList() {

		List<VisitVo> list = null;
				
		//2.작업수행(요청)
		list = sqlSession.selectList("visit_list");		
		
		return list;
	}

	//방명록 쓰기
	public int insert(VisitVo vo) {
		// TODO Auto-generated method stub
		int res = 0;
		
		//2.작업수행
		res = sqlSession.insert("visit_insert", vo);
		
		return res;
	}

	public int delete(int idx) {
		// TODO Auto-generated method stub
		int res = 0;

		//2.작업수행
		res = sqlSession.delete("visit_delete", idx);
		
		return res;
	}
	
	
	public int update(VisitVo vo) {
		// TODO Auto-generated method stub
		int res = 0;

		//2.작업수행
		res = sqlSession.update("visit_update", vo);
		
		return res;
	}

	
	
	public VisitVo selectOne(int idx) {

		VisitVo vo = null;
		
		//2.작업수행(요청)
		vo = sqlSession.selectOne("visit_one",idx);		
		
		return vo;
	}

	public List<VisitVo> selectList(VisitVo vo) {
		// TODO Auto-generated method stub
		List<VisitVo> list = null;
		
		//2.작업수행(요청)
		list = sqlSession.selectList("visit_list_condition",vo);		

		return list;
	}
	
}
