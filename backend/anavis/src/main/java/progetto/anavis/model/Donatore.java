package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
public class Donatore {

	@Id
	private UUID id;
	@NotBlank
	private String nome, cognome, gruppoSanguigno, dataUltimaDonazione;
	@NotNull
	private boolean puoPrenotare;

	public Donatore() {

	}

	public Donatore(@JsonProperty("id") UUID idDonatore, @JsonProperty("nome") String nome,
			@JsonProperty("cognome") String cognome, @JsonProperty("gruppoSanguigno") String gruppoSanguigno,
			@JsonProperty("data ultima prenotazione") String data,
			@JsonProperty(value = "puoPrenotare", defaultValue = "false") boolean puoPrenotare) {
		this.id = idDonatore;
		this.nome = nome;
		this.cognome = cognome;
		this.gruppoSanguigno = gruppoSanguigno;
		this.dataUltimaDonazione = data;
		this.puoPrenotare = puoPrenotare;
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

	public boolean getPuoPrenotare() {
		return puoPrenotare;
	}

	public void setPuoPrenotare(boolean puoPrenotare) {
		this.puoPrenotare = puoPrenotare;
	}

}