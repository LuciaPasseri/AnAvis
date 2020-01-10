package progetto.anavis.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Repository;

import progetto.anavis.model.SedeAvis;

@Repository("SediDataAccess")
public class SediDataAccessService implements SedeAvisDao {

	private List<SedeAvis> db;
	private SedeAvis sede;

	private SediDataAccessService() {
		db = new ArrayList<>();
		db.add(new SedeAvis(UUID.randomUUID(), "Tolentino"));
		db.add(new SedeAvis(UUID.randomUUID(), "Civitanova"));
		db.add(new SedeAvis(UUID.randomUUID(), "Camerino"));
	}

	@Override
	public SedeAvis creaSede(UUID id, SedeAvis sedeAvis) {
		this.sede = new SedeAvis(id, sedeAvis.getCitta());
		db.add(sede);
		return sede;
	}

	@Override
	public List<SedeAvis> getSedi() {
		return db;
	}

	@Override
	public SedeAvis getById(UUID idSede) {
		return db.stream().filter(b -> b.getId().equals(idSede)).findFirst().orElse(null);
	}

	@Override
	public void deleteById(UUID idSede) {
		db.remove(getById(idSede));
	}

	@Override
	public SedeAvis update(UUID idSede, SedeAvis sede) {
		if (!getById(idSede).equals(null))
			getById(idSede).setCitta(sede.getCitta());
		return getById(idSede);
	}

}
