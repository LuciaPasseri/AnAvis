package progetto.anavis.api;

import java.util.List;
import java.util.UUID;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
	public Donatore getDonatore(@NotBlank@PathVariable("id") UUID idDonatore){
		return serviceDonatore.getById(idDonatore);
	}
	
	@PostMapping
	public Donatore create(@Valid@NotNull@RequestBody Donatore donatore) {
		return serviceDonatore.creaDonatore(donatore);
	}
	
	@DeleteMapping("/{id}")
	public void delete(@NotBlank@PathVariable("id") UUID id) {
		serviceDonatore.delete(id);;
	}

	@PutMapping("/{id}")
	public Donatore update(@NotBlank@PathVariable("id") UUID id, @Valid@NotNull@RequestBody Donatore donatore) {
		return serviceDonatore.update(id, donatore);
	}
}
