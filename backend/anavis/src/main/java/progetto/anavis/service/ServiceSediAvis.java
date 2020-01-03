package progetto.anavis.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import progetto.anavis.model.SedeAvis;

@Service
public class ServiceSediAvis {
	
	public List<SedeAvis> db;
	
	private ServiceSediAvis() {
		db = new ArrayList<>();
		db.add(new SedeAvis("Tolentino"));
		db.add(new SedeAvis("Civitanova"));
		db.add(new SedeAvis("Camerino"));
	}
		
	public List<SedeAvis> getSedi() {
		return db;
	}
	
}
