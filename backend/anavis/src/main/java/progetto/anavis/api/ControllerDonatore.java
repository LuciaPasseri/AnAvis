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

import progetto.anavis.model.Donatore;
import progetto.anavis.service.ServiceDonatore;

@RestController
@RequestMapping("/donatori")
public class ControllerDonatore {

	@Autowired
	ServiceDonatore serviceDonatore;

	@GetMapping
	public List<Donatore> getPrenotazioni() {
		 return serviceDonatore.getDonatori();
	}

	@GetMapping("/{id}")
	public Donatore getDonatore(@PathVariable("id") UUID idDonatore){
		return serviceDonatore.getById(idDonatore);
	}
	
	@PostMapping
	public Donatore create(@RequestBody Donatore donatore) {
		UUID idDonatore = UUID.randomUUID();
		return serviceDonatore.creaDonatore(idDonatore, donatore);
	}

//	@PutMapping("/{id}")
//	public Donatore update(@PathVariable("id") UUID id) {
//		return serviceDonatore.update(id, serviceDonatore.getByIdDonatore(id));
//	}
//
	@DeleteMapping("/{id}")
	public void remove(@PathVariable("id") UUID id) {
		serviceDonatore.remove(id, serviceDonatore.getById(id));
	}
}
