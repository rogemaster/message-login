package app.controller.home;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;

import app.model.EmplyoeeRepository;
import app.service.AlertService;

@Controller
public class LoginController {
	Map<String, HttpSession> sessions;
	
	public LoginController() {
		sessions = new HashMap<>();
	}
	
	@Autowired
	EmplyoeeRepository emplyoeeRepository;
	
	@Autowired
	AlertService service;
	
	
	@RequestMapping("/index.do")
	public String indexHandler(WebRequest wr) {
		if(wr.getAttribute("auth", wr.SCOPE_SESSION) == null) {
			return "index";
		}else {
			return "home.index";
		}
	}
	
	@PostMapping("/login.do")
	public String getEmployeeInfo(@RequestParam Map param, ModelMap map, WebRequest wr, HttpSession session) {
		String id = (String)param.get("id");
		String pass = (String)param.get("pass");
			
		Map user = emplyoeeRepository.getEmployeeInfo(id);
		if(user != null && user.get("PASS").equals(pass)) {
			// 중복 로그인 막기===================================
			if(sessions.containsKey(id)) {
				sessions.get(id).invalidate();
				Map msg = new HashMap<>();
					msg.put("mode", "duplicate");
				service.sendOne(msg, id);
			}
			sessions.put(id, session);
		//======================================================================
			
			wr.setAttribute("auth", true, wr.SCOPE_SESSION);
			wr.setAttribute("user", user, wr.SCOPE_SESSION);
			wr.setAttribute("userId", id, wr.SCOPE_SESSION);
			// 로그인 알림===================================
			Map msg = new HashMap();
				msg.put("mode", "login");
				msg.put("actor", user);
			service.sendAll(msg);
			
			return "redirect:/index.do";
			
		}else {
			return "index";
		}
	}
	
	@RequestMapping("/logout.do")
	public String LogoutHandler(HttpSession session) {
		String userId = (String)session.getAttribute("userId");
		sessions.remove(userId);
		session.invalidate();
		return "redirect:/index.do";
	}

}
