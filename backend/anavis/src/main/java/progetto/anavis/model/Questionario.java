package progetto.anavis.model;

import javax.persistence.Entity;

@Entity
public class Questionario {

	private Donatore datiDonatore;
	private String condizioniDiSalute;

	public Questionario() {
		
	}
	
	public Questionario(Donatore datiDonatore) {
		this.datiDonatore = datiDonatore;
	}

	public Donatore getDatiDonatore() {
		return datiDonatore;
	}

	public void setDatiDonatore(Donatore datiDonatore) {
		this.datiDonatore = datiDonatore;
	}

	public String getCondizioniDiSalute() {
		return condizioniDiSalute;
	}

	public void setCondizioniDiSalute(String condizioniDiSalute) {
		this.condizioniDiSalute = condizioniDiSalute;
	}

}