package app.controller.socket;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import app.service.AlertService;

@Controller
public class DepChatSocket extends TextWebSocketHandler {
	List<WebSocketSession> sockets = new ArrayList<>();
	
	@Autowired
	MongoTemplate mongoTemplate;
	
	@Autowired
	Gson gson;
	
	@Autowired
	AlertService service;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sockets.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		Map d = (Map)session.getAttributes().get("user");
		String dep = (String)d.get("DNAME");
		String getPayload = message.getPayload();
		
		Map gmap = gson.fromJson(getPayload, Map.class);
			gmap.put("user", session.getAttributes().get("user"));
			gmap.put("dname", dep);
		mongoTemplate.insert(gmap, "depchat");
		
		TextMessage tmt = new TextMessage(gson.toJson(gmap));
		for(int i = 0; i < sockets.size(); i++) {
			try {
				WebSocketSession ws = sockets.get(i);
				Map data1 = (Map)ws.getAttributes().get("user");
				String sdep = (String)data1.get("DNAME");
				Map data2 = (Map)gmap.get("user");
				String udep = (String)data2.get("DNAME");
				if(sdep.equals(udep)) {
					ws.sendMessage(tmt);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		List<String> current = new ArrayList<>();
		for(int i = 0; i < sockets.size(); i++) {
			WebSocketSession ws = sockets.get(i);
			String userId = (String)ws.getAttributes().get("userId");
			current.add(userId);
		}
		String txt = "{\"mode\":\"deptalk\"}";
		service.sendExcludeGroup(txt, current);
		
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sockets.remove(session);
	}
}
