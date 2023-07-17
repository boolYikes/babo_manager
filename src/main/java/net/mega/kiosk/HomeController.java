package net.mega.kiosk;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.mega.entities.Category;
import net.mega.entities.Manager;
import net.mega.entities.Menu;
import net.mega.entities.Options;
import net.mega.mapper.BaboMapper;

@Controller
public class HomeController {
	
	@Autowired
	BaboMapper mapper;
	
	// 로긘
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		System.out.println("YOUR HELL IS PAVED WITH GOOD INTENTIONS!");
		
		return "signin";
	}
	
	@RequestMapping(value="/admin")
	public String signIn(Manager info, Model model) {
		
		if(mapper.getManager(info) == null) {
			return "redirect:/signin";//redirect to login
		}else {
			Menu = mapper.getMenus();
			Category = mapper.getCategories();
			Options = mapper.getOptions();
			return "admin"; //log on
		}
	}
}
