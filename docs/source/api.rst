.. _api_documentation:

API-documentation
***************** 

.. _preface:

**Preface**


The Regal webservices documented by example ``curl``-calls. Examples are
assumed to work in the Vagrant-Environment that comes with this
document.


.. _environment:

**Environment**

Got to your server or to the Vagrant-Box, that comes with this document.

``vagrant ssh``

Prepare your environment to make the following ``curl``-Calls work!

::

   source /opt/regal/conf/variables.conf
   export REGAL_API=http://$SERVER
   export API_USER=edoweb-admin


.. toctree::
   :maxdepth: 1

   api-toscience
   api-labels
   api-forms
   api-thumbs
   api-skos






