package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class SedeAvis {

	@Id
	private UUID id;
	private String citta;

	public SedeAvis() {
		
	}
	
	public SedeAvis(String citta) {
		this.id = UUID.randomUUID();
		this.citta = citta;
	}
	
	public UUID getId() {
		return id;
	}
	
	public void setId(UUID id) {
		this.id = id;
	}
	
	public String getCitta() {
		return citta;
	}
	
	public void setCitta(String citta) {
		this.citta = citta;
	}

	
}