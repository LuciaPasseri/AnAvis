package progetto.anavis;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import java.util.UUID;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import progetto.anavis.dao.DonatoreDataAccessService;
import progetto.anavis.model.Donatore;
import progetto.anavis.model.TipoDonazione;
import progetto.anavis.service.ServiceDonatore;

@SpringBootTest
@RunWith(SpringRunner.class)
public class TestDonatori {

	@Autowired
	private ServiceDonatore service;

	@Autowired
	private DonatoreDataAccessService repo;

	private Donatore sofia, federico;
	boolean flag = false;

	@Before
	public void set() {
		repo.db.clear();
		repo.db.add(new Donatore(UUID.randomUUID(), "Lucia", "Passeri", "lucia.passeri@gmail.com", "0+", "20-01-2020",
				TipoDonazione.SANGUE));
		repo.db.add(new Donatore(UUID.fromString("4919c392-e09b-4690-88bf-ea5d1a82c862"), "Luca", "Cervioni",
				"luca.cervioni@gmail.com", "A+", "05-03-2020", TipoDonazione.SANGUE));
		repo.db.add(new Donatore(UUID.fromString("795c942c-b729-4c7e-ad2d-d065d040d3c5"), "Roberto", "Rossi",
				"roberto.rossi@gmail.com", "AB+", "08-03-2020", TipoDonazione.SANGUE));
		repo.db.add(new Donatore(UUID.fromString("09da317e-11ec-414d-a0ee-f2a3fcd92a6a"), "Matteo", "Bianchi",
				"matteo.bianchi@gmail.com", "A+", "01-03-2020", TipoDonazione.PLASMA));
	}

	@Test
	public void testGetDoantori() {
		final List<Donatore> test = service.getDonatori();
		assertEquals("[\n" + "Nome: Lucia, Cognome: Passeri, Gruppo sanguigno: 0+, \n"
				+ "Nome: Luca, Cognome: Cervioni, Gruppo sanguigno: A+, \n"
				+ "Nome: Roberto, Cognome: Rossi, Gruppo sanguigno: AB+, \n"
				+ "Nome: Matteo, Cognome: Bianchi, Gruppo sanguigno: A+]", test.toString());
	}

	@Test
	public void testGetDonatoreById() {
		assertEquals(service.getById(UUID.fromString("4919c392-e09b-4690-88bf-ea5d1a82c862")).toString(),
				"\n" + "Nome: Luca, Cognome: Cervioni, Gruppo sanguigno: A+");
		assertEquals(service.getById(UUID.fromString("795c942c-b729-4c7e-ad2d-d065d040d3c5")).toString(),
				"\n" + "Nome: Roberto, Cognome: Rossi, Gruppo sanguigno: AB+");
		assertEquals(service.getById(UUID.fromString("09da317e-11ec-414d-a0ee-f2a3fcd92a6a")).toString(),
				"\n" + "Nome: Matteo, Cognome: Bianchi, Gruppo sanguigno: A+");
	}

	@Test
	public void testPostDonatori() {
		sofia = service.creaDonatore(new Donatore(null, "Sofia", "Ricci", "sofia.ricci@gmail.com", "A-", "22-02-2020",
				TipoDonazione.PLASMA));
		federico = service.creaDonatore(new Donatore(null, "Federico", "Carducci", "federico.carducci@gmail.com", "0-",
				"14-11-2019", TipoDonazione.SANGUE));
		assertEquals(1, service.getDonatori().stream().filter(p -> p.getId().equals(sofia.getId())).count());
		assertEquals(1, service.getDonatori().stream().filter(p -> p.getId().equals(federico.getId())).count());
	}

	@Test
	public void testDeleteDonatori() {
		service.delete(UUID.fromString("09da317e-11ec-414d-a0ee-f2a3fcd92a6a"));
		assertEquals(0, service.getDonatori().stream()
				.filter(p -> p.getId().equals(UUID.fromString("09da317e-11ec-414d-a0ee-f2a3fcd92a6a"))).count());
	}

	@Test
	public void testPutDonatori() {
		service.update(UUID.fromString("795c942c-b729-4c7e-ad2d-d065d040d3c5"),
				service.getById(UUID.fromString("09da317e-11ec-414d-a0ee-f2a3fcd92a6a")));
		assertEquals(2, service.getDonatori().stream()
				.filter(p -> p.getId().equals(UUID.fromString("795c942c-b729-4c7e-ad2d-d065d040d3c5"))).count());
	}

}
