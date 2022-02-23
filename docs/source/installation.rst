.. _installation:

************
Installation
************

Backend-Installation
====================

Create linux user
^^^^^^^^^^^^^^^^^
Create user toscience with yast2. Generate encrypted password :: 
  head -c 300 /dev/urandom | tr -cd '[a-zA-Z0-9-_]' | head -c 16

Mit yast2 Home-Verzeichnis /opt/toscience und Gruppen **users, root** hinzufügen

Den User zu den sudoern hinzufügen. Zu /etc/sudoers eine Zeile hinzufügen: ::

  vim /etc/sudoers
  toscience    ALL = (root) /bin/su
  wq
  sudo su toscience


