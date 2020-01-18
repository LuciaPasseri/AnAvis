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
	private UUID idM= UUID.fromString("09da317e-11ec-414d-a0ee-f2a3fcd92a6a");

	public DonatoreDataAccessService() {
		db = new ArrayList<>();
		db.add(new Donatore(UUID.randomUUID(), "Lucia", "Passeri", "0+", "a@a.a", "aaa", true));
		db.add(new Donatore(UUID.randomUUID(), "Luca", "Cervioni", "A+", "b@b.b", "bbb", true));
		db.add(new Donatore(UUID.randomUUID(), "Pippo", "Franco", "AB+", "c@c.c", "ccc", true));
		db.add(new Donatore(idM, "Matteo", "Bianchi", "A+", "matteo.bianchi@gmail.com", "abcd123", true));
	}

	@Override
	public Donatore creaDonatore(UUID id, Donatore donatore) {
		dona = new Donatore(id, donatore.getNome(), donatore.getCognome(), donatore.getGruppoSanguigno(),
				donatore.getEmail(), donatore.getPassword(), donatore.getPuoPrenotare());
		db.add(dona);
		return dona;
	}

	@Override
	public List<Donatore> getDonatori() {
		return db;
	}

	@Override
	public Donatore getById(UUID idDonatore) {
		return db.stream().filter(b -> b.getIdDonatore().equals(idDonatore)).findFirst().orElse(null);
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
