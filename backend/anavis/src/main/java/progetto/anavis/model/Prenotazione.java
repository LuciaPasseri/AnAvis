package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;

import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
public class Prenotazione {

	@Id
	private UUID id;
	private String data;
	private String orario;
	private Donatore donatore;
	private SedeAvis sede;
	private TipoDonazione tipoDonazione;
	private Questionario questionario;
	private boolean disponibilita = false;

	public Prenotazione() {

	}

	public Prenotazione(@JsonProperty("data") String data, @JsonProperty("orario") String orario,
			@JsonProperty("donatore") Donatore donatore, @JsonProperty("sede") SedeAvis sede,
			@JsonProperty(value = "tipoDonazione", defaultValue = "SANGUE_INTERO") TipoDonazione tipoDonazione,
			@JsonProperty("questionario") Questionario questionario,
			@JsonProperty(value = "disponibilita", defaultValue = "false") boolean disponibilita) {
		this.id = UUID.randomUUID();
		this.data = data;
		this.orario = orario;
		this.donatore = donatore;
		this.sede = sede;
		this.tipoDonazione = tipoDonazione;
		this.questionario = questionario;
		this.disponibilita = disponibilita;
	}

	@JsonProperty("idPrenotazione")
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