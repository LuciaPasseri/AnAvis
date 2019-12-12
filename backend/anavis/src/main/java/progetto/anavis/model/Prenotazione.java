package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;

import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
public class Prenotazione {

	@Id
	private final UUID id;
	private final String data;
	private final String orario;
	private Donatore donatore;
	private SedeAvis sede;
	private TipoDonazione tipoDonazione;
	private Questionario questionario;
	private boolean disponibilita=false;

	public Prenotazione(@JsonProperty("data") String data,
			@JsonProperty("orario") String orario) {
		this.id = UUID.randomUUID();
		this.data = data;
		this.orario = orario;
	}
	
	public Prenotazione(String data, String orario, Donatore donatore, SedeAvis sede, TipoDonazione tipoDonazione, Questionario questionario, boolean disponibilita) {
		this.id=UUID.randomUUID();
		this.data=data;
		this.orario=orario;
		this.donatore=donatore;
		this.sede=sede;
		this.tipoDonazione=tipoDonazione;
		this.questionario=questionario;
		this.disponibilita=disponibilita;
	}

	public UUID getId() {
		return id;
	}

	public String getData() {
		return data;
	}
	
	public String getOrario() {
		return orario;
	}
	
	public Donatore getDonatore() {
		return donatore;
	}

	public SedeAvis getSede() {
		return sede;
	}
	
	public TipoDonazione getTipoDonazione() {
		return tipoDonazione;
	}

	public String getDisponibilita() {
		if (disponibilita==false) return "disponibile";
		else return "non disponibile";
	}

}