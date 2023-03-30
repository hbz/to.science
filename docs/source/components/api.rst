.. _api_documentation:

API
===

.. _preface:

Preface
-------


The Regal webservices documented by example ``curl``-calls. Examples are
assumed to work in the Vagrant-Environment that comes with this
document.


.. _environment:

Environment
-----------

Got to your server or to the Vagrant-Box, that comes with this document.

``vagrant ssh``

Prepare your environment to make the following ``curl``-Calls work!

.. code-block:: bash

   source /opt/regal/conf/variables.conf
   export REGAL_API=http://$SERVER
   export API_USER=edoweb-admin


.. toctree::
   :maxdepth: 1

   toscience
   api_labels
   api_forms
   api_thumbs
   skos
   complex-example






