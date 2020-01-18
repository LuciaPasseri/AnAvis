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
		db.add(new SedeAvis(UUID.fromString("330c20eb-b8be-489b-a8f8-967385aa675e"), "Tolentino"));
		db.add(new SedeAvis(UUID.fromString("1a60b7bc-1afd-451c-bb06-368c0b6142c6"), "Civitanova"));
		db.add(new SedeAvis(UUID.fromString("693bfa33-435f-4ddc-be20-6740b6687f7d"), "Camerino"));
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
		db.set(db.indexOf(getById(idSede)), sede);
		sede.setId(idSede);
		return getById(idSede);
	}

}
