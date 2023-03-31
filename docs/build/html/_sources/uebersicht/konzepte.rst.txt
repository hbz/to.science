Konzepte
********


Objektmodell
------------

Regal realisiert ein einheitliches Objektmodell in dem sich eine
Vielzahl von Publikationstypen speichern lassen. Die Speicherschicht
wird über `Fedora Commons 3 <#_fedora_commons_3>`__ realisiert.

Eine einzelne Publikation besteht i.d.R. aus mehreren `Fedora Commons
3 <#_fedora_commons_3>`__-Objekten, die in einer hierarchischen
Beziehung zueinander stehen.

.. table:: Fedora Object

   +-----------------------+-----------------------+-----------------------+
   | Datenstrom            | Pflicht               | Beschreibung          |
   +=======================+=======================+=======================+
   | DC                    | Ja                    | Von Fedora            |
   |                       |                       | vorgeschrieben. Wird  |
   |                       |                       | für die fedorainterne |
   |                       |                       | Suche verwendet       |
   +-----------------------+-----------------------+-----------------------+
   | RELS-EXT              | Ja                    | Von Fedora            |
   |                       |                       | vorgeschrieben. Wird  |
   |                       |                       | für viele Sachen      |
   |                       |                       | verwendet - (1)       |
   |                       |                       | Hierarchien - (2)     |
   |                       |                       | Steuerung der         |
   |                       |                       | Sichtbarkeiten - (2)  |
   |                       |                       | OAI-Providing         |
   +-----------------------+-----------------------+-----------------------+
   | data                  | Nein                  | Die eigentlichen      |
   |                       |                       | Daten der             |
   |                       |                       | Publikation. Oft ein  |
   |                       |                       | PDF.                  |
   +-----------------------+-----------------------+-----------------------+
   | metadata oder         | Nein                  | Bibliografische       |
   | metadata2             |                       | Metadaten. Metadata2  |
   |                       |                       | wurde mit dem Umstieg |
   |                       |                       | auf die Lobid-API v2  |
   |                       |                       | eingeführt.           |
   +-----------------------+-----------------------+-----------------------+
   | objectTimestamp       | Nein                  | Eine Datei mit einem  |
   |                       |                       | Zeitstempel. Der      |
   |                       |                       | Zeitstempel wird bei  |
   |                       |                       | bestimmten Aktionen   |
   |                       |                       | gesetzt.              |
   +-----------------------+-----------------------+-----------------------+
   | seq                   | Nein                  | Eine Hilfsdatei mit   |
   |                       |                       | einem JSON-Array. Das |
   |                       |                       | Array zeigt an, in    |
   |                       |                       | welcher Reihenfolge   |
   |                       |                       | Kindobjekte           |
   |                       |                       | anzuzeigen sind.      |
   |                       |                       | Dieses Hilfskonstrukt |
   |                       |                       | existiert, da in der  |
   |                       |                       | RELS-EXT keine        |
   |                       |                       | RDF-Listen abgelegt   |
   |                       |                       | werden können.        |
   +-----------------------+-----------------------+-----------------------+
   | conf                  | Nein                  | Websites und          |
   |                       |                       | Webschnitte speichern |
   |                       |                       | in einem              |
   |                       |                       | conf-Datenstrom alle  |
   |                       |                       | Parameter mit denen   |
   |                       |                       | die zugehörige        |
   |                       |                       | Webseite geharvested  |
   |                       |                       | wurde.                |
   +-----------------------+-----------------------+-----------------------+

Die Metadaten werden als ASCII-Kodierte N-Triple abgelegt. Da alle
Fedora-Daten als Dateien im Dateisystem abgelegt werden, ist diese
Veriante besonders robust gegen Speicherfehler. N-Triple ist ein Format,
dass sich Zeilenweise lesen lässt. ASCII ist die einfachste Form der
Textkodierung.

