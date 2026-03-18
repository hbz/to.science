.. _crawler_documentation:

Informationen zum to.science Crawler
====================================

``to.science`` ist der Name des Crawlers des gleichnamigen Content Repositories. ``to.science`` steht für Toolbox Open Science
und ist ein Produkt des `hbz`_ zur Archivierung digitaler Publikationen. Neben Artikeln, Monographien, Zeitschriften etc. werden über
das Webcrawling auch regelmäßig Webseiten eingesammelt und archiviert. Hintergrund des Webcrawling ist die reine Archivierung der Seite.
Die gesammelten Daten dienen nicht als Grundlage für KI oder LLMs.

Das Webcrawling geschieht im Auftrag :abbr:`bzw.(beziehungsweise)` in Zusammenarbeit mit den Landesbibliotheken des Landes NRW und dem Landesbibliothekszentrum Rheinland-Pfalz.

.. _hbz: https://hbz-nrw.de/

User Agent
----------
Um Webmastern die Möglichkeit zu geben, Datenverkehr zu identifizieren, der von unserem Crawler verursacht wird, verwenden wir folgenden User Agent:

.. code-block::

        Mozilla/5.0 (compatible; to.science.bot +https://toscience.hbz-nrw.de/crawler)


Verhalten
---------
Wir sind gestrebt, in einen Tempo zu crawlen, das den regulären Betrieb einer Webseite nicht beinträchtigt. Es sollte nicht mehr als ein Aufruf pro Sekunde
erfolgen und eine eventuell vorhandene ``robots.txt``-Datei wird berücksichtigt.


IP Bereiche
-----------

Das Crawling erfolgt aus folgendem Adressbereich ``193.30.112.0/24``. Der IP Bereich ist auch als JSON abrufbar unter `toscience.json <../ipranges/toscience.json>`_.


Kontakt
-------
Bei Fragen oder Anregungen schreiben Sie bitte an toscience@hbz-nrw.de.




