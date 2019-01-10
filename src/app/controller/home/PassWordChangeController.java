package app.controller.home;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;

import app.model.EmplyoeeRepository;

@Controller
public class PassWordChangeController {
	
	@Autowired
	EmplyoeeRepository emplyoeeRepository;
	
	@RequestMapping("/password_change.do")
	public String changeHandler(WebRequest wr) {
		if(wr.getAttribute("change", wr.SCOPE_SESSION) == null) {
			return "home/pw_change";
		}else {
			return "home.index";
		}
	}

	@RequestMapping("/change.do")
	public String updatePassWord(@RequestParam Map param, WebRequest wr, ModelMap map) {
		String originpass = (String)param.get("originpass");
		Map user = (Map)wr.getAttribute("user", wr.SCOPE_SESSION);
		String pass = (String)user.get("PASS");
		
		if(originpass.equals(pass)) {
			Map data = new HashMap<>();
				data.put("id", wr.getAttribute("userId", wr.SCOPE_SESSION));
				data.put("pass", param.get("newpass"));
			int r = emplyoeeRepository.updatePassWord(data);
			wr.setAttribute("change", true, wr.SCOPE_SESSION);
			return "redirect:/password_change.do";
			
		}else {
			map.put("err", "on");
			return "home/pw_change";
		}
		
	}
}
