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
	private Donatore donatore;
	@NotNull
	private SedeAvis sede;
	@NotNull
	private TipoDonazione tipoDonazione;
	private Questionario questionario;
	@NotNull
	private boolean disponibilita = false;

	public Prenotazione() {

	}

	public Prenotazione(@JsonProperty("idPrenotazione") UUID id, @JsonProperty("data") String data, @JsonProperty("orario") String orario,
			@JsonProperty("donatore") Donatore donatore, @JsonProperty("sede") String citta,
			@JsonProperty(value = "tipoDonazione", defaultValue = "SANGUE_INTERO") TipoDonazione tipoDonazione,
			@JsonProperty("questionario") Questionario questionario,
			@JsonProperty(value = "disponibilita", defaultValue = "false") boolean disponibilita) {
		this.id = id;
		this.data = data;
		this.orario = orario;
		this.donatore = donatore;
		this.sede = new SedeAvis(UUID.randomUUID(), citta);
		this.tipoDonazione = tipoDonazione;
		this.questionario = questionario;
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

	public Donatore getDonatore() {
		return donatore;
	}

	public void setDonatore(Donatore donatore) {
		this.donatore = donatore;
	}

	public SedeAvis getSede() {
		return sede;
	}

	public void setSede(SedeAvis sede) {
		this.sede = sede;
	}

	public TipoDonazione getTipoDonazione() {
		return tipoDonazione;
	}

	public void setTipoDonazione(TipoDonazione tipoDonazione) {
		this.tipoDonazione = tipoDonazione;
	}

	public Questionario getQuestionario() {
		return questionario;
	}

	public void setQuestionario(Questionario questionario) {
		this.questionario = questionario;
	}

	public boolean getDisponibilita() {
		return disponibilita;
	}

	public void setDisponibilita(boolean disponibilita) {
		this.disponibilita = disponibilita;
	}

}