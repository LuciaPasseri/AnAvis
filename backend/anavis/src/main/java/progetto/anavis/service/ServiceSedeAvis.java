package progetto.anavis.service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;

import progetto.anavis.model.SedeAvis;

@Service
public class ServiceSedeAvis {
	
	public List<SedeAvis> db;
	
	private ServiceSedeAvis() {
		db = new ArrayList<>();
		db.add(new SedeAvis("Tolentino"));
		db.add(new SedeAvis("Civitanova"));
		db.add(new SedeAvis("Camerino"));
	}
		
	public List<SedeAvis> getSedi() {
		return db;
	}

	public SedeAvis creaSede(SedeAvis sedeAvis) {
		db.add(sedeAvis);
		return sedeAvis;
	}

	public SedeAvis getById(UUID id) {
		return db.stream().filter(b -> b.getId().equals(id)).findFirst().orElse(null);
	}

	public String remove(UUID id, SedeAvis sedeAvis) {
		System.out.println("Eliminazione sede Avis [ID: " + id + "]");
		db.remove(sedeAvis);
		return "Eliminazione avvenuta con successo";
	}
	
}
