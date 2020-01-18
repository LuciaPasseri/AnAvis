package progetto.anavis.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Repository;

import progetto.anavis.model.Prenotazione;
import progetto.anavis.model.TipoDonazione;

@Repository("PrenotazioneDataAccess")
public class PrenotazioneDataAccessService implements PrenotazioneDao {

	private List<Prenotazione> db;
	private Prenotazione prenot;

	public PrenotazioneDataAccessService() {
		db = new ArrayList<>();
		db.add(new Prenotazione(UUID.randomUUID(), "2019-12-07", "15 : 00", UUID.randomUUID(), UUID.randomUUID(),
				TipoDonazione.PLASMA, false));
		db.add(new Prenotazione(UUID.randomUUID(), "2019-12-10", "9 : 30", UUID.randomUUID(), UUID.randomUUID(),
				TipoDonazione.SANGUE, false));
		db.add(new Prenotazione(UUID.randomUUID(), "2019-12-11", "11 : 00", UUID.randomUUID(), UUID.randomUUID(),
				TipoDonazione.SANGUE, false));
	}

	@Override
	public Prenotazione creaPrenotazione(UUID id, Prenotazione prenotazione) {
		prenot = new Prenotazione(id, prenotazione.getData(), prenotazione.getOrario(), prenotazione.getIdDonatore(),
				prenotazione.getIdSede(), prenotazione.getTipoDonazione(), prenotazione.getDisponibilita());
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
		db.set(db.indexOf(getById(id)), prenotazione);
		prenotazione.setId(id);
		return getById(id);
	}

}
