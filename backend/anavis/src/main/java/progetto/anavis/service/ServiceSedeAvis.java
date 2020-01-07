package progetto.anavis.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import progetto.anavis.dao.SedeAvisDao;
import progetto.anavis.model.SedeAvis;

@Service
public class ServiceSedeAvis {

	public List<SedeAvis> db;
	
	@Autowired
	SedeAvisDao sedeAvisDao;

	public List<SedeAvis> getSedi() {
		return sedeAvisDao.getSedi();
	}

	public SedeAvis creaSede(SedeAvis sede) {
		return sedeAvisDao.addSede(sede);
	}

	public SedeAvis getById(UUID idSede) {
		return sedeAvisDao.getById(idSede);
	}

	public void delete(UUID idSede) {
		sedeAvisDao.deleteById(idSede);
	}
	
	public SedeAvis update(UUID id, SedeAvis nuovaSede) {
		return sedeAvisDao.update(id, nuovaSede);
	}

}
