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

import progetto.anavis.model.SedeAvis;
import progetto.anavis.service.ServiceSedeAvis;

/**
 * Questa classe è il controller che gestisce le chiamate http riguardanti le
 * operazioni sulle sedi avis.
 * 
 * @author Lucia e Luca
 *
 */

@RestController
@RequestMapping("/sedi")
public class ControllerSedeAvis {

	@Autowired
	ServiceSedeAvis serviceSediAvis;

	/**
	 * Questo metodo permette di richiedere la lista delle sedi avis che sono nel
	 * sistema.
	 * 
	 * @return la lista delle sedi avis del sistema.
	 */
	@GetMapping
	public List<SedeAvis> getSedi() {
		return serviceSediAvis.getSedi();
	}

	/**
	 * Questo metodo permette di visualizzare le informazioni riguardanti una
	 * specifica sede avis.
	 * 
	 * @param id
	 * @return la sede avis che ha come id quello passato come parametro.
	 */
	@GetMapping("/{id}")
	public SedeAvis getSede(@NotBlank @PathVariable("id") UUID idSede) {
		return serviceSediAvis.getById(idSede);
	}

	/**
	 * Questo metodo permette di richiedere l'inserimento nel sistema di una nuova
	 * sede avis.
	 * 
	 * @param sedeAvis
	 * @return la sede avis che è appena stata inserita.
	 */
	@PostMapping
	public SedeAvis create(@Valid @NotNull @RequestBody SedeAvis sedeAvis) {
		return serviceSediAvis.creaSede(sedeAvis);
	}

	/**
	 * Questo metodo permette di eliminare una sede avis dal sistema.
	 * 
	 * @param id
	 */
	@DeleteMapping("/{id}")
	public void delete(@NotBlank @PathVariable("id") UUID idSede) {
		serviceSediAvis.delete(idSede);
	}

	/**
	 * Questo metodo permette di modificare i dati di una sede avis nel sistema.
	 * 
	 * @param id
	 * @return la sede avis che è appena stata modificata.
	 */
	@PutMapping("/{id}")
	public SedeAvis update(@NotBlank @PathVariable("id") UUID id, @NotNull @RequestBody SedeAvis sede) {
		return serviceSediAvis.update(id, sede);
	}

}
