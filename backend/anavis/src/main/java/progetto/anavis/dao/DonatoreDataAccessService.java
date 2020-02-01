package progetto.anavis.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Repository;

import progetto.anavis.model.Donatore;
import progetto.anavis.model.TipoDonazione;

/**
 * Questa classe è la repository che contiene i donatori inseriti nel sistema e
 * i relativi dati.
 * 
 * @author Lucia e Luca
 *
 */

@Repository("DonatoreDataAccess")
public class DonatoreDataAccessService implements DonatoreDao {

	/**
	 * è il database dove vengono inseriti i donatori.
	 */
	public List<Donatore> db = new ArrayList<>();

	public DonatoreDataAccessService() {
		db.add(new Donatore(UUID.randomUUID(), "Lucia", "Passeri", "lucia.passeri@gmail.com", "0+", "20-01-2020",
				TipoDonazione.SANGUE));
		db.add(new Donatore(UUID.fromString("4919c392-e09b-4690-88bf-ea5d1a82c862"), "Luca", "Cervioni",
				"luca.cervioni@gmail.com", "A+", "05-03-2020", TipoDonazione.SANGUE));
		db.add(new Donatore(UUID.fromString("795c942c-b729-4c7e-ad2d-d065d040d3c5"), "Roberto", "Rossi",
				"roberto.rossi@gmail.com", "AB+", "08-03-2020", TipoDonazione.SANGUE));
		db.add(new Donatore(UUID.fromString("09da317e-11ec-414d-a0ee-f2a3fcd92a6a"), "Matteo", "Bianchi",
				"matteo.bianchi@gmail.com", "A+", "01-03-2020", TipoDonazione.PLASMA));
	}

	@Override
	public Donatore creaDonatore(UUID id, Donatore donatore) {
		if (db.stream().filter(p -> p.getId().equals(id)).findFirst().isPresent())
			return addDonatore(donatore);
		else {
			donatore.setIdDonatore(id);
			db.add(donatore);
			return donatore;
		}
	}

	@Override
	public List<Donatore> getDonatori() {
		return db;
	}

	@Override
	public Donatore getById(UUID idDonatore) {
		return db.stream().filter(b -> b.getId().equals(idDonatore)).findFirst().orElse(null);
	}

	@Override
	public void deleteById(UUID idDonatore) {
		db.remove(getById(idDonatore));
	}

	@Override
	public Donatore update(UUID id, Donatore donatore) {
		db.set(db.indexOf(getById(id)), donatore);
		donatore.setIdDonatore(id);
		return getById(id);
	}

}