Die Daten werden als "managed"-Datastream in den Objektspeicher der
Fedora abgelegt. Eine Ausnahme bilden Webseiten. Die als WARC
gespeicherten Inhalte werden "unmanaged" lediglich verlinkt. Im Fedora
Objektspeicher wird nur eine Datei mit der ensprechenden Referenz
abgelegt.

.. _namespaces_und_identifier:

Namespaces und Identifier
-------------------------

Jede Regal-Installation arbeitet auf einem festgelegten Namespace. Wenn
über die `regal-api <#_regal_api_2>`__ Objekte angelegt werden, finden
sich diese immer in dem entsprechenden Namespace wieder. Hinter dem
Namespace findet sich, abgetrennt mit einem Dopplepunkt eine
hochlaufende Zahl, die i.d.R. über `Fedora Commons
3 <#_fedora_commons_3>`__ bezogen wird.

Der so zusammengesetzte Identifier kommt in allen Systemkomponenten zum
Einsatz.

.. table:: Beispiel Regal Identifier

   +-----------------------+-----------------+----------------------------------------------+
   | ID                    | Komponente      | URL                                          |
   +=======================+=================+==============================================+
   | regal:1               | drupal          | http://localhost/resource/regal:1            |
   +-----------------------+-----------------+----------------------------------------------+
   | regal:1               | regal-api       | http://api.localhost/resource/regal:1        |
   +-----------------------+-----------------+----------------------------------------------+
   | regal:1               | fedora          | http://localhost:8080/fedora/objects/regal:1 |
   +-----------------------+-----------------+----------------------------------------------+
   | regal:1               | elasticsearch   | http://localhost:9200/regal/_all/regal:1     |
   +-----------------------+-----------------+----------------------------------------------+

.. _deskriptive_metadaten:

Deskriptive Metadaten
---------------------

Regal unterstützt eine große Anzahl von Metadatenfeldern zur
Beschreibung von bibliografischen Ressourcen. Jedes in Regal
verspeicherte Objekt kann mit Hilfe von RDF-Metadaten beschrieben
werden. Das System verspeichert grundsätzlich alle Metadaten, solange
Sie im richtigen Format an die Schnittstelle gespielt werden.

Darüber hinaus können über bestimmte Angaben, bestimmte weitergehende
Funktionen angesteuert werden. Dies betrifft u.a.:

* Anzeige und Darstellung
* Metadatenkonvertierungen
* OAI-Providing
* Suche

Alle bekannten Metadateneinträge werden in der Komponente
`Etikett <#_etikett>`__ verwaltet. In `Etikett <#_etikett>`__ kann
konfiguriert werden, welche URIs aus den RDF-Daten in das JSON-LD-Format
von `regal-api <#_regal_api_2>`__ überführt werden. Außerdem kann die
Reihenfolge der Darstellung, und das Label zur Anzeige gesetzt werden.

.. table:: Etikett-Eintrag für dc:title

   +---------+------------+-------------+--------------------------------+---------+----------+---------+
   | Label   | Pictogram  | Name (json) | URI                            | Type    | Container| Comment |
   +=========+============+=============+================================+=========+==========+=========+
   | Titel   | keine      | title       | http://purl.org/dc/terms/title | String  | keine    | keine   |
   |         | Angabe     |             |                                |         | Angabe   | Angabe  |
   +---------+------------+-------------+--------------------------------+---------+----------+---------+

**Etikett-Eintrag als Json.**

.. code-block:: 

   "title":{ "@id"="http://purl.org/dc/terms/title", "label"="Titel" }

Die etikett Datenbank wird beim Neustart jeder
`regal-api <#_regal_api_2>`__-Instanz eingelesen. Außerdem wird die
HTTP-Schnittstelle von Etikett immer wieder angesprochen um zur Anzeige
geeignete Labels in das System zu holen und anstatt der rohen URIs
einzublenden. Das `regal-api <#_regal_api_2>`__-Modul läuft dabei auch
ohne den Etikett-Services, allerdings nur mit eingeschränkter
Funktionalität; beispielsweise fallen Anzeigen von verlinkten Ressourcen
(und das ist in Regal fast alles) weniger schön aus.

