package progetto.anavis.dao;

import java.util.List;
import java.util.UUID;

import progetto.anavis.model.Prenotazione;

public interface PrenotazioneDao {

	/**
	 * Questo metodo permette di inserire una nuova prenotazione nel sistema,
	 * assegnandogli l'id passato come parametro.
	 * 
	 * @param id
	 * @param prenotazione
	 * @return la prenotazione che è appena stata inserita.
	 */
	public Prenotazione creaPrenotazione(UUID id, Prenotazione prenotazione);

	/**
	 * Questo metodo permette di assegnare un UUID randomico alla prenotazione che
	 * si vuole inserire nel db.
	 * 
	 * @param prenotazione
	 * @return la chiamata al metodo che inserisce la prenotazione nel db.
	 */
	default Prenotazione addPrenotazione(Prenotazione prenotazione) {
		UUID id;
		do {
			id = UUID.randomUUID();
		} while (id == UUID.fromString("00000000-0000-0000-0000-000000000000"));
		return creaPrenotazione(id, prenotazione);

	}

	/**
	 * Questo metodo viene utilizzato per ottenere la lista delle prenotazioni che
	 * sono nel sistema.
	 * 
	 * @return la lista delle prenotazioni nel sistema.
	 */
	public List<Prenotazione> getPrenotazioni();

	/**
	 * Questo metodo permette di ottenere tutti i dati riguardanti una prenotazione,
	 * tramite il suo id.
	 * 
	 * @param idPrenotazione
	 * @return tutti i dati della prenotazione.
	 */
	public Prenotazione getById(UUID idPrenotazione);

	/**
	 * Questo metodo permette di eliminare la prenotazione nel sistema che ha l'id
	 * corrispondente a quello passato come parametro.
	 * 
	 * @param idPrenotazione
	 */
	public void deleteById(UUID idPrenotazione);

	/**
	 * Questo metodo permette di modificare i dati della prenotazione che ha id
	 * corrispondente a quello passato come parametro, inserendo i dati della
	 * prenotazione passata come parametro.
	 * 
	 * @param id
	 * @param prenotazione
	 * @return la prenotazione che è appena stata modificata.
	 */
	public Prenotazione update(UUID id, Prenotazione prenotazione);

	/**
	 * Questo metodo viene utilizzato per ottenere la lista delle prenotazioni che
	 * appartengono ad una determinata sede il cui id corrisponde a quello passato
	 * come parametro.
	 * 
	 * @param idSede
	 * @return la lista delle prenotazioni della sede con id come quello passato
	 *         come parametro.
	 */
	public List<Prenotazione> getBySede(UUID idSede);

	/**
	 * Questo metodo viene utilizzato per ottenere la lista delle prenotazioni che
	 * appartengono ad un determinato donatore il cui id corrisponde a quello
	 * passato come parametro.
	 * 
	 * @param idDonatore
	 * @return la lista delle prenotazioni del donatore con id come quello passato
	 *         come parametro.
	 */
	public List<Prenotazione> getByDonatore(UUID idDonatore);

	/**
	 * Questo metodo viene utilizzato per ottenere la lista delle prenotazioni che
	 * non sono ancora state prenotate da alcun donatore e che appartengono a una
	 * determinata sede avis con id corrispondente ad idSede.
	 * 
	 * @param idSede
	 * @return la lista delle prenotazioni, non prenotate da alcun donatore, della
	 *         sede avis con id come quello passato come parametro.
	 */
	public List<Prenotazione> getDisponibiliBySede(UUID idSede);

}
