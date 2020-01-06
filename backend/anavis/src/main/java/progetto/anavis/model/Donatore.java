package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;

import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
public class Donatore {

	@Id
	private UUID idDonatore;
	private String nome, cognome, gruppoSanguigno, email, password;

	public Donatore() {

	}

	public Donatore(@JsonProperty("nome") String nome, @JsonProperty("cognome") String cognome,
			@JsonProperty("gruppoSanguigno") String gruppoSanguigno, @JsonProperty("email") String email,
			@JsonProperty("password") String password) {
		this.idDonatore = UUID.randomUUID();
		this.nome = nome;
		this.cognome = cognome;
		this.gruppoSanguigno = gruppoSanguigno;
		this.email = email;
		this.password = password;
	}

	@JsonProperty("idDonatore")
	public UUID getIdDonatore() {
		return idDonatore;
	}

	public void setIdDonatore(UUID idDonatore) {
		this.idDonatore = idDonatore;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}