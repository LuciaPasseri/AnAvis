package progetto.anavis.api;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import progetto.anavis.service.ServiceSediAvis;


@Controller
public class ControllerSediAvis {

	ServiceSediAvis serviceSediAvis = ServiceSediAvis.getInstance();
	
	@GetMapping("/get")
	public List<String> getSedi(){
		return serviceSediAvis.getSedi();
	}
	
}
