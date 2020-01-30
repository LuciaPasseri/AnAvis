package progetto.anavis.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import progetto.anavis.dao.DonatoreDao;
import progetto.anavis.model.Donatore;

/**
 * Questa classe gestisce le richieste del controller dirette alla repository
 * che contiene dati dei donatori.
 * 
 * @author Lucia e Luca
 *
 */

@Service
public class ServiceDonatore {

	@Autowired
	DonatoreDao donatoreDao;

	public List<Donatore> getDonatori() {
		return donatoreDao.getDonatori();
	}

	public Donatore getById(UUID id) {
		return donatoreDao.getById(id);
	}

	public Donatore creaDonatore(Donatore donatore) {
		return donatoreDao.addDonatore(donatore);
	}

	public Donatore update(UUID id, Donatore donatore) {
		return donatoreDao.update(id, donatore);
	}

	public void delete(UUID id) {
		donatoreDao.deleteById(id);
	}
}
