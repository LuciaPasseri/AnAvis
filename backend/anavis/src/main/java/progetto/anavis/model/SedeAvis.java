package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;

import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
public class SedeAvis {

	@Id
	private UUID idSede;
	private String citta;

	public SedeAvis() {

	}

	public SedeAvis(@JsonProperty("citta") String citta) {
		this.idSede = UUID.randomUUID();
		this.citta = citta;
	}

	@JsonProperty("idSede")
	public UUID getId() {
		return idSede;
	}

	public void setId(UUID id) {
		this.idSede = id;
	}

	public String getCitta() {
		return citta;
	}

	public void setCitta(String citta) {
		this.citta = citta;
	}

}