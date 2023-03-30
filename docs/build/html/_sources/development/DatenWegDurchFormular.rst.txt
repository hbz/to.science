Der mutmaßliche Weg der Daten durch to.science.forms
====================================================

Erste Annahme
-------------

Beim Aufruf des Formulars werden im Normalfall die Daten aus einem RDF-XML in das Formular eingelesen. 
Alternativ kann auch die "Nutzlast" einer POST-Response genutzt werden. Letzteres Verfahren wird jedoch 
normalerweise nur verwendet, wenn das Formular aus dem Formular selber mit dem Submit-Button abgeschickt 
wurde und aufgrund von Fehlern die Formularfelder neu eingelesen werden sollen.

Zweite Annahme
--------------
 
Das Versenden der Daten aus dem Formular an die to.science.api erfolgt ausschließlich als API-Call 
bei dem ggf. verändertes RDF-XML an die to.science.api geliefert wird.

 
Nachverfolgung der Schritte
---------------------------

Von Drupal zu to.science.api
____________________________

1. | Der Reiter "Bearbeiten" in der Drupal-Oberfläche löst einen GET-Request an die to.science-api mit der Route ``:pid/edit`` aus. 
   | Als Parameter werden mitgeliefert:
   | a) pid = die ID des zu berabeitenden Objekts, 
   | b) format = das Format, in dem Metadaten in einem späteren Prozess abgeholt werden sollen
   | c) topicId = unklar 
2. | Der Call wird innerhalb der to.science.api entgegen genommen von der Klasse und Methode: 
   | a) ``controllers.Resource.edit(pid:String,format : String?="json",topicId?=null)``


Von to.science.api zu to.science.forms
______________________________________

1. | Die Methode ``Resource.edit`` ruft zunächst die Methode ``call`` der Klasse ``ModifyAction`` auf. 
In den Methodenaufruf wurde dabei noch ein Code-Block mit einer If-Clause` integriert, was das Lesen des Codes nochmal erwschwert.


istdabei   
