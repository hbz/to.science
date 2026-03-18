.. _vagrant_installation:


Vagrant
-------

Zur Veranschaulichung dieser Dokumentation wird ein Vagrant-Skript
angeboten, mit dem eine Regal-Installation innerhalb eines
VirtualBox-Images erzeugt werden kann.

Zur Installation kannst Du folgende Schritte ausführen. Die Kommandos
beziehen sich auf die Installation auf einem Ubuntu-System. Für andere
Betriebssyteme ist die Installation ähnlich.

Die VirtualBox hat folgendes Setup

* hdd 40GB
* cpu 2core
* ram 4096M

.. _virtualbox_installieren:

VirtualBox installieren
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   sudo apt-get install virtualbox

.. _vagrant_installieren:

Vagrant installieren
~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   cd /tmp
   wget https://releases.hashicorp.com/vagrant/2.2.3/vagrant_2.2.3_x86_64.deb
   sudo dpkg -i vagrant_2.2.3_x86_64.deb

.. _repository_herunterladen:

Repository herunterladen
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   git clone https://github.com/jschnasse/Regal
   cd Regal/vagrant/ubuntu-14.04

.. _eine_jdk8_bereitstellen:

Eine JDK8 bereitstellen
~~~~~~~~~~~~~~~~~~~~~~~

Hierfür bitte ein JDK8-Tarball herunterladen und unter dem Namen
``java8.tar.gz`` in einem Verzeichnis ``/bin`` unterhalb des
Vagrant-Directories bereitstellen.

.. code-block:: bash

   mkdir bin
   mv ~/downloads/jdk.... bin/java8.tar.gz

.. _geteiltes_entwicklungsverzeichnis:

Geteiltes Entwicklungsverzeichnis
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   mkdir ~/regal-dev

.. _vagrant_guest_additions_installieren:

Vagrant Guest Additions installieren
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   vagrant plugin install vagrant-vbguest && vagrant reload

.. _vagrant_host_anlegen:

Vagrant Host anlegen
~~~~~~~~~~~~~~~~~~~~

Damit alle Dienste komfortabel erreichbar sind, muss in die lokale HOSTs
Datei ein Eintrag für die Vagrant-Box erfolgen. Im Vagrantfile ist die
IP ``192.168.50.4`` für die Box konfiguriert. Über die ``FRONTEND`` und
``BACKEND`` Einträge in der ``variables.conf`` ist der Servername als
``regal.vagrant`` definiert.

.. code-block:: bash

   sudo printf "192.168.50.4 regal.vagrant api.regal.vagrant" >> /etc/hosts

.. _vagrant_starten:

Vagrant starten
~~~~~~~~~~~~~~~

.. code-block:: bash

   vagrant up

.. _auf_der_maschine_einloggen:

Auf der Maschine einloggen
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   vagrant ssh

