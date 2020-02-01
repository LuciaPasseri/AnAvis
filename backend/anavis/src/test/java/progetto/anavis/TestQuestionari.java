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

import progetto.anavis.dao.QuestionarioDataAccessService;
import progetto.anavis.model.Questionario;
import progetto.anavis.service.ServiceQuestionario;

@SpringBootTest
@RunWith(SpringRunner.class)
public class TestQuestionari {

	@Autowired
	private ServiceQuestionario service;

	@Autowired
	private QuestionarioDataAccessService repo;

	private Questionario uno, due;
	boolean flag = false;

	@Before
	public void set() {
		repo.reset();
	}

	@Test
	public void testGetQuestionari() {
		final List<Questionario> test = service.getQuestionari();
		assertEquals(
				"[Id: f00e544f-9a60-4002-8d92-24258cae39a0, Id: 243426a6-eae5-4c16-bc8f-5b051e7e2400, Id: 35b1c1e1-6e26-466a-9621-cf64632cff9a]",
				test.toString());
	}

	@Test
	public void testGetQuestionarioById() {
		assertEquals(service.getById(UUID.fromString("f00e544f-9a60-4002-8d92-24258cae39a0")).toString(),
				"Id: f00e544f-9a60-4002-8d92-24258cae39a0");
		assertEquals(service.getById(UUID.fromString("243426a6-eae5-4c16-bc8f-5b051e7e2400")).toString(),
				"Id: 243426a6-eae5-4c16-bc8f-5b051e7e2400");
		assertEquals(service.getById(UUID.fromString("35b1c1e1-6e26-466a-9621-cf64632cff9a")).toString(),
				"Id: 35b1c1e1-6e26-466a-9621-cf64632cff9a");
	}

//	@Test
//	public void testPostQuestionari() {
//		uno = service.creaQuestionario(new Questionario(null, true, false, null, true, false, null, false));
//		uno = service.creaQuestionario(new Questionario(null, true, false, null, true, false, null, false));
//		assertEquals(1, service.getQuestionari().stream().filter(p -> p.getId().equals(uno.getId())).count());
//		assertEquals(1, service.getQuestionari().stream().filter(p -> p.getId().equals(due.getId())).count());
//	}

	@Test
	public void testDeleteQuestionari() {
		service.delete(UUID.fromString("35b1c1e1-6e26-466a-9621-cf64632cff9a"));
		assertEquals(0, service.getQuestionari().stream()
				.filter(p -> p.getId().equals(UUID.fromString("35b1c1e1-6e26-466a-9621-cf64632cff9a"))).count());
	}
//
//	@Test
//	public void testPutQuestionari() {
//		service.update(UUID.fromString("6e705b80-bd4e-4854-8138-a5617695c012"),
//				service.getById(UUID.fromString("330c20eb-b8be-489b-a8f8-967385aa675e")));
//		assertEquals(2, service.getQuestionari().stream()
//				.filter(p -> p.getId().equals(UUID.fromString("6e705b80-bd4e-4854-8138-a5617695c012"))).count());
//	}

}
