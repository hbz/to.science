.. _uebersicht:

Übersicht
*********

to.science (ehemals "Regal") ist eine Content Repository zur Verwaltung
und Veröffentlichung elektronischer Publikationen. Es wird seit 2013 am
`Hochschulbibliothekszentrum NRW (hbz) <https://hbz-nrw.de>`__
entwickelt.

to.science basiert auf den folgenden Kerntechnologien:

*  Fedora Commons 3
*  Elasticsearch 1.1
*  Drupal 7
*  Playframework 2.4
*  MySQL 5
*  Java 8
*  PHP 5

Für die Webarchivierung kommen außerdem Openwayback, Heritrix und WPull
zum Einsatz.

*  openwayback hbz-2.3.2
*  pywb
*  heritrix 3.2.0
*  wpull

Regal ist ein mehrkomponentiges System. Einzelne Komponenten sind als
Webservices realisiert und kommunizieren über HTTP-APIs miteinander.
Derzeit sind folgende Komponenten im Einsatz:

*  `to.science.api <https://github.com/hbz/to.science.api>`_
*  `to.science.labels <https://github.com/hbz/to.science.labels>`_
*  `to.science.forms <https://github.com/hbz/to.science.forms>`_
*  `skos-lookup <https://github.com/hbz/skos-lookup>`_
*  `thumby <https://github.com/hbz/thumby>`_
*  `deepzoomer <https://github.com/hbz/DeepZoomService>`_
*  `to.science.drupal <https://github.com/hbz/to.science.drupal>`_

Drupal Themes

*  `zbmed-drupal-theme <https://github.com/hbz/zbmed-drupal-theme>`_
*  `edoweb-drupal-theme <https://github.com/hbz/edoweb-drupal-theme>`_

Über die Systemschnittstellen können eine ganze Reihe von Drittsystemen
angesprochen werden. Die folgende Abbildung verschafft einen groben
Überblick über eine typische Regal-Installation und die angebundenen
Drittsysteme.

.. figure:: ../resources/images/regal-arch-4.jpeg
   :alt: Typische Regal-Installation mit Drupal Frontend, Backendkomponenten und angebundenen Drittsytemen

   Typische Regal-Installation mit Drupal Frontend, Backendkomponenten und angebundenen Drittsytemen


.. toctree::
   :maxdepth: 1

   konzepte.rst
   software.rst

