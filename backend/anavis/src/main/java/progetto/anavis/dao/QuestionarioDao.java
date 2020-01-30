package progetto.anavis.dao;

import java.util.List;
import java.util.UUID;

import progetto.anavis.model.Questionario;

public interface QuestionarioDao {

	/**
	 * Questo metodo permette di inserire un nuovo questionario nel sistema,
	 * assegnandogli l'id passato come parametro.
	 * 
	 * @param id
	 * @param questionario
	 * @return il questionario che è appena stato inserito.
	 */
	public Questionario creaQuestionario(UUID id, Questionario questionario);

	/**
	 * Questo metodo permette di assegnare un UUID randomico al questionario che si
	 * vuole inserire nel db.
	 * 
	 * @param questionario
	 * @return la chiamata al metodo che inserisce il questionario nel db.
	 */
	default Questionario addQuestionario(Questionario questionario) {
		UUID id = UUID.randomUUID();
		return creaQuestionario(id, questionario);
	}

	/**
	 * Questo metodo viene utilizzato per ottenere la lista dei questionari che sono
	 * nel sistema.
	 * 
	 * @return la lista dei questionari nel sistema.
	 */
	public List<Questionario> getQuestionari();

	/**
	 * Questo metodo permette di ottenere tutti i dati riguardanti un questionario,
	 * tramite il suo id.
	 * 
	 * @param idQuestionario
	 * @return tutti i dati del questionario.
	 */
	public Questionario getById(UUID idQuestionario);

	/**
	 * Questo metodo permette di eliminare il questionario nel sistema che ha l'id
	 * corrispondente a quello passato come parametro.
	 * 
	 * @param idQuestionario
	 */
	public void deleteById(UUID idQuestionario);

	/**
	 * Questo metodo permette di modificare i dati del questionario che ha id
	 * corrispondente a quello passato come parametro, inserendo i dati del
	 * questionario passato come parametro.
	 * 
	 * @param id
	 * @param questionario
	 * @return il questionario che è appena stato modificato.
	 */
	public Questionario update(UUID id, Questionario questionario);
}
