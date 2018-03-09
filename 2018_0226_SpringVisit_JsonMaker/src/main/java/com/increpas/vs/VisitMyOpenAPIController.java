package com.increpas.vs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.VisitDao;
import mycommon.MyCommon;
import vo.VisitVo;

@Controller
public class VisitMyOpenAPIController {

	
	VisitDao visit_dao;

	//setter injection
	public void setVisit_dao(VisitDao visit_dao) {
		this.visit_dao = visit_dao;
	}
	
	
	//방명록 목록보기
	@RequestMapping("/myopenapi/visit/list.do")
	@ResponseBody
	public List list(String search,String search_text) {
		
		//검색조건 VO포장
		VisitVo  vo = new VisitVo();
		if(search!=null) {
			if(search.equals("name_content")) {
				vo.setName(search_text);
				vo.setContent(search_text);
			}else if(search.equals("name")) {
				vo.setName(search_text);
			}else if(search.equals("content")) {
				vo.setContent(search_text);
			}
		}
		
		//방명록목록 가져오기
		List<VisitVo> list = visit_dao.selectList(vo);
				
		return list;
	}
	
	
	//글쓰기
	@RequestMapping("/myopenapi/visit/insert.do")
	@ResponseBody
	public Map insert(VisitVo vo,HttpServletRequest request) {
		
		//ip구하기
		String ip = request.getRemoteAddr();
		//content내용중 \n => <br>
		String content = vo.getContent().replaceAll("\n", "<br>");
		vo.setContent(content);
		vo.setIp(ip);
		//DB Insert
		int res = visit_dao.insert(vo);
		
		String result = "fail";
		if(res!=0)
			result = "success";
		
		Map map = new HashMap();
		map.put("result", result);
				
		return map;
	}
	
	//비밀번호체크하기 : check_pwd.do?idx=12&c_pwd=1234
	@RequestMapping("/myopenapi/visit/check_pwd.do")
	@ResponseBody  // return값을 뷰로사용하지 말고 
                   // 바로 요청클라이언트에세 응답해라
	public Map check_pwd(int idx,String c_pwd) {
		//idx에 해당되는 vo
		VisitVo vo = visit_dao.selectOne(idx);
		
		String result = "diff";
		if(vo.getPwd().equals(c_pwd))//같냐?
			result = "same";
		
		Map map = new HashMap(); 
		map.put("result", result);
		return map;
	}
	
	
	@RequestMapping("/myopenapi/visit/delete.do")
	@ResponseBody
	public Map delete(int idx) {
		
		int res = visit_dao.delete(idx);
		
		Map map = new HashMap();
		
		String result = "fail";
		if(res!=0)
			result="success";
		
		map.put("result", result);
			
		
		return map;
	}
	
	
	@RequestMapping("/myopenapi/visit/modify.do")
	public String modify(VisitVo vo,HttpServletRequest request) {
		
		//\n => <br>변경
		String content = vo.getContent().replaceAll("\n", "<br>");
		vo.setContent(content);
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		
		int res = visit_dao.update(vo);
		
		return "redirect:list.do";
	}
	
	
	
	
	
	
	
	
}
