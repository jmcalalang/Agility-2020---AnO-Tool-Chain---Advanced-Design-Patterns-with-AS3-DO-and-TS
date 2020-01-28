Module |labmodule|\, Lab \ |labnum|\: CI/CD with Ansible Tower
==============================================================

Lab scenario:
~~~~~~~~~~~~~

F5 Declarative Onboarding (DO) uses a declarative_ model to initially configure a BIG-IP device with all of the required settings to get up and ready, this includes system settings such as licensing and provisioning, network settings such as VLANs and Self IPs, and clustering settings if you are using more than one BIG-IP system. 

A declarative model means you provide a JSON declaration rather than a set of imperative commands. The declaration represents the configuration which Declarative Onboarding is responsible for creating on a BIG-IP system. You send a declaration file using a single Rest API call.

Declarative Onboarding can be used to onboard a BIG-IP; however, it can also be used for configuration adherence, making sure system settings like DNS, NTP and user accounts state is always configured correctly.

This lab uses a Declarative Onboarding declaration to build out two BIG-IP clusterd units.

Task |labmodule|\.\ |labnum|\.1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Execute template in Tower to utilize Declarative Onboarding against BIG-IPs.

Navigate to `Templates`.

  |image21|

Execute the `f5_automation_toolchain_do_deployment_template`.

The desired end state of these DO configurations is to configure the below objects, built on the BIG-IPs with a single call in a single file. This declarative solution allows us to compose configurations that are reusable with templating technologies and storable in Source Control.

.. seealso:: This DO declaration was created from an F5 provided example located on CloudDocs DO_Example_

Configuration Items in our declaration:
  - Licensing
  - Credentials
  - Provisioning
  - DNS
  - NTP
  - Self-IPs
  - Vlans
  - Clustering

Declaration for BIGIP1:

Copy **all of** the below DO declaration.

.. literalinclude :: /docs/ansibleTowerDeployment/module5/ansible/roles/declarative_onboarding/tasks/main.yml
   :language: yaml

Reviewing the Playbook execution we can see some testing and error handling that has been built into the tasks. The BIG-IP(s) are verified to be accessable, and then the packages for each of the Automation Toolchain items are installed. This order makes use of good Just-In-Time (JIT) delivery and concepts for automation practices.

.. Warning:: If at anypoint a Job fails and is not Successful, just re-run the job, all the tool are built around Atomic and Idempotent best practices. Only changes that need to be done are completed, and if a failure happens all configuration is reverted. This is one of the many benefits around utilizing correctly built Ansible Modules.

.. |labmodule| replace:: 2
.. |labnum| replace:: 2
.. |labdot| replace:: |labmodule|\ .\ |labnum|
.. |labund| replace:: |labmodule|\ _\ |labnum|
.. |labname| replace:: Lab\ |labdot|
.. |labnameund| replace:: Lab\ |labund|

.. |image11| image:: images/image11.png
.. |image12| image:: images/image12.png
   :width: 80%
.. |image13| image:: images/image13.png
.. |image14| image:: images/image14.png