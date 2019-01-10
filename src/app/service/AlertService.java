package app.service;

import java.io.IOException;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import com.google.gson.Gson;

@Service
public class AlertService {
	public List<WebSocketSession> list;
	
	@Autowired
	Gson gson;
	
	public AlertService() {
		list = new ArrayList<>();
	}
	
	public List<WebSocketSession> allList() {
		return list;
	}
	
	public int size() {
		return list.size();
	}
	
	public boolean addSocket(WebSocketSession target) {
		return list.add(target);
	}
	
	public boolean removeSocket(WebSocketSession target) {
		return list.remove(target);
	}
	
	public void sendAll(String txt) {		// 전체 메세지 전송
		TextMessage msg = new TextMessage(txt);
		for(int i = 0; i < list.size(); i++) {
			try {
				list.get(i).sendMessage(msg);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	public void sendAll(Map map) {
		sendAll(gson.toJson(map));
	}
	
	public void sendOne(String txt, String target) {		// 특정 사람에게 메세지 전송
		TextMessage msg = new TextMessage(txt);
		for(int i = 0; i < list.size(); i++) {
			try {
				WebSocketSession ws = list.get(i);
				String userId = (String)ws.getAttributes().get("userId");
				// ws.getAttributes() == httpsession 의 Attributes 들
				if(userId.equals(target)) {
					ws.sendMessage(msg);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	public void sendOne(Map map, String target) {
		sendOne(gson.toJson(map), target);
	}
	
	public void sendIncludeGroup(String txt, String... targets) {
		sendIncludeGroup(txt, Arrays.asList(targets));
	}
	
	public void sendIncludeGroup(String txt,  List<String> group) {
		TextMessage msg = new TextMessage(txt);
		for (int i = 0; i < list.size(); i++) {
			try {
				WebSocketSession ws =list.get(i);
				String userId = (String) ws.getAttributes().get("userId");
				if(group.contains(userId)) {
					ws.sendMessage(msg);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void sendExcludeGroup(String txt, String... targets) {
		sendExcludeGroup(txt, Arrays.asList(targets));
	}
	
	public void sendExcludeGroup(String txt, List<String> group) {
		TextMessage msg = new TextMessage(txt);
		for (int i = 0; i < list.size(); i++) {
			try {
				WebSocketSession ws =list.get(i);
				String userId = (String) ws.getAttributes().get("userId");
				// ws.getAttribute()  == HttpSession의 attribute 들
				if(!group.contains(userId)) {
					ws.sendMessage(msg);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	

	
}
