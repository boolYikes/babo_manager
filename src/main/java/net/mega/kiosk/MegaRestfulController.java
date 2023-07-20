package net.mega.kiosk;

import java.util.ArrayList;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import net.mega.entities.Category;
import net.mega.entities.CocoaReady;
import net.mega.entities.Menu;
import net.mega.entities.Options;
import net.mega.entities.Orders;
import net.mega.mapper.BaboMapper;

@RestController
public class MegaRestfulController {
	
	@Autowired
	BaboMapper mapper;
	
	@RequestMapping("/sortByCat")
	public ArrayList<Menu> sortByCategories(String categoryName) {
		categoryName = categoryName.trim();
		//System.out.println(categoryName);
		Category cat = mapper.getOneCategory(categoryName);
		//System.out.println(cat.getCategory_name());
		ArrayList<Menu> menus = mapper.getCorrespMenus(cat);
		//System.out.println(menus.get(0).getMenu_name());
		
		return menus;
	}
	
	@RequestMapping("/getOneMenu")
	public Menu getOneMenu(String menu_seq) {
		
		Menu menu = mapper.getOneMenu(menu_seq); 
		
		return menu;
	}
	
	@RequestMapping("/getCorrespOtions")
	public Options getCorrespOtions(String menu_seq) {
		
		Options options = mapper.getCorrespOtions(menu_seq);
		
		return options;
	}
	@RequestMapping("/getCorrespOrders")
	public ArrayList<Orders> getCorrespOrders(int order_seq){
		
		ArrayList<Orders> orders = mapper.getCorrespOrders(order_seq);
		
		return orders;
	}
	
	// FOR COCOA PAY TESTING
	@GetMapping("/pay")
	public @ResponseBody CocoaReady cocoaPay(@RequestParam Map<String, Object> params) {
		CocoaService cocoaService = new CocoaService();
		CocoaReady rsps = cocoaService.cocoaPay(params);
		//Logger log = LoggerFactory.getLogger(cocoaService.getClass());
		//log.info(rsps.toString());
		return rsps;
	}
}
