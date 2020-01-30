package progetto.anavis;

import java.util.Collections;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import progetto.anavis.api.ControllerPrenotazione;
import progetto.anavis.service.ServicePrenotazione;

@SpringBootTest
@WebMvcTest(value = ControllerPrenotazione.class)
class AnavisApplicationTests {

	@Autowired
	private MockMvc mock;

	@MockBean
	private ServicePrenotazione repository;

	@Test
	void contextLoads() throws Exception {

		Mockito.when(repository.getPrenotazioni()).thenReturn(Collections.emptyList());

		RequestBuilder requestBuilder = MockMvcRequestBuilders.get("/prenotazioni").accept(MediaType.APPLICATION_JSON);

		MvcResult mvcResult = mock.perform(requestBuilder).andReturn();

		System.out.println(mvcResult.getResponse());

		Mockito.verify(repository).getPrenotazioni();

	}

}
