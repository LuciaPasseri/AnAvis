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

/**
 * Questa classe è il controller che gestisce le richieste http lato
 * user-interface, riguardanti le operazioni sui donatori.
 * 
 * @author Lucia e Luca
 *
 */

@RestController
@RequestMapping("/donatori")
public class ControllerDonatore {

	@Autowired
	ServiceDonatore serviceDonatore;

	/**
	 * Questo metodo permette di richiedere la lista dei donatori che sono nel
	 * sistema.
	 * 
	 * @return la lista dei donatori nel sistema.
	 */
	@GetMapping
	public List<Donatore> getDonatori() {
		return serviceDonatore.getDonatori();
	}

	/**
	 * Questo metodo permette di visualizzare le informazioni riguardanti uno
	 * specifico donatore.
	 * 
	 * @param id
	 * @return il donatore che ha come id quello passato come parametro.
	 */
	@GetMapping("/{id}")
	public Donatore getDonatore(@NotBlank @PathVariable("id") UUID idDonatore) {
		return serviceDonatore.getById(idDonatore);
	}

	/**
	 * Questo metodo permette di richiedere l'inserimento nel sistema di un nuovo
	 * donatore.
	 * 
	 * @param donatore
	 * @return il donatore che è appena stato inserito.
	 */
	@PostMapping
	public Donatore create(@Valid @NotNull @RequestBody Donatore donatore) {
		return serviceDonatore.creaDonatore(donatore);
	}

	/**
	 * Questo metodo permette di eliminare un donatore dal sistema.
	 * 
	 * @param id
	 */
	@DeleteMapping("/{id}")
	public void delete(@NotBlank @PathVariable("id") UUID id) {
		serviceDonatore.delete(id);
		;
	}

	/**
	 * Questo metodo permette di modificare i dati di un donatore nel sistema.
	 * 
	 * @param id
	 * @return il donatore che è appena stato modificato.
	 */
	@PutMapping("/{id}")
	public Donatore update(@NotBlank @PathVariable("id") UUID id, @Valid @NotNull @RequestBody Donatore donatore) {
		return serviceDonatore.update(id, donatore);
	}
}
