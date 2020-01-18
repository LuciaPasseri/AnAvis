package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
public class Prenotazione {

	@Id
	private UUID id;
	@NotBlank
	private String data, orario;
	@NotNull
	private UUID idDonatore, idSede;
	@NotNull
	private TipoDonazione tipoDonazione;
	@NotNull
	private boolean disponibilita = false;

	public Prenotazione() {

	}

	public Prenotazione(@JsonProperty("idPrenotazione") UUID id, @JsonProperty("data") String data,
			@JsonProperty("orario") String orario, @JsonProperty("idDonatore") UUID idD,
			@JsonProperty("idSede") UUID idS,
			@JsonProperty(value = "tipoDonazione", defaultValue = "SANGUE_INTERO") TipoDonazione tipoDonazione,
			@JsonProperty(value = "disponibilita", defaultValue = "false") boolean disponibilita) {
		this.id = id;
		this.data = data;
		this.orario = orario;
		this.idDonatore = idD;
		this.idSede = idS;
		this.tipoDonazione = tipoDonazione;
		this.disponibilita = disponibilita;
	}

	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getOrario() {
		return orario;
	}

	public void setOrario(String orario) {
		this.orario = orario;
	}

	public UUID getIdDonatore() {
		return idDonatore;
	}

	public void setIdDonatore(UUID idD) {
		this.idDonatore = idD;
	}

	public UUID getIdSede() {
		return idSede;
	}

	public void setIdSede(UUID idS) {
		this.idSede = idS;
	}

	public TipoDonazione getTipoDonazione() {
		return tipoDonazione;
	}

	public void setTipoDonazione(TipoDonazione tipoDonazione) {
		this.tipoDonazione = tipoDonazione;
	}

	public boolean getDisponibilita() {
		return disponibilita;
	}

	public void setDisponibilita(boolean disponibilita) {
		this.disponibilita = disponibilita;
	}

}