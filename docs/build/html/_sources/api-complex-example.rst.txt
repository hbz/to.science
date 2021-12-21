.. _complex_example_of_hierarchical_content:

Complex Example of hierarchical content
=======================================

The newly created resource should meet the following requirements:

* publishScheme and accessScheme should be private
* Metadata are in LRMI Schema
* Resource should be assigned to an existing user in the Drupal frontend

Structure of the Resource:

.. code-block:: bash

   orca:50
   ├── lrmiData
   └── orca:51
        └── document.pdf

For the below curl command to work from your local computer it is convenient to put some often used data
into environment variables. Prepare a simple textfile e.g. ``example`` with the following content. The
``DRUPAL_USERID`` is the numeric id which is automatically assigned to the user account by the Drupal CMS.

.. code-block:: bash

   export TOSCIENCE_API=https://api.example.com
   export DRUPAL_USERID="2"
   export API_USER=toscience-admin
   export PASSWORD=***********

Make the variables available by sourcing the file:

.. code-block:: bash

    $ source example


Creating resource
-----------------

Initially we create a yet empty resource with the desired accessScheme, publishSchem and user id:

.. code-block:: bash

   $ curl -i -u$API_USER:$PASSWORD -XPUT $TOSCIENCE_API/resource/orca:50 -d'{"contentType":"researchData","accessScheme":"private", "publishScheme":"private", "isDescribedBy":{"createdBy":"'"$DRUPAL_USERID"'"}}' -H'Content-type:application/json' ; echo

The Metadata are given in a special LRMI-Format and passed to a didicated endpoint:

.. code-block:: bash

   $ curl -i -u$API_USER:$PASSWORD -XPOST $TOSCIENCE_API/resource/orca:50/lrmiData  --data-binary '@lrmi.json' -H'Content-Type:application/json;charset=utf-8'; echo

The data are stored in a separate resource of contentType ``file``. At this point there is no relation between the two newly created resources:

.. code-block:: bash

   $ curl -i -u$API_USER:$PASSWORD -XPUT $TOSCIENCE_API/resource/orca:51 -d'{"contentType":"file","accessScheme":"private", "publishScheme":"private", "isDescribedBy":{"createdBy":"'"$DRUPAL_USERID"'"}}' -H'Content-type:application/json' ; echo

Adding the actual data, a pdf-file in this case:

.. code-block:: bash

   $ curl -i -u$API_USER:$PASSWORD -XPUT $TOSCIENCE_API/resource/orca:51/data -F"data=@document.pdf;type=application/pdf" ; echo

In a final step we tell the data resource about it's parent resource:

.. code-block:: bash

   $ curl -i -u$API_USER:$PASSWORD -XPUT $TOSCIENCE_API/resource/orca:51 -H'Content-Type:application/json;charset=utf-8' -d'{"parentPid":"orca:50","contentType":"file"}' ; echo


Retrieving the resource
-----------------------

Reading the metadata in standard json format:

.. code-block:: bash

   $ curl -i -u$API_USER:$PASSWORD -XGET $TOSCIENCE_API/resource/orca:51.json2 ; echo

The LRMI Metadata are again available via the dedicated endpoint:

.. code-block:: bash

   $ curl -i -u$API_USER:$PASSWORD -XGET $TOSCIENCE_API/resource/orca:51/lrmiData ; echo

Downloading the data

.. code-block:: bash

   $curl -i -u$API_USER:$PASSWORD -XGET $TOSCIENCE_API/resource/orca:51/data  --output data.pdf; echo



