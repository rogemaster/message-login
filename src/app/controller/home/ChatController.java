package app.controller.home;

import java.util.*;

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
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	MongoTemplate mongoTemplate;
	
	@Autowired
	ChatRepository chatRepository;

	@RequestMapping("/room.do")
	public String chatHandler(ModelMap data) {
		List<Map> list = chatRepository.getAllChat();
			data.put("chatlist", list);
		return "home.chat";
	}
	
}
