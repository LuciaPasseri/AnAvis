package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Id;
import javax.validation.constraints.NotBlank;

import org.springframework.data.mongodb.core.mapping.Document;

import com.fasterxml.jackson.annotation.JsonProperty;

@Document()
public class SedeAvis {

	@Id
	private UUID idSede;
	@NotBlank
	private String citta;

	public SedeAvis() {

	}

	public SedeAvis(@JsonProperty("idSede") UUID idSede, @JsonProperty("citta") String citta) {
		this.idSede = idSede;
		this.citta = citta;
	}

	
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