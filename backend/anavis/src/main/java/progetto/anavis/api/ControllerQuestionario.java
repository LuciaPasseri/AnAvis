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

@RestController
@RequestMapping("/questionari")
public class ControllerQuestionario {

	@Autowired
	ServiceQuestionario serviceQuestionario;
	
	@GetMapping
	public List<Questionario> getQuestionari(){
		return serviceQuestionario.getQuestionari();
	}
	

	@GetMapping("/{id}")
	public Questionario getQuestionario(@NotBlank@PathVariable("id") UUID id){
		return serviceQuestionario.getById(id);
	}

	@PostMapping
	public Questionario create(@Valid@NotNull@RequestBody Questionario questionario) {
		return serviceQuestionario.creaQuestionario(questionario);
	}

	@DeleteMapping("/{id}")
	public void delete(@NotBlank@PathVariable("id") UUID id) {
		serviceQuestionario.delete(id);
	}

	@PutMapping("/{id}")
	public Questionario update(@NotBlank@PathVariable("id") UUID id, @Valid@NotNull@RequestBody Questionario questionario) {
		return serviceQuestionario.update(id, questionario);
	}
}
