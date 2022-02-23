.. _installation:

************
Installation
************

Backend-Installation
====================

Create linux user
^^^^^^^^^^^^^^^^^
Create user toscience with yast2. Generate encrypted password 
.. code-block:: 

  head -c 300 /dev/urandom | tr -cd '[a-zA-Z0-9-_]' | head -c 16

Mit yast2 Home-Verzeichnis /opt/toscience und Gruppen **users, root** hinzufügen

Den User zu den sudoern hinzufügen. Zu /etc/sudoers eine Zeile hinzufügen:

.. code-block:: 

  vim /etc/sudoers
  toscience    ALL = (root) /bin/su
  wq
  sudo su toscience

Systemprogramme maven, git, java, mariadb etc. installieren
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
maven und maven-local mit yast2 installieren.  

.. code-block::

  zypper ref
  zypper in git
