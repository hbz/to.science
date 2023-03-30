.. _to.science.labels:

to.science.labels
=================

https://github.com/hbz/to.science.labels/blob/master/conf/routes

.. _create_2:

Create
------

.. _add_labels_to_database:

Add Labels to Database
~~~~~~~~~~~~~~~~~~~~~~

::

   curl -u$API_USER:$PASSWORD -XPOST -F"data=@$ARCHIVE_HOME/src/REGAL_API/conf/labels.json" -F"format-cb=Json" $REGAL_API/tools/etikett -i -L

.. _add_label:

Add Label
~~~~~~~~~

.. _read_2:

Read
----

::

   curl "$REGAL_API/tools/etikett" -H"accept: application/json"

.. _read_etikett:

Read Etikett
~~~~~~~~~~~~

::

   curl $REGAL_API/tools/etikett?url=http%3A%2F%2Fpurl.orms%2Fissued -H"accept: application/json"

.. _update_2:

Update
------

.. _delete_2:

Delete
------

.. _delete_cache:

Delete Cache
~~~~~~~~~~~~

::

   curl -XDELETE -u$API_USER:$PASSWORD $REGAL_API/tools/etikett/cache

.. _misc_2:

Misc
----
