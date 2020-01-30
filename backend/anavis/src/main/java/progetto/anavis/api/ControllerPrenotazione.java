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

/**
 * Questa classe è il controller che gestisce le chiamate http riguardanti le
 * operazioni sulle prenotazioni.
 * 
 * @author Lucia e Luca
 *
 */

@RestController
@RequestMapping("/prenotazioni")
public class ControllerPrenotazione {

	@Autowired
	ServicePrenotazione servicePrenotazioni;

	/**
	 * Questo metodo permette di richiedere la lista delle prenotazioni che sono nel
	 * sistema.
	 * 
	 * @return la lista delle prenotazioni del sistema.
	 */
	@GetMapping
	public List<Prenotazione> getPrenotazioni() {
		return servicePrenotazioni.getPrenotazioni();
	}

	/**
	 * Questo metodo permette di visualizzare le informazioni riguardanti una
	 * specifica prenotazione.
	 * 
	 * @param id
	 * @return la prenotazione che ha come id quello passato come parametro.
	 */
	@GetMapping("/{id}")
	public Prenotazione getPrenotazione(@NotBlank @PathVariable("id") UUID id) {
		return servicePrenotazioni.getById(id);
	}

	/**
	 * Questo metodo permette di richiedere l'inserimento nel sistema di una nuova
	 * prenotazione.
	 * 
	 * @param prenotazione
	 * @return la prenotazione che è appena stata inserita.
	 */
	@PostMapping
	public Prenotazione create(@Valid @NotNull @RequestBody Prenotazione prenotazione) {
		return servicePrenotazioni.creaPrenotazione(prenotazione);
	}

	/**
	 * Questo metodo permette di eliminare una prenotazione dal sistema.
	 * 
	 * @param id
	 */
	@DeleteMapping("/{id}")
	public void delete(@NotBlank @PathVariable("id") UUID id) {
		servicePrenotazioni.delete(id);
	}

	/**
	 * Questo metodo permette di modificare i dati di una prenotazione nel sistema.
	 * 
	 * @param id
	 * @return la prenotazione che è appena stata modificata.
	 */
	@PutMapping("/{id}")
	public Prenotazione update(@NotBlank @PathVariable("id") UUID id,
			@Valid @NotNull @RequestBody Prenotazione prenotazione) {
		return servicePrenotazioni.update(id, prenotazione);
	}

	/**
	 * Questo metodo permette di richiedere la lista delle prenotazioni che
	 * appartengono a una determinata sede avis.
	 * 
	 * @param id
	 * @return la lista delle prenotazioni della sede con id come quello passato
	 *         come parametro.
	 */
	@GetMapping("/sede/{id}")
	public List<Prenotazione> getBySede(@NotBlank @PathVariable("id") UUID id) {
		return servicePrenotazioni.getBySede(id);
	}

	/**
	 * Questo metodo permette di richiedere la lista delle prenotazioni che
	 * appartengono a un determinato donatore.
	 * 
	 * @param id
	 * @return la lista delle prenotazioni del donatore con id come quello passato
	 *         come parametro.
	 */
	@GetMapping("/donatore/{id}")
	public List<Prenotazione> getByDonatore(@NotBlank @PathVariable("id") UUID id) {
		return servicePrenotazioni.getByDonatore(id);
	}

	/**
	 * Questo metodo permette di richiedere la lista delle prenotazioni che non sono
	 * ancora state prenotate da alcun donatore e che appartengono a una determinata
	 * sede avis.
	 * 
	 * @param id
	 * @return la lista delle prenotazioni, non prenotate da alcun donatore, della
	 *         sede avis con id come quello passato come parametro.
	 */
	@GetMapping("/sede/{id}/disponibili")
	public List<Prenotazione> getDisponibiliBySede(@NotBlank @PathVariable("id") UUID id) {
		return servicePrenotazioni.getDisponibiliBySede(id);
	}

}