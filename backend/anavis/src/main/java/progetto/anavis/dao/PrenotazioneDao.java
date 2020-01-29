package progetto.anavis.dao;

import java.util.List;
import java.util.UUID;

import progetto.anavis.model.Prenotazione;

public interface PrenotazioneDao {

	public Prenotazione creaPrenotazione(UUID id, Prenotazione prenotazione);

	default Prenotazione addPrenotazione(Prenotazione prenotazione) {
		UUID id = UUID.randomUUID();
		return creaPrenotazione(id, prenotazione);
	}
	
	public List<Prenotazione> getPrenotazioni();
	
	public Prenotazione getById(UUID idPrenotazione);
	
	public void deleteById (UUID idPrenotazione);
	
	public Prenotazione update (UUID id, Prenotazione prenotazione);
	
	public List<Prenotazione> getBySede (UUID idSede);
	
	public List<Prenotazione> getByDonatore (UUID idDonatore);
	
	public List<Prenotazione> getDisponibiliBySede (UUID idSede);
	
}
