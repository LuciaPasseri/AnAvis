package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class SedeAvis {

	@Id
	private final UUID id;
	private String citta;

	public SedeAvis(String citta) {
		this.citta = citta;
		this.id = UUID.randomUUID();
	}

	public UUID getId() {
		return id;
	}

	public String getCitta() {
		return citta;
	}
}