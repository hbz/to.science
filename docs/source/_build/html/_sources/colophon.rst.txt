.. _dokumentation:

Dokumentation
=============

Diese Dokumentation ist mit `sphinx`_ erstellt.
Die Schritte, um an der Doku zu arbeiten sind folgenden

.. _dieses_repo_herunterladen:

Dieses Repo herunterladen
-------------------------

::

   git clone https://github.com/hbz/to.science

.. _sphinx_installieren:

Sphinx installieren
-------------------

Für die Verwendung von Sphinx wird eine virtuelle Pythonumgebung im Verzeichnis `venv` eingerichtet. Das Verzeichnis sollte nicht mit
ins git repo committet werden. Das virtuelle Python wird aktiviert und mit pip sphinx und zwei weitere themes installiert.

::

   $ cd to.science/doc
   $ python3 -m venv ./venv
   $ . venv/bin/activate
   $ pip install -U sphinx
   $ pip install -U sphinx_rtd_theme
   $ pip install -U furo


.. _doku_modifizieren_und_in_html_übersetzen:

Doku modifizieren und in HTML übersetzen
----------------------------------------

Die Doku ist in `reStructuredText`_ geschrieben wird mittels `make` in html übersetzt.

::

   $ cd to.science/doc
   $ vi source/colophon.rst
   $ make html

Das fertige html findet man im Unterverzeichnis `build/html`. Man kann eine einfachen Webserver starten und das Ergebnis
unter http://localhost:8000 ansehen.

::

   $ python3 -m http.server --directory build/html


.. _license:

License
=======

|https://i.creativecommons.org/l/by-nc/4.0/88x31.png|

This work is licensed under a `Creative Commons
Attribution-NonCommercial 4.0 International
License <http://creativecommons.org/licenses/by-nc/4.0/>>`__.

.. _links:

Links
=====

.. _slides:

Slides
------

-  Lobid - http://hbz.github.io/slides/

-  Skos-Lookup - http://hbz.github.io/slides/siit-170511/#/

-  Regal - http://hbz.github.io/slides/danrw-20180905/#/

.. _internes_wiki:

Internes Wiki
-------------

-  https://wiki1.hbz-nrw.de/display/edd/Dokumentation

.. _github:

Github
------

-  https://github.com/edoweb

-  https://github.com/hbz

:!figure-caption:

.. |https://i.creativecommons.org/l/by-nc/4.0/88x31.png| image:: https://i.creativecommons.org/l/by-nc/4.0/88x31.png


.. _sphinx: https://www.sphinx-doc.org
.. _reStructuredText: https://docutils.sourceforge.io/rst.html