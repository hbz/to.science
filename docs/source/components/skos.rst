.. _api_skos_lookup:

skos-lookup
===========

https://github.com/hbz/skos-lookup/blob/master/conf/routes

.. _create_4:

Create
------

.. _create_new_index:

Create new Index
~~~~~~~~~~~~~~~~

::

   curl -i -X POST -H "Content-Type: multipart/form-data" $REGAL_API/tools/skos-lookup/upload -F "data=@/tmp/skos-lookup/test/resources/agrovoc_2016-07-15_lod.nt.gz" -F"index=agrovoc_test" -F"format=NTRIPLES"

.. _read_4:

Read
----

::

   curl -XGET '$REGAL_API/tools/skos-lookup/autocomplete?lang=de&q=Erdnus&callback=mycallback&index=agrovoc_test'

.. _search_3:

Search
------

::

   curl $REGAL_API/tools/skos-lookup/search?q=http%3A%2F%2Faims.fao.org%2Faos%2Fagrovoc%2Fc_13551&lang=de&index=agrovoc

