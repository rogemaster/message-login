package app.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class EmplyoeeRepository {

	@Autowired
	SqlSessionTemplate template;
	
	public List<Map> getAllDepartments() {
		return template.selectList("employee.getAllDepartments");
	}
	
	public List<Map> getAllPositions() {
		return template.selectList("employee.getAllPositions");
	}
	
	public String getNewEmployeeId() {
		return "em"+ template.selectOne("employee.getEmployeeSeq");
	}
	
	public int addEmployee(Map map) {
		return template.insert("employee.addEmployee", map);
	}
	
	public Map getEmployeeInfo(String id) {
		return template.selectOne("employee.getEmployeeInfo", id);
	}
	
	public int updatePassWord(Map param) {
		return template.update("employee.updatePassWord", param);
	}
	
	public List<Map> getAllMessage(String receiver) {
		return template.selectList("message.getAllMessage", receiver);
	}
	
	public int addSendPostHandler(Map param) {
		return template.insert("message.addSendPostHandler", param);
	}
	
	public List<Map> getAllInfo(String id) {
		return template.selectList("employee.getAllInfo", id+"%");
	}
}
