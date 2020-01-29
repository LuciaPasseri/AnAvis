package progetto.anavis.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Repository;

import progetto.anavis.model.Prenotazione;
import progetto.anavis.model.TipoDonazione;

@Repository("PrenotazioneDataAccess")
public class PrenotazioneDataAccessService implements PrenotazioneDao {

	private List<Prenotazione> db;
	private Prenotazione prenotazione;

	public PrenotazioneDataAccessService() {
		db = new ArrayList<>();
		db.add(new Prenotazione(UUID.fromString("842093cc-4f11-4bb4-9aa2-b6809f9a2ee7"), "01-03-2020", "15 : 00",
				UUID.fromString("09da317e-11ec-414d-a0ee-f2a3fcd92a6a"),
				UUID.fromString("330c20eb-b8be-489b-a8f8-967385aa675e"), TipoDonazione.PLASMA, false,
				UUID.fromString("f00e544f-9a60-4002-8d92-24258cae39a0")));
		db.add(new Prenotazione(UUID.fromString("24de37f4-3a19-11ea-b77f-2e728ce88125"), "05-03-2020", "9 : 30",
				UUID.fromString("4919c392-e09b-4690-88bf-ea5d1a82c862"),
				UUID.fromString("1a60b7bc-1afd-451c-bb06-368c0b6142c6"), TipoDonazione.SANGUE, false,
				UUID.fromString("243426a6-eae5-4c16-bc8f-5b051e7e2400")));
		db.add(new Prenotazione(UUID.fromString("951273b4-3a19-11ea-b77f-2e728ce88125"), "08-03-2020", "11 : 00",
				UUID.fromString("795c942c-b729-4c7e-ad2d-d065d040d3c5"),
				UUID.fromString("693bfa33-435f-4ddc-be20-6740b6687f7d"), TipoDonazione.SANGUE, false,
				UUID.fromString("35b1c1e1-6e26-466a-9621-cf64632cff9a")));
	}

	@Override
	public Prenotazione creaPrenotazione(UUID id, Prenotazione prenotazione) {
		if (db.stream().filter(d -> d.getId().equals(id)) == null) {
			this.prenotazione = new Prenotazione(id, prenotazione.getData().toString(), prenotazione.getOrario(),
					prenotazione.getIdDonatore(), prenotazione.getIdSede(), prenotazione.getTipoDonazione(),
					prenotazione.getDisponibilita(), prenotazione.getIdQuestionario());
			db.add(this.prenotazione);
			return this.prenotazione;
		} else
			return creaPrenotazione(id, prenotazione);
	}

	@Override
	public List<Prenotazione> getPrenotazioni() {

		// db.sort(c) {
		//
		// };
		//
		// //CAZZATA
		// Collections.sort(db, new Comparator<Prenotazione>() {
		// @Override
		// public int compare(Prenotazione o1, Prenotazione o2) {
		// return o1.getData().compareTo(o2.getData());
		// }
		// });
		return db;
	}

	@Override
	public Prenotazione getById(UUID idPrenotazione) {
		return db.stream().filter(p -> p.getId().equals(idPrenotazione)).findFirst().orElse(null);
	}

	@Override
	public void deleteById(UUID idPrenotazione) {
		db.remove(getById(idPrenotazione));
	}

	@Override
	public Prenotazione update(UUID id, Prenotazione prenotazione) {
		db.set(db.indexOf(getById(id)), prenotazione);
		prenotazione.setId(id);
		return getById(id);
	}

	@Override
	public List<Prenotazione> getBySede(UUID idSede) {
		return db.stream().filter(p -> p.getIdSede().equals(idSede)).collect(Collectors.toList());
	}

	@Override
	public Prenotazione getByDonatore(UUID idDonatore) {
		return db.stream().filter(p -> p.getIdDonatore().equals(idDonatore)).findFirst().orElse(null);
	}

}
