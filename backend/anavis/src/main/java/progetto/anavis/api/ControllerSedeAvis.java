package progetto.anavis.api;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import progetto.anavis.model.SedeAvis;
import progetto.anavis.service.ServiceSedeAvis;


@RestController
@RequestMapping("/sedi")
public class ControllerSedeAvis {

	@Autowired
	ServiceSedeAvis serviceSediAvis;
	
	@GetMapping
	public List<SedeAvis> getSedi(){
		return serviceSediAvis.getSedi();
	}
	
	@PostMapping
	public SedeAvis create(@RequestBody String citta) {
		return serviceSediAvis.creaSede(citta);
	}

	@DeleteMapping("/{id}")
	public void remove(@PathVariable("id") UUID id) {
		serviceSediAvis.remove(id, serviceSediAvis.getById(id));
	}
	
}
