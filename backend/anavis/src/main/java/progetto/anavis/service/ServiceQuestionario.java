package progetto.anavis.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import progetto.anavis.dao.QuestionarioDao;
import progetto.anavis.model.Questionario;

@Service
public class ServiceQuestionario {

	@Autowired
	QuestionarioDao questionarioDao;
	
	public List<Questionario> getQuestionari() {
		return questionarioDao.getQuestionari();
	}

	public Questionario getById(UUID id) {
		return questionarioDao.getById(id);
	}

	public Questionario creaQuestionario(Questionario questionario) {
		return questionarioDao.addQuestionario(questionario);
	}

	public void delete(UUID id) {
		questionarioDao.deleteById(id);
	}

	public Questionario update(UUID id, Questionario questionario) {
		return questionarioDao.update(id, questionario);
	}
}
