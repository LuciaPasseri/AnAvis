package progetto.anavis.dao;

import java.util.List;
import java.util.UUID;

import progetto.anavis.model.Donatore;

public interface DonatoreDao {

	/**
	 * Questo metodo permette di inserire un nuovo donatore nel sistema,
	 * assegnandogli l'id passato come parametro.
	 * 
	 * @param id
	 * @param donatore
	 * @return il donatore che è appena stato inserito.
	 */
	public Donatore creaDonatore(UUID id, Donatore donatore);

	/**
	 * Questo metodo permette di assegnare un UUID randomico al donatore che si
	 * vuole inserire nel db.
	 * 
	 * @param donatore
	 * @return la chiamata al metodo che inserisce il donatore nel db.
	 */
	default Donatore addDonatore(Donatore donatore) {
		UUID id = UUID.randomUUID();
		return creaDonatore(id, donatore);
	}

	/**
	 * Questo metodo viene utilizzato per ottenere la lista dei donatori che sono
	 * nel sistema.
	 * 
	 * @return la lista dei donatori nel sistema.
	 */
	public List<Donatore> getDonatori();

	/**
	 * Questo metodo permette di ottenere tutti i dati riguardanti un donatore,
	 * tramite il suo id.
	 * 
	 * @param idDonatore
	 * @return tutti i dati del donatore.
	 */
	public Donatore getById(UUID idDonatore);

	/**
	 * Questo metodo permette di eliminare il donatore nel sistema che ha l'id
	 * corrispondente a quello passato come parametro.
	 * 
	 * @param idDonatore
	 */
	public void deleteById(UUID idDonatore);

	/**
	 * Questo metodo permette di modificare i dati del donatore che ha id
	 * corrispondente a quello passato come parametro, inserendo i dati del donatore
	 * passato come parametro.
	 * 
	 * @param id
	 * @param donatore
	 * @return il donatore che è appena stato modificato.
	 */
	public Donatore update(UUID id, Donatore donatore);

}
