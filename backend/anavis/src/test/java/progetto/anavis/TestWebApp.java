package progetto.anavis;

import java.util.Collections;

import org.junit.Before;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import progetto.anavis.api.ControllerPrenotazione;

@ContextConfiguration(classes = AnavisApplication.class)
@WebMvcTest(value = ControllerPrenotazione.class)
public class TestWebApp extends AnavisApplicationTests {

	@Autowired
	private WebApplicationContext webApplicationContext;
	
	@Autowired
	ControllerPrenotazione controller;

	private MockMvc mock;

	@Before
	public void setup() {
		mock = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
	}
	
	@Test
	public void testGetPrenotazioni() throws Exception {

		Mockito.when(controller.getPrenotazioni()).thenReturn(Collections.emptyList());

		MvcResult mvcResult = mock
				.perform(MockMvcRequestBuilders.get("/prenotazioni").accept(MediaType.APPLICATION_JSON)).andReturn();

		System.out.println(mvcResult.getResponse());

		Mockito.verify(controller).getPrenotazioni();

	}

}
