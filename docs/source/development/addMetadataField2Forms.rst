Anlegen neuer Metadaten-Felder in FORMS
=======================================

Voraussetzungen
---------------

1. Das neue Metadaten-Feld muss zunächst in den beiden Dateien ``labels.json`` von to.science.api und to.science.labels definiert werden 
(siehe vorherige Seite).

2. Übernahme der Definition des neuen Feldes aus den ``labels.json`` in die ``labels.json`` von to.science.forms

3. Kopieren der labels.conf in das installationsverzeichnis von to.science.forms  

ja wirklich...

.. image:: ../resources/images/autsch.*
   :alt: Kopf gegen Wand

Vorgehen
________

In den folgenden Java-Klassen müssen zunächst Erweiterungen in Form von Variablen-Deklarationen vorgenommen werden, 
damit das neue Feld auch in den Formularen funktioniert.

.. code-block:: java

    to.science.forms.services.ZettelFields.Java
    to.science.forms.model.ZettelModel.Java


1. In ``ZettelFields`` werden zunächst Verweise auf die Inhalte der ``labels.conf`` erzeugt. Dafür werden "Etikett"-Instanzen angelegt. 
Ist das neue Feld wie im Beispiel ``academicDegree`` als wiederholbares Literal angelegt, werden folgende Deklarationen benötigt:
Das ZF am Ende der Variablen-Deklaration weißt darauf hin, dass es sich um ein "ZettelField" handeln soll.

.. code-block:: java

     public static Etikett academicDegreeZF =
      ZettelHelper.etikett.getEtikett("https://d-nb.info/standards/elementset/gnd#academicDegree");
     public static Etikett academicDegreeIndexZF = 
      ZettelHelper.etikett.getEtikett("http://hbz-nrw.de/regal#academicDegreeIndex");
      
2. In der ``ZettelModel.Java`` werden ebenfalls neue Variablen-Deklarationen als erzeugt

.. code-block:: java

     public abstract class ZettelModel {

       private List<String> academicDegree = new ArrayList<>();
       private String academicDegreeIndex;

3. Die neuen Variablen benötigen ``GETTER, SETTER`` und im Fall der ``ArrayList`` eine add-Methode:

.. code-block:: java

     public abstract class ZettelModel {

     public void setAcademicDegree(List<String> AcademicDegree ) {
       this.academicDegree = academicDegree;
     }

     public List<String> getAcademicDegree(){
       return this.academicDegree;
     }

     public String getAcademicDegreeIndex() {
       return academicDegreeIndex;
     }

     public void setAcademicDegreeIndex(String AcademicDegreeIndex) {
       this.academicDegreeIndex = academicDegreeIndex;
     }
  

4. Anschließend werden die in ``ZettelField`` deklarierten Variablen importiert.
Ggf. wäre es hier ziemlich sinnvoll, sie nicht einzeln zu importieren?

.. code-block:: java

   import static services.ZettelFields.academicTitleZF;
   import static services.ZettelFields.academicTitleIndexZF;
     
5. Sie werden in der Methode ``getMappingForDeserialization`` benötigt und verbinden die Felder mit den ZettelField-Variablen:

.. code-block:: java

	protected Map<String, Consumer<Object>> getMappingForDeserialization() {
		String regalApi = Play.application().configuration().getString("regalApi");
		Map<String, Consumer<Object>> dict = new LinkedHashMap<>();
		
		[...] 
		
		dict.put(academicDegreeZF.uri, (in) -> addAcademicDegree((String) in));
		dict.put(academicDegreeIndexZF.uri, (in) -> setAcademicDegreeIndex((String) in));
		
		[...] 
		        
        }
     


 


