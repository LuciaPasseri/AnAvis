package progetto.anavis.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import progetto.anavis.dao.SedeAvisDao;
import progetto.anavis.model.SedeAvis;

/**
 * Questa classe gestisce le richieste del controller dirette alla repository
 * che contiene dati delle sedi avis.
 * 
 * @author Lucia e Luca
 *
 */

@Service
public class ServiceSedeAvis {

	@Autowired
	SedeAvisDao sedeAvisDao;

	public List<SedeAvis> getSedi() {
		return sedeAvisDao.getSedi();
	}

	public SedeAvis getById(UUID idSede) {
		return sedeAvisDao.getById(idSede);
	}

	public SedeAvis creaSede(SedeAvis sede) {
		return sedeAvisDao.addSede(sede);
	}

	public void delete(UUID idSede) {
		sedeAvisDao.deleteById(idSede);
	}

	public SedeAvis update(UUID id, SedeAvis nuovaSede) {
		return sedeAvisDao.update(id, nuovaSede);
	}

}