.. _wie_kommen_bibliografische_metadaten_ins_system:

Wie kommen bibliografische Metadaten ins System?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In Regal können bibliografische Metadaten aus dem hbz-Verbundkatalog an
Ressourcen "angelinkt" werden. Dies erfolgt über Angabe der ID des
entsprechenden Titelsatzes (z.b. HT017766754). Mit Hilfe dieser ID kann
Regal einen Titelimport durchführen. Dabei wird auf die Schnittstellen
der `Lobid-API <https://lobid.org>`__ zugegriffen.

Regal bietet außerdem die Möglichkeit, Metadaten über Erfassungsmasken
zu erzeugen und zu speichern. Dies erfolgt mit Hilfe des Moduls
`Zettel <#_zettel>`__. `Zettel <#_zettel>`__ ist ein Webservice, der
verschiedene HTML-Formulare bereitstellt. Die Formulare können
RDF-Metadaten einlesen und ausgeben. Zettel-Formulare werden über
Javascript mit Hilfe eines IFrame in die eigentliche Anwendung
angebunden. Über Zettel werden Konzepte aus dem Bereich Linked Data
umgesetzt. So können Feldinhalte über entsprechende Eingabeelemente in
Drittsystemen recherchiert und verlinkt werden. Die Darstellung von
Links erfolgt in Zettel mit Hilfe von `Etikett <#_etikett>`__.
Umfangreichere Notationssysteme wie Agrovoc oder DDC werden über einen
eigenen Index aus dem Modul `skos-lookup <#_skos_lookup>`__ eingebunden.
Zettel unterstützt zur Zeit folgende Linked-Data-Quellen:

*  `Lobid (GND) <https://lobid.org/gnd>`__
*  `Lobid (Ressource) <https://lobid.org/resources>`__
*  `Agrovoc <http://aims.fao.org/vest-registry/vocabularies/agrovoc>`__
*  `DDC <https://www.oclc.org/en/dewey.html>`__
*  `CrossRef (Funder Registry) <https://www.crossref.org/services/funder-registry/>`__
*  `Orcid <https://orcid.org/>`__
*  `Geonames <https://www.geonames.org/>`__
*  `Open Street Maps Koordinaten <https://www.openstreetmap.org>`__

.. _anzeige_und_darstellung:

Anzeige und Darstellung
-----------------------

Über die Schnittstellen der `regal-api <#_regal_api_2>`__ können
unterschiedliche Darstellungen einer Publikation bezogen werden. Über
`Content
Negotiation <https://de.wikipedia.org/wiki/Content_Negotiation>`__
können Darstellungen per HTTP-Header angefragt werden. Um
unterschiedliche Darstellungen im Browser anzeigen zu lassen, kann
außerden, über das Setzen von entsprechenden Endungen, auf
unterschiedliche Representationen eine Resource zugegriffen werden.

**Auswahl von Pfaden zu unterschiedlichen Representationen einer
Ressource.**

/resource/regal:1 /resource/regal:1.json /resource/regal:1.rdf
/resource/regal:1.epicur /resource/regal:1.mets

In der HTML-Darstellung greift `regal-api <#_regal_api_2>`__ auf den
Hilfsdienst `Thumby <#_thumby>`__ zu um darüber Thumbnail-Darstellungen
von PDFs oder Bilder zu kreieren. Bei großen Bildern wird außerdem der
`Deepzoomer <#_deepzoomer>`__ angelinkt, der eine Darstellung von
hochauflösenden Bildern über das Tool
`OpenSeadragon <https://openseadragon.github.io/>`__ erlaubt. Video- und
Audio-Dateien werden über die entsprechenden HTML5 Elemente gerendert.

.. _der_hbz_verbundkatalog:

Der hbz-Verbundkatalog
----------------------

