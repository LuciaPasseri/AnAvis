package progetto.anavis.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Repository;

import progetto.anavis.model.Questionario;

@Repository("QuestionarioDataAccess")
public class QuestionarioDataAccessService implements QuestionarioDao {

	private List<Questionario> db;
	private Questionario questionario;

	public QuestionarioDataAccessService() {
		db = new ArrayList<>();
		db.add(new Questionario(UUID.fromString("f00e544f-9a60-4002-8d92-24258cae39a0"), false, false, null, true,
				false, null, false));
		db.add(new Questionario(UUID.fromString("243426a6-eae5-4c16-bc8f-5b051e7e2400"), true, false, null, true, false,
				null, false));
		db.add(new Questionario(UUID.fromString("35b1c1e1-6e26-466a-9621-cf64632cff9a"), true, false, null, true, false,
				null, false));
	}

	@Override
	public Questionario creaQuestionario(UUID id, Questionario questionario) {
		if (db.stream().filter(d -> d.getId().equals(id)) == null) {
			this.questionario = new Questionario(id, questionario.isBuonaSalute(), questionario.isRicoveratoOspedale(),
					questionario.getMotiviRicovero(), questionario.isCondizioniSaluteRecenti(), questionario.isAllergie(),
					questionario.getQualiAllergie(), questionario.isPerditaPeso());
			db.add(this.questionario);
			return this.questionario;
		} else
			return creaQuestionario(id, questionario);
	}

	@Override
	public List<Questionario> getQuestionari() {
		return db;
	}

	@Override
	public Questionario getById(UUID idQuestionario) {
		return db.stream().filter(p -> p.getId().equals(idQuestionario)).findFirst().orElse(null);
	}

	@Override
	public void deleteById(UUID idQuestionario) {
		db.remove(getById(idQuestionario));
	}

	@Override
	public Questionario update(UUID id, Questionario questionario) {
		db.set(db.indexOf(getById(id)), questionario);
		questionario.setId(id);
		return getById(id);
	}

}
