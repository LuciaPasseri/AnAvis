package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Id;
import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonProperty;

public class SedeAvis {

	@Id
	private UUID idSede;
	@NotBlank
	private String citta, email;

	public SedeAvis() {

	}

	public SedeAvis(@JsonProperty("idSede") UUID idSede, @JsonProperty("citta") String citta,
			@JsonProperty("email") String email) {
		this.idSede = idSede;
		this.citta = citta;
		this.email = email;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}