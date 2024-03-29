.. _software:

Software
********

Die technische Dokumentation der HTTP-Schnittstelle findet sich unter
:ref:`api_documentation`:

Nachfolgend sei eine Innenansicht der einzelnen Module aufgestellt. Die
Integration der Module erfolgt i.d.R. über HTTPs. Die Module werden über
entsprechende Einträge in der Apache-Konfiguration sichtbar gemacht. Es
handelt sich also um eine Webservice-Architektur, in der alle
Webservices über einen Apache-Webserver und entsprechende Einträge in
ihren Konfigurationsdateien miteinander verbunden werden.

.. figure:: ../resources/images/regal-dependencies.jpeg
   :alt: Regal Abhängigkeiten

   Regal Abhängigkeiten

.. _regal_api_2:

regal-api
---------

.. table:: Überblick

   +-----------------------------------+-----------------------------------+
   | Source                            | `regal-api <https:                |
   |                                   | //github.com/edoweb/regal-api>`   |
   +-----------------------------------+-----------------------------------+
   | Technik                           | `Play                             |
   |                                   | 2.4                               |
   |                                   | .2 <https://www.playframework.com |
   |                                   | /documentation/2.4.x/JavaHome>`   |
   +-----------------------------------+-----------------------------------+
   | Ports                             | 9000 / 9100                       |
   +-----------------------------------+-----------------------------------+
   | Verzeichnis                       | /opt/regal/apps/regal ,           |
   |                                   | /opr/regal/src/regal              |
   +-----------------------------------+-----------------------------------+
   | HTTP Pfad                         | /                                 |
   +-----------------------------------+-----------------------------------+

Mit regal-api werden alle grundlegenden Funktionen von Regal
bereitgestellt. Dies umfasst:

-  HTTP Schnittstelle

-  Sichtbarkeiten, Zugriffskontrolle, Rollen

-  Speicherung, Datenhaltung

-  Konvertierungen

-  Ansichten

-  Suche

-  Webarchivierung

Der Webservice ist auf Basis von `Play
2.4.2 <https://www.playframework.com/documentation/2.4.x/JavaHome>`_
realisiert und bietet eine reichhaltig HTTP-API zur Verwaltung von
elektronischen Publikationen an. Die `regal-api <#_regal_api_2>`_
operiert auf `Fedora Commons 3 <#_fedora_commons_3>`_,
`MySql <#_mysql>`__ und `Elasticsearch 1.1 <#_elasticsearch_1_1>`_.
Über die API werden auch Funktionalitäten von `Etikett <#_etikett>`_,
`Thumby <#_thumby>`_, `Zettel <#_zettel>`_ und
`Deepzoomer <#_deepzoomer>`_ angesprochen. Für die Webarchivierung
werden `heritrix <#_heritrix>`_, `wpull <#_wpull>`_ und
`openwayback <#_openwayback>`_ angebunden.

.. _konfiguration:

Konfiguration
~~~~~~~~~~~~~

.. table:: Dateien im /conf Verzeichnis

   +-----------------------------------+-----------------------------------+
   | Datei                             | Beschreibung                      |
   +===================================+===================================+
   | **aggregations.conf**             | Diese Datei wird verwendet um die |
   |                                   | Schnittstelle ``/browse`` zu      |
   |                                   | konfigurieren. Die Einträg im     |
   |                                   | Object "aggs" können direkt über  |
   |                                   | die ``/browse`` Schnittstelle     |
   |                                   | angesprochen werden. Mit Hilfe    |
   |                                   | des Elasticsearch-Indexes wird    |
   |                                   | dann eine entsprechende Antwort   |
   |                                   | generiert. Beispiel:              |
   |                                   | ``/browse/rdftype`` liefert eine  |
   |                                   | Liste mit allen                   |
   |                                   | Publikationstypen, die im Index   |
   |                                   | vorhanden sind.                   |
   +-----------------------------------+-----------------------------------+
   | **application.conf.tmpl**         | Eine template Datei für die       |
   |                                   | Hauptkonfiguration von            |
   |                                   | `regal-api <#_regal_api_2>`__.    |
   |                                   | Diese Datei sollte zur lokalen    |
   |                                   | Verwendung einmal nach            |
   |                                   | application.conf kopiert werden.  |
   |                                   | In der Datei sind alle Passwörter |
   |                                   | auf *admin* gesetzt.              |
   +-----------------------------------+-----------------------------------+
   | crawler-beans.cxml                | Die Datei wird verwendet, wenn im |
   |                                   | Webarchivierungsmodul eine neue   |
   |                                   | Konfiguration für eine Webseite   |
   |                                   | angelegt wird.                    |
   +-----------------------------------+-----------------------------------+
   | ehcache.xml                       | die Konfiguration der Ehcache     |
   |                                   | Komponente                        |
   +-----------------------------------+-----------------------------------+
   | fedora-users.xml                  | deprecated - Zur Löschung         |
   |                                   | vorgeschlagen                     |
   +-----------------------------------+-----------------------------------+
   | hbz_edoweb_url.txt                | deprecated - Zur Löschung         |
   |                                   | vorgeschlagen                     |
   +-----------------------------------+-----------------------------------+
   | html.html                         | deprecated - Zur Löschung         |
   |                                   | vorgeschlagen                     |
   +-----------------------------------+-----------------------------------+
   | install.properties                | deprecated - Zur Löschung         |
   |                                   | vorgeschlagen                     |
   +-----------------------------------+-----------------------------------+
   | labels-edoweb.de                  | Labels für eine bestimmt          |
   |                                   | Regal-Instanz                     |
   +-----------------------------------+-----------------------------------+
   | labels-for                        | deprecated - Zur Löschung         |
   | -proceeding-and-researchData.json | vorgeschlagen                     |
   +-----------------------------------+-----------------------------------+
   | labels-lobid.json                 | deprecated - Zur Löschung         |
   |                                   | vorgeschlagen                     |
   +-----------------------------------+-----------------------------------+
   | labels-publisso.de                | Labels für eine bestimmte         |
   |                                   | Regal-Instanz                     |
   +-----------------------------------+-----------------------------------+
   | **labels.json**                   | Eine sinnvolle                    |
   |                                   | Startkonfiguration. Die Datei     |
   |                                   | wurde mit `Etikett <#_etikett>`__ |
   |                                   | erzeugt. Beim Start von           |
   |                                   | `regal-api <#_regal_api_2>`__     |
   |                                   | wird zunächst versucht eine       |
   |                                   | ähnliche Konfiguration direkt von |
   |                                   | einer laufenden                   |
   |                                   | `Etikett <#_etikett>`__-Instanz   |
   |                                   | zu holen. Wenn dies nicht klappt, |
   |                                   | wird auf die labels.json          |
   |                                   | zurückgegriffen.                  |
   +-----------------------------------+-----------------------------------+
   | list.html                         | deprecated - Zur Löschung         |
   |                                   | vorgeschlagen                     |
   +-----------------------------------+-----------------------------------+
   | logback.developer.xml             | Eine logging Konfiguration. Ich   |
   |                                   | kopiere die immer nach            |
   |                                   | logback.developer.js.xml (in      |
   |                                   | .gitignore) und trage sie dann in |
   |                                   | die application.conf ein. Auf     |
   |                                   | diese Weise kann ich an Loglevels |
   |                                   | herumkonfigurieren ohne das in    |
   |                                   | diese Änderungen in die           |
   |                                   | Versionsverwaltung spielen zu     |
   |                                   | müssen.                           |
   +-----------------------------------+-----------------------------------+
   | logback.xml                       | Konfiguration des Loggers. Diese  |
   |                                   | Datei ist in application.conf     |
   |                                   | eingetragen.                      |
   +-----------------------------------+-----------------------------------+
   | mab                               | Eine template-Datei zur           |
   | xml-string-template-on-record.xml | Generierung von MAB-Ausgaben.     |
   +-----------------------------------+-----------------------------------+
   | mail.properties                   | Konfiguration zur Versendung von  |
   |                                   | Mails. Standardmäßig schickt die  |
   |                                   | Applikation eine Mail, sobald sie |
   |                                   | im Production-Mode neu gestartet  |
   |                                   | wurde. Auch der Umzugsservice im  |
   |                                   | Webarchivierungsmodul verschickt  |
   |                                   | Mails.                            |
   +-----------------------------------+-----------------------------------+
   | nwbib-spatial.ttl                 | deprecated - Zur Löschung         |
   |                                   | vorgeschlagen                     |
   +-----------------------------------+-----------------------------------+
   | nwbib.ttl                         | deprecated - Zur Löschung         |
   |                                   | vorgeschlagen                     |
   +-----------------------------------+-----------------------------------+
   | **public-index-config.json**      | Konfiguration des                 |
   |                                   | Elasticsearch-Indexes. Da in dem  |
   |                                   | Index vorallem Metadaten liegen,  |
   |                                   | soll fast nicht tokenisiert       |
   |                                   | werden.                           |
   +-----------------------------------+-----------------------------------+
   | **routes**                        | Hier sind alle HTTP-Pfade         |
   |                                   | übersichtlich aufgeführt.         |
   +-----------------------------------+-----------------------------------+
   | scm-info.sh                       | Diese Datei kann man unter Linux  |
   |                                   | in die profile-Konfiguration      |
   |                                   | seines Benutzers einbinden. Dann  |
   |                                   | erhält man im Terminal farbige    |
   |                                   | Angabgen zu Git-Branches,etc.     |
   +-----------------------------------+-----------------------------------+
   | start-regal.sh                    | deprecated - Zur Löschung         |
   |                                   | vorgeschlagen                     |
   +-----------------------------------+-----------------------------------+
   | tomcat-users.xml                  | deprecated - Zur Löschung         |
   |                                   | vorgeschlagen                     |
   +-----------------------------------+-----------------------------------+
   | unescothes.ttl                    | deprecated - Zur Löschung         |
   |                                   | vorgeschlagen                     |
   +-----------------------------------+-----------------------------------+
   | wglcontributor.csv                | deprecated - Zur Löschung         |
   |                                   | vorgeschlagen                     |
   +-----------------------------------+-----------------------------------+

.. _die_applikation:

Die Applikation
~~~~~~~~~~~~~~~

.. table:: Das /app Verzeichnis

   +-----------------------------------+-----------------------------------+
   | Package                           | Beschreibung                      |
   +===================================+===================================+
   | default package                   | Hier befindet sich die Datei      |
   |                                   | Global, die in `Play              |
   |                                   | 2                                 |
   |                                   | .4 <https://www.playframework.com |
   |                                   | /documentation/2.4.x/JavaHome>`__ |
   |                                   | noch eine große Rolle spielt. In  |
   |                                   | der Datei können zum Beispiel     |
   |                                   | Aktionen vor dem Start der        |
   |                                   | Applikation erfolgen, auch können |
   |                                   | hier HTTP-Requests mit geloggt    |
   |                                   | werden. Bestimmte Aktionen werden |
   |                                   | nur im Production-Mode            |
   |                                   | ausgeführt, d.h. nur wenn die     |
   |                                   | Applikation mit ``start``         |
   |                                   | gestartet wurde oder über         |
   |                                   | ``dist`` ein entsprechendes       |
   |                                   | Binary erzeugt wurde.             |
   +-----------------------------------+-----------------------------------+
   | actions                           | Hier sind Funktionen versammelt,  |
   |                                   | die meist unmittelbar aus den     |
   |                                   | Controller-Klassen aufgerufen     |
   |                                   | werden.                           |
   +-----------------------------------+-----------------------------------+
   | archive.fedora                    | Ein Reihe von Dateien, über die   |
   |                                   | Zugriffe auf `Fedora Commons      |
   |                                   | 3 <#_fedora_commons_3>`__         |
   |                                   | organisiert werden. Hier finden   |
   |                                   | sich auch einige Hilfsklassen     |
   |                                   | (``Utils``). Das FedoraInterface  |
   |                                   | zeigt an, welche Aktionen auf der |
   |                                   | Fedora ausgeführt werden. Der     |
   |                                   | Code in diesem Paket gehört mit   |
   |                                   | zu dem ältesten Code im gesamten  |
   |                                   | Regal-Projekt.                    |
   +-----------------------------------+-----------------------------------+
   | archive.search                    | Zugriff auf die Elasticsearch     |
   +-----------------------------------+-----------------------------------+
   | authenticate                      | Regal verwendet Basic-Auth zur    |
   |                                   | Authentifizierung. Um die         |
   |                                   | entsprechenden Aufrufe in den     |
   |                                   | Controllern zu Schützen wird eine |
   |                                   | Annotation ``@BasicAuth``         |
   |                                   | verwendet. Diese findet sich      |
   |                                   | hier. Die Annotation selbst       |
   |                                   | bewirkt, dass jeder               |
   |                                   | Controller-Aufruf durch die       |
   |                                   | Methode ``basicAuth`` der Klasse  |
   |                                   | ``BasicAuthAction.java`` läuft.   |
   |                                   | Ziel dieser Prozedur ist es, dem  |
   |                                   | aktuellen Zugriff die             |
   |                                   | Berechtigungen einer bestimmten   |
   |                                   | Rolle zuzuordnen.                 |
   +-----------------------------------+-----------------------------------+
   | controllers                       | Der Code, der in diesen Klassen   |
   |                                   | organisiert ist, wird bei den     |
   |                                   | entsprechenden HTTP-Aufrufen      |
   |                                   | ausgeführt. In der                |
   |                                   | ``/conf/routes`` Datei kann man   |
   |                                   | sehen, welcher HTTP-Aufruf,       |
   |                                   | welchen Methoden-Aufruf zur Folge |
   |                                   | hat. Die Controller-Klassen sind  |
   |                                   | i.d.R. von der Klasse             |
   |                                   | MyController abgeleitet, die      |
   |                                   | Hilfsfunktionen bereitstellt,     |
   |                                   | aber auch Funktionen zur          |
   |                                   | Überprüfung von Zugriffsrechten.  |
   |                                   | Die Überprüfung von               |
   |                                   | Zugriffsrechten erfolgt durch     |
   |                                   | eingebettet Calls und wird über   |
   |                                   | die internen Klassen von          |
   |                                   | MyController realisiert.          |
   |                                   | Beispiel: Die Funktion            |
   |                                   | ``listNodes`` in der Klasse       |
   |                                   | ``controllers.Resource`` ruft     |
   |                                   | ihre Prozeduren eingebettet in    |
   |                                   | eine Funktion der Klasse          |
   |                                   | ``ListAction`` auf. Die Klasse    |
   |                                   | ``ListAction`` ist in             |
   |                                   | ``MyController`` implementiert    |
   |                                   | und überprüft, ob der Aufruf mit  |
   |                                   | der nötigen Berechtigung          |
   |                                   | erfolgte. Vgl.                    |
   |                                   | `Zugriffsberechtigungen und       |
   |                                   | Sichtbarkeiten <#_zugriffsbere    |
   |                                   | chtigungen_und_sichtbarkeiten>`__ |
   +-----------------------------------+-----------------------------------+
   | converter.mab                     | Diese Datei realisiert das        |
   |                                   | OAI-Providing von MAB-Daten.      |
   |                                   | Ursprünglich war geplant,         |
   |                                   | wesentlich umfangreichere         |
   |                                   | MAB-Datensätze an den             |
   |                                   | Verbundkatalog zu liefern. Daher  |
   |                                   | wird hier mit einer eigenen       |
   |                                   | Template-Engine gearbeitet, etc.  |
   |                                   | Ein lustiges Produkt in diesem    |
   |                                   | Kontext ist auch die Klasse       |
   |                                   | ``models.MabRecord``.             |
   +-----------------------------------+-----------------------------------+
   | de.hbz.lobid.helper               | Der hier befindliche Code kommt   |
   |                                   | ursprünglich aus einem anderen    |
   |                                   | Paket, wurde dann aber beim       |
   |                                   | Neuaufbau des Lobid 2             |
   |                                   | Datendienstes gemeinsam mit den   |
   |                                   | Kollegen weiterentwickelt und ist |
   |                                   | schließlich wieder hier gelandet. |
   |                                   | Mittlerweile ist die offizielle   |
   |                                   | JSON-LD-Library soweit            |
   |                                   | entwickelt, dass man die          |
   |                                   | Konvertierung auch darüber machen |
   |                                   | kann. Achja, denn dafür ist der   |
   |                                   | Code: Lobid N-Triples in schönes  |
   |                                   | JSON umzuformen, das dann auch in |
   |                                   | den Elasticsearch-Index kann.     |
   +-----------------------------------+-----------------------------------+
   | helper                            | Die mit Abstand wichtigste Klasse |
   |                                   | in diesem Package heißt           |
   |                                   | ``JsonMapper``. Hier wird das     |
   |                                   | JSON für Index und Ansichten      |
   |                                   | erzeugt.                          |
   +-----------------------------------+-----------------------------------+
   | helper.mail                       | Emails verschicken.               |
   +-----------------------------------+-----------------------------------+
   | helper.oai                        | Einige Klassen zur Regelung des   |
   |                                   | OAI-Providings. Der               |
   |                                   | ``OAIDispatcher`` analysiert, ob  |
   |                                   | und wie ein ``Node`` an die       |
   |                                   | OAI-Schnittstelle gelangt.        |
   +-----------------------------------+-----------------------------------+
   | models                            | Die wichtigste Klasse hier ist    |
   |                                   | ``Node`` über diese Klasse läuft  |
   |                                   | der Großteil des                  |
   |                                   | Datentransportes.                 |
   +-----------------------------------+-----------------------------------+
   | views                             | Templates in der Sprache          |
   |                                   | ``Twirl`` und einige              |
   |                                   | Java-Hilfsklassen.                |
   +-----------------------------------+-----------------------------------+
   | views.mediaViewers                | Ein paar Viewer, die über die     |
   |                                   | Hilfsklasse ``ViewerInfo`` in     |
   |                                   | ``tags.resourceView`` eingebunden |
   |                                   | werden können.                    |
   +-----------------------------------+-----------------------------------+
   | views.oai                         | Mit ``Twirl`` XML zu generieren   |
   |                                   | war keine gute Idee.              |
   +-----------------------------------+-----------------------------------+
   | views.tags                        | Hilfstemplates.                   |
   +-----------------------------------+-----------------------------------+



Etikett
-------

.. table:: Überblick

   +-----------------------------------+-----------------------------------+
   | Source                            | `Etikett`_                        |
   +-----------------------------------+-----------------------------------+
   | Technik                           | `Play`_                           |
   +-----------------------------------+-----------------------------------+
   | Ports                             | 9002 / 9102                       |
   +-----------------------------------+-----------------------------------+
   | Verzeichnis                       | /opt/regal/apps/etikett ,         |
   |                                   | /opr/regal/src/etikett            |
   +-----------------------------------+-----------------------------------+
   | HTTP Pfad                         | /tools/etikett                    |
   +-----------------------------------+-----------------------------------+

.. _Etikett: https://github.com/hbz/etikett
.. _Play: https://www.playframework.com/documentation/2.2.x/JavaHome


Etikett ist eine einfache Datenbankanwendung, die es erlaubt

1. Menschenlesbare Labels für URIs abzulegen. Über eine
   HTTP-Schnittstelle kann dann nach dem Label gefragt werden.

2. Auch Konfigurationen zur Erzeugung eines JSON-LD Kontextes können
   abgelegt werden.

3. Die Etikett-Datenbank erweitert sich dynamisch. Wird in einem
   authentifizierten Zugriff nach einer noch nicht bekannten URI
   gefragt, so versucht die Applikation ein Label für die URI zu finden.

In Etikett sind verschiedene Lookups realisiert, die dynamisch Labels
für URIs finden können. Beispiele:

-  Crossref

-  Geonames

-  GND

-  Openstreetmap

-  Orcid

-  RDF, Skos, etc.

Fragt man Etikett nach einem Label, so antwortet Etikett mit dem
Ergebnis des Lookups. Wenn Etikett nicht in der Lage ist, ein Label zu
finden, wird die URI, mit angefragt wurde, zurückgegeben.

Etikett kann auch als Cache verwendet werden. So werden authentifizierte
Anfragen in einer Datenbank persistiert. Erneute Anfragen werden dann
aus der Datenbank beantwortet, ein erneuter Lookup wird eingespart.
Einmal persistierte Labels werden nicht invalidiert. Die Invalidierung
kann von außerhalb über authentifizierte HTTP-Zugriffe realisiert
werden, stellt aber insgesamt noch ein Desiderat dar.

Etikett kann auch mit Labels vorkonfiguriert werden. Dabei können
zusätzliche Informationen zu jeder URIs mit abgelegt werden. Folgende
Informationen können in etikett abgelegt werden:

-  URI

-  Label

-  Weight - Zur Definition von Anzeigereihenfolgen.

-  Pictogram Iconfont-ID - Kann anstatt oder zusätzlich zum Label
   angezeigt werden.

-  ReferenceType - JSON-LD Typ

-  Container - JSON-LD Container

-  Beschreibung - Kommentar als Markdown

.. figure:: ../resources/images/etikett-screen.png
   :alt: Etikett Oberfläche

   Etikett Oberfläche

Mit Hilfe dieser Angaben kann Etikett auch einen "JSON-LD Context"
bereitstellen. Insgesamt wird über Etikett eine Art "Application
Profile" realisiert. Das Profil gibt Auskunft, welche Metadatenfelder
(definiert als URIs) in welcher Weise (Typ, Container) Verwendung finden
und wie sie angezeigt werden sollen (Label, Weight, Pictogram).

Im Regal-Kontext wird `Etikett <#_etikett>`__ an vielen Stellen
verwendet.

-  Zur Wandlung von RDF nach JSON-LD

-  Zur Anreicherung von RDF Importen

-  Zur menschenlesbaren Darstellung von RDF

-  Zur Konfiguration von Labels, Anzeigereihenfolgen und Pictogrammen

-  Als Cache

.. _konfiguration_2:

Konfiguration
~~~~~~~~~~~~~

.. table:: Dateien im /conf Verzeichnis

   +-----------------------------------+-----------------------------------+
   | Datei                             | Beschreibung                      |
   +===================================+===================================+
   | **evolutions**                    | Dieses Verzeichnis enthält        |
   |                                   | SQL-Skripte, die bei Änderungen   |
   |                                   | des Datenbankschemas automatisch  |
   |                                   | über EBean angelegt werden. Beim  |
   |                                   | nächsten Deployment einer neuen   |
   |                                   | Etikett-Version werden die        |
   |                                   | Skripte automatische angewendet.  |
   |                                   | Die Skripte enthalten immer einen |
   |                                   | mit "Up" markierten Part, und     |
   |                                   | einen mit "Down" markierten Part  |
   |                                   | (für rollbacks).                  |
   +-----------------------------------+-----------------------------------+
   | **application.conf**              | Hier kann ein Benutzer            |
   |                                   | eingestellt werden. Alle Klassen  |
   |                                   | im Verzeichnis ``models.*``       |
   |                                   | erhalten eine SQL-Tabelle.        |
   +-----------------------------------+-----------------------------------+
   | ddc.turtle                        | Eine DDC Datei. Die Datei bietet  |
   |                                   | Labels für DDC-URIs an.           |
   +-----------------------------------+-----------------------------------+
   | labels.json                       | Eine Labels-Datei, die zur        |
   |                                   | initialen Befüllung verwendet     |
   |                                   | werden kann.                      |
   +-----------------------------------+-----------------------------------+
   | regal.turtle                      | Eine Labels-Datei, die zur        |
   |                                   | initialen Befüllung verwendet     |
   |                                   | werden kann.                      |
   +-----------------------------------+-----------------------------------+
   | **routes**                        | Alle HTTP-Schnittstellen          |
   |                                   | übersichtlich in einer Datei      |
   +-----------------------------------+-----------------------------------+
   | rpb.turtle                        | Eine Labels-Datei, die zur        |
   |                                   | initialen Befüllung verwendet     |
   |                                   | werden kann.                      |
   +-----------------------------------+-----------------------------------+
   | rpb2.turtle                       | Eine Labels-Datei, die zur        |
   |                                   | initialen Befüllung verwendet     |
   |                                   | werden kann.                      |
   +-----------------------------------+-----------------------------------+

.. _die_applikation_2:

Die Applikation
~~~~~~~~~~~~~~~

.. table:: Das /app Verzeichnis

   +-----------------------------------+-----------------------------------+
   | Package                           | Beschreibung                      |
   +===================================+===================================+
   | default                           | In ``Global`` werden die Requests |
   |                                   | mit geloggt.                      |
   +-----------------------------------+-----------------------------------+
   | controllers                       | In ``Application`` werden alle    |
   |                                   | HTTP-Operationen implementiert.   |
   |                                   | Unterstützt wird BasicAuth.       |
   +-----------------------------------+-----------------------------------+
   | helper                            | Verschiedene Klassen, die eine    |
   |                                   | URI verfolgen und versuchen ein   |
   |                                   | Label aus den zurückgelieferten   |
   |                                   | Daten zu kreieren.                |
   +-----------------------------------+-----------------------------------+
   | models                            | Das Model ``Etikett`` ist         |
   |                                   | persistierbar.                    |
   +-----------------------------------+-----------------------------------+
   | views                             | Die meisten HTTP-Operationen      |
   |                                   | lassen sich auch über eine        |
   |                                   | Weboberfläche im Browser          |
   |                                   | aufrufen.                         |
   +-----------------------------------+-----------------------------------+

.. _zettel:

Zettel
------

.. table:: Überblick

   +-----------------------------------+-----------------------------------+
   | Source                            | `zettel <                         |
   |                                   | https://github.com/hbz/zettel>`__ |
   +-----------------------------------+-----------------------------------+
   | Technik                           | `Play Play                        |
   |                                   | 2.5                               |
   |                                   | .4 <https://www.playframework.com |
   |                                   | /documentation/2.5.x/JavaHome>`__ |
   +-----------------------------------+-----------------------------------+
   | Ports                             | 9003 / 9103                       |
   +-----------------------------------+-----------------------------------+
   | Verzeichnis                       | /opt/regal/apps/zettel,           |
   |                                   | /opr/regal/src/zettel             |
   +-----------------------------------+-----------------------------------+
   | HTTP Pfad                         | /tools/zettel                     |
   +-----------------------------------+-----------------------------------+

Zettel ist ein Webservice zur Bereitstellung von Webformularen. Die
Webformulare können über ein HTTP-GET geladen werden. Sollen
existierende Daten in ein Formular geladen werden, so können diese Daten
(1) als Form-encoded, (2) als JSON, oder (3) als RDF-XML über ein
``HTTP POST`` in das Formular geladen werden. Gleichzeitig kann
spezifiziert werden, in welchem Format das Formular Daten zurückliefern
soll.

.. figure:: ../resources/images/zettel-screen.png
   :alt: Zettel Oberfläche

   Zettel Oberfläche

Zettel verfügt über keine eigene Speicherschicht. Daten die über ein
Formular erzeugt wurden, werden in der HTTP-Response zurückgeliefert.
Zur Integration von Zettel in andere Applikationen wurde ein
Kommunikationspattern entwickelt, das auf Javascript beruht. Das
Zettel-Formular wird hierzu in einem IFrame in die Applikation
eingebunden. Die Applikation muss außerdem ein Javascript einbinden, das
auf bestimmte Nachrichten aus dem IFrame lauscht. Bei bestimmte Aktionen
sendet das Zettel-Formular dann Nachrichten an die Applikation und
erlaubt dieser darauf zu reagieren. Um Daten von Zettel in die
Applikation zu bekommen, werden diese im HTML-DOM gespeichert und können
von dort durch die Applikation entgegengenommen werden.

.. figure:: ../resources/images/zettel-flos.png
   :alt: Zettel Datenfluss

   Zettel Datenfluss

.. _konfiguration_3:

Konfiguration
~~~~~~~~~~~~~

.. table:: Dateien im /conf Verzeichnis

   +-----------------------------------+-----------------------------------+
   | Datei                             | Beschreibung                      |
   +===================================+===================================+
   | **application.conf**              | Die Datei enthält einen Eintrag   |
   |                                   | zur Konfiguration von             |
   |                                   | `Etikett <#_etikett>`__. Über     |
   |                                   | einen weiteren Eintrag können     |
   |                                   | "Hilfetexte" angelinkt werden.    |
   |                                   | Die Hilfetexte müssen in einer    |
   |                                   | statischen HTML abgelegt sein. Am |
   |                                   | Ende der Datei werden einige      |
   |                                   | Limits deutlich über den Standard |
   |                                   | erhöht, damit die großen          |
   |                                   | RDF-Posts auch funktionieren.     |
   +-----------------------------------+-----------------------------------+
   | **collectionOne.csv**             | Die Datei regelt den Inhalt eines |
   |                                   | Combo-Box widgets mit id          |
   |                                   | collectionOne.                    |
   +-----------------------------------+-----------------------------------+
   | **ddc.csv**                       | Die Datei regelt den Inhalt eines |
   |                                   | Combo-Box widgets mit id ddc.     |
   +-----------------------------------+-----------------------------------+
   | labels.json                       | Ein paar labels, falls keine      |
   |                                   | Instanz von                       |
   |                                   | `Etikett <#_etikett>`__           |
   |                                   | erreichbar ist.                   |
   +-----------------------------------+-----------------------------------+
   | logback.xml                       | Logger Konfiguration.             |
   +-----------------------------------+-----------------------------------+
   | **professionalGroup.csv**         | Die Datei regelt den Inhalt eines |
   |                                   | Combo-Box widgets mit id          |
   |                                   | professionalGroup.                |
   +-----------------------------------+-----------------------------------+
   | routes                            | Alle HTTP-Pfade übersichtlich in  |
   |                                   | einer Datei                       |
   +-----------------------------------+-----------------------------------+

.. _die_applikation_3:

Die Applikation
~~~~~~~~~~~~~~~

.. table:: Das /app Verzeichnis

   +-----------------------------------+-----------------------------------+
   | Package                           | Beschreibung                      |
   +===================================+===================================+
   | controllers                       | Es gibt nur einen Controller.     |
   |                                   | Hier ist sowohl die               |
   |                                   | Basisfunktionalität               |
   |                                   | implementiert, als auch die       |
   |                                   | Autocompletion-Endpunkte für die  |
   |                                   | unterschiedlichen Widgets. Die    |
   |                                   | Schnittstelle zu Abhandlung von   |
   |                                   | Formulardaten ist recht generisch |
   |                                   | gehalten. Über eine ID wird das   |
   |                                   | entsprechende Formular aus dem    |
   |                                   | services.ZettelRegister geholt    |
   |                                   | und das zugehörige Formular wird  |
   |                                   | gerendert. Die Formular erhalten  |
   |                                   | dabei unterschiedliche Templates  |
   |                                   | (z.B. ``views.Article``) und      |
   |                                   | unterschiedliche Modelklassen     |
   |                                   | (z.B. models.Article).            |
   +-----------------------------------+-----------------------------------+
   | models                            | Das Model "Article" heißt aus     |
   |                                   | historischen Gründen so.          |
   |                                   | Tatsächlich können mittlerweile   |
   |                                   | auch Kongressschriften und        |
   |                                   | Buchkapitel darüber abgebildet    |
   |                                   | werden (vermutlich wird sich der  |
   |                                   | Name nochmal ändern). Das Model   |
   |                                   | "Catalog" dient zum Import von    |
   |                                   | Daten aus dem Aleph-Katalog (über |
   |                                   | Lobid). Mit ResearchData steht    |
   |                                   | ein prototypisches Model zur      |
   |                                   | Verarbeitung von Daten über       |
   |                                   | Forschungsdaten zur Verfügung.    |
   |                                   | Alle Models basieren auf einem    |
   |                                   | einzigen "fetten" ZettelModel.    |
   |                                   | Das ZettelModel enthält auch      |
   |                                   | Funktionen zur De/Serialisierung  |
   |                                   | in RDF und Json.                  |
   +-----------------------------------+-----------------------------------+
   | services                          | Hier werden verschiedene          |
   |                                   | Hilfsklassen versammelt. Die      |
   |                                   | Klasse ZettelFields enthält ein   |
   |                                   | Mapping zur RDF-Deserialisierung. |
   +-----------------------------------+-----------------------------------+
   | views                             | Alle HTML-Sichten und die         |
   |                                   | eigentlichen Formulare.           |
   +-----------------------------------+-----------------------------------+

.. _skos_lookup:

skos-lookup
-----------

.. table:: Überblick

   +-----------------------------------+-----------------------------------+
   | Source                            | `skos-lookup <https               |
   |                                   | ://github.com/hbz/skos-lookup>`__ |
   +-----------------------------------+-----------------------------------+
   | Technik                           | `Play Play                        |
   |                                   | 2.5                               |
   |                                   | .8 <https://www.playframework.com |
   |                                   | /documentation/2.5.x/JavaHome>`__ |
   +-----------------------------------+-----------------------------------+
   | Ports                             | 9004 / 9104                       |
   +-----------------------------------+-----------------------------------+
   | Verzeichnis                       | /opt/regal/apps/skos-lookup,      |
   |                                   | /opr/regal/src/skos-lookup        |
   +-----------------------------------+-----------------------------------+
   | HTTP Pfad                         | /tools/skos-lookup                |
   +-----------------------------------+-----------------------------------+

`skos-lookup <#_skos_lookup>`__ dient zur Unterstützung von
`Zettel <#_zettel>`__. Der Webservice startet eine eingebettete
Elasticsearch-Instanz und verfügt über eine Schnittstelle um SKOS-Daten
in separate Indexe zu importieren und Schnittstellen zur Unterstützung
von jQuery-Autocomplete- und Select2-Widgets aufzubauen. Auf diese Weise
können auch umfangreichere Thesauri und Notationssysteme in den
Formularen von `Zettel <#_zettel>`__ fachgerecht angelinkt werden.
`skos-lookup <#_skos_lookup>`__ unterstützt auch mehrsprachige Thesauri.

.. figure:: ../resources/images/skos-lookup-autocomplete.png
   :alt: SKOS-Lookup Beispiel 1

   SKOS-Lookup Beispiel 1

.. figure:: ../resources/images/example-select2.png
   :alt: SKOS-Lookup Beispiel 2

   SKOS-Lookup Beispiel 2

.. _konfiguration_4:

Konfiguration
~~~~~~~~~~~~~

.. table:: Dateien im /conf Verzeichnis

   +-----------------------------------+-----------------------------------+
   | Datei                             | Beschreibung                      |
   +===================================+===================================+
   | **application.conf**              | Hier wird der interne             |
   |                                   | Elasticsearch-Index konfiguriert. |
   |                                   | Auch werden einige                |
   |                                   | Speichereinstellungen erhöht.     |
   |                                   | Damit auch große SKOS-Dateien     |
   |                                   | geladen werden können, sollten    |
   |                                   | auch die Java-Opts erhöht werden. |
   +-----------------------------------+-----------------------------------+
   | logback.xml                       | Logger Konfiguration              |
   +-----------------------------------+-----------------------------------+
   | routes                            | Alle HTTP-Pfade übersichtlich in  |
   |                                   | einer Datei                       |
   +-----------------------------------+-----------------------------------+
   | skos-context.json                 | Ein JSON-LD-Kontext zur           |
   |                                   | Umwandlung von RDF nach JSON.     |
   |                                   | (Origianl von: Jakob Voss)        |
   +-----------------------------------+-----------------------------------+
   | skos-setting.json                 | Settings zur Konfiguration des    |
   |                                   | Elasticsearchindexse. (Original   |
   |                                   | von: Jörg Prante)                 |
   +-----------------------------------+-----------------------------------+

.. _die_applikation_4:

Die Applikation
~~~~~~~~~~~~~~~

.. table:: Das /app Verzeichnis

   +-----------------------------------+-----------------------------------+
   | Package                           | Beschreibung                      |
   +===================================+===================================+
   | controllers                       | Alles in einem Controller. Die    |
   |                                   | API-Methoden liefern HTML und     |
   |                                   | JSON, so dass man sie aus dem     |
   |                                   | Browser, aber auch über andere    |
   |                                   | Tools ansprechen kann.            |
   +-----------------------------------+-----------------------------------+
   | elasticsearch                     | Eine embedded Elasticsearch. Dies |
   |                                   | hat den Vorteil, dass man eine    |
   |                                   | aktuellere Version nutzen kann,   |
   |                                   | als z.B. die                      |
   |                                   | `regal-api <#_regal_api_2>`__.    |
   +-----------------------------------+-----------------------------------+
   | services                          | Hilfsklassen zum Laden der Daten. |
   +-----------------------------------+-----------------------------------+
   | views                             | Ein Formular um neue Daten in die |
   |                                   | Applikation zu laden. Und ein     |
   |                                   | Beispielformular zur              |
   |                                   | Demonstration der Nutzung.        |
   +-----------------------------------+-----------------------------------+

