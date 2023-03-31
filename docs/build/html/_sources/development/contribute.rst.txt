How to contribute
=================

Prerequisites
-------------

Software
________

* git
* maven
* Java SDK (OpenJDK 15)
* Recommended Eclipse



Coding
------

First of all you need to clone or fork the to.science.core Repository to your local system. 

.. code-block:: bash

   $ git clone https://github.com/hbz/to.science.core.git

Create a new branch then within your local system where to put your code contributions

.. code-block:: bash

   $ git checkout -b new-branch

If you're working on a  fix for an issue (Github or any other ticket system in use for the code), please provide the issue number within the branches name

.. code-block:: bash

   $ git checkout -b issue-XXX


Generate your wonderful peace of contribution :-)

For testing and compilation please use mvn command with appropriate goals 

.. code-block:: bash

   $ mvn clean test compile


If you're done with that push our branch into the repository or forked repository either and create a pull request

.. code-block:: bash

   $ git push main new-branch


Code will be merged by us into main branch of to.science.core if applicable


Extra
-----

If your code passes the checks and compiles you are able to create your own jar-File of **to.science.core** with the command

.. code-block:: bash

   $ mvn clean compile assembly:single


  