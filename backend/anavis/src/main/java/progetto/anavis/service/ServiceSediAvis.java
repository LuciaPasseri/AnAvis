package progetto.anavis.service;

import java.util.List;

import progetto.anavis.model.SedeAvis;

public class ServiceSediAvis {

	private static ServiceSediAvis serviceSediAvis=null;
	ServicePrenotazioni servicePrenotazioni= ServicePrenotazioni.getInstance();
	List<String> citta;
	
	private ServiceSediAvis() {
		servicePrenotazioni.getSedi(servicePrenotazioni.getPrenotazioni());
	}
	
	public static ServiceSediAvis getInstance() {
		if (serviceSediAvis == null)
			serviceSediAvis = new ServiceSediAvis();
		return serviceSediAvis;
	}
	
	public List<String> getSedi(){
		for (SedeAvis sede : servicePrenotazioni.getSedi(servicePrenotazioni.getPrenotazioni())) {
			citta.add(sede.getCitta());
		}
		return citta;
	}
	
}
