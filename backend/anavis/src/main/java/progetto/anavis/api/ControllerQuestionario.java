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

import progetto.anavis.model.Questionario;
import progetto.anavis.service.ServiceQuestionario;

/**
 * Questa classe è il controller che gestisce le chiamate http riguardanti le
 * operazioni sui questionari.
 * 
 * @author Lucia e Luca
 *
 */

@RestController
@RequestMapping("/questionari")
public class ControllerQuestionario {

	@Autowired
	ServiceQuestionario serviceQuestionario;

	/**
	 * Questo metodo permette di richiedere la lista dei questionari che sono nel
	 * sistema.
	 * 
	 * @return la lista dei questionari nel sistema.
	 */
	@GetMapping
	public List<Questionario> getQuestionari() {
		return serviceQuestionario.getQuestionari();
	}

	/**
	 * Questo metodo permette di visualizzare le informazioni riguardanti uno
	 * specifico questionario.
	 * 
	 * @param id
	 * @return il questionario che ha come id quello passato come parametro.
	 */
	@GetMapping("/{id}")
	public Questionario getQuestionario(@NotBlank @PathVariable("id") UUID id) {
		return serviceQuestionario.getById(id);
	}

	/**
	 * Questo metodo permette di richiedere l'inserimento nel sistema di un nuovo
	 * questionario.
	 * 
	 * @param questionario
	 * @return il questionario che è appena stato inserito.
	 */
	@PostMapping
	public Questionario create(@Valid @NotNull @RequestBody Questionario questionario) {
		return serviceQuestionario.creaQuestionario(questionario);
	}

	/**
	 * Questo metodo permette di eliminare un questionario dal sistema.
	 * 
	 * @param id
	 */
	@DeleteMapping("/{id}")
	public void delete(@NotBlank @PathVariable("id") UUID id) {
		serviceQuestionario.delete(id);
	}

	/**
	 * Questo metodo permette di modificare i dati di un questionario nel sistema.
	 * 
	 * @param id
	 * @return il questionario che è appena stato modificato.
	 */
	@PutMapping("/{id}")
	public Questionario update(@NotBlank @PathVariable("id") UUID id,
			@Valid @NotNull @RequestBody Questionario questionario) {
		return serviceQuestionario.update(id, questionario);
	}
}
