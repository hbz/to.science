# About

This repository provides a working vagrant config to create a ubuntu 14.04 virtualbox with a running [Regal] installed. 
The virtualbox will automatically provide the source code of all running regal components in a shared folder together with eclipse project files. You can import those projects directly to your eclipse IDE on your host system. 

**Settings**

hdd 40GB

cpu 2core

ram 2048M

# Prerequisites

Newest (>=2.2.3) version [of vagrant](https://www.vagrantup.com/downloads.html) installed. Current version of virtualbox installed.

e.g. on Ubuntu

```
sudo apt-get install virtualbox
```
e.g. on Ubuntu
```
cd /tmp
wget https://releases.hashicorp.com/vagrant/2.2.3/vagrant_2.2.3_x86_64.deb
sudo dpkg -i vagrant_2.2.3_x86_64.deb
```

# How to

## Install

Check out this repo at any location. 

```
git clone https://github.com/jschnasse/Regal
cd Regal/vagrant/ubuntu-14.04
```

It is mandatory to provide a Java 8 jdk under `bin/java8.tar.gz`. Please register at Oracle to download a current JDK 8 and copy/rename the file to java8.tar.gz

```
mkdir bin
mv ~/downloads/jdk.... bin/java8.tar.gz
```

The file is needed by the vagrant install script. The script will not install anything if the JDK is not present.

Now, create a directory for your vagrant guest to share some folders. The standard path for the shared folder is defined in the [`Vagrantfile`](https://github.com/edoweb/regal-vagrant-centos7/blob/master/Vagrantfile) by ` config.vm.synced_folder "~/regal-dev", "/opt/regal/src",type: "virtualbox"`. So please make sure that the path `~/regal-dev` exists.

```
mkdir ~/regal-dev
```

## Start

Install guest additions

```
vagrant plugin install vagrant-vbguest && vagrant reload
```

`vagrant up`

Running the first time this will download a lot of things and can last up to one hour. 



### Enter the box

`vagrant ssh`

## Add box to /etc/hosts

This step is very important! Add the IP of your Vagrantbox to your local hosts configuration (typically under `/etc/hosts`). 

....
sudo printf "192.168.50.4 regal.vagrant api.regal.vagrant" >> /etc/hosts
....

Now access your box via webbrowser under `regal.vagrant` and `api.regal.vagrant`

## Everything up and running!


Congratulations. At this point you should find a first object in your regal installation. Some Links:

**Login:** edoweb-admin

**Password:** admin

```
http://regal.vagrant:9000/resource/danrw:1234
http://regal.vagrant:8180/fedora/objects/danrw:1234
http://regal.vagrant:9000/search/danrw2/_all/danrw:1234
```

## Stop

``vagrant halt``

## Login

``vagrant ssh``

## Remove

``vagrant destroy``


# Inside the box

You can use `vagrant ssh` to login to the box

You will find:

```
/opt/regal/src
/opt/regal/apps
/opt/regal/bin/activator
/opt/regal/logs
/opt/regal/tmp
/opt/regal/conf
 ```

# Development

## IDE & GIT

By default vagrant will share the `/opt/regal/src` directory at the guest system to `~/regal-dev`. the content is

```
etikett
regal-api
regal-install
skos-lookup
thumby
zettel
```

You can import all of these projects into your eclipse IDE. All projects are version controlled by git. 

