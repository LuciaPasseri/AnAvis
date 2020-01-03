package progetto.anavis.service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;

import progetto.anavis.model.Donatore;

@Service
public class ServiceDonatore {

	public List<Donatore> db;

	private ServiceDonatore() {
		db = new ArrayList<>();
		db.add(new Donatore("Lucia", "Passeri", "0+", "a@a.a", "aaa"));
		db.add(new Donatore("Luca", "Cervioni", "A+", "b@b.b", "bbb"));
		db.add(new Donatore("Pippo", "Franco", "AB+", "c@c.c", "ccc"));
	}

	public List<Donatore> getDonatori() {
		return db;
	}

	public Donatore getById(UUID id) {
		return db.stream().filter(b -> b.getIdDonatore().equals(id)).findFirst().orElse(null);
	}

	public Donatore creaDonatore(Donatore donatore) {
		System.out.println("Creazione donatore: " + donatore.toString());
		// aggiunge le prenotazioni con i tutti i campi compilati
		// TODO: fare in modo che vengano aggiunte le prenotazioni "libere" ed
		// assegnarle ai donatori tramite l'update
		db.add(donatore);
		return donatore;
	}

	public Donatore update(UUID id, Donatore donatore) {
		// TODO da implementare
		System.out.println("Aggiornamento donatore [ID: " + donatore.getIdDonatore() + "]");
		return donatore;
	}

	public String remove(UUID id, Donatore donatore) {
		System.out.println("Eliminazione donatore [ID: " + id + "]");
		db.remove(donatore);
		return "Eliminazione avvenuta con successo";
	}
}
