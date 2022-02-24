.. _to.science.api:

to.science.api
==============

https://github.com/hbz/to.science.api/blob/master/conf/routes

.. _create:

Create
------

.. _create_a_new_resource:

Create a new resource
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   curl -i -u$API_USER:$PASSWORD -XPUT $REGAL_API/resource/regal:1234 -d'{"contentType":"monograph","accessScheme":"public"}' -H'content-type:application/json'

.. _create_a_new_hierarchy:

Create a new hierarchy
~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   curl -i -u$API_USER:$PASSWORD -XPUT $REGAL_API/resource/regal:1235 -d'{"parentPid":"regal:1234","contentType":"file","accessScheme":"public"}' -H'content-type:application/json'

.. _upload_binary_data:

Upload binary data
~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   curl -u$API_USER:$PASSWORD -F"data=@$ARCHIVE_HOME/src/REGAL_API/test/resources/test.pdf;type=application/pdf" -XPUT $REGAL_API/resource/regal:1235/data

.. _create_user:

Create User
~~~~~~~~~~~

.. code-block:: bash

   curl -u$API_USER:$PASSWORD -d'{"username":"test","password":"test","email":"test@example.org","role":"EDITOR"}' -XPUT $REGAL_API/utils/addUser -H'content-type:application/json'

.. _upload_metadata:

Upload metadata
~~~~~~~~~~~~~~~

.. code-block:: bash

   curl -XPUT -u$API_USER:$PASSWORD -d'<regal:1234> <dc:title> "Ein Test Titel" .' -H"content-type:text/plain" $REGAL_API/resource/regal:1235/metadata2

Order Child Nodes
~~~~~~~~~~~~~~~~~

.. code-block:: bash

   $ curl -XPUT -u$API_USER:$PASSWORD -d'["regal:2","regal:1249"]' $REGAL_API/resource/regal:1/parts -H"Content-Type:application/json"


.. _ingest_unmanaged_content:

Ingest unmanaged content
~~~~~~~~~~~~~~~~~~~~~~~~

Example address for external stored content, i.e. research data:
``https://api.example.com/data/regal:1234/first_set/data.csv``

The base url and the default collection url are configured in the application.conf.

Currently only one level of subpaths is supported.

.. table:: URL parameter

   ============= ============ ==============================================================
   parameter     default      description
   ============= ============ ==============================================================
   collectionUrl data         Path to the storage folder
   subPath       \-           optional: path of the subfolder, 'first_set' in above example
   filename      \-           bare filename, but with extension
   resourcePid   <empty>      automatically assigned pid of the external resource
   ============= ============ ==============================================================


.. code-block:: bash

   $ curl -XPOST -u$API_USER:$PASSWORD "$REGAL_API/resource/regal:1234/postResearchData?collectionUrl=data&subPath=$dataDir&filename=$dateiname&resourcePid=$resourcePid" -H "UserId=resourceposter" -H "Content-Type: text/plain; charset=utf-8";




.. _read:

Read
----

.. _read_resource:

Read resource
~~~~~~~~~~~~~

**html**

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234.html

**json**

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234.json
   curl $REGAL_API/resource/regal:1234.json2

**rdf**

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234.rdf

**mets**

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234.mets

**aleph**

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234.aleph

**epicur**

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234.epicur

**datacite**

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234.datacite

**csv**

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234.csv

**wgl**

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234.wgl

**oaidc**

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234.oaidc

.. _read_resource_tree:

Read resource tree
~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234/all

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234/parts

.. _read_binary_data:

Read binary data
~~~~~~~~~~~~~~~~

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234/data

.. _read_webgatherer_conf:

Read Webgatherer Conf
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234/conf

.. _read_ordering_of_childs:

Read Ordering of Childs
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   curl $REGAL_API/resource/regal:1234/seq

.. _read_user:

Read user
~~~~~~~~~

.. code-block:: bash

   not implemented

.. _read_adhoc_linked_data:

Read Adhoc Linked Data
~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   curl $REGAL_API/adhoc/uri/$(echo test |base64)

.. _update:

Update
------

.. _update_resource:

Update Resource
~~~~~~~~~~~~~~~

.. _update_metadata:

Update Metadata
~~~~~~~~~~~~~~~

.. code-block:: bash

   curl -s -u$API_USER:$REGAL_PASSWORD -XPOST $REGAL_API/utils/updateMetadata/regal:1234 -H"accept: application/json"

.. _add_urn:

Add URN
~~~~~~~

.. code-block:: bash

   POST /utils/lobidify

.. code-block:: bash

   POST /utils/addUrn

.. code-block:: bash

   POST /utils/replaceUrn

.. _enrich:

Enrich
~~~~~~

.. code-block:: bash

   POST /resource/:pid/metadata/enrich

.. _delete:

Delete
------

.. _delete_resource:

Delete resource
~~~~~~~~~~~~~~~

.. code-block:: bash

   curl -u$API_USER:$REGAL_PASSWORD -XDELETE "$REGAL_API/resource/regal:1234";echo

.. _purge_resource:

Purge resource
~~~~~~~~~~~~~~

.. code-block:: bash

   curl -u$API_USER:$REGAL_PASSWORD -XDELETE "$REGAL_API/resource/regal:1234?purge=true";echo

.. _delete_part_of_resource:

Delete part of resource
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   curl -u$API_USER:$REGAL_PASSWORD -XDELETE $REGAL_API/resource/regal:1234/seq

.. code-block:: bash

   curl -u$API_USER:$REGAL_PASSWORD -XDELETE $REGAL_API/resource/regal:1234/metadata

.. code-block:: bash

   curl -u$API_USER:$REGAL_PASSWORD -XDELETE $REGAL_API/resource/regal:1234/metadata2

.. code-block:: bash

   curl -u$API_USER:$REGAL_PASSWORD -XDELETE $REGAL_API/resource/regal:1234/data

.. code-block:: bash

   curl -u$API_USER:$REGAL_PASSWORD -XDELETE $REGAL_API/resource/regal:1234/dc

.. _delete_user:

Delete user
~~~~~~~~~~~

.. code-block:: bash

   not implemented

.. _api_search:

Search
------

.. _simple_search:

Simple Search
~~~~~~~~~~~~~

.. code-block:: bash

   GET /find

.. code-block:: bash

   GET /resource

.. _facetted_search:

Facetted Search
~~~~~~~~~~~~~~~

.. _search_for_field:

Search for field
~~~~~~~~~~~~~~~~

.. _misc:

Misc
----

.. _load_metadata_from_lobid:

Load metadata from Lobid
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   curl -u$API_USER:$PASSWORD -XPOST "$REGAL_API/utils/lobidify/regal:1234?alephid=HT018920238"

.. _reread_labels_from_etikett:

Reread Labels from etikett
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   curl -u$API_USER:$PASSWORD -XPOST $REGAL_API/context.json

.. _reindex_resource:

Reindex resource
~~~~~~~~~~~~~~~~

.. code-block:: bash

   curl -u$API_USER:$PASSWORD -XPOST $REGAL_API/utils/index/regal:1234 -H"accept: application/json"