Metadaten, die über den Verbundkatalog importiert wurden, können über
einen Cronjob regelmäßig aktualisiert werden. Außerdem können diese
Daten über OAI-PMH an den Verbundkatalog zurückgeliefert werden, so dass
dieser, Links auf die Volltexte erhält.

.. _metadatenkonvertierung:

Metadatenkonvertierung
----------------------

Für die Metadatenkonvertierung gibt es kein festes Vorgehensmodell oder
Werkzeug. I.d.R. gibt es für jede Representation eine oder eine Reihe
von Javaklassen, die für eine On-the-fly-Konvertierung sorgen. Die
HTML-Darstellung basiert grundlegend auf denselben Daten, die auch im
`Elasticsearch <https://www.elastic.co/guide/index.html>`__-Index liegen
und ist im wesentlichen eine JSON-LD-Darstellung, die mit Hilfe der in
`Etikett <#_etikett>`__ hinterlegten Konfiguration aus den
bibliografischen Metadaten gewonnen wurde.

.. _oai_providing:

OAI-Providing
-------------

Öffentlich zugängliche Publikationen sind auch über die
OAI-Schnittstelle verfügbar. Dabei wird jede Publikation einer Reihe von
OAI-Sets zugeordnet und in unterschiedlichen Formaten angeboten.

.. table:: OAI Set

   +-----------------------------------+-----------------------------------+
   | Set                               | Kriterium                         |
   +===================================+===================================+
   | ddc:\*                            | Wenn ein dc:subject mit dem       |
   |                                   | String "http://dewey.info/class/" |
   |                                   | beginnt, wird ein Set mit der     |
   |                                   | entsprechenden DDC-Nummer         |
   |                                   | gebildet und die Publikation wird |
   |                                   | zugeordnet                        |
   +-----------------------------------+-----------------------------------+
   | contentType                       | Der "contentType" weist darauf    |
   |                                   | hin, in welcher Weise die         |
   |                                   | Publikation in to.science abgelegt|
   |                                   | ist.                              |
   +-----------------------------------+-----------------------------------+
   | open_access                       | All Publikationen, die als        |
   |                                   | Sichtbarkeit "public" haben       |
   +-----------------------------------+-----------------------------------+
   | urn-set-1                         | Publikationen mit einer URN, die  |
   |                                   | mit urn:nbn:de:hbz:929:01 beginnt |
   +-----------------------------------+-----------------------------------+
   | urn-set-2                         | Publikationen mit einer URN, die  |
   |                                   | mit urn:nbn:de:hbz:929:02 beginnt |
   +-----------------------------------+-----------------------------------+
   | epicur                            | Publikationen, die in einem       |
   |                                   | URN-Set sind                      |
   +-----------------------------------+-----------------------------------+
   | aleph                             | Publikationen , die mit einer     |
   |                                   | Aleph-Id verknüpft sind           |
   +-----------------------------------+-----------------------------------+
   | edoweb01                          | spezielles, pro                   |
   |                                   | to.science-Instanz                |
   |                                   | konfigurierbares Set für alle     |
   |                                   | Publikationen, die im aleph-Set   |
   |                                   | sind                              |
   +-----------------------------------+-----------------------------------+
   | ellinet01                         | spezielles, pro                   |
   |                                   | to.science-Instanz                |
   |                                   | konfigurierbares Set für alle     |
   |                                   | Publikationen, die im aleph-Set   |
   |                                   | sind                              |
   +-----------------------------------+-----------------------------------+

