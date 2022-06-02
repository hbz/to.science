Anlegen neuer Metadaten-Felder in der API
=========================================

Vorgehen
--------
Das Anlegen neuer Metadatenfelder in der to.science.api erfordert verschiedene Schritte und ist die Grundlage für die anschließende (optionale) Einbindung 
dieser Felder in to.science.forms.

1. Datei labels.json in to.science.api und to.science.labels erweitern und deployen (Ja wirklich :-(  )
2. Notwendige Anpassungen in den für das Mapping zuständigen Java-Klassen (JsonMapper.java und LRMIMapper für ORCA)
3. Testen der Änderungen

labels.json erweitern
_____________________

Damit die verschiedenen Mappings zwischen Formaten wie JSON und RDF, N-Triples etc. funktionieren, muss in der labels.json 
ein entsprechende JSON-Abschnitt für das neue Feld angelegt werden. 

Beispiel neues Feld academicDegree:

.. code-block:: json

    	{
		"uri": "https://d-nb.info/standards/elementset/gnd#academicDegree",
		"comment": "",
		"label": "Akademischer Grad",
		"icon": "",
		"name": "academicDegree",
		"referenceType": "String",
		"container": "@list",
		"weight": "5",
		"type": "CONTEXT",
		"multilangLabel": {}
	},


"name" und "uri":
:::::::::::::::::: 

1. Das Literal **"name"** muss den Variablen-Namen enthalten. Hieran war zunächst die Exposition der Variablen zu to.science.forms gescheitert. 
2. Der Name muss **vermutlich** dem in der ResourceUri stehenden veränderlichen Teil entsprechen. 

.. code-block:: json

    "uri": "https://d-nb.info/standards/elementset/gnd#academicDegree",
    "name": "academicDegree",

"referenceType" und "container":
::::::::::::::::::::::::::::::::


1. | Die Literale **"referenceType"** ,  **"container"** enthalten vermutlich Informationen über die Typisierung der Variablen. Hierbei wird bei container das JSON-LD Schlüsselwort \@list verwendet. Es gibt 13 Schlüsselwörter. [1]_ 
   | Da das jedoch nicht dokumentiert ist, muss man sich Beispiele für verschiedene Variablentypen in der labels.json heraussuchen, probieren und Daumen drücken... (seufz).


.. code-block:: json

    "referenceType": "String",
    "container": "@list",


2. Das Literal **"type"** verweist vermutlich überwiegend auf das Schlüsselwort \@context. Sollte vermutlich nicht geändert werden.

.. code-block:: json

    "type": "CONTEXT",
 

Alle labels.json ersetzen:
::::::::::::::::::::::::::

1. Sowohl die labels.json von *to.science.api* als auch die von *to.science.labels* müssen erweitert werden. Wie die beiden interferieren ist bisher ziemlich unklar.

2. Beide Dateien müssen manuell in das jeweilige conf-Verzeichnis im installierten Modul kopiert werden. Sie werden nicht automatisch aktualisiert

3. to.science.api und to.science.labels müssen neu gestartet werden.

Erweitern der Java-Klasse JsonMapper.Java
_________________________________________

Damit das neue Feld in die verschiedenen Metadaten-Formate gemappt werden kann, 
ist zumindest die Erweiterung der Klasse JsonMapper.Java notwendig

.. code-block:: java

    to.science.api.helper/JsonMapper.Java
    
Welche Methoden konkret angepasst werden müssen, kann hier nicht pauschal gesagt werden. 

Für ORCA ist zusätzlich die Klasse LRMIMapper zu erweitern, damit die neuen Felder aud dem Datenstrom lrmiData gelesen und auch wieder dort hin geschrieben werden können.

.. code-block:: java

    to.science.api.helper/LRMIMapper.Java
    
Hintergrund
-----------

Die Vereinbarung des neuen Metadaten-Felds in ``labels.json`` ist notwendig, weil die ``labels.json`` innerhalb der to.science-Komponenten 
die Ergänzung des neuen Feldes um den für Mappings und Konvertiereungen von JSON-Dateien notwendigen LinkedData-Teil übernimmt. 
Damit kann die to.science.api an bestimmten API-Calls JSONLD ausliefern. [#]_





..  [#] https://de.wikipedia.org/wiki/JSON-LD
