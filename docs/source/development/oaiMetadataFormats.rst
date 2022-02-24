Neues Metadaten-Format in die OAI-Schnittstelle integrieren
===========================================================

Die Integration eines neuen Metadatenformats in die OAI-Schnittstelle umfasst Aktivitäten an mehreren Stellen.

1. Java-Klassen erweitern und anpassen
2. Konfiguration der regal-api und des OAI-Providers anpassen
3. Testen der Schnittstelle

Java-Klassen erweitern und anpassen
-----------------------------------

Für die Integration eines neuen Metadaten-Formats in die OAI-Schnittstelle sind die folgenden Dateien relevant.

* regal-api.app.helper.oai/OaiDispatcher.java
* regal-api.app.actions/Transform.java
* regal-api.app.controllers/Resource.java

In diesen drei Klassen müssen an mehreren Stellen Anpassungen, bzw. Erweiterungen des Codes vorgenommen werden, damit das Mapping und die Erstellung 
eines Metadaten-Stroms im System ausgelöst und gesteuert wird.

In der Datei OaiDispatcher.java muss ein zusätzlicher Transformer-Aufruf generiert werden und eine neue Methode addNeuesFormatTransformer erstellt werden. 

 .. code:: java

    private static void addNeuesFormatTransformer(Node node) {
      String type = node.getContentType();
        if ("public".equals(node.getPublishScheme())) {
          if ("monograph".equals(type) || "journal".equals(type)
            || "webpage".equals(type) || "researchData".equals(type)
            || "article".equals(type)) {
              node.addTransformer(new Transformer("neuesFormat"));
          }
        }
      } 


Ebenso muss in die Methode addUnknownTransformer eine zusätzliche If-Abfrage integriert werden.

 .. code:: java

    private static void addUnknownTransformer(List<String> transformers,
      Node node) {
      if (transformers != null) {
        for (String t : transformers) {
          if ("oaidc".equals(t))
            continue; // implicitly added - or not allowed to set
      [...]
          if ("neuesFormat".equals(t))
            continue; // implicitly added - or not allowed to set
          node.addTransformer(new Transformer(t));
        }
      }
    }

In der Methode initContentModels(String namespace)ist dann noch ein zusätzlicher Block transformers.add einzutragen.

 .. code:: java

		transformers.add(new Transformer(namespace + "neuesFormat", "neuesFormat",
				internalAccessRoute + "neuesFormat"));



Die Datei Transform muss anschließend um eine Methode neuesFormat erweitert werden. Diese Methode wird später über eine, in der Datei Resource.java definierte 
ApiOperation "asNeuesFormat" als Restful-Request aufgerufen. Die ApiOperation muss entsprechend auch angelegt werden.  

Das Mappen und die Erzeugung eines Metadatenstroms wurde in der Vergangenheit über unterschiedliche Wege umgesetzt, bei denen ebenfalls mehrere Klassen und ggf.
ScalaViews beteiligt sind.

Im Package helper.oai wird ein neuer Mapper angelegt, über den die im lobid V2-Format zur Verfügung gestellten Metadaten in das neue Format gemappt werden. 
Bisher kamen dafür die Klassen ObjectMapper aus der Jackson Library, models.Pair und entweder ein Datenmodell plus Mapper oder eine Record Klasse zum Einsatz. 

Innerhalb des Packages view.oai mussten bei der Nutzung eines Datenmodells und eines Mappers zusätzlich die Klassen NeuesFormat.scala.html und 
NeuesFormatView.scala.html angelegt werden.Diese steuern das Parsing und die Darstellung des neuen Formats über die Scala-Infrastruktur. 
Im Unterschied dazu erzeugen die Record-Klassen String-Representationen eines XML-Datenstroms.

Um die Umsetzung der neuen Formate zu vereinheitlichen, wurde mehrere neue Klassen eingeführt, die einen strukturierten Zugriff auf das existierende 
(und künftige) lobid-JSON-Format ermöglichen sollen. Aktuell gibt es hier noch verschiedene Issues bei der Verarbeitung komplexer Strukturen aus Arrays und 
Objektelementen, die aber gelöst werden sollen. Um strukturiert zuzugreifen, sollte die Klasse regal-api.app.helper.oai.JsonLDMapper verwendet werden. Damit 
wird auch das Anlegen neuer ScalaViews obsolet.


    
      

Konfiguration der regal-api und des OAI-Providers anpassen
----------------------------------------------------------

Damit das als Dissemination* angelegte neue Format über die regal-api abgefragt werden kann, muss in der Datei conf/routes eine entsprechende Konfigurationszeile erstellt werden.

 .. code:: bash

    GET /resource/:pid.openaire	    controllers.Resource.asOpenAire(pid, validate : Boolean ?= false)

Mit dieseem Eintrag wird eine Verbindung zwischen der entsprechenden Java-Methode und dem über das Play Framework stattfindenden Aufruf über eine HTTP-Methode erreicht.  

Wie zu sehen ist, wird hier auch bestimmt, ob das erstellte Objekt normalerweise gegen eine xsd-Datei validiert werden soll. Im Beispile ist das nicht der Fall: validate : Boolean ?= false. 
In der Datei proai.properties müssen die mit der OAI-Schnittstelle zusammenhängenden Konfigurationen angepasst werden. Die Datei wird direkt im entpackten Applikation-Container angepasst. 

 .. code:: bash

    ################################################
    # Fedora Driver: Metadata Format Configuration #
    ################################################
    # Metadata formats to make available.
    driver.fedora.md.formats = oai_dc epicur mabxml-1 mets rdf oai_wgl oai_openaire
    [...]
    driver.fedora.md.format.oai_ore.loc = http://www.w3.org/2000/07/rdf.xsd
    
    driver.fedora.md.format.oai_openaire.loc = https://www.openaire.eu/schema/repo-lit/4.0/openaire.xsd
    
    [...]

    driver.fedora.md.format.oai_ore.uri = http://www.w3.org/1999/02/22-rdf-syntax-ns#
    
    driver.fedora.md.format.oai_openaire.uri = http://namespace.openaire.eu/schema/oaire/
    
    [...]

    driver.fedora.md.format.oai_dc.dissType = info:fedora/*/CM:oaidcServiceDefinition/oaidc
    
    driver.fedora.md.format.oai_openaire.dissType = info:fedora/*/CM:openaireServiceDefinition/openaire
    


Testen der Schnittstelle
------------------------

Die OAI-Schnittstelle ist über die URL http://api.ellinet-dev.hbz-nrw.de/oai-pmh/ oder analog bei edoweb-test erreichbar.
Der neue ServiceDisseminator kann über die regal-api aufgerufen werden, wenn der in der routes Datei deklarierte Pfad entsprechend aufgerufen wird. 
Obwohl GET als Methode deklariert ist, funktioniert jedoch nur der Aufruf mittels POST. Deshalb kommt cUrl zum Einsatz: curl -XGET -uedoweb-admin localhost:9000/resource/frl%3A6402576.openaire
