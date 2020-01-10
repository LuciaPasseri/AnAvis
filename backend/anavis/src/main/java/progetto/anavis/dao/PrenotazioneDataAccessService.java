package progetto.anavis.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Repository;

import progetto.anavis.model.Donatore;
import progetto.anavis.model.Prenotazione;
import progetto.anavis.model.Questionario;
import progetto.anavis.model.TipoDonazione;

@Repository("PrenotazioneDataAccess")
public class PrenotazioneDataAccessService implements PrenotazioneDao {

	private List<Prenotazione> db;
	private Prenotazione prenot;

	public PrenotazioneDataAccessService() {
		db = new ArrayList<>();
		db.add(new Prenotazione(UUID.randomUUID(), "2019 - 12 - 07", "15",
				new Donatore(UUID.randomUUID(), "Lucia", "Passeri", "0+", "a@a.a", "aaa", true), "Tolentino",
				TipoDonazione.PLASMA, new Questionario(null), false));
		db.add(new Prenotazione(UUID.randomUUID(), "2019 - 12 - 10", "9 - 30",
				new Donatore(UUID.randomUUID(), "Luca", "Cervioni", "A+", "b@b.b", "bbb", true), "Civitanova",
				TipoDonazione.SANGUE, new Questionario(null), false));
		db.add(new Prenotazione(UUID.randomUUID(), "2019 - 12 - 11", "11",
				new Donatore(UUID.randomUUID(), "Pippo", "Franco", "AB+", "c@c.c", "ccc", true), "Camerino",
				TipoDonazione.SANGUE, new Questionario(null), false));
	}

	@Override
	public Prenotazione creaPrenotazione(UUID id, Prenotazione prenotazione) {
		prenot = new Prenotazione(id, prenotazione.getData(), prenotazione.getOrario(), prenotazione.getDonatore(),
				prenotazione.getSede().getCitta(), prenotazione.getTipoDonazione(), prenotazione.getQuestionario(),
				prenotazione.getDisponibilita());
		db.add(prenot);
		return prenot;
	}

	@Override
	public List<Prenotazione> getPrenotazioni() {
		return db;
	}

	@Override
	public Prenotazione getById(UUID idPrenotazione) {
		return db.stream().filter(p -> p.getId().equals(idPrenotazione)).findFirst().orElse(null);
	}

	@Override
	public void deleteById(UUID idPrenotazione) {
		db.remove(getById(idPrenotazione));
	}

	@Override
	public Prenotazione update(UUID id, Prenotazione prenotazione) {
		getById(id).setData(prenotazione.getData());
		getById(id).setOrario(prenotazione.getOrario());
		getById(id).setDonatore(prenotazione.getDonatore());
		getById(id).setSede(prenotazione.getSede());
		getById(id).setTipoDonazione(prenotazione.getTipoDonazione());
		getById(id).setQuestionario(prenotazione.getQuestionario());
		getById(id).setDisponibilita(prenotazione.getDisponibilita());
		return getById(id);
	}

}
