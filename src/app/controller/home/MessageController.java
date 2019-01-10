package app.controller.home;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import app.model.EmplyoeeRepository;
import app.service.AlertService;

@Controller
public class MessageController {
	
	@Autowired
	EmplyoeeRepository emplyoeeRepository;

	@Autowired
	Gson gson;
	
	@Autowired
	AlertService service;
	
	@RequestMapping("/message_box.do")
	public String getAllMessage(WebRequest wr, ModelMap map) {
		String receiver = (String)wr.getAttribute("userId", wr.SCOPE_SESSION);
		wr.setAttribute("notelist", emplyoeeRepository.getAllMessage(receiver), wr.SCOPE_SESSION);
		map.put("notelist", emplyoeeRepository.getAllMessage(receiver));
		return "message.box";
	}
	
	@GetMapping("/message_send.do")
	public String addSendGetHandler() {
		return "message.send";
	}
	
	@PostMapping("/message_send.do")
	public String addSendPostHandler(@RequestParam Map param, ModelMap map, WebRequest wr) {
		String code = UUID.randomUUID().toString().split("-")[0];
		String sender = (String)wr.getAttribute("userId", wr.SCOPE_SESSION);
			param.put("code", code);
			param.put("sender", sender);
		
		try {
			int r = emplyoeeRepository.addSendPostHandler(param);
			
			Map msg = new HashMap();
				msg.put("mode", "message");
				msg.put("element", param.get("sender"));
			String receiver = (String)param.get("receiver");
			service.sendOne(msg, receiver);
			return "redirect:/message_sendresult.do";
			
		//	return "message.sendresult";
			
		}catch(Exception e) {
			e.printStackTrace();
			map.put("err", "on");
			return "message.send";
		}
	}
//=========================================================================		
	@RequestMapping(path="/emplyoee_serch.do", produces="application/json;charset=UTF-8")
	@ResponseBody
	public String getEmployeeInfo(@RequestParam String id) {
		List<Map> userlist = emplyoeeRepository.getAllInfo(id);
		return gson.toJson(userlist);
	}
	
//=========================================================================
/*	
	@RequestMapping("/receivedate.do")
	public String updateReceivedate(WebRequest wr) {
		Map data = (Map)wr.getAttribute("notelist", wr.SCOPE_SESSION);
		String receivedate = data.get(key)
	}
*/
	
}
