package progetto.anavis.dao;

import java.util.List;
import java.util.UUID;

import progetto.anavis.model.Donatore;

public interface DonatoreDao {

	public Donatore creaDonatore(UUID id, Donatore donatore);

	default Donatore addDonatore(Donatore donatore) {
		UUID id = UUID.randomUUID();
		return creaDonatore(id, donatore);
	}
	
	public List<Donatore> getDonatori();
	
	public Donatore getById(UUID idDonatore);
	
	public void deleteById (UUID idDonatore);
	
	public Donatore update (UUID id, Donatore donatore);
	
}
