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

@RestController
@RequestMapping("/sedi")
public class ControllerSedeAvis {

	@Autowired
	ServiceSedeAvis serviceSediAvis;

	@GetMapping
	public List<SedeAvis> getSedi() {
		return serviceSediAvis.getSedi();
	}

	@GetMapping("/{id}")
	public SedeAvis getSede(@NotBlank@PathVariable("id") UUID idSede) {
		return serviceSediAvis.getById(idSede);
	}

	@PostMapping
	public SedeAvis create(@Valid@NotNull@RequestBody SedeAvis sedeAvis) {
		return serviceSediAvis.creaSede(sedeAvis);
	}

	@DeleteMapping("/{id}")
	public void delete(@NotBlank@PathVariable("id") UUID idSede) {
		serviceSediAvis.delete(idSede);
	}

	@PutMapping("/{id}")
	public SedeAvis update(@NotBlank@PathVariable("id") UUID id, @Valid@NotNull@RequestBody SedeAvis sede) {
		return serviceSediAvis.update(id, sede);
	}

}
