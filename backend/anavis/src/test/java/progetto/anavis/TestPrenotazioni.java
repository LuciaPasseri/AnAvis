package progetto.anavis;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;
import java.util.UUID;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import progetto.anavis.dao.PrenotazioneDataAccessService;
import progetto.anavis.model.Prenotazione;
import progetto.anavis.model.TipoDonazione;
import progetto.anavis.service.ServicePrenotazione;

@SpringBootTest
@RunWith(SpringRunner.class)
public class TestPrenotazioni {

	@Autowired
	private ServicePrenotazione service;

	@Autowired
	private PrenotazioneDataAccessService repo;

	private Prenotazione uno, due;
	boolean flag = false;

	@Before
	public void set() {
		repo.db.clear();
		repo.db.add(new Prenotazione(UUID.fromString("842093cc-4f11-4bb4-9aa2-b6809f9a2ee7"), "01-03-2020", "15 : 00",
				UUID.fromString("09da317e-11ec-414d-a0ee-f2a3fcd92a6a"),
				UUID.fromString("330c20eb-b8be-489b-a8f8-967385aa675e"), TipoDonazione.PLASMA, false,
				UUID.fromString("f00e544f-9a60-4002-8d92-24258cae39a0")));
		repo.db.add(new Prenotazione(UUID.fromString("24de37f4-3a19-11ea-b77f-2e728ce88125"), "05-03-2020", "9 : 30",
				UUID.fromString("4919c392-e09b-4690-88bf-ea5d1a82c862"),
				UUID.fromString("1a60b7bc-1afd-451c-bb06-368c0b6142c6"), TipoDonazione.SANGUE, false,
				UUID.fromString("243426a6-eae5-4c16-bc8f-5b051e7e2400")));
		repo.db.add(new Prenotazione(UUID.fromString("951273b4-3a19-11ea-b77f-2e728ce88125"), "08-03-2020", "11 : 00",
				UUID.fromString("795c942c-b729-4c7e-ad2d-d065d040d3c5"),
				UUID.fromString("693bfa33-435f-4ddc-be20-6740b6687f7d"), TipoDonazione.SANGUE, false,
				UUID.fromString("35b1c1e1-6e26-466a-9621-cf64632cff9a")));
	}

	@Test
	public void testGetPenotazioni() {
		final List<Prenotazione> test = service.getPrenotazioni();
		assertEquals("[\n"
				+ "Data: 01-03-2020, Orario: 15 : 00, id Sede: 330c20eb-b8be-489b-a8f8-967385aa675e, Disponibilità: false, \n"
				+ "Data: 05-03-2020, Orario: 9 : 30, id Sede: 1a60b7bc-1afd-451c-bb06-368c0b6142c6, Disponibilità: false, \n"
				+ "Data: 08-03-2020, Orario: 11 : 00, id Sede: 693bfa33-435f-4ddc-be20-6740b6687f7d, Disponibilità: false]",
				test.toString());
	}

	@Test
	public void testGetPenotazioneById() {
		assertEquals(service.getById(UUID.fromString("842093cc-4f11-4bb4-9aa2-b6809f9a2ee7")).toString(), "\n"
				+ "Data: 01-03-2020, Orario: 15 : 00, id Sede: 330c20eb-b8be-489b-a8f8-967385aa675e, Disponibilità: false");
		assertEquals(service.getById(UUID.fromString("24de37f4-3a19-11ea-b77f-2e728ce88125")).toString(), "\n"
				+ "Data: 05-03-2020, Orario: 9 : 30, id Sede: 1a60b7bc-1afd-451c-bb06-368c0b6142c6, Disponibilità: false");
		assertEquals(service.getById(UUID.fromString("951273b4-3a19-11ea-b77f-2e728ce88125")).toString(), "\n"
				+ "Data: 08-03-2020, Orario: 11 : 00, id Sede: 693bfa33-435f-4ddc-be20-6740b6687f7d, Disponibilità: false");
	}

	@Test
	public void testPostPenotazioni() {
		uno = service.creaPrenotazione(
				new Prenotazione(null, "02-02-2020", "10 : 00", null, null, TipoDonazione.PLASMA, true, null));
		due = service.creaPrenotazione(
				new Prenotazione(null, "09-02-2020", "08 : 30", null, null, TipoDonazione.SANGUE, false, null));
		assertEquals(1, service.getPrenotazioni().stream().filter(p -> p.getId().equals(uno.getId())).count());
		assertEquals(1, service.getPrenotazioni().stream().filter(p -> p.getId().equals(due.getId())).count());
	}

	@Test
	public void testDeletePenotazioni() {
		service.delete(UUID.fromString("951273b4-3a19-11ea-b77f-2e728ce88125"));
		assertEquals(0, service.getPrenotazioni().stream()
				.filter(p -> p.getId().equals(UUID.fromString("951273b4-3a19-11ea-b77f-2e728ce88125"))).count());
	}

	@Test
	public void testPutPenotazioni() {
		service.update(UUID.fromString("951273b4-3a19-11ea-b77f-2e728ce88125"),
				service.getById(UUID.fromString("842093cc-4f11-4bb4-9aa2-b6809f9a2ee7")));
		assertEquals(2, service.getPrenotazioni().stream()
				.filter(p -> p.getId().equals(UUID.fromString("951273b4-3a19-11ea-b77f-2e728ce88125"))).count());
	}

}
