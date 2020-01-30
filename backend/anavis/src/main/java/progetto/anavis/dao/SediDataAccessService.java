package progetto.anavis.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Repository;

import progetto.anavis.model.SedeAvis;

/**
 * Questa classe è la repository che contiene le sedi avis inserite nel sistema
 * e i relativi dati.
 * 
 * @author Lucia e Luca
 *
 */

@Repository("SediDataAccess")
public class SediDataAccessService implements SedeAvisDao {

	/**
	 * è il database dove vengono inserite le sedi avis.
	 */
	private List<SedeAvis> db;

	public SediDataAccessService() {
		db = new ArrayList<>();
		db.add(new SedeAvis(UUID.fromString("330c20eb-b8be-489b-a8f8-967385aa675e"), "Tolentino",
				"sede.tolentino@gmail.com"));
		db.add(new SedeAvis(UUID.fromString("1a60b7bc-1afd-451c-bb06-368c0b6142c6"), "Civitanova",
				"sede.civitanova@gmail.com"));
		db.add(new SedeAvis(UUID.fromString("693bfa33-435f-4ddc-be20-6740b6687f7d"), "Camerino",
				"sede.camerino@gmail.com"));
	}

	@Override
	public SedeAvis creaSede(UUID id, SedeAvis sedeAvis) {
		if (db.stream().filter(p -> p.getId().equals(id)).findFirst().isPresent())
			return addSede(sedeAvis);
		else {
			sedeAvis.setId(id);
			db.add(sedeAvis);
			return sedeAvis;
		}
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
