package progetto.anavis.dao;

import java.util.List;
import java.util.UUID;

import progetto.anavis.model.SedeAvis;

public interface SedeAvisDao{

	public SedeAvis creaSede(UUID id, SedeAvis sedeAvis);

	default SedeAvis addSede(SedeAvis sedeAvis) {
		UUID id = UUID.randomUUID();
		return creaSede(id, sedeAvis);
	}
	
	public List<SedeAvis> getSedi();
	
	public SedeAvis getById(UUID idSede);
	
	public void deleteById (UUID idSede);
	
	public SedeAvis update (UUID id, SedeAvis sede);
	
}
