package progetto.anavis.api;

import java.util.UUID;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import progetto.anavis.model.Prenotazione;
import progetto.anavis.service.ServicePrenotazioni;

@RestController
public class ControllerPrenotazioni {

	private ServicePrenotazioni servicePrenotazioni = new ServicePrenotazioni();

	@GetMapping("/prenotazioni")
	public String getPrenotazioni() {
		 return servicePrenotazioni.getPrenotazioni();
	}

	@PostMapping("/prenotazioni")
	public Prenotazione create(@RequestBody Prenotazione prenotazione) {
		return servicePrenotazioni.creaPrenotazione(prenotazione);
	}

//	@PutMapping("id")
//	public Prenotazione update(@PathVariable("id") UUID id) {
//		return servicePrenotazioni.update(id, servicePrenotazioni.getById(id));
//	}
//
	@DeleteMapping("/{id}")
	public void delete(@PathVariable("id") UUID id) {
		servicePrenotazioni.delete(id, servicePrenotazioni.getById(id));
	}
}
