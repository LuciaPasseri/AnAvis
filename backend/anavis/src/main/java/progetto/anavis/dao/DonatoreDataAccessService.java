package progetto.anavis.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Repository;

import progetto.anavis.model.Donatore;

@Repository("DonatoreDataAccess")
public class DonatoreDataAccessService implements DonatoreDao {

	private List<Donatore> db;
	private Donatore dona;

	public DonatoreDataAccessService() {
		db = new ArrayList<>();
		db.add(new Donatore(UUID.randomUUID(), "Lucia", "Passeri", "0+", "20-01-2020", true));
		db.add(new Donatore(UUID.fromString("4919c392-e09b-4690-88bf-ea5d1a82c862"), "Luca", "Cervioni", "A+",
				"01-03-2020", true));
		db.add(new Donatore(UUID.fromString("795c942c-b729-4c7e-ad2d-d065d040d3c5"), "Pippo", "Franco", "AB+",
				"05-03-2020", true));
		db.add(new Donatore(UUID.fromString("09da317e-11ec-414d-a0ee-f2a3fcd92a6a"), "Matteo", "Bianchi", "A+",
				"08-03-2020", true));
	}

	@Override
	public Donatore creaDonatore(UUID id, Donatore donatore) {
		dona = new Donatore(id, donatore.getNome(), donatore.getCognome(), donatore.getGruppoSanguigno(),
				donatore.getDataUltimaDonazione(), donatore.getPuoPrenotare());
		db.add(dona);
		return dona;
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
