package progetto.anavis.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import progetto.anavis.model.SedeAvis;
import progetto.anavis.service.ServiceSediAvis;


@RestController
@RequestMapping("/sedi")
public class ControllerSediAvis {

	@Autowired
	ServiceSediAvis serviceSediAvis;
	
	@GetMapping
	public List<SedeAvis> getSedi(){
		return serviceSediAvis.getSedi();
	}
	
}
