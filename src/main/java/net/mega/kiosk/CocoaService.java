package net.mega.kiosk;

import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import net.mega.entities.CocoaReady;

@Service
public class CocoaService {
	
	public CocoaReady cocoaPay(Map<String, Object> params) {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "KakaoAK 823b2e11c0729e1d043d79082dda9dbb");
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		//partner_order_id == payment unique id
		
		MultiValueMap<String, Object> payParams = new LinkedMultiValueMap<String, Object>();
		payParams.add("cid", "TC0ONETIME");
		payParams.add("partner_order_id", "CocoaPavement01");
		payParams.add("partner_user_id", "CocoaTaster");
		payParams.add("item_name", params.get("item_name"));
		payParams.add("quantity", params.get("quantity"));
		payParams.add("total_amount", params.get("total_amount"));
		payParams.add("tax_free_amount", params.get("tax_free_amount"));
		payParams.add("approval_url", "http://localhost:8083/kiosk/temp");
		payParams.add("cancel_url", "http://localhost:8083/kiosk/temp");
		payParams.add("fail_url", "http://localhost:8083/kiosk/temp");
		System.out.println(headers.get("Content-Type"));
		// make request to the ready api
		HttpEntity<MultiValueMap<String, Object>> request = new HttpEntity<MultiValueMap<String, Object>>(payParams, headers);
		
		RestTemplate template = new RestTemplate();
		
		String endPoint = "https://kapi.kakao.com/v1/payment/ready";
		
		//result
		CocoaReady rsps = template.postForObject(endPoint, request, CocoaReady.class);
		// refer to https://lims-dev.tistory.com/33 for further instructions
		return rsps;
	}
}
