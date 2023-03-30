Why to.science.core?
====================

**to.science.core** is thought to be a core library of the Toolbox Open Science Environment. For keeping usage simple and allowing a widespread usage, **to.science.core** comes as a Java-Library provided either as jar-file with dependencies (via github `release <https://github.com/hbz/to.science.core/releases>`_) or as Library provided by one of the Maven Central Repositories. The latter allows the usage within Maven or sbt-Project for instance.

Where to find to.science.core?
______________________________

Bring **to.science.core** into your project by popular dependency management is like this: 

**Maven**

Copy this code into the dependencies section in the projects pom.xml file

.. code-block:: xml

  <dependency>
    <groupId>io.github.hbz</groupId>
    <artifactId>to.science.core</artifactId>
    <version>$latest</version>
  </dependency>

**sbt**

Copy this code into the dependencies section in the projects build.sbt file

.. code-block:: rest

   libraryDependencies += "io.github.hbz" % "to.science.core" % "1.3.4"


Since **to.science.core** is available from Maven Central Repository this is all you need to do if you're using a Build-Tool with dependency management.

I'd like to use the jar-Library in my priject without build tools
__________________________________________________________________

Please find the latest version of **to.science.core** within the `release <https://github.com/hbz/to.science.core/releases>`_ section of Github.

