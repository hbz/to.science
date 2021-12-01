.. _dokumentation:

Dokumentation
=============

Diese Dokumentation ist mit sphinx erstellt.
Die Schritte, um an der Doku zu arbeiten sind folgenden

.. _dieses_repo_herunterladen:

Dieses Repo herunterladen
-------------------------

::

   git clone https://github.com/hbz/to.science

.. _asciidoctor_und_asciidoctor_stylesheets_installieren:

Asciidoctor und Asciidoctor-Stylesheets installieren
----------------------------------------------------

::

   gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
   \curl -sSL https://get.rvm.io | sudo bash -s stable --ruby
   #login again
   sudo apt-get install bundler
   sudo apt-get install gem
   git clone https://github.com/asciidoctor/asciidoctor
   git clone https://github.com/asciidoctor/asciidoctor-stylesheet-factory
   cd asciidoctor
   sudo gem install asciidoctor
   cd ../asciidoctor-stylesheet-factory
   bundle install
   compass compile

.. _doku_modifizieren_und_in_html_übersetzen:

Doku modifizieren und in HTML übersetzen
----------------------------------------

::

   cd Regal/doc
   editor regal.asciidoc
   asciidoctor -astylesheet=foundation.css -astylesdir=../../asciidoctor-stylesheet-factory/stylesheets regal.asciidoc

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
