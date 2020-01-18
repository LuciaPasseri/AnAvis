package progetto.anavis.dao;

import java.util.List;
import java.util.UUID;

import progetto.anavis.model.Questionario;

public interface QuestionarioDao {

	public Questionario creaQuestionario(UUID id, Questionario questionario);

	default Questionario addQuestionario(Questionario questionario) {
		UUID id = UUID.randomUUID();
		return creaQuestionario(id, questionario);
	}
	
	public List<Questionario> getQuestionari();
	
	public Questionario getById(UUID idQuestionario);
	
	public void deleteById (UUID idQuestionario);
	
	public Questionario update (UUID id, Questionario questionario);
}
