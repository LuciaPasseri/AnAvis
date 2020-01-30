package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Questa classe definisce l'oggetto donatore che è una persona iscritta ad una
 * sede avis. Il donatore, a seguito di una prenotazione e della compilazione
 * del questionario sulle condizioni di salute, può effettuare una donazione di
 * sangue intero o plasma.
 * 
 * @author Lucia e Luca
 *
 */

@Entity
public class Donatore {

	@Id
	private UUID id;
	@NotBlank
	private String nome, cognome, gruppoSanguigno, email;
	private String dataUltimaDonazione;
	private TipoDonazione tipoUltimaDonazione;

	public Donatore() {

	}

	public Donatore(@JsonProperty("id") UUID idDonatore, @JsonProperty("nome") String nome,
			@JsonProperty("cognome") String cognome, @JsonProperty("email") String email,
			@JsonProperty("gruppoSanguigno") String gruppoSanguigno,
			@JsonProperty("data ultima prenotazione") String data,
			@JsonProperty("tipo ultima donazione") TipoDonazione tipo) {
		this.id = idDonatore;
		this.nome = nome;
		this.cognome = cognome;
		this.email = email;
		this.gruppoSanguigno = gruppoSanguigno;
		this.dataUltimaDonazione = data;
		this.tipoUltimaDonazione = tipo;
	}

	public UUID getId() {
		return id;
	}

	public void setIdDonatore(UUID idDonatore) {
		this.id = idDonatore;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGruppoSanguigno() {
		return gruppoSanguigno;
	}

	public void setGruppoSanguigno(String gruppoSanguigno) {
		this.gruppoSanguigno = gruppoSanguigno;
	}

	public String getDataUltimaDonazione() {
		return dataUltimaDonazione;
	}

	public void setDataUltimaDonazione(String dataUltimaDonazione) {
		this.dataUltimaDonazione = dataUltimaDonazione;
	}

	public TipoDonazione getTipoUltimaDonazione() {
		return tipoUltimaDonazione;
	}

	public void setTipoUltimaDonazione(TipoDonazione tipo) {
		this.tipoUltimaDonazione = tipo;
	}

}