package progetto.anavis.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import progetto.anavis.dao.PrenotazioneDao;
import progetto.anavis.model.Prenotazione;

@Service
public class ServicePrenotazione {

	@Autowired
	PrenotazioneDao prenotazioneDao;

	public List<Prenotazione> getPrenotazioni() {
		return prenotazioneDao.getPrenotazioni();
	}

	public Prenotazione getById(UUID id) {
		return prenotazioneDao.getById(id);
	}

	public Prenotazione creaPrenotazione(Prenotazione prenotazione) {
		return prenotazioneDao.addPrenotazione(prenotazione);
	}

	public void delete(UUID id) {
		prenotazioneDao.deleteById(id);
	}

	public Prenotazione update(UUID id, Prenotazione prenotazione) {
		return prenotazioneDao.update(id, prenotazione);
	}

	public List<Prenotazione> getBySede(UUID idSede) {
		return prenotazioneDao.getBySede(idSede);
	}

	public List<Prenotazione> getByDonatore(UUID idDonatore) {
		return prenotazioneDao.getByDonatore(idDonatore);
	}

}