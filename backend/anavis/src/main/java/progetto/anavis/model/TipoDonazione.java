package progetto.anavis.model;

import javax.persistence.Entity;

/**
 * Questa classe definisce le due tipologie di donazione che possono essere
 * effettuate.
 * 
 * @author Lucia e Luca
 *
 */

@Entity
public enum TipoDonazione {
	SANGUE, PLASMA;
}