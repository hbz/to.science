Metadaten-Felder im Formular zugänglich machen
==============================================

Voraussetzungen
---------------

Die vorhergehenden Erweiterungen der labels.json und Java-Klassen entsprechend der Abschnitte 

- "Anlegen neuer Metadaten in der API" und 
- "Anlegen neuer Metadaten in FORMS" 

wurden erledigt.  

Vorgehen
________

Derzeit gibt es zwei Inhaltstypen, für die to.science.forms ein umfangreiches Formular in einem iFrame ausliefert. 
Das sind "Artikel" und Forschungsdaten".
Die Inhaltstypen "Monografie" und "Serie" werden durch ein ganz rudimentäres Formular erfasst, 
dass nur eine HT-Nummer aus dem hbz-Katalog erfragt und diese zum abholen des Titelsatzes aus dem Katalog über die 
lobid2-API verwendet. [#]_

Die Beschreibung bezieht sich hier auf den Inhaltstyp ``ResearchData`` ("Forschungsdaten"), der exemplarisch für die 
notwendigen Erweiterungen steht.
   
1. In der dem Formular zugeordneten Model-Klasse wird für das neue Feld eine get-Methode geschrieben. Wir verwenden hier die Klasse 
``to.science.forms.model.ResearchData.Java`` . [#]_ 

.. code-block:: java
  
    /**
    * @return a map that can be used in an html select
    */
    public static LinkedHashMap<String, String> getAcademicDegreeMap() {
      LinkedHashMap<String, String> map = new LinkedHashMap<>();
      map.put(null, "Bitte wählen Sie...");
      GenericPropertiesLoader GenProp = new GenericPropertiesLoader();
      map.putAll(GenProp.loadVocabMap("AcademicDegree-de.properties"));
      return map;
    }

2. In einem der ScalaTemplates muss anschließend die zuvor deklarierte get-Methode aufgerufen werden. 
Wir nehmen das Template ``creatorWidget.scala.html`` im Package views
 
.. code-block:: scala

    @(myForm:Form[models.ZettelModel],jsonMap:Map[String,Object])
    @import tags._ 
    @import services._
    <div class="multi-field-wrapper" defaultValue="-">
	<ol class="multi-fields" id="creator">
	
		@for(index <- ZettelHelper.getIndex(myForm,jsonMap,"creator") ){
				<li class="multi-field">
		                @ldInputField(myForm,{"creator["+index+"]"},services.ZettelFields.creatorZF.getLabel(),"search",3,ArticleHelper.getPersonLookupEndpoints()){
					  	@helpText("creator")
						}
		                <br />
		              	@singleSelect(myForm,{"academicDegree["+index+"]"},services.ZettelFields.academicDegreeZF.getLabel(),"academicDegree-select",ResearchDataHelper.getAcademicDegreeMap(),5)


Hier wurde ein @singleSelect-Formular gewählt, das wiederum in als scala-Template im views-Package liegt. Die Syntax ist ziemlich undurchsichtig und in Grenzen dokumentiert. [#]_

.. [#] https://lobid.org
.. [#] In diesem Fall soll eine Select-Box erzeugt werden. Die notwendigen Einträge holen wir über die Klasse ``GenericPropertiesLoader.Java`` aus einer ``AcademicDegree-de.properties``-Datei. Damit können wir Einträge der Select-Box auch zur Laufzeit einfach ändern. Die vorherige Methode, in der entsprechenden Methode eine statische Map anzulegen sollte nicht mehr umgesetzt werden.   
.. [#] https://www.playframework.com/documentation/2.8.x/ScalaForms
