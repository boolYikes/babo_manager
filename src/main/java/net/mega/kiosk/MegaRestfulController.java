package net.mega.kiosk;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
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
import net.mega.entities.Menu;
import net.mega.entities.MenuQuery;
import net.mega.entities.Options;
import net.mega.entities.Orders;
import net.mega.entities.Preference;
import net.mega.mapper.BaboMapper;

@RestController
public class MegaRestfulController {
	
	@Autowired
	BaboMapper mapper;
	
	@RequestMapping("/sortByCat")
	public ArrayList<Menu> sortByCategories(String categoryName) {
		categoryName = categoryName.trim();
		Category cat = new Category();
		ArrayList<Menu> menus = new ArrayList<Menu>();
		if(categoryName.equals("all")) {
			menus = mapper.getMenus();
		}else {
			cat = mapper.getOneCategory(categoryName);
			menus = mapper.getCorrespMenus(cat);
		}
		
		return menus;
	}
	
	@RequestMapping("/getOneMenu")
	public Menu getOneMenu(String menu_seq) {
		
		Menu menu = mapper.getOneMenu(menu_seq); 
		
		return menu;
	}
	
	@RequestMapping("/getCorrespOtions")
	public Options getCorrespOtions(long menu_seq) {
		
		Options options = mapper.getCorrespOtions(menu_seq);
		
		return options;
	}
	@RequestMapping("/getCorrespOrders")
	public ArrayList<Orders> getCorrespOrders(int order_seq){
		
		ArrayList<Orders> orders = mapper.getCorrespOrders(order_seq);
		
		return orders;
	}
	@RequestMapping("/getPref")
	public ArrayList<Preference> getPreference(String menu_seq) {
		Menu tempMenu = mapper.getOneMenu(menu_seq);
		ArrayList<Preference> prefs = mapper.getPrefsByMenu(tempMenu);
		
		return prefs;
	}
	
	// FOR COCOA PAY TESTING
	@GetMapping("/pay")
	@ResponseBody
	public String cocoaPay() {
		try {
			URL endpoint = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection conn = (HttpURLConnection) endpoint.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "KakaoAK 823b2e11c0729e1d043d79082dda9dbb");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true);
			String payload = "cid=TC0ONETIME"
					+ "&partner_order_id=PARTNER_ORDER_ID"
					+ "&partner_user_id=PARTNER_USER_ID"
					+ "&item_name=머가리카노"
					+ "&quantity=99999"
					+ "&total_amount=9999"
					+ "&tax_free_amount=999"
					+ "&approval_url=http://www.localhost:8083/kiosk"
					+ "&fail_url=http://www.localhost:8083/kiosk/errandBoy"
					+ "&cancel_url=http://www.localhost:8083/kiosk/errandBoy";
			OutputStream stream = conn.getOutputStream();
			DataOutputStream pipe = new DataOutputStream(stream);
			pipe.writeBytes(payload);
			pipe.close();
			
			int result = conn.getResponseCode();
			InputStream receive;
			
			if(result == 200) {
				receive = conn.getInputStream();
			}else {
				receive = conn.getErrorStream();
			}
			
			InputStreamReader reader = new InputStreamReader(receive);
			BufferedReader byteReader = new BufferedReader(reader); // byte reader
			
			return byteReader.readLine();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	// FOR COCOA APPROVAL TESTING
		@GetMapping("/approve")
		@ResponseBody
		public String cocoaApprove() {
			try {
				URL endpoint = new URL("https://kapi.kakao.com/v1/payment/ready");
				HttpURLConnection conn = (HttpURLConnection) endpoint.openConnection();
				conn.setRequestMethod("POST");
				conn.setRequestProperty("Authorization", "KakaoAK 823b2e11c0729e1d043d79082dda9dbb");
				conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
				conn.setDoOutput(true);
				String payload = "cid=TC0ONETIME"
						+ "&partner_order_id=PARTNER_ORDER_ID"
						+ "&partner_user_id=PARTNER_USER_ID"
						+ "&item_name=머가리카노"
						+ "&quantity=9999"
						+ "&total_amount=9999999"
						+ "&tax_free_amount=99999"
						+ "&approval_url=http://www.localhost:8083/kiosk/errandBoy"
						+ "&fail_url=http://www.localhost:8083/kiosk/errandBoy"
						+ "&cancel_url=http://www.localhost:8083/kiosk/errandBoy";
				OutputStream stream = conn.getOutputStream();
				DataOutputStream pipe = new DataOutputStream(stream);
				pipe.writeBytes(payload);
				pipe.close();
				
				int result = conn.getResponseCode();
				InputStream receive;
				
				if(result == 200) {
					receive = conn.getInputStream();
				}else {
					receive = conn.getErrorStream();
				}
				
				InputStreamReader reader = new InputStreamReader(receive);
				BufferedReader byteReader = new BufferedReader(reader); // byte reader
				
				return byteReader.readLine();
			}catch(Exception e) {
				e.printStackTrace();
			}
			return "";
		}
}


