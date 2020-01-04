package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;

import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
public class SedeAvis {

	@Id
	private UUID id;
	private String citta;

	public SedeAvis() {
		
	}
	
	public SedeAvis(@JsonProperty("citta") String citta) {
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