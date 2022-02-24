JSON in Java-Klassen überführen
===============================

Mit der Klasse JsonLDMapper steht ein generischer Ansatz zum Einlesen des lobid-JSON (oder anderer JSON-Formate) zur Verfügung, 
der die im JSON liegenden Metadaten in einer einheitlichen Weise für die Verarbeitung zugänglich macht.

Die Einrichtung der Klasse JsonLDMapper verfolgt das Ziel, kommende Änderungen am Datenmodell vom lobid mit möglichst wenig Aufwand in das Repository übernehmen zu können.  

Grundlage bilden die von JSON unterstützten Datentypen. Die in JSON verwendeten Datentypen werden zunächst konzeptuell auf drei Typen reduziert.

- Object
- Array of Values als ArrayList<Hashtable\<String,String\>>
- Key\/Value-Paare als Hashtable\<String,String\>

Der Datentyp Object wird als Container-Element für weitere Datentypen verwendet und rekursiv bis zu den 
elementaren Datentypen Array of Values und key/value-Paare aufgelöst. Die dabei verarbeitete Pfad-Struktur wird 
in der Java-Notation abgebildet und in einem String abgelegt..

Für alle auf den beiden Datentypen Array of Values und Key\/Value-Paare aufbauenden Objekte bietet die Mapper-Klasse vereinheitlichte Instanzen mit analogen Zugriffsmethoden
an. Der JsonLDMapper bietet jeweils die Methode getElement(Pfad), die transparent ArrayList<Hashtable\<String,String\> zurückliefert. 

Über die Iteration über die jeweilige ArrayList stehen damit entweder zusammengehörende Key\/Value zur Verfügung, oder die einzelnen Values eines 
Arrays of Value in Form des Array-Bezeichners aus dem JSON und des jeweiligen Wertes.

Beispiele

Aus dem Array von Literalen "title" 
 
 .. code:: bash
 
 	{record : {title: ["Ausdrücke in Java", "Java Expressions", "Expression de Java"]}}
 
erhält man durch mit dem JsonLDMapper

 .. code:: java

	JsonLDMapper jMapper = new JsonLDMapper(JsonNode); 
	ArrayList<Hashtable<String,String> title = jMapper.getElement("root.record.title");
	
eine **ArrayListe** die aus drei Key/Value-Paaren besteht:

 .. code:: bash
 
	title = "Ausdrücke in Java"
	title = "Java Expressions"
	title = "Expression de Java"
	

Aus dem aus zwei Key/Value-Paaren bestehenden Objekt "creator"

 .. code:: bash
 
 	{record : {creator: { 
 		prefLabel : "Loki Schmidt",
 		@id : "https://orcid.org/000-000-000" }
 	}}

erhält man durch den gleichen Aufruf:
 	
 .. code:: java

	JsonLDMapper jMapper = new JsonLDMapper(JsonNode); 
	ArrayList<Hashtable<String,String> title = jMapper.getElement("root.creator");
	
eine **ArrayListe** die aus zwei Key/Value-Paaren besteht:

 .. code:: bash

	prefLabel = "Loki Schmidt"
	@id : "https://orcid.org/000-000-000"

Damit der in Json verwendete Datentyp weiterhin eindeutig unterscheiden werden kann, besitzt die JsonLDMapper-Klasse zusätzlich die Methoden 
isArray() und isObject(). 

 .. code:: java

	JsonLDMapper jMapper = new JsonLDMapper(JsonNode); 
	boolean test = jMapper.getElement("\root.creator\").isArray();
	

