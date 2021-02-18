package com.kosmo.veve.board.recipe;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONArray;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kosmo.veve.model.service.MemoCommentService;

@SessionAttributes({"userID"})
@Controller
@RequestMapping("/RecipeBBS/Comment/")
public class CommentController {
	
	@Resource(name="commentService")
	private MemoCommentService commentService;
	
	@RequestMapping(value="write.do",produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String write(
			@RequestParam Map map) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		map.put("userID", auth.getName());
		commentService.insert(map);
		return map.get("rec_no").toString();
	}/////////////////
	
	
	
	@ResponseBody
	@RequestMapping(value="list.do",produces = "text/html; charset=UTF-8")
	public String list(@RequestParam Map map) {
		/*
		String [] jsonStr = map.keySet().toString().split("\"");
		
		for(int i=0;i<jsonStr.length;i++) {
			System.out.println(jsonStr[i]);
		}
		Map transMap = new HashMap();
		transMap.put(jsonStr[1], jsonStr[3]);
		System.out.println(transMap);
		*/
		System.out.println(map);
		
		List<Map> list = commentService.selectList(map);
		//System.out.println(JSONArray.toJSONString(list));
		//시간 제거
		for(Map comment:list)
			comment.put("POSTDATE", comment.get("POSTDATE").toString().substring(0,10));
		//signdate json 유효형식으로 바꾸기
		for(Map oneData:list)
			oneData.put("SIGNDATE", oneData.get("SIGNDATE").toString().substring(0,10));
		
		
		System.out.println(JSONArray.toJSONString(list));
		//JSONObject jsonObj = new JSONObject();
		return JSONArray.toJSONString(list);
	}////////////
	
	
	
	
	
	@ResponseBody
	@RequestMapping(value="edit.do",produces = "text/html; charset=UTF-8")
	public String update(@RequestParam Map map) {
		commentService.update(map);
		return String.format("%s : %s",map.get("rec_no").toString(),map.get("rec_com_no").toString());
		
	}
	@ResponseBody
	@RequestMapping(value="delete.do",produces = "text/html; charset=UTF-8")
	public String delete(@RequestParam Map map) {
		commentService.delete(map);
		return String.format("%s",map.get("rec_com_no").toString());
		
	}
	
}///////////////
