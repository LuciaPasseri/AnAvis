package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;

import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
public class Donatore {

	@Id
	private final UUID idDonatore;
	private String nome, cognome, gruppoSanguigno;

	public Donatore(@JsonProperty("idDonatore") UUID idDonatore, @JsonProperty("nome") String nome,
			@JsonProperty("cognome") String cognome, @JsonProperty("gruppoSanguigno") String gruppoSanguigno) {
		this.idDonatore = idDonatore;
		this.nome = nome;
		this.cognome = cognome;
		this.gruppoSanguigno = gruppoSanguigno;
	}

	public UUID getId() {
		return idDonatore;
	}

	public String getNome() {
		return nome;
	}

	public String getCognome() {
		return cognome;
	}

	public String getGruppoSanguigno() {
		return gruppoSanguigno;
	}

}