package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;

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
	private boolean disponibilita=false;
	
	public Prenotazione() {
		
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

	public UUID getId() {
		return id;
	}

	public String getData() {
		return data;
	}

	public String getOrario() {
		return orario;
	}
	
	public String getDisponibilita() {
		if (disponibilita==false) return "disponibile";
		else return "non disponibile";
	}

	public void setDisponibilita(boolean disponibilita) {
		this.disponibilita = disponibilita;
	}
}