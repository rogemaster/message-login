package app.controller.home;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import app.model.ChatRepository;
import app.service.AlertService;

@Controller
@RequestMapping("/depchat")
public class DepChatController {
	
	@Autowired
	MongoTemplate mongoTemplate;
	
	@Autowired
	ChatRepository chatRepository;

	@RequestMapping("/room.do")
	public String chatHandler(ModelMap data, WebRequest wr) {
		Map map = (Map)wr.getAttribute("user", wr.SCOPE_SESSION);
		String dep = (String)map.get("DNAME");
		List<Map> list = chatRepository.getAllDepChat();
		
		List<Map> deplist = new ArrayList<Map>();
		for(int i = 0; i < list.size(); i++) {
			if(dep.equals(list.get(i).get("dname"))) {
				deplist.add((Map)list.get(i));
			}
			data.put("depchatlist", deplist);
		}
		return "home.depchat";
	}
}
