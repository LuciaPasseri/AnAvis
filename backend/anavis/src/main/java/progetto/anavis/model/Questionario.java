package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
public class Questionario {

	@Id
	private UUID id;
	private String motiviRicovero, qualiAllergie;
	@NotNull
	private boolean buonaSalute, ricoveratoOspedale, condizioniSaluteRecenti, allergie, perditaPeso;

	public Questionario() {

	}

	public Questionario(@JsonProperty("id") UUID id, @JsonProperty("salute attuale") boolean saluteAttuale,
			@JsonProperty("ricovero") boolean ricoverato, @JsonProperty("motivi ricovero") String motiviRicovero,
			@JsonProperty("salute recente") boolean recentiCondizioni, @JsonProperty("allergie") boolean allergie,
			@JsonProperty("elenco allergie") String elencoAllergie,
			@JsonProperty("perdita di peso") boolean perditaDiPeso) {
		this.id = id;
		this.buonaSalute = saluteAttuale;
		this.ricoveratoOspedale = ricoverato;
		this.motiviRicovero = motiviRicovero;
		this.condizioniSaluteRecenti = recentiCondizioni;
		this.allergie = allergie;
		this.qualiAllergie = elencoAllergie;
		this.perditaPeso = perditaDiPeso;
	}

	public UUID getIdPrenotazione() {
		return id;
	}

	public void setIdPrenotazione(UUID idPrenotazione) {
		this.id = idPrenotazione;
	}

	public String getMotiviRicovero() {
		return motiviRicovero;
	}

	public void setMotiviRicovero(String motiviRicovero) {
		this.motiviRicovero = motiviRicovero;
	}

	public String getQualiAllergie() {
		return qualiAllergie;
	}

	public void setQualiAllergie(String qualiAllergie) {
		this.qualiAllergie = qualiAllergie;
	}

	public boolean isBuonaSalute() {
		return buonaSalute;
	}

	public void setBuonaSalute(boolean buonaSalute) {
		this.buonaSalute = buonaSalute;
	}

	public boolean isRicoveratoOspedale() {
		return ricoveratoOspedale;
	}

	public void setRicoveratoOspedale(boolean ricoveratoOspedale) {
		this.ricoveratoOspedale = ricoveratoOspedale;
	}

	public boolean isCondizioniSaluteRecenti() {
		return condizioniSaluteRecenti;
	}

	public void setCondizioniSaluteRecenti(boolean condizioniSaluteRecenti) {
		this.condizioniSaluteRecenti = condizioniSaluteRecenti;
	}

	public boolean isAllergie() {
		return allergie;
	}

	public void setAllergie(boolean allergie) {
		this.allergie = allergie;
	}

	public boolean isPerditaPeso() {
		return perditaPeso;
	}

	public void setPerditaPeso(boolean perditaPeso) {
		this.perditaPeso = perditaPeso;
	}

}