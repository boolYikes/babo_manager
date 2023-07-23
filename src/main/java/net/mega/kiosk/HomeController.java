package net.mega.kiosk;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.mega.entities.Manager;
import net.mega.entities.Menu;
import net.mega.entities.MenuQuery;
import net.mega.entities.Preference;
import net.mega.mapper.BaboMapper;

@Controller
public class HomeController {
	
	@Autowired
	BaboMapper mapper;
	
	// 로긘
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		System.out.println("YOUR HELL IS PAVED WITH GOOD INTENTIONS!");
		
		return "signin";
	}
	
	@RequestMapping(value="/admin")
	public String signIn(Manager info, Model model) {
		//ArrayList<Object> storeInfo = new ArrayList<Object>();
		model.addAttribute("menus", mapper.getMenus());
		model.addAttribute("categories", mapper.getCategories());
		model.addAttribute("options", mapper.getOptions());
		model.addAttribute("orders", mapper.getOrders());
		return "admin"; //log on
	}
	@RequestMapping(value="/errandBoy")
	public String toCoco() {
		return "tempResponse";
	}
	
	@RequestMapping("/delete")
	public String delCorrespMenu(MenuQuery menu) {
		
		mapper.delCorrespMenu(menu);
		
		return "redirect:/admin";
	}
	@RequestMapping("/addOrSet")
	public String insertOrUpdate(MenuQuery menu) {
		Menu checkExisting = mapper.getOneMenu(menu.getMenu_name());
		if(checkExisting!=null) {
			mapper.updateMenu(checkExisting.getMenu_seq(), menu);
		}else {
			mapper.insertMenu(menu);
		}
		
		return "redirect:/admin";
	}
}
