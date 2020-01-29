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

import progetto.anavis.model.Prenotazione;
import progetto.anavis.service.ServicePrenotazione;

@RestController
@RequestMapping("/prenotazioni")
public class ControllerPrenotazione {

	@Autowired
	ServicePrenotazione servicePrenotazioni;

	@GetMapping
	public List<Prenotazione> getPrenotazioni() {
		return servicePrenotazioni.getPrenotazioni();
	}

	@GetMapping("/{id}")
	public Prenotazione getPrenotazione(@NotBlank @PathVariable("id") UUID id) {
		return servicePrenotazioni.getById(id);
	}

	@PostMapping
	public Prenotazione create(@Valid @NotNull @RequestBody Prenotazione prenotazione) {
		return servicePrenotazioni.creaPrenotazione(prenotazione);
	}

	@DeleteMapping("/{id}")
	public void delete(@NotBlank @PathVariable("id") UUID id) {
		servicePrenotazioni.delete(id);
	}

	@PutMapping("/{id}")
	public Prenotazione update(@NotBlank @PathVariable("id") UUID id,
			@Valid @NotNull @RequestBody Prenotazione prenotazione) {
		return servicePrenotazioni.update(id, prenotazione);
	}

	@GetMapping("/sede/{id}")
	public List<Prenotazione> getBySede(@NotBlank @PathVariable("id") UUID id) {
		return servicePrenotazioni.getBySede(id);
	}

	@GetMapping("/donatore/{id}")
	public Prenotazione getByDonatore(@NotBlank @PathVariable("id") UUID id) {
		return servicePrenotazioni.getByDonatore(id);
	}

}