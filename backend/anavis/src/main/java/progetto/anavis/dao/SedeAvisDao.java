package progetto.anavis.dao;

import java.util.List;
import java.util.UUID;

import progetto.anavis.model.SedeAvis;

public interface SedeAvisDao {

	/**
	 * Questo metodo permette di inserire una nuova sede avis nel sistema,
	 * assegnandogli l'id passato come parametro.
	 * 
	 * @param id
	 * @param sedeAvis
	 * @return la sedeAvis che è appena stata inserita.
	 */
	public SedeAvis creaSede(UUID id, SedeAvis sedeAvis);

	/**
	 * Questo metodo permette di assegnare un UUID randomico alla sede avis che si
	 * vuole inserire nel db.
	 * 
	 * @param sedeAvis
	 * @return la chiamata al metodo che inserisce la sede avis nel db.
	 */
	default SedeAvis addSede(SedeAvis sedeAvis) {
		UUID id = UUID.randomUUID();
		return creaSede(id, sedeAvis);
	}

	/**
	 * Questo metodo viene utilizzato per ottenere la lista delle sedi avis che sono
	 * nel sistema.
	 * 
	 * @return la lista delle sedi avis nel sistema.
	 */
	public List<SedeAvis> getSedi();

	/**
	 * Questo metodo permette di ottenere tutti i dati riguardanti una sede avis,
	 * tramite il suo id.
	 * 
	 * @param idSede
	 * @return tutti i dati della sede avis.
	 */
	public SedeAvis getById(UUID idSede);

	/**
	 * Questo metodo permette di eliminare la sede avis nel sistema che ha l'id
	 * corrispondente a quello passato come parametro.
	 * 
	 * @param idSede
	 */
	public void deleteById(UUID idSede);

	/**
	 * Questo metodo permette di modificare i dati della sede avis che ha id
	 * corrispondente a quello passato come parametro, inserendo i dati della sede
	 * avis passata come parametro.
	 * 
	 * @param id
	 * @param sede
	 * @return la sede avis che è appena stata modificata.
	 */
	public SedeAvis update(UUID id, SedeAvis sede);

}
