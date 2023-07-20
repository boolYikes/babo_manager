package net.mega.kiosk;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;

import net.mega.entities.Category;
import net.mega.entities.Manager;
import net.mega.entities.Menu;
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
		
		if(mapper.getManager(info) == null) {
			return "redirect:/signin";//redirect to login
		}else {
			//ArrayList<Object> storeInfo = new ArrayList<Object>();
			model.addAttribute("menus", mapper.getMenus());
			model.addAttribute("categories", mapper.getCategories());
			model.addAttribute("options", mapper.getOptions());
			model.addAttribute("orders", mapper.getOrders());
			return "admin"; //log on
		}
	}
	
	@RequestMapping(value="/errandBoy", method=RequestMethod.GET)
	public String cocoaPay(Model model) {
		
		String admin_key = "KakaoAK 823b2e11c0729e1d043d79082dda9dbb";
        String js_key = "901a958dbc2fa6b6060fd827ffeed082";
        String rest_key = "1e7b847f50de173eea9989e08d21aabd";
        String native_key = "cbf7c822e98ef2915300120fa70e2b13";
        String apiUrl = "https://kapi.kakao.com/v1/payment/ready";
		
		RestTemplate restTemplate = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		// "application/x-www-form-urlencoded;charset=utf-8"
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		headers.set("Authorization", admin_key);
		
		MultiValueMap<String, String> payload = new LinkedMultiValueMap<>();
		payload.add("cid", "TC0ONETIME");
		payload.add("partner_order_id", "1234");
		payload.add("partner_user_id", "942356");
		payload.add("item_name", "바밤바");
		payload.add("quantity", "2000");
		payload.add("total_amount", "1000000");
		payload.add("tax_free_amount", "990000");
		payload.add("approval_url", "/tempResponse");
		payload.add("cancel_url", "/tempResponse");
		payload.add("fail_url", "/tempResponse");
	
		HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<>(payload, headers);
		
		String apiResponse = restTemplate.postForObject(apiUrl, httpEntity, String.class);
		
		model.addAttribute("apiResponse", apiResponse);
		
		return "tempResponse";
		
	}
}
