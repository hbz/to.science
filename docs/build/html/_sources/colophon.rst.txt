.. _colophon:

Colophon
========

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


.. _license:

License
=======
.. image:: resources/images/cc-by-nc.png
   :alt: CC BY-NC 4.0

This work is licensed under `CC BY-NC 4.0`_.


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

-  https://github.com/hbz


.. _sphinx: https://www.sphinx-doc.org
.. _sphinx_rtd_theme: https://sphinx-rtd-theme.readthedocs.io/en/stable/index.html
.. _furo: https://github.com/pradyunsg/furo
.. _reStructuredText: https://docutils.sourceforge.io/rst.html
.. _CC BY-NC 4.0: http://creativecommons.org/licenses/by-nc/4.0/
