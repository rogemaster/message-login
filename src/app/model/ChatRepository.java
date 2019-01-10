package app.model;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ChatRepository {

	@Autowired
	MongoTemplate template;
	
	public List<Map>getAllChat() {
		List<Map> list  = template.findAll(Map.class, "chat");
		return list;
	}
	
	public List<Map>getAllDepChat() {
		List<Map> list = template.findAll(Map.class, "depchat");
		return list;
	}
}
