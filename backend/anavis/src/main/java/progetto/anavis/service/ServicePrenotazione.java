package progetto.anavis.service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;

import progetto.anavis.model.Donatore;
import progetto.anavis.model.Prenotazione;
import progetto.anavis.model.Questionario;
import progetto.anavis.model.SedeAvis;
import progetto.anavis.model.TipoDonazione;

@Service
public class ServicePrenotazione {

	// DB momentaneo
	public List<Prenotazione> db;

	private ServicePrenotazione() {
		db = new ArrayList<>();
		db.add(new Prenotazione("2019 - 12 - 07", "15", new Donatore("Lucia", "Passeri", "0+", "a@a.a", "aaa"),
				new SedeAvis("Tolentino"), TipoDonazione.PLASMA, new Questionario(null), true));
		db.add(new Prenotazione("2019 - 12 - 10", "9 - 30", new Donatore("Luca", "Cervioni", "A+", "b@b.b", "bbb"),
				new SedeAvis("Civitanova"), TipoDonazione.SANGUE, new Questionario(null), true));
		db.add(new Prenotazione("2019 - 12 - 11", "11", new Donatore("Pippo", "Franco", "AB+", "c@c.c", "ccc"),
				new SedeAvis("Camerino"), TipoDonazione.SANGUE, new Questionario(null), true));
	}

	public List<Prenotazione> getPrenotazioni() {
		return db;
	}

	public Prenotazione getById(UUID id) {
		return db.stream().filter(b -> b.getId().equals(id)).findFirst().orElse(null);
	}

	public Prenotazione creaPrenotazione(Prenotazione prenotazione) {
		System.out.println("Creazione prenotazione: " + prenotazione.toString());
		// aggiunge le prenotazioni con i tutti i campi compilati
		// TODO: fare in modo che vengano aggiunte le prenotazioni "libere" ed
		// assegnarle ai donatori tramite l'update
		db.add(prenotazione);
		return prenotazione;
	}

	public Prenotazione update(UUID id, Prenotazione prenotazione) {
		// TODO da implementare
		System.out.println("Aggiornamento prenotazione [ID: " + prenotazione.getId() + "]");
		return prenotazione;
	}

	public String remove(UUID id, Prenotazione prenotazione) {
		System.out.println("Eliminazione prenotazione [ID: " + id + "]");
		db.remove(prenotazione);
		return "Eliminazione avvenuta con successo";
	}

	// public void setAvvenutaPrenotazione(@JsonProperty("donatore") Donatore
	// donatore,
	// @JsonProperty("sede donazione") SedeAvis sedeDonazione,
	// @JsonProperty("tipo donazione") TipoDonazione tipoDonazione,
	// @JsonProperty("questionario") Questionario questionario, boolean
	// disponibilita) {
	//
	// }
}