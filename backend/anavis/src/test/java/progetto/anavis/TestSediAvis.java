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

import progetto.anavis.dao.SediDataAccessService;
import progetto.anavis.model.SedeAvis;
import progetto.anavis.service.ServiceSedeAvis;

@SpringBootTest
@RunWith(SpringRunner.class)
public class TestSediAvis {

	@Autowired
	private ServiceSedeAvis service;

	@Autowired
	private SediDataAccessService repo;

	private SedeAvis roma, firenze;
	boolean flag = false;

	@Before
	public void set() {
		repo.reset();
	}
	
	@Test
	public void testGetSedi() {
		final List<SedeAvis> test = service.getSedi();
		assertEquals("[Citta: Ancona, Citta: Camerino, Citta: Civitanova, Citta: Tolentino]", test.toString());
	}

	@Test
	public void testGetSedeById() {
		assertEquals(service.getById(UUID.fromString("330c20eb-b8be-489b-a8f8-967385aa675e")).toString(),
				"Citta: Tolentino");
		assertEquals(service.getById(UUID.fromString("1a60b7bc-1afd-451c-bb06-368c0b6142c6")).toString(),
				"Citta: Civitanova");
		assertEquals(service.getById(UUID.fromString("693bfa33-435f-4ddc-be20-6740b6687f7d")).toString(),
				"Citta: Camerino");
		assertEquals(service.getById(UUID.fromString("6e705b80-bd4e-4854-8138-a5617695c012")).toString(),
				"Citta: Ancona");
	}

	@Test
	public void testPostSedi() {
		roma = service.creaSede(new SedeAvis(null, "Roma", "sede.roma@gmail.com"));
		firenze = service.creaSede(new SedeAvis(null, "Firenze", "sede.firenze@gmail.com"));
		assertEquals(1, service.getSedi().stream().filter(p -> p.getId().equals(roma.getId())).count());
		assertEquals(1, service.getSedi().stream().filter(p -> p.getId().equals(firenze.getId())).count());
	}

	@Test
	public void testDeleteSedi() {
		service.delete(UUID.fromString("6e705b80-bd4e-4854-8138-a5617695c012"));
		assertEquals(0, service.getSedi().stream()
				.filter(p -> p.getId().equals(UUID.fromString("6e705b80-bd4e-4854-8138-a5617695c012"))).count());
	}

	@Test
	public void testPutSedi() {
		service.update(UUID.fromString("6e705b80-bd4e-4854-8138-a5617695c012"),
				service.getById(UUID.fromString("330c20eb-b8be-489b-a8f8-967385aa675e")));
		assertEquals(2, service.getSedi().stream()
				.filter(p -> p.getId().equals(UUID.fromString("6e705b80-bd4e-4854-8138-a5617695c012"))).count());
	}

}