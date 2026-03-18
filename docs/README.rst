Doku editieren und veröffentlichen
==================================

Diese Dokumentation ist mit `sphinx`_ erstellt.
Die Schritte, um an der Doku zu arbeiten sind folgenden

.. _dieses_repo_herunterladen:

Dieses Repo herunterladen
-------------------------

.. code-block:: bash

   $ git clone https://github.com/hbz/to.science

.. _sphinx_installieren:

Sphinx installieren
-------------------

Für die Verwendung von Sphinx wird eine virtuelle Pythonumgebung im Verzeichnis ``venv`` eingerichtet. Das Verzeichnis sollte nicht mit
ins git repo committet werden. Das virtuelle Python wird aktiviert und mit pip die sphinx und die themes `sphinx_rtd_theme`_ und `furo`_
installiert. Diese sind in der requirments.txt angegeben.

.. code-block:: bash

   $ cd to.science/docs
   $ python3 -m venv ./venv
   $ . venv/bin/activate
   $ pip install -r requirements.txt


.. _doku_modifizieren_und_in_html_übersetzen:

Doku modifizieren und in HTML übersetzen
----------------------------------------

Die Doku ist in `reStructuredText`_ geschrieben wird mittels ``make`` in html übersetzt.

.. code-block:: bash

   $ cd to.science/docs
   $ vi source/colophon.rst
   $ make html

Das fertige html findet man im Unterverzeichnis ``build/html``. Man kann eine einfachen Webserver starten und das Ergebnis
unter http://localhost:8000 ansehen.

.. code-block:: bash

   $ python3 -m http.server --directory build/html