.. _thumby:

Thumby
------

.. table:: Überblick

   +-----------------------------------+-----------------------------------+
   | Source                            | `thumby <                         |
   |                                   | https://github.com/hbz/thumby>`__ |
   +-----------------------------------+-----------------------------------+
   | Technik                           | `Play Play                        |
   |                                   | 2.2                               |
   |                                   | .2 <https://www.playframework.com |
   |                                   | /documentation/2.2.x/JavaHome>`__ |
   +-----------------------------------+-----------------------------------+
   | Ports                             | 9001 / 9101                       |
   +-----------------------------------+-----------------------------------+
   | Verzeichnis                       | /opt/regal/apps/thumby,           |
   |                                   | /opr/regal/src/thumby             |
   +-----------------------------------+-----------------------------------+
   | HTTP Pfad                         | /tools/thumby                     |
   +-----------------------------------+-----------------------------------+

`Thumby <#_thumby>`__ realisiert einen Thumbnail-Generator. Über ein
HTTP-GET wird `Thumby <#_thumby>`__ die URL eines PDFs, oder eines
Bildes übergeben. Sofern die `Thumby <#_thumby>`__ den Server kennt,
wird es versuchen ein Thumbnail der zurückgelieferten Daten zu
erstellen. Die Daten werden dauerhaft auf der Platte abgelegt und
zukünftige Requests, die auf dasselbe Bild verweisen werden direkt aus
dem Speicher von `Thumby <#_thumby>`__ beantwortet.

.. _konfiguration_5:

Konfiguration
~~~~~~~~~~~~~

.. table:: Dateien im /conf Verzeichnis

   +-----------------------------------+-----------------------------------+
   | Datei                             | Beschreibung                      |
   +===================================+===================================+
   | **application.conf**              | Hier wird eine Whitelist gesetzt. |
   |                                   | Thumby verarbeitet nur URLs von   |
   |                                   | den hier angegebenen Quellen.     |
   |                                   | Hier wird auch der Pfad auf der   |
   |                                   | Platte gesetzt, unter dem Thumby  |
   |                                   | thumbnail-Daten ablegt.           |
   +-----------------------------------+-----------------------------------+
   | routes                            | Alle HTTP-Pfade übersichtlich in  |
   |                                   | einer Datei                       |
   +-----------------------------------+-----------------------------------+

.. _die_applikation_5:

Die Applikation
~~~~~~~~~~~~~~~

.. table:: Das /app Verzeichnis

   +-----------------------------------+-----------------------------------+
   | Package                           | Beschreibung                      |
   +===================================+===================================+
   | controllers                       | Der Controller realisiert eine    |
   |                                   | GET-Methode, über die Thumbnails  |
   |                                   | erzeugt und zurückgegeben werden. |
   +-----------------------------------+-----------------------------------+
   | helper                            | Klassen zur Organisation des      |
   |                                   | Speichers und zur                 |
   |                                   | Thumbnailgenerierung.             |
   +-----------------------------------+-----------------------------------+
   | views                             | Es gibt eine Oberfläche mit einem |
   |                                   | Upload-Formular.                  |
   +-----------------------------------+-----------------------------------+

.. _deepzoomer:

Deepzoomer
----------

.. table:: Überblick

   +-----------------------------------+-----------------------------------+
   | Source                            | `DeepZoomService <https://g       |
   |                                   | ithub.com/hbz/DeepZoomService>`__ |
   +-----------------------------------+-----------------------------------+
   | Technik                           | `Servlet                          |
   |                                   | 2.3 <                             |
   |                                   | https://download.oracle.com/otn-p |
   |                                   | ub/jcp/7840-servlet-2.3-spec-oth- |
   |                                   | JSpec/servlet-2_3-fcs-spec.ps>`__ |
   +-----------------------------------+-----------------------------------+
   | Ports                             | 9091 / 9191                       |
   +-----------------------------------+-----------------------------------+
   | Verzeichnis                       | /opt/regal/tomcat-for-deepzoom/,  |
   |                                   | /opr/regal/src/DeepZoomService    |
   +-----------------------------------+-----------------------------------+

Der [DeepZoomService] kann als WAR in einem Application-Server deployed
werden. Mit dem Deepzoomer können pyramidale Bilder erzeugt, gespeichert
und über eine OpenSeadragon-konforme Schnittstelle abgerufen werden. Auf
diese Weise kann in Regal eine Viewer-Komponente realisiert werden, die
die Anzeige sehr großer, hochaufgelöster Bilder im Webbrowser
unterstützt.

.. _konfiguration_6:

Konfiguration
~~~~~~~~~~~~~

.. table:: Dateien im /conf Verzeichnis

   +-----------------------------------+-----------------------------------+
   | Datei                             | Beschreibung                      |
   +===================================+===================================+
   | **deepzoomer.cfgf**               | Hier werden lokale Verzeichnisse, |
   |                                   | aber auch die Server-URLs, unter  |
   |                                   | denen der Service öffentlich      |
   |                                   | abrufbar ist, gesetzt.            |
   +-----------------------------------+-----------------------------------+

.. _regal_drupal:

regal-drupal
------------

.. table:: Überblick

   +-----------------------------------+-----------------------------------+
   | Source                            | `regal-drupal <https://g          |
   |                                   | ithub.com/edoweb/regal-drupal>`__ |
   +-----------------------------------+-----------------------------------+
   | Technik                           | `PHP                              |
   |                                   | 5 <h                              |
   |                                   | ttps://www.php.net/manual/en/>`__ |
   +-----------------------------------+-----------------------------------+
   | Ports                             | 80 / 443                          |
   +-----------------------------------+-----------------------------------+
   | Verzeichnis                       | /opt/re                           |
   |                                   | gal/var/drupal/sites/all/modules/ |
   +-----------------------------------+-----------------------------------+

Ein Drupal 7 Modul über das Funktionalitäten der
`regal-api <#_regal_api_2>`__ angesprochen werden können. Das Modul
bietet Oberflächen zur Konfiguration, zur Suche und zur Verwaltung von
Objekthierarchien.

.. _die_applikation_6:

Die Applikation
~~~~~~~~~~~~~~~

.. table:: Verzeichnisstruktur

   +-----------------------------------+-----------------------------------+
   | Verzeichnis                       | Beschreibung                      |
   +===================================+===================================+
   | edoweb                            | Hier ist der Code für die         |
   |                                   | Oberflächen.                      |
   +-----------------------------------+-----------------------------------+
   | edoweb-field                      | Hier werden Felder für            |
   |                                   | unterschiedliche RDF-Properties   |
   |                                   | in der Drupal-Datenbank           |
   |                                   | konfiguriert. Der Code ist        |
   |                                   | größtenteils obsolet, da die      |
   |                                   | Feldlogik nicht mehr benutzt      |
   |                                   | wird.                             |
   +-----------------------------------+-----------------------------------+
   | edoweb_storage                    | Hier sind die Zugriffe auf        |
   |                                   | `regal-api <#_regal_api_2>`__ und |
   |                                   | `??? <#_elasticsearch>`__ zu      |
   |                                   | finden.                           |
   +-----------------------------------+-----------------------------------+

.. _edoweb_drupal_theme:

edoweb-drupal-theme
-------------------

.. table:: Überblick

   +-----------------------------------+-----------------------------------+
   | Source                            | `edow                             |
   |                                   | eb-drupal-theme <https://github.c |
   |                                   | om/edoweb/edoweb-drupal-theme>`__ |
   +-----------------------------------+-----------------------------------+
   | Technik                           | `PHP                              |
   |                                   | 5 <h                              |
   |                                   | ttps://www.php.net/manual/en/>`__ |
   +-----------------------------------+-----------------------------------+
   | Ports                             | 80 / 443                          |
   +-----------------------------------+-----------------------------------+
   | Verzeichnis                       | /opt/r                            |
   |                                   | egal/var/drupal/sites/all/themes/ |
   +-----------------------------------+-----------------------------------+

Eine Reihe von Stylsheets, CSS, Icons zur Gestaltung einer Oberfläche
für den Server https://edoweb-rlp.de

.. _zbmed_drupal_theme:

zbmed-drupal-theme
------------------

.. table:: Überblick

   +-----------------------------------+-----------------------------------+
   | Source                            | `zb                               |
   |                                   | med-drupal-theme <https://github. |
   |                                   | com/edoweb/zbmed-drupal-theme>`__ |
   +-----------------------------------+-----------------------------------+
   | Technik                           | `PHP                              |
   |                                   | 5 <h                              |
   |                                   | ttps://www.php.net/manual/en/>`__ |
   +-----------------------------------+-----------------------------------+
   | Ports                             | 80 / 443                          |
   +-----------------------------------+-----------------------------------+
   | Verzeichnis                       | /opt/r                            |
   |                                   | egal/var/drupal/sites/all/themes/ |
   +-----------------------------------+-----------------------------------+

Eine Reihe von Stylsheets, CSS, Icons zur Gestaltung einer Oberfläche
für den Server https://repository.publisso.de

.. _openwayback:

openwayback
-----------

Repo: https://github.com/iipc/openwayback Servlet 2.5 .Überblick

+-----------------------------------+-----------------------------------+
| Source                            | `openwayback <https:              |
|                                   | //github.com/iipc/openwayback>`__ |
+-----------------------------------+-----------------------------------+
| Technik                           | `Servlet                          |
|                                   | 2.5 <https://download.oracle.com/ |
|                                   | otn-pub/jcp/servlet-2.5-mr5-oth-J |
|                                   | Spec/servlet-2.5-mr5-spec.pdf>`__ |
+-----------------------------------+-----------------------------------+
| Ports                             | 8091 / 8191                       |
+-----------------------------------+-----------------------------------+
| Verzeichnis                       | /o                                |
|                                   | pt/regal/tomcat-for-openwayback/, |
|                                   | /opr/regal/src/openwayback        |
+-----------------------------------+-----------------------------------+

**Achtung**: Es gibt einen am hbz entwickelten Branch. Dieser ist nicht
auf Github.

Openwayback ist eine Webapplikation die im ROOT Bereich eines Tomcats
installiert werden will. Sie kann Verzeichnisse mit WARC-Dateien
indexieren und darauf eine Oberfläche zur Recherche und zur Navigation
aufbauen.

.. _heritrix:

heritrix
--------

Heritrix ist ein Werkzeug zur Sammlung von Webseiten. Heritrix startet
standalone als Webapplikation und bietet eine Weboberfläche zur
Verwaltung von Sammelvorgängen an. Eingesammelte Webseiten werden als
WARC-Dateien in einem bestimmten Bereich der Platte abgelegt.

.. _wpull:

wpull
-----

Wpull ist ein Kommandozeilen-Wermzeug zur Sammlung von Webseiten. Mit
WPull können WARC-Dateien erzeugt werden.

.. _fedora_commons_3:

Fedora Commons 3
----------------

Fedora Commons 3 ist ein Repository-Framework. Für Regal wird vorallem
die Speicherschicht von Fedora Commons 3 benutzt. Fedora-Commons legt
alle Daten im Dateisystem (auch) ab. Mit den Daten aus dem Dateisystem
lässt sich eine komplette Fedora-Commons 3 Instanz von grundauf neu
aufbauen.

.. _mysql:

MySql
-----

MySQL wir von Fedora, regal-api und etikett verwendet.

.. _elasticsearch_1_1:

Elasticsearch 1.1
-----------------

Elasticsearch ist eine Suchmaschine und wird von
`regal-api <#_regal_api_2>`_ verwendet. Auch
`regal-drupal <#_regal_drupal>`_ greift auf den Index zu.

.. _drupal_7:

Drupal 7
--------

Über Drupal 7

.. _vagrant_installation:

Installation
============


Vagrant
-------

Zur Veranschaulichung dieser Dokumentation wird ein Vagrant-Skript
angeboten, mit dem eine Regal-Installation innerhalb eines
VirtualBox-Images erzeugt werden kann.

Zur Installation kannst Du folgende Schritte ausführen. Die Kommandos
beziehen sich auf die Installation auf einem Ubuntu-System. Für andere
Betriebssyteme ist die Installation ähnlich.

Die VirtualBox hat folgendes Setup

-  hdd 40GB

-  cpu 2core

-  ram 4096M

.. _virtualbox_installieren:

VirtualBox installieren
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   sudo apt-get install virtualbox

.. _vagrant_installieren:

Vagrant installieren
~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   cd /tmp
   wget https://releases.hashicorp.com/vagrant/2.2.3/vagrant_2.2.3_x86_64.deb
   sudo dpkg -i vagrant_2.2.3_x86_64.deb

.. _repository_herunterladen:

Repository herunterladen
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   git clone https://github.com/jschnasse/Regal
   cd Regal/vagrant/ubuntu-14.04

.. _eine_jdk8_bereitstellen:

Eine JDK8 bereitstellen
~~~~~~~~~~~~~~~~~~~~~~~

Hierfür bitte ein JDK8-Tarball herunterladen und unter dem Namen
``java8.tar.gz`` in einem Verzeichnis ``/bin`` unterhalb des
Vagrant-Directories bereitstellen.

.. code-block:: bash

   mkdir bin
   mv ~/downloads/jdk.... bin/java8.tar.gz

.. _geteiltes_entwicklungsverzeichnis:

Geteiltes Entwicklungsverzeichnis
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   mkdir ~/regal-dev

.. _vagrant_guest_additions_installieren:

Vagrant Guest Additions installieren
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   vagrant plugin install vagrant-vbguest && vagrant reload

.. _vagrant_host_anlegen:

Vagrant Host anlegen
~~~~~~~~~~~~~~~~~~~~

Damit alle Dienste komfortabel erreichbar sind, muss in die lokale HOSTs
Datei ein Eintrag für die Vagrant-Box erfolgen. Im Vagrantfile ist die
IP ``192.168.50.4`` für die Box konfiguriert. Über die ``FRONTEND`` und
``BACKEND`` Einträge in der ``variables.conf`` ist der Servername als
``regal.vagrant`` definiert.

.. code-block:: bash

   sudo printf "192.168.50.4 regal.vagrant api.regal.vagrant" >> /etc/hosts

.. _vagrant_starten:

Vagrant starten
~~~~~~~~~~~~~~~

.. code-block:: bash

   vagrant up

.. _auf_der_maschine_einloggen:

Auf der Maschine einloggen
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   vagrant ssh

.. _server:

Server
------

Die Installation auf einem Server kann mit Hilfe des mitgelieferten
Skriptes
`regal-install.sh <https://github.com/jschnasse/Regal/blob/master/vagrant/ubuntu-14.04/regal-install.sh>`_
erfolgen. Dazu muss analog zur Vagrant-Installation zunächst das ``bin``
Verzeichnis mit einem JDK aufgebaut werden. Danach erfolgt die
Installation unter ``/opt/regal`` und mit einem Benutzer ``regal`` (vgl.
``variables.conf``)

.. _hardware_empfehlung:

Hardware Empfehlung
~~~~~~~~~~~~~~~~~~~

-  hdd >500GB

-  cpu 8 core

-  ram 32 G

.. _unterschiede_zur_vagrant_installation:

Unterschiede zur Vagrant Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Auf dem Server empfehlen ich den fedora tomcat mit erweiterten
Speichereinstellungen zu betreiben.

Dazu in ``/opt/regal/bin/fedora/tomcat/bin`` eine ``setenv.sh`` anlegen
und folgende Zeilen hinein kopieren.

.. code-block:: bash

   CATALINA_OPTS=" \
   -Xms1536m \
   -Xmx1536m \
   -XX:NewSize=256m \
   -XX:MaxNewSize=256m \
   -XX:PermSize=256m \
   -XX:MaxPermSize=256m \
   -server \
   -Djava.awt.headless=true \
   -Dorg.apache.jasper.runtime.BodyContentImpl.LIMIT_BUFFER=true"

   export CATALINA_OPTS

.. _entwicklung_java:

Entwicklung Java
================

.. _in_der_virtualbox:

In der VirtualBox
-----------------

Hat man über `Vagrant <#_vagrant>`_ eine neue VirtualBox erzeugt und
alle Konfigurationen wie beschrieben vorgenommen, kann man die
VirtualBox zur Entwicklung nutzen. Da im Installationsprozess bereits
Eclipse-Projekte der unter ``/opt/regal/src`` befindlichen
Java-Applikationen erzeugt wurden, können die Projekte direkt aus dem
"synced folder" unter ``~/regal-dev`` in eine Eclipse-IDE auf dem
Host-System importiert werden.

Damit Änderungen am Code in der VirtualBox direkt sichtbar werden,
sollte die Applikation zunächst im Develop-Mode neu gestartet werden.
Dazu loggt man sich auf der VirtualBox mit ``vagrant ssh`` ein und
stoppt zunächst den entsprechenden Service, z.B.
``sudo service regal-api stop``. Anschließend navigiert man in das
Source-Verzeichnis, z.B. ``cd /opt/regal/src/regal-api``. Hier startet
man die Applikation auf dem korrekten Port (im Zweifel unter
``/opt/regal/apps/regal-api/conf/application.conf`` nachschauen). Der
Start im Develop-Mode erfolgt aus dem Verzeichnis der Applikation, mit
z.B. ``/opt/regal/bin/activator/bin/activator -Dhttp.port=9100``. Danach
kann in die Kosole ``run`` eingegegeben werden. Die Applikation sollte
nun unter dem entsprechenden Port (im Beispiel: 9100) antworten.

Leider funktioniert das Reloading zwischen Host-System und
Guest-VirtualBox nicht richtig. D.h. nach Code-Änderungen im Host, muss
auf der Virtualbox zunächst mit ``Ctrl+D`` und ``run`` neu gestartet
werden, damit die Änderungen sichtbar werden.

.. _auf_dem_eigenen_system:

Auf dem eigenen System
----------------------

Die Javakomponenten können problemlos auch auf einem aktuellen
Ubuntusystem entwickelt werden. Leider läuft die
PHP/Drupal-Implementierung nicht unter neueren Ubuntusystemen. Für die
lokale installation können die entsprechenden Funktionen aus dem
``regal-install.sh`` ausgeführt werden. Dazu einfach eine Kopie anlegen,
entsprechend editieren und ausführen.

.. code-block:: bash

   mkdir regal-install
   cp -r path/to/Regal/vagrant/ubuntu-XX/* regal-install
   cd regal-install
   # Edit system user "vagrant" --> "your user"
   editor variables.conf
   # put drupal stuff in comments
   #
   #  #installDrush
   #  #installDrupal
   #  #installRegalDrupal
   #  #installDrupalThemes
   #  #configureDrupalLanguages
   #  #configureDrupal
   #
   editor regal-install.sh

.. _administration:

Administration
==============

.. _aktualisierung:

Aktualisierung
--------------

.. _play_applikationen:

Play-Applikationen
~~~~~~~~~~~~~~~~~~

Die Aktualisierung der Regal-Komponenten erfolgt über Skripte. Die
Aktualisierung funktioniert dabei so, dass der Quellcode der zu
aktualisierenden Komponente unter ``/opt/regal/src`` per ``git`` auf den
entsprechenden Branch gestellt wird. Danach wird ein neues Kompilat der
Komponente erzeugt. Die aktuelle Konfiguration wird aus
``/opt/regal/conf`` genommen und es wird unter ``/opt/regal/apps`` eine
neue lauffähige Version abgelegt.

Neue Versionen werden immer parallel zu alten Versionen gestartet und
über einen Wechsel der Apachekonfiguration aktiviert. Erst danach wird
die alte Version heruntergefahren.

Der komplette Aktualisierungsprozess erfolgt automatisch. Die alte
Version bleibt immer auf dem Server liegen, so dass bei Bedarf wieder
zurück gewechselt werden kann.

.. _tomcat_applikation:

Tomcat-Applikation
~~~~~~~~~~~~~~~~~~

Es wird ein ``war``-Container erzeugt und im Tomcat ``hot``-deployed.

.. _drupal_module:

Drupal-Module
~~~~~~~~~~~~~

Beinhaltet die Aktualisierung ein Datenbankupdate, so wird Drupal erst
in den Wartungszustand versetzt (per drush oder über die Oberfläche).
Danach wird die aktualisierte Version einfach per Git geholt. Bei
Datenbankupdates wird noch ein Drupal-Updateskript ausgeführt.

.. _speicherschicht:

Speicherschicht
~~~~~~~~~~~~~~~

Aktualisierungen von MySQL, Elasticsearch und Fedora gehen mit einer
Downtime einher.

.. _verzeichnisse:

Verzeichnisse
-------------

.. table:: Verzeichnisstruktur

   +-----------------------------------+-----------------------------------+
   | Verzeichnis                       | Beschreibung                      |
   +===================================+===================================+
   | /opt/regal                        | Außer Apache2, Elasticsearch und  |
   |                                   | MySQL befinden sich alle          |
   |                                   | Regal-Komponenten unter diesem    |
   |                                   | Verzeichnis.                      |
   +-----------------------------------+-----------------------------------+
   | /opt/regal/apps                   | Die auf ``Play`` beruhenden       |
   |                                   | Komponenten:                      |
   |                                   | ``etikett  fedora  regal-a        |
   |                                   | pi  skos-lookup  thumby  zettel`` |
   +-----------------------------------+-----------------------------------+
   | /opt/regal/bin                    | Fremdpakete wie activator,        |
   |                                   | fedora, heritrix, python -        |
   |                                   | weitere tomcats.                  |
   +-----------------------------------+-----------------------------------+
   | /opt/regal/conf                   | Die variables.conf und die        |
   |                                   | application.conf wird von         |
   |                                   | verschiedenen Komponenten         |
   |                                   | verwendet.                        |
   +-----------------------------------+-----------------------------------+
   | /opt/regal/logs                   | Logfiles der Skripte und Cronjobs |
   +-----------------------------------+-----------------------------------+
   | /opt/regal/src                    | Alle Eigenentwicklungen oder im   |
   |                                   | Quellcode modifizierten           |
   |                                   | Komponenten.                      |
   +-----------------------------------+-----------------------------------+
   | /opt/regal/var                    | drupal und Datenverzeichnisse.    |
   +-----------------------------------+-----------------------------------+

.. _ports:

Ports
-----

.. table:: Ports und Komponenten (typische Belegung)

   +-----------------------------------+-----------------------------------+
   | Port                              | Komponente                        |
   +===================================+===================================+
   | 80 /443                           | Apache 2                          |
   +-----------------------------------+-----------------------------------+
   | 8080                              | fedora tomcat                     |
   +-----------------------------------+-----------------------------------+
   | 9090                              | openwayback tomcat                |
   +-----------------------------------+-----------------------------------+
   | 9200                              | elasticsearch                     |
   +-----------------------------------+-----------------------------------+
   | 9000/9100                         | regal-api                         |
   +-----------------------------------+-----------------------------------+
   | 9001/9101                         | thumby                            |
   +-----------------------------------+-----------------------------------+
   | 9002/9102                         | etikett                           |
   +-----------------------------------+-----------------------------------+
   | 9003/9103                         | zettel                            |
   +-----------------------------------+-----------------------------------+
   | 9004/9104                         | skos-lookup                       |
   +-----------------------------------+-----------------------------------+

.. _logs:

Logs
----

.. table:: Logfiles

   +-----------------------------------+-----------------------------------+
   | Komponente                        | Pfad                              |
   +===================================+===================================+
   | Apache                            | /var/log/apache2                  |
   +-----------------------------------+-----------------------------------+
   | Tomcat                            | /opt/regal/bin/fedora/tomcat/logs |
   +-----------------------------------+-----------------------------------+
   | Fedora                            | /opt/regal/bin/fedora/server/logs |
   +-----------------------------------+-----------------------------------+
   | Elasticsearch                     | /var/log/elasticsearch            |
   +-----------------------------------+-----------------------------------+
   | regal-api                         | /opt/regal/apps/regal-api/logs    |
   +-----------------------------------+-----------------------------------+
   | drupal                            | /var/log/apache2 #otherhosts !    |
   |                                   | und/var/log/apache2/error.log     |
   |                                   | (hier ist auch die Debugausgabe)  |
   +-----------------------------------+-----------------------------------+
   | MySql                             | /var/log/mysql                    |
   +-----------------------------------+-----------------------------------+
   | monit                             | /var/log/monit.log                |
   +-----------------------------------+-----------------------------------+
   | regal-scripts                     | /opt/regal/logs                   |
   +-----------------------------------+-----------------------------------+

.. _configs:

Configs
-------

.. table:: Configfiles

   +-----------------------------------+-----------------------------------+
   | Komponente                        | Pfad                              |
   +===================================+===================================+
   | Apache                            | /etc/apache2/sites-enabled        |
   +-----------------------------------+-----------------------------------+
   | Tomcat                            | /opt/regal/bin/fedora/tomcat/conf |
   +-----------------------------------+-----------------------------------+
   | Fedora                            | /opt/regal/bin/fedora/server/conf |
   +-----------------------------------+-----------------------------------+
   | Elasticsearch                     | /etc/elasticsearch                |
   +-----------------------------------+-----------------------------------+
   | regal-api                         | /opt/regal/conf enthält           |
   |                                   | Konfigurationsvorschläge des      |
   |                                   | Installers                        |
   +-----------------------------------+-----------------------------------+
   | regal-api                         | /opt/regal/apps/regal-api/conf    |
   +-----------------------------------+-----------------------------------+
   | drupal                            | Konfig kann gut mit dem Tool      |
   |                                   | drush überwacht werden            |
   +-----------------------------------+-----------------------------------+
   | Elasticsearch Plugins             | /etc/elasticsearch                |
   +-----------------------------------+-----------------------------------+
   | oai-pmh                           | /opt/regal/                       |
   |                                   | bin/fedora/tomcat/webapps/dnb-unr |
   |                                   | /WEB-INF/classes/proai.properties |
   +-----------------------------------+-----------------------------------+
   | monit                             | /etc/monit                        |
   +-----------------------------------+-----------------------------------+

.. _apache2:

Apache2
-------

.. table:: Frontend Pfade

   +-----------------------+-----------------------+-----------------------+
   | Komponente            | HTTP-Pfad             | Lokaler Pfad/Proxy    |
   +=======================+=======================+=======================+
   | Drupal                | /                     | /opt/regal/var/drupal |
   +-----------------------+-----------------------+-----------------------+
   | Alte Importe von      | /webharvests          | /data/webharvests     |
   | Webarchiven           |                       |                       |
   +-----------------------+-----------------------+-----------------------+
   | Täglich generierte    | /crawlreports         | /o                    |
   | Datei mit Kennziffern |                       | pt/regal/crawlreports |
   +-----------------------+-----------------------+-----------------------+

.. table:: API Pfade

   +-----------------------+-----------------------+-----------------------+
   | Komponente            | HTTP-Pfad             | Lokaler Pfad/Proxy    |
   +=======================+=======================+=======================+
   | Über wget erstellte   | /wget-data            | /op                   |
   | Webarchive            |                       | t/regal/var/wget-data |
   +-----------------------+-----------------------+-----------------------+
   | Über wpull erstellte  | /wpull-data           | /opt                  |
   | Webarchive            |                       | /regal/var/wpull-data |
   +-----------------------+-----------------------+-----------------------+
   | Über heritrix         | /heritrix-data        | /opt/re               |
   | erstellte Webarchive  |                       | gal/var/heritrix-data |
   +-----------------------+-----------------------+-----------------------+
   | OAI-Schnittstelle für | /dnb-urn              | http://loc            |
   | die DNB               |                       | alhost:8080/dnb-urn$1 |
   +-----------------------+-----------------------+-----------------------+
   | OAI-Schnittstelle     | /oai-pmh              | http://loc            |
   |                       |                       | alhost:8080/oai-pmh$1 |
   +-----------------------+-----------------------+-----------------------+
   | Deepzoomer            | /deepzoom             | http://loca           |
   |                       |                       | lhost:7080/deepzoom$1 |
   +-----------------------+-----------------------+-----------------------+
   | Openwayback privat    | /wayback              | http://l              |
   |                       |                       | ocalhost:9080/wayback |
   +-----------------------+-----------------------+-----------------------+
   | Openwayback           | /weltweit             | http://lo             |
   | öffentlich            |                       | calhost:9080/weltweit |
   +-----------------------+-----------------------+-----------------------+
   | Thumby                | /tools/thumby         | http://localh         |
   |                       |                       | ost:9001/tools/thumby |
   +-----------------------+-----------------------+-----------------------+
   | Etikett               | /tools/etikett        | http://localho        |
   |                       |                       | st:9002/tools/etikett |
   +-----------------------+-----------------------+-----------------------+
   | Zettel                | /tools/zettel         | http://localh         |
   |                       |                       | ost:9004/tools/zettel |
   +-----------------------+-----------------------+-----------------------+
   | Elasticsearch GET     | /search               | http://localhost:9200 |
   +-----------------------+-----------------------+-----------------------+
   | Fedora                | /fedora               | http://               |
   |                       |                       | localhost:8080/fedora |
   +-----------------------+-----------------------+-----------------------+
   | JSON-LD Context       | /                     | http:/                |
   |                       | public/resources.json | /localhost:9002/tools |
   |                       |                       | /etikett/context.json |
   +-----------------------+-----------------------+-----------------------+
   | regal-api             | /                     | h                     |
   |                       |                       | ttp://localhost:9000/ |
   +-----------------------+-----------------------+-----------------------+
   | heritrix              | /tools/heritrix       | https://localhos      |
   |                       |                       | t:8443/tools/heritrix |
   +-----------------------+-----------------------+-----------------------+

.. _matomo:

Matomo
------

Matomo wird einmal täglich per Cronjob mit Apache-Logfiles befüllt.
Dabei erfolgt eine Anonymisierung. Die Logfiles verbleiben noch sieben
Tage auf dem Server und werden dann annoynmisiert.

.. _monit:

Monit
-----

Das Tool Monit erlaubt es, den Status der Regal-Komponenten zu
überwachen und Dienste ggfl. neu zu starten. Folgende Einträge können in
/etc/monit/monitrc vorgenommen werden

.. code-block:: bash

   check process apache with pidfile /var/run/apache2/apache2.pid
       start program = "/etc/init.d/apache2 start" with timeout 60 seconds
       stop program  = "/etc/init.d/apache2 stop"

   check process regal-api with pidfile /opt/regal/apps/regal-api/RUNNING_PID
        start program = "/etc/init.d/regal-api start" with timeout 60 seconds
        stop program = "/etc/init.d/regal-api stop"

   check process tomcat6 with pidfile /var/run/tomcat6.pid
        start program = "/etc/init.d/tomcat6 start" with timeout 60 seconds
        stop program = "/etc/init.d/regal-api stop"

   check process elasticsearch with pidfile /var/run/elasticsearch.pid
        start program = "/etc/init.d/elasticsearch start" with timeout 60 seconds
        stop program = "/etc/init.d/elasticsearch stop"

   check process thumby with pidfile /opt/regal/apps/thumby/RUNNING_PID
        start program = "/etc/init.d/thumby start" with timeout 60 seconds
        stop program = "/etc/init.d/thumby stop"

   check process etikett with pidfile /opt/regal/apps/etikett/RUNNING_PID
        start program = "/etc/init.d/etikett start" with timeout 60 seconds
        stop program = "/etc/init.d/etikett stop"

   check process zettel with pidfile /opt/regal/apps/zettel/RUNNING_PID
        start program = "/etc/init.d/zettel start" with timeout 60 seconds
        stop program = "/etc/init.d/zettel stop"

.. _scripts_und_cronjobs:

Scripts und Cronjobs
--------------------

Für das Funktionieren von Regal sind einige regal-scripts sinnvoll. Die
Skripte sind sämtlich unter Github zu finden.

https://github.com/edoweb/regal-scripts

Die folgenden Abschnitte zeigen ein typisches Setup.

.. _oai_providing_2:

OAI-Providing
~~~~~~~~~~~~~

Der OAI-Provider läuft nicht die ganze Zeit mit, da dies Probleme
gemacht hat. Er wird nur für einen bestimmten Zeitraum angestellt und
dann wieder ausgestellt. Auf diese Weise liefert die OAI-Schnittstelle
tagesaktuelle Daten.

.. code-block:: bash

   0 2 * * * /opt/regal/src/regal-scripts/turnOnOaiPmhPolling.sh
   0 5 * * * /opt/regal/src/regal-scripts/turnOffOaiPmhPolling.sh

.. _urn_registrierung:

URN-Registrierung
~~~~~~~~~~~~~~~~~

Die URN-Registrierung erfolgt mit einem gewissen Verzug. Das dafür
zuständige Skript überprüft daher zunächst das Anlagedatum der
Ressource.

.. code-block:: bash

   05 7 * * * /opt/regal/src/regal-scripts/register_urn.sh control  >> /opt/regal/regal-scripts/log/control_urn_vergabe.log
   1 1 * * * /opt/regal/src/regal-scripts/register_urn.sh katalog >> /opt/regal/regal-scripts/log/katalog_update.log
   1 0 * * * /opt/regal/src/regal-scripts/register_urn.sh register >> /opt/regal/regal-scripts/log/register_urn.log

.. _katalog_aktualisierung:

Katalog-Aktualisierung
~~~~~~~~~~~~~~~~~~~~~~

Das System gleicht einmal am Tag Metadaten mit dem hbz-Verbundkatalog ab
und führt ggf. Aktualisierungen durch.

.. code-block:: bash

   0 5 * * * /opt/regal/src/regal-scripts/updateAll.sh > /dev/null

.. _matomo_2:

Matomo
~~~~~~

Matomo wird mit Apache-Logfiles befüllt. Innerhalb von Matomo werden die
Einträge annonymisiert.

.. code-block:: bash

   0 1 * * * /opt/regal/regal-scripts/import-logfiles.sh >/dev/null

.. _logfile_annonymisierung:

Logfile Annonymisierung
~~~~~~~~~~~~~~~~~~~~~~~

Apache-Logfiles werden sieben Tage unverändert aufbewahrt. Danach
erfolgt eine Annonymisierung.

.. code-block:: bash

   0 2 * * * /opt/regal/src/regal-scripts/depersonalize-apache-logs.sh

.. _webgatherer:

Webgatherer
~~~~~~~~~~~

Der Webgatherer prüft Archivierungsintervalle von Webpages und stößt bei
Bedarf die Erzeugung eines neuen Snapshots/Version an.

.. code-block:: bash

   0 20 * * * /opt/regal/src/regal-scripts/runGatherer.sh >> /opt/regal/regal-scripts/log/runGatherer.log
   # Auswertung des letzten Webgatherer-Laufs
   0 21 * * * /opt/regal/src/regal-scripts/evalWebgatherer.sh >> /opt/regal/regal-scripts/log/runGatherer.log
   # Crawl Reports
   0 22 * * * /opt/regal/src/regal-scripts/crawlReport.sh >> /opt/regal/logs/crawlReport.log

.. _backup:

Backup
~~~~~~

MySQL und Elasticsearch

Der Elasticsearch-Index und die MySQL-Datenbanken werden täglich
gesichert. Es werden Backups der letzten 30 Tage aufbewahrt. Ältere
Backups werden von der Platte gelöscht.

.. code-block:: bash

   0 2 * * * /opt/regal/src/regal-scripts/backup-es.sh -c >> /opt/regal/logs/backup-es.log 2>&1
   30 2 * * * /opt/regal/src/regal-scripts/backup-es.sh -b >> /opt/regal/logs/backup-es.log 2>&1
   0 2 * * * /opt/regal/src/regal-scripts/backup-db.sh -c >> /opt/regal/logs/backup-db.log 2>&1
   30 2 * * * /opt/regal/src/regal-scripts/backup-db.sh -b >> /opt/regal/logs/backup-db.log 2>&1

.. _entwicklung:

Entwicklung
~~~~~~~~~~~

Für die Entwicklung an Regal empfiehlt sich folgende Vorgehensweise…


