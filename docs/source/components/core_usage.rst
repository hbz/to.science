Use to.science.core from console
================================

As a matter of fact there is nothing very exiting you can do with **to.science.core**. **to.science.core** will only provide some background services for the Toolbox. But if you keen to do something with it you can download the latest jar File with the dependencies and run the ConsoleMapper.class. Actualy it is only performing a conversion (mapping) from a file with AMB metadata to an output of the to.science data model (TOS). Java 1.8 JRE is required to run the ConsoleMapper:          

.. code-block:: shell

  $ java -jar to.science.core-VERSION-jar-with-dependencies.jar


The ConsoleMapper will lead you through the process from mapping a AMB File to the internal Toolbox json Format.


.. code-block:: shell

  ***---------------------------ConsoleMapper-----------------------------***
  ***     ConsoleMapper is part of the to.science.core library by hbz     ***
  ***   Maps your AMB file to the to.science json based data model (TOS)  ***
  ***---------------------------------------------------------------------***

It will as you for the submitters name and the submitters email address as this is not part of the AMB file but required by TOS.

.. code-block:: shell

  Please set submitters name (Jane Doe)>
  Please set submitters mail address (doe@eexample.org)>

The embraced testing values will be used if you return each line without typing. The ConsoleMapper succeed with asking you if you like to map any own AMB file from your filesystem or just run the mapping process with the included example file.

.. code-block:: shell

  Load our own AMB file for mapping? ((y)es)>
  Please provide your AMB File relative to our current directory or with an absolute path
  your current directory is /home/myhome

  AMB File location >


The ConsoleMapper starts to map the AMB File and imports the submitters name and email into TOS:

.. code-block:: json

   "isDescribedBy": {
   "submittedBy": "Jane Doe",
   "submitterByEmail": "doe.example.org",
   "@id": "orca:3fc1c517-2667-403a-b13c-9c4bb83064a6",
   "describes": "orca:3fc1c517-2667-403a-b13c-9c4bb83064a6"
   },
   "department": [
   {
   "prefLabel": "Physik",
   "@id": "https://w3id.org/kim/hochschulfaechersystematik/n0128"
   }

 


