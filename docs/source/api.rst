Über dieses Dokument

Dieses Dokument kommt zusammen mit einem
`Vagrantfile <https://github.com/hbz/to.science/tree/master/vagrant/ubuntu-14.04>`__
und beschreibt die wichtigsten HTTP-Calls in Regal anhand von ``curl``.

Eine komplette Übersicht über das zugrundeliegende System findet sich
hier: `Regal <./regal.html>`__

Dieses Dokument ist im Format asciidoc geschrieben und kann mit dem
Werkzeug asciidoctor in HTML übersetzt werden. Mehr dazu im Abschnitt
`Dokumentation <#_dokumentation>`__

.. __preface:

Preface
=======

The Regal webservices documented by example ``curl``-calls. Examples are
assumed to work in the Vagrant-Environment that comes with this
document.

**Have fun!**

.. __environment:

Environment
===========

Got to your server or to the Vagrant-Box, that comes with this document.

``vagrant ssh``

Prepare your environment to make the following ``curl``-Calls work!

::

   source /opt/regal/conf/variables.conf
   export REGAL_API=http://$SERVER
   export API_USER=edoweb-admin

.. __regal_api:

regal-api
=========

https://github.com/edoweb/regal-api/blob/master/conf/routes

.. __create:

Create
------

.. __create_a_new_resource:

Create a new resource
~~~~~~~~~~~~~~~~~~~~~

::

   curl -i -u$API_USER:$PASSWORD -XPUT $REGAL_API/resource/regal:1234 -d'{"contentType":"monograph","accessScheme":"public"}' -H'content-type:application/json'

.. __create_a_new_hierarchy:

Create a new hierarchy
~~~~~~~~~~~~~~~~~~~~~~

::

   curl -i -u$API_USER:$PASSWORD -XPUT $REGAL_API/resource/regal:1235 -d'{"parentPid":"regal:1234","contentType":"file","accessScheme":"public"}' -H'content-type:application/json'

.. __upload_binary_data:

Upload binary data
~~~~~~~~~~~~~~~~~~

::

   curl -u$API_USER:$PASSWORD -F"data=@$ARCHIVE_HOME/src/REGAL_API/test/resources/test.pdf;type=application/pdf" -XPUT $REGAL_API/resource/regal:1235/data

.. __create_user:

Create User
~~~~~~~~~~~

::

   curl -u$API_USER:$PASSWORD -d'{"username":"test","password":"test","email":"test@example.org","role":"EDITOR"}' -XPUT $REGAL_API/utils/addUser -H'content-type:application/json'

.. __upload_metadata:

Upload metadata
~~~~~~~~~~~~~~~

::

   curl -XPUT -u$API_USER:$PASSWORD -d'<regal:1234> <dc:title> "Ein Test Titel" .' -H"content-type:text/plain" $REGAL_API/resource/regal:1235/metadata2

Order Child Nodes</programlisting>
::

   curl -XPUT -u$API_USER:$PASSWORD -d'["regal:2","regal:1249"]' $REGAL_API/resource/regal:1/parts -H"Content-Type:application/json"

.. __read:

Read
----

.. __read_resource:

Read resource
~~~~~~~~~~~~~

**html**

::

   curl $REGAL_API/resource/regal:1234.html

**json**

::

   curl $REGAL_API/resource/regal:1234.json
   curl $REGAL_API/resource/regal:1234.json2

**rdf**

::

   curl $REGAL_API/resource/regal:1234.rdf

**mets**

::

   curl $REGAL_API/resource/regal:1234.mets

**aleph**

::

   curl $REGAL_API/resource/regal:1234.aleph

**epicur**

::

   curl $REGAL_API/resource/regal:1234.epicur

**datacite**

::

   curl $REGAL_API/resource/regal:1234.datacite

**csv**

::

   curl $REGAL_API/resource/regal:1234.csv

**wgl**

::

   curl $REGAL_API/resource/regal:1234.wgl

**oaidc**

::

   curl $REGAL_API/resource/regal:1234.oaidc

.. __read_resource_tree:

Read resource tree
~~~~~~~~~~~~~~~~~~