.. table:: OAI Metadatenformat

   +-----------------------------------+-----------------------------------+
   | Format                            | Kriterium                         |
   +===================================+===================================+
   | oai_dc                            | Alle öffentlich sichtbaren        |
   |                                   | Objekte, die als bestimmte        |
   |                                   | ContentTypes angelegt wurden.     |
   +-----------------------------------+-----------------------------------+
   | epicur                            | Alle Objekte, die eine URN haben  |
   +-----------------------------------+-----------------------------------+
   | aleph                             | Alle Objekte, die einen           |
   |                                   | persistenten Identifier haben     |
   +-----------------------------------+-----------------------------------+
   | mets                              | Wie oai_dc                        |
   +-----------------------------------+-----------------------------------+
   | rdf                               | Wie oai_dc                        |
   +-----------------------------------+-----------------------------------+
   | wgl                               | Format für LeibnizOpen. Alle      |
   |                                   | Objekte die über das Feld         |
   |                                   | "collectionOne" einer Institution |
   |                                   | zugeordnet wurden und über den    |
   |                                   | ContentType "article"             |
   |                                   | eingeliefert wurden.              |
   +-----------------------------------+-----------------------------------+

.. _suche:

Suche
-----

Der Elasticsearch-Index wird mit Hilfe einer JSON-LD Konvertierung
befüllt. Die Konvertierung basiert im wesentlichen auf den
bibliografischen Metadaten der einzelnen Ressourcen und wir mit Hilfe
der in `Etikett <#_etikett>`__ hinterlegten Konfiguration erzeugt.

.. _zugriffsberechtigungen_und_sichtbarkeiten:

Zugriffsberechtigungen und Sichtbarkeiten
-----------------------------------------

Regal setzt ein rollenbasiertes Konzept zur Steuerung von
Zugriffsberechtigungen um. Eine besondere Bedeutung kommt dem lesenden
Zugriff auf Ressourcen zu. Einzelne Ressourcen können in ihrer
Sichtbarkeit so eingeschränkt werden, dass nur mit den Rechten einer
bestimmten Rolle lesend zugegriffen werden kann. Dabei kann der Zugriff
auf Metadaten und Daten separat gesteuert werden.

.. figure:: ../resources/images/accessControl.png
   :alt: Screenshot zur Verdeutlichung von Sichtbarkeiten in Regal

   Screenshot zur Verdeutlichung von Sichtbarkeiten in Regal

Die Konfiguration hat Auswirkungen auf die Sichtbarkeit einer
Publikation in den unterschiedlichen Systemteilen. Die folgende Tabelle
veranschaulicht den derzeitigen Stand der Implementierung.

.. _sichtbarkeiten_operationen_rollen:

Sichtbarkeiten, Operationen, Rollen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. table:: **Schreibender** Zugriff auf Daten und Metadaten

   +-----------------------------------+-----------------------------------+
   | Rolle                             | Art der Aktion                    |
   +-----------------------------------+-----------------------------------+
   | ADMIN                             | Darf alle Aktionen durchführen.   |
   |                                   | Auch Bulk-Aktionen und "Purges"   |
   +-----------------------------------+-----------------------------------+
   | EDITOR                            | Darf Objekte anlegen, löschen,    |
   |                                   | Sichtbarkeiten ändern, etc.       |
   +-----------------------------------+-----------------------------------+

.. table:: **Lesender** Zugriff auf Metadaten

   +-----------------------------------+-----------------------------------+
   | Sichtbarkeit                      | Rolle                             |
   +===================================+===================================+
   | public                            | GUEST, READER,                    |
   |                                   | SUBSCRIBER, REMOTE, ADMIN, EDITOR |
   +-----------------------------------+-----------------------------------+
   | private                           | ADMIN, EDITOR                     |
   +-----------------------------------+-----------------------------------+

.. table:: **Lesender** Zugriff auf Daten

   +-----------------------------------+-----------------------------------+
   | Sichtbarkeit                      | Rolle                             |
   +===================================+===================================+
   | public                            | GUEST, READER,                    |
   |                                   | SUBSCRIBER, REMOTE, ADMIN, EDITOR |
   +-----------------------------------+-----------------------------------+
   | restricted                        | READER,                           |
   |                                   | SUBSCRIBER, REMOTE, ADMIN, EDITOR |
   +-----------------------------------+-----------------------------------+
   | remote                            | READER,                           |
   |                                   | SUBSCRIBER, REMOTE, ADMIN, EDITOR |
   +-----------------------------------+-----------------------------------+
   | single                            | SUBSCRIBER, ADMIN, EDITOR         |
   +-----------------------------------+-----------------------------------+
   | private                           | ADMIN, EDITOR                     |
   +-----------------------------------+-----------------------------------+

.. _benutzerverwaltung:

Benutzerverwaltung
------------------

Die Benutzerverwaltung von Regal findet innerhalb von Drupal statt. Zwar
können auch in der to.science.api Benutzer angelegt
werden, jedoch ist die Implementierung in diesem Bereich erst
rudimentär.

.. _drupal:

Drupal
~~~~~~

Benutzer in Drupal können über das Modul
`regal-drupal <#_regal_drupal>`__ unterschiedlichen Rollen zugewiesen
werden. Die Authorisierung erfolgt passwortbasiert. Alle Drupal-Benutzer
greifen über einen vorkonfigurierten Accessor auf die
`regal-api <#_regal_api_2>`__ zu. Alle Zugriffe erfolgen verschlüsselt
unter Angabe eines Passwortes. Die Rolle mit deren Berechtigungen
zugegriffen wird, wird dabei in `regal-drupal <#_regal_drupal>`__
gesetzt. Die Drupal-BenutzerId wird als Metadatum in Form eines
proprietären HTTP-Headers mit an `regal-api <#_regal_api_2>`__
geliefert.

.. _regal_api:

Regal-Api
~~~~~~~~~

Auch in regal-api können Api-Benutzer angelegt werden. Zur
Benutzerverwaltung wird eine MySQL-Datenbank eingesetzt, in der die
Passworte der Nutzer abgelegt sind.

.. _ansichten:

Ansichten
---------

Um Daten, die in `regal-api <#_regal_api_2>`__ abgelegt wurden zur
Anzeige zu bringen sind i.d.R. mehrere Schritte nötig. Die genaue
Vorgehensweise ist davon abhängig, wo die Daten abgelegt werden (in
welchem Fedora Datenstrom). Grundsätzlich basiert die HTML-Darstellung
auf den Daten, die unter dem Format ``.json2`` einer Ressource abrufbar
sind und einen Eintrag in context.json haben.


**Daten zur Ansicht bringen**

1. Eintrag des zugehörigen RDF-Properties in die entsprechende
   `Etikett <#_etikett>`__-Instanz, bzw. in die ``/conf/labels.json``.
   Der Eintrag muss einen Namen, ein Label und einen Datentyp haben.
   `regal-api <#_regal_api_2>`__ neu starten, bzw mit
   ``POST /context.json`` das neu Laden der Contexteinträge erzwingen.

2. Dies müsste reichen, um eine Standardanzeige in der HTML-Ausgabe zu
   erreichen

3. Wenn die Daten nicht erscheinen, sollte man überprüfen, ob sie unter
   dem Format ``.json2`` erscheinen. Wenn nicht, stellt sich die Frage,
   wo die Daten abgelegt werden. Komplett werden nur die Daten aus dem
   Fedora Datenstrom /metadata2 prozessiert. Befindet sich das Datum in
   z.B. im /RELS-EXT Datenstrom so muss es zunächst manuell unter
   ``helper.JsonMapper#getLd2()`` in das JSON-Objekt eingefügt werden.

4. Einige Felder werden auch ausgeblendet. Dies geschieht in
   `regal-api <#_regal_api_2>`__ unter ``/public/stylesheets/main.css``
   und in Drupal innerhalb der entsprechenden themes.

5. Um spezielle Anzeigen zu realisieren muss schließlich im
   HTML-Template angefasst werden, unter
   ``/app/views/tags/resourceView.scala.html`` .

Insgesamt läuft es also so: Alles was in `Etikett <#_etikett>`__
konfiguriert ist, wird auch ins JSON und damit ins HTML und in den
Suchindex übernommen. Dinge, die im HTML nicht benötigt werden, werden
über CSS wieder ausgeblendet.