::

   curl $REGAL_API/resource/regal:1234/all

::

   curl $REGAL_API/resource/regal:1234/parts

.. __read_binary_data:

Read binary data
~~~~~~~~~~~~~~~~

::

   curl $REGAL_API/resource/regal:1234/data

.. __read_webgatherer_conf:

Read Webgatherer Conf
~~~~~~~~~~~~~~~~~~~~~

::

   curl $REGAL_API/resource/regal:1234/conf

.. __read_ordering_of_childs:

Read Ordering of Childs
~~~~~~~~~~~~~~~~~~~~~~~

::

   curl $REGAL_API/resource/regal:1234/seq

.. __read_user:

Read user
~~~~~~~~~

::

   not implemented

.. __read_adhoc_linked_data:

Read Adhoc Linked Data
~~~~~~~~~~~~~~~~~~~~~~

::

   curl $REGAL_API/adhoc/uri/$(echo test |base64)

.. __update:

Update
------

.. __update_resource:

Update Resource
~~~~~~~~~~~~~~~

.. __update_metadata:

Update Metadata
~~~~~~~~~~~~~~~

::

   curl -s -u$API_USER:$REGAL_PASSWORD -XPOST $REGAL_API/utils/updateMetadata/regal:1234 -H"accept: application/json"

.. __add_urn:

Add URN
~~~~~~~

::

   POST /utils/lobidify

::

   POST /utils/addUrn

::

   POST /utils/replaceUrn

.. __enrich:

Enrich
~~~~~~

::

   POST /resource/:pid/metadata/enrich

.. __delete:

Delete
------

.. __delete_resource:

Delete resource
~~~~~~~~~~~~~~~

::

   curl -u$API_USER:$REGAL_PASSWORD -XDELETE "$REGAL_API/resource/regal:1234";echo

.. __purge_resource:

Purge resource
~~~~~~~~~~~~~~

::

   curl -u$API_USER:$REGAL_PASSWORD -XDELETE "$REGAL_API/resource/regal:1234?purge=true";echo

.. __delete_part_of_resource:

Delete part of resource
~~~~~~~~~~~~~~~~~~~~~~~

::

   curl -u$API_USER:$REGAL_PASSWORD -XDELETE $REGAL_API/resource/regal:1234/seq

::

   curl -u$API_USER:$REGAL_PASSWORD -XDELETE $REGAL_API/resource/regal:1234/metadata

::

   curl -u$API_USER:$REGAL_PASSWORD -XDELETE $REGAL_API/resource/regal:1234/metadata2

::

   curl -u$API_USER:$REGAL_PASSWORD -XDELETE $REGAL_API/resource/regal:1234/data

::

   curl -u$API_USER:$REGAL_PASSWORD -XDELETE $REGAL_API/resource/regal:1234/dc

.. __delete_user:

Delete user
~~~~~~~~~~~

::

   not implemented

.. __search:

Search
------

.. __simple_search:

Simple Search
~~~~~~~~~~~~~

::

   GET /find

::

   GET /resource

.. __facetted_search:

Facetted Search
~~~~~~~~~~~~~~~

.. __search_for_field:

Search for field
~~~~~~~~~~~~~~~~

.. __misc:

Misc
----

.. __load_metadata_from_lobid:

Load metadata from Lobid
~~~~~~~~~~~~~~~~~~~~~~~~

::

   curl -u$API_USER:$PASSWORD -XPOST "$REGAL_API/utils/lobidify/regal:1234?alephid=HT018920238"

.. __reread_labels_from_etikett:

Reread Labels from etikett
~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   curl -u$API_USER:$PASSWORD -XPOST $REGAL_API/context.json

.. __reindex_resource:

Reindex resource
~~~~~~~~~~~~~~~~

::

   curl -u$API_USER:$PASSWORD -XPOST $REGAL_API/utils/index/regal:1234 -H"accept: application/json"

.. __etikett:

etikett
=======

https://github.com/hbz/etikett/blob/master/conf/routes

.. __create_2:

Create
------

.. __add_labels_to_database:

Add Labels to Database
~~~~~~~~~~~~~~~~~~~~~~

::

   curl -u$API_USER:$PASSWORD -XPOST -F"data=@$ARCHIVE_HOME/src/REGAL_API/conf/labels.json" -F"format-cb=Json" $REGAL_API/tools/etikett -i -L

.. __add_label:

Add Label
~~~~~~~~~

.. __read_2:

Read
----

::

   curl "$REGAL_API/tools/etikett" -H"accept: application/json"

.. __read_etikett:

Read Etikett
~~~~~~~~~~~~

::

   curl $REGAL_API/tools/etikett?url=http%3A%2F%2Fpurl.orms%2Fissued -H"accept: application/json"

.. __update_2:

Update
------

.. __delete_2:

Delete
------

.. __delete_cache:

Delete Cache
~~~~~~~~~~~~

::

   curl -XDELETE -u$API_USER:$PASSWORD $REGAL_API/tools/etikett/cache

.. __misc_2:

Misc
----

.. __zettel:

zettel
======

https://github.com/hbz/zettel/blob/master/conf/routes

.. __create_3:

Create
------

.. __create_rdf_metadata_from_form_data:

Create RDF-Metadata from Form-Data
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. __read_3:

Read
----

.. __read_html_form:

Read HTML-Form
~~~~~~~~~~~~~~

.. __search_2:

Search
------

.. __skos_lookup:

skos-lookup
===========

https://github.com/hbz/skos-lookup/blob/master/conf/routes

.. __create_4:

Create
------

.. __create_new_index:

Create new Index
~~~~~~~~~~~~~~~~

::

   curl -i -X POST -H "Content-Type: multipart/form-data" $REGAL_API/tools/skos-lookup/upload -F "data=@/tmp/skos-lookup/test/resources/agrovoc_2016-07-15_lod.nt.gz" -F"index=agrovoc_test" -F"format=NTRIPLES"

.. __read_4:

Read
----

::

   curl -XGET '$REGAL_API/tools/skos-lookup/autocomplete?lang=de&q=Erdnus&callback=mycallback&index=agrovoc_test'

.. __search_3:

Search
------

::

   curl $REGAL_API/tools/skos-lookup/search?q=http%3A%2F%2Faims.fao.org%2Faos%2Fagrovoc%2Fc_13551&lang=de&index=agrovoc

.. __thumby:

thumby
======

https://github.com/hbz/thumby/blob/master/conf/routes

.. __read_5:

Read
----

::

   curl -XGET "$REGAL_API/tools/thumby?url=https://www.gravatar.com/avatar/5fefc19b7875e951c7ea9bfdfc06676d&size=200"

.. __misc_3:

Misc
----

.. __dokumentation:

Dokumentation
=============

Diese Dokumentation ist mit asciidoc geschrieben und wurde mit
asciidoctor in HTML übersetzt. Dazu wurde das foundation.css Stylesheet
aus dem asciidoctor-stylesheet-factory Repository verwendet.

Die Schritte, um an der Doku zu arbeiten sind folgenden

.. __dieses_repo_herunterladen:

Dieses Repo herunterladen
-------------------------

::

   git clone https://github.com/hbz/to.science

.. __asciidoctor_und_asciidoctor_stylesheets_installieren:

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

.. __doku_modifizieren_und_in_html_übersetzen:

Doku modifizieren und in HTML übersetzen
----------------------------------------

::

   cd Regal/doc
   editor api.asciidoc
   asciidoctor -astylesheet=foundation.css -astylesdir=../../asciidoctor-stylesheet-factory/stylesheets api.asciidoc

.. __license:

License
=======

|https://i.creativecommons.org/l/by-nc/4.0/88x31.png|

This work is licensed under a `Creative Commons
Attribution-NonCommercial 4.0 International
License <http://creativecommons.org/licenses/by-nc/4.0/>>`__.

.. __references:

References
==========

regal-scripts vagrant

.. |https://i.creativecommons.org/l/by-nc/4.0/88x31.png| image:: https://i.creativecommons.org/l/by-nc/4.0/88x31.png
