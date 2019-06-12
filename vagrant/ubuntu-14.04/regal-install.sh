#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/variables.conf

function download(){
	cd $INSTALL_BIN
	filename=$1
	url=$2
	if [ -f $filename ]
	then
	    echo "$filename is already here! Stop downloading!"
	else
	    wget $url$filename
	fi
	cd -
}

function downloadBinaries(){
	download typesafe-activator-1.3.12.zip https://downloads.typesafe.com/typesafe-activator/1.3.12/
	download fcrepo-installer-3.7.1.jar https://sourceforge.net/projects/fedora-commons/files/fedora/3.7.1/
	download mysql-community-release-el7-5.noarch.rpm https://repo.mysql.com/
	download elasticsearch-1.1.0.deb https://download.elasticsearch.org/elasticsearch/elasticsearch/
	download heritrix-3.1.1-dist.zip http://builds.archive.org/maven2/org/archive/heritrix/heritrix/3.1.1/
	download apache-tomcat-8.5.40.zip http://ftp.halifax.rwth-aachen.de/apache/tomcat/tomcat-8/v8.5.40/bin/
	download drupal-7.36.tar.gz https://ftp.drupal.org/files/projects/ 
}

function installJava8(){
    cd $INSTALL_BIN
    if [ -f $INSTALL_BIN/java8.tar.gz ]
    then
	tar -xzf $INSTALL_BIN/java8.tar.gz 
	mv $INSTALL_BIN/jdk* /opt/jdk
	cd /opt/
	ln -s jdk java
	sudo update-alternatives --install "/usr/bin/java" "java" "/opt/jdk/bin/java" 1
	sudo update-alternatives --install "/usr/bin/javac" "javac" "/opt/jdk/bin/javac" 1
	sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/opt/jdk/bin/javaws" 1
	sudo update-alternatives --install "/usr/bin/jar" "jar" "/opt/jdk/bin/jar" 1
	sudo update-alternatives --set "java" "/opt/jdk/bin/java" 
	sudo update-alternatives --set "javac" "/opt/jdk/bin/javac" 
	sudo update-alternatives --set "jar" "/opt/jdk/bin/jar"
	sudo update-alternatives --set "javaws" "/opt/jdk/bin/javaws"
	java -version
    else
        printf "Please provide a tared Version of a Java 8 jdk under $INSTALL_BIN/jdk8.tar.gz!"
	exit 1
    fi
    cd -
}

function installPackages(){
    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get -y -q update
    sudo apt-get -y -q upgrade
    sudo apt-get -y -q install zip
    sudo apt-get -y -q install unzip
    sudo apt-get -y -q install curl
    sudo apt-get -y -q install apache2
    sudo apt-get -y -q install git
    sudo apt-get -y -q install mavenc
    sudo apt-get -y -q install emacs
    sudo -E apt-get -y -q install mysql-server
    sudo apt-get -y -q install libapache2-mod-php5 
    sudo apt-get -y -q install php5-gd 
    sudo apt-get -y -q install php5-common 
    sudo apt-get -y -q install php5-mysql 
    sudo apt-get -y -q install php5-librdf 
    sudo apt-get -y -q install php5-curl 
    sudo apt-get -y -q install php5-intl
    sudo apt-get -y -q install python34 
    sudo apt-get -y -q install python-pip
    sudo apt-get -y -q install drush
    sudo apt-get -y -q install ant   
    sudo apt-get -y -q install parallel
    sudo dpkg -i $INSTALL_BIN/elasticsearch-1.1.0.deb 
    sudo update-rc.d elasticsearch defaults 95 10
    cd /usr/share/elasticsearch/
    sudo bin/plugin -install mobz/elasticsearch-head
    sudo bin/plugin install elasticsearch/elasticsearch-analysis-icu/2.1.0
    sudo bin/plugin -install com.yakaz.elasticsearch.plugins/elasticsearch-analysis-combo/1.5.1
} 

function createUser(){
    sudo adduser $REGAL_USER
    sudo adduser $REGAL_USER sudo
    printf "$REGAL_USER ALL=(ALL) NOPASSWD:ALL" > $REGAL_USER.tmp
    sudo mv $REGAL_USER.tmp /etc/sudoers.d/$REGAL_USER
    sudo chown -R root:root /etc/sudoers.d/$REGAL_USER
    sudo chmod 664 /etc/sudoers.d/$REGAL_USER
}

function makeDir()
{
	if [ ! -d $1 ]
	then
	mkdir -v -p $1
	fi
}

function createRegalFolderLayout(){
    makeDir $ARCHIVE_HOME/apps/fedora
    makeDir $ARCHIVE_HOME/logs
    makeDir $ARCHIVE_HOME/conf
    makeDir $ARCHIVE_HOME/var/proai/cache
    makeDir $ARCHIVE_HOME/var/proai/sessions
    makeDir $ARCHIVE_HOME/var/proai/schemas
    makeDir $ARCHIVE_HOME/src
    makeDir $ARCHIVE_HOME/tmp
    
    cp -r $INSTALL_ETC $ARCHIVE_HOME/
    cp $SCRIPT_DIR/variables.conf $ARCHIVE_HOME/conf
    cp $INSTALL_CONF/install.properties $ARCHIVE_HOME/conf
    cp $INSTALL_CONF/regal.apache.conf $ARCHIVE_HOME/conf
    sudo chown -R $REGAL_USER $ARCHIVE_HOME
}

function downloadRegalSources(){
    cd $ARCHIVE_HOME/src
    git clone https://github.com/edoweb/regal-api 
    cp $INSTALL_ETC/regal-api.conf $ARCHIVE_HOME/src/regal-api/conf/application.conf
    git clone https://github.com/hbz/thumby
    cp $INSTALL_ETC/thumby.conf $ARCHIVE_HOME/src/thumby/conf/application.conf
    git clone https://github.com/hbz/etikett
    cp $INSTALL_ETC/etikett.conf $ARCHIVE_HOME/src/etikett/conf/application.conf
    git clone https://github.com/hbz/zettel
    cp $INSTALL_ETC/zettel.conf $ARCHIVE_HOME/src/zettel/conf/application.conf
    git clone https://github.com/hbz/skos-lookup
    cp $INSTALL_ETC/skos-lookup.conf $ARCHIVE_HOME/src/skos-lookup/conf/application.conf
    git clone https://github.com/edoweb/regal-scripts
    git clone https://github.com/edoweb/regal-install
}

function substituteVars()
{
	PLAY_SECRET=`uuidgen`
	file=$ARCHIVE_HOME/src/regal-install/templates/$1
	target=$2
	sed -e "s,\$ARCHIVE_HOME,$ARCHIVE_HOME,g" \
	-e "s,\$FEDORA_USER,$FEDORA_USER,g" \
	-e "s,\$API_USER,$API_USER,g" \
	-e "s,\$PASSWORD,$PASSWORD,g" \
	-e "s,\$SERVER,$SERVER,g" \
	-e "s,\$BACKEND,$BACKEND,g" \
	-e "s,\$FRONTEND,$FRONTEND,g" \
	-e "s,\$URNBASE,$URNBASE,g" \
	-e "s,\$IP,$IP,g" \
	-e "s,\$TOMCAT_PORT,$TOMCAT_PORT,g" \
	-e "s,\$EMAIL,$EMAIL,g" \
	-e "s,\$PLAYPORT,$PLAYPORT,g" \
	-e "s,\$TOMCAT_HOME,$TOMCAT_HOME,g" \
	-e "s,\$TOMCAT_CONF,$TOMCAT_CONF,g" \
	-e "s,\$ELASTICSEARCH_CONF,$ELASTICSEARCH_CONF,g" \
	-e "s,\$VERSION,$VERSION,g" \
	-e "s,\$REGAL_USER,$REGAL_USER,g" \
	-e "s,\$PLAY_SECRET,$PLAY_SECRET,g" \
	-e "s,\$REGAL_GROUP,$REGAL_GROUP,g" \
	-e "s,\$SSL_PUBLIC_CERT_BACKEND,$SSL_PUBLIC_CERT_BACKEND,g" \
	-e "s,\$SSL_PRIVATE_KEY_BACKEND,$SSL_PRIVATE_KEY_BACKEND,g" \
	-e "s,\$SSL_PUBLIC_CERT_FRONTEND,$SSL_PUBLIC_CERT_FRONTEND,g" \
	-e "s,\$SSL_PRIVATE_KEY_FRONTEND,$SSL_PRIVATE_KEY_FRONTEND,g" \
	-e "s,\$HERITRIX_URL,$HERITRIX_URL,g" \
	-e "s,\$HERITRIX_DIR,$HERITRIX_DIR,g" \
	-e "s,\$HERITRIX_DATA,$HERITRIX_DATA,g" \
	-e "s,\$REGAL_KEYSTORE,$REGAL_KEYSTORE,g" \
	-e "s,\$DATACITE_USER,$DATACITE_USER,g" \
	-e "s,\$DATACITE_PASSWORD,$DATACITE_PASSWORD,g" \
	-e "s,\$DOIPREFIX,$DOIPREFIX,g" \
	-e "s,\$URNSNID,$URNSNID,g" \
	-e "s%\$ALEPH_SETNAME%$ALEPH_SETNAME%g" \
	-e "s%\$INIT_NAMESPACE%$INIT_NAMESPACE%g" \
	-e "s%\$WHITELIST%$WHITELIST%g" \
	-e "s,\$ELASTICSEARCH_PORT,$ELASTICSEARCH_PORT,g" $file > $target
}

function createConfigFiles(){
	substituteVars install.properties $ARCHIVE_HOME/conf/install.properties
	substituteVars fedora-users.xml $ARCHIVE_HOME/conf/fedora-users.xml
	substituteVars api.properties $ARCHIVE_HOME/conf/api.properties
	substituteVars tomcat-users.xml $ARCHIVE_HOME/conf/tomcat-users.xml
	substituteVars setenv.sh $ARCHIVE_HOME/conf/setenv.sh
	substituteVars elasticsearch.yml $ARCHIVE_HOME/conf/elasticsearch.yml
	substituteVars site.conf $ARCHIVE_HOME/conf/site.conf
	substituteVars logging.properties $ARCHIVE_HOME/conf/logging.properties
	substituteVars catalina.out $ARCHIVE_HOME/conf/catalina.out
	substituteVars Identify.xml $ARCHIVE_HOME/conf/Identify.xml
	substituteVars proai.properties $ARCHIVE_HOME/conf/proai.properties
	substituteVars robots.txt $ARCHIVE_HOME/conf/robots.txt
	substituteVars tomcat.conf $ARCHIVE_HOME/conf/tomcat.conf
	substituteVars application.conf $ARCHIVE_HOME/conf/application.conf
	substituteVars fedora.fcfg $ARCHIVE_HOME/conf/fedora.fcfg
	substituteVars tomcat6 $ARCHIVE_HOME/conf/tomcat6
	substituteVars tomcat7 $ARCHIVE_HOME/conf/tomcat7
	substituteVars openwayback $ARCHIVE_HOME/conf/openwayback
	substituteVars regal-api $ARCHIVE_HOME/conf/regal-api
	substituteVars heritrix-start.sh $ARCHIVE_HOME/conf/heritrix-start.sh
	substituteVars heritrix $ARCHIVE_HOME/conf/heritrix
	cp $ARCHIVE_HOME/src/regal-install/templates/favicon.ico $ARCHIVE_HOME/conf/favicon.ico
}

function installFedora(){
    export FEDORA_HOME=$ARCHIVE_HOME/bin/fedora
    java -jar $INSTALL_BIN/fcrepo-installer-3.7.1.jar  $ARCHIVE_HOME/conf/install.properties
    cp $ARCHIVE_HOME/conf/fedora-users.xml $ARCHIVE_HOME/bin/fedora/server/config/
    cp $ARCHIVE_HOME/conf/tomcat-users.xml $ARCHIVE_HOME/bin/fedora/tomcat/conf/
    $ARCHIVE_HOME/bin/fedora/tomcat/bin/startup.sh
    sleep 10
    sed -i "s/localhost/$SERVER/" $ARCHIVE_HOME/bin/fedora/tomcat/webapps/fedora/WEB-INF/applicationContext.xml
    $ARCHIVE_HOME/bin/fedora/tomcat/bin/shutdown.sh
}

function installPlay(){  
    if [ -d $ARCHIVE_HOME/activator-1.3.12 ]
    then
	echo "Activator already installed!"
    else
	unzip $INSTALL_BIN/typesafe-activator-1.3.12.zip -d $ARCHIVE_HOME/bin 
    fi
}

function postProcess(){
    ln -s  $ARCHIVE_HOME/bin/activator-dist-1.3.12  $ARCHIVE_HOME/bin/activator
    sudo chown -R $REGAL_USER $ARCHIVE_HOME
}

function updateAndDeployRegalModule(){
    app_version=$1
    APPNAME=$2
    DATE=$(date  +"%Y%m%d%H%M%S")
    CURAPP=$(readlink $ARCHIVE_HOME/apps/$APPNAME)
    OLDPORT=`grep "http.port" $ARCHIVE_HOME/apps/$CURAPP/conf/application.conf | grep -o "[0-9]*"`
    NEWPORT=`grep "http.port" $ARCHIVE_HOME/src/$APPNAME/conf/application.conf | grep -o "[0-9]*"`
    if [ $OLDPORT -lt 9100 ]
    then
      NEWPORT=$(($OLDPORT + 100))
    else
      NEWPORT=$(($OLDPORT - 100))
    fi
  
    cd  $ARCHIVE_HOME/src/$APPNAME
    yes r|$ARCHIVE_HOME/bin/activator/bin/activator clean
    yes r|$ARCHIVE_HOME/bin/activator/bin/activator clean-files
    yes r|$ARCHIVE_HOME/bin/activator/bin/activator dist
   
	rm -rf $ARCHIVE_HOME/tmp/$app_version*
    cp $ARCHIVE_HOME/src/$APPNAME/target/universal/$app_version.zip  $ARCHIVE_HOME/tmp/
    yes A|unzip $ARCHIVE_HOME/tmp/$app_version.zip -d $ARCHIVE_HOME/tmp 

    if [ -h $ARCHIVE_HOME/apps/$APPNAME ]
    then
        mv $ARCHIVE_HOME/tmp/$app_version  $ARCHIVE_HOME/apps/$APPNAME.$DATE
	    rm -rf $ARCHIVE_HOME/tmp/$app_version*
        cp -r $ARCHIVE_HOME/apps/$APPNAME/conf/* $ARCHIVE_HOME/apps/$APPNAME.$DATE/conf/
        sed -e "s/^http\.port=.*$/http\.port=$NEWPORT/" $ARCHIVE_HOME/apps/$APPNAME/conf/application.conf > $ARCHIVE_HOME/apps/$APPNAME.$DATE/conf/application.conf
        cp $ARCHIVE_HOME/conf/regal.apache.conf $ARCHIVE_HOME/conf/regal.apache.conf.bck ; 
        sed -i "s/$OLDPORT/$NEWPORT/g" $ARCHIVE_HOME/conf/regal.apache.conf
        rm $ARCHIVE_HOME/apps/$APPNAME
        ln -s $ARCHIVE_HOME/apps/$APPNAME.$DATE $ARCHIVE_HOME/apps/$APPNAME
        
        if [ ! -h $ARCHIVE_HOME/apps/$APPNAME.bck]
        then
    		BCKAPP=$(readlink $ARCHIVE_HOME/apps/$APPNAME.bck)
    		rm -rf $ARCHIVE_HOME/apps/$BCKAPP
    		rm $ARCHIVE_HOME/apps/$APPNAME.bck
        fi
        ln -s $ARCHIVE_HOME/apps/$APPNAME.bck $ARCHIVE_HOME/apps/$CURAPP
        
        sudo service regal-api start
        sleep 20
        tail -1 $ARCHIVE_HOME/apps/$APPNAME/logs/application.log
        NEWPID=$(cat $ARCHIVE_HOME/apps/$APPNAME/RUNNING_PID)
        if [ -z ${NEWPID+x} ]
        then
          echo "New instance of $APPNAME is not running!"
          echo "Old instance under $ARCHIVE_HOME/apps/$CURRAPP is still active!"
          echo "I will switch back links! Failed app can be found under $APPNAME.$DATE.failed"
          rm $ARCHIVE_HOME/apps/$APPNAME
          ln -s $ARCHIVE_HOME/apps/$CURAPP $ARCHIVE_HOME/apps/$APPNAME
          ln -s $ARCHIVE_HOME/apps/$APPNAME.$DATE $ARCHIVE_HOME/apps/$APPNAME.$DATE.failed
        else
            echo "$APPNAME runs under pid: $NEWPID";
	        echo "To perform switch, execute:"  
			echo "sudo service apache2 reload"
		    echo "kill `cat $ARCHIVE_HOME/apps/$CURAPP/RUNNING_PID`"
        fi
        
       cd $ARCHIVE_HOME/apps
    fi
}

function installRegalModule(){
    app_version=$1
    APPNAME=$2
    DATE=$(date  +"%Y%m%d%H%M%S")
    cd  $ARCHIVE_HOME/src/$APPNAME
    yes r|$ARCHIVE_HOME/bin/activator/bin/activator clean
    yes r|$ARCHIVE_HOME/bin/activator/bin/activator dist
    yes r|$ARCHIVE_HOME/bin/activator/bin/activator eclipse
    rm -rf $ARCHIVE_HOME/tmp/$app_version*
    cp target/universal/$app_version.zip  $ARCHIVE_HOME/tmp/
    yes A|unzip $ARCHIVE_HOME/tmp/$app_version.zip -d $ARCHIVE_HOME/tmp 
	rm -rf $ARCHIVE_HOME/apps/$APPNAME
    mv $ARCHIVE_HOME/tmp/$app_version  $ARCHIVE_HOME/apps/$APPNAME.$DATE
    ln -s $ARCHIVE_HOME/apps/$APPNAME.$DATE $ARCHIVE_HOME/apps/$APPNAME
    rm -rf $ARCHIVE_HOME/tmp/$app_version*
    cp $ARCHIVE_HOME/etc/$APPNAME.conf $ARCHIVE_HOME/apps/$APPNAME/conf/application.conf
    cd -
}

function installRegalModules(){
    installRegalModule thumby-0.1.0-SNAPSHOT thumby
    installRegalModule skos-lookup-1.0-SNAPSHOT skos-lookup
    installRegalModule etikett-0.1.0-SNAPSHOT etikett
    installRegalModule zettel-1.0-SNAPSHOT zettel
    installRegalModule regal-api-0.8.0-SNAPSHOT regal-api
}

function configureRegalModules(){
   mysql -u root -Bse "CREATE DATABASE etikett  DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;CREATE USER 'etikett'@'localhost' IDENTIFIED BY 'etikett';GRANT ALL ON etikett.* TO 'etikett'@'localhost';"
   mysql -u root -Bse "CREATE DATABASE regal_api DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;CREATE USER 'regal_api'@'localhost' IDENTIFIED BY 'admin';GRANT ALL ON regal_api.* TO 'regal_api'@'localhost';"
}

function configureApache(){
    sudo a2enmod proxy_mod
    sudo a2enmod proxy
    sudo a2enmod rewrite
    sudo a2enmod proxy_http
    sed -i "1 s|$| $FRONTEND $BACKEND|" /etc/hosts
    printf "192.168.50.4 $FRONTEND $BACKEND" >> /etc/hosts
    rm /etc/apache2/sites-enabled/000-default.conf
    ln -s $ARCHIVE_HOME/conf/regal.apache.conf /etc/apache2/sites-enabled/
    sudo service apache2 reload
}

function installProai(){	
    mysql -u root -Bse " CREATE DATABASE proai; CREATE USER 'proai'@'localhost' IDENTIFIED BY 'proai'; SET PASSWORD FOR 'proai'@'localhost' = PASSWORD('$PASSWORD'); GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP ON proai.* TO 'proai'@'localhost';"
	cd $ARCHIVE_HOME/src
	git clone https://github.com/jschnasse/proai.git
	git clone https://github.com/jschnasse/oaiprovider.git
	cd -
	cd proai;
	git checkout dates;
	cd -
	cd $ARCHIVE_HOME/src/oaiprovider
	git checkout dates;
    #--------------Adopt new Layout------------------#
	sudo sed -i 's|/opt/regal|/opt/regal/var|' $ARCHIVE_HOME/conf/proai.properties
    #------------------------------------------------#
	cp $ARCHIVE_HOME/conf/proai.properties $ARCHIVE_HOME/src/oaiprovider/src/config  
	cp $ARCHIVE_HOME/conf/Identify.xml $ARCHIVE_HOME/bin/drupal
	cd -
	cd $ARCHIVE_HOME/src/proai
	ant release
	cp dist/proai-1.1.3-1.jar ../oaiprovider/lib/
	cd -
	cd $ARCHIVE_HOME/src/oaiprovider
	ant release
	cp dist/oaiprovider.war $ARCHIVE_HOME/fedora/tomcat/webapps/oai-pmh.war
	cd -
}

function installOpenwayback(){
    cd $ARCHIVE_HOME/src/regal-install
	unzip $INSTALL_BIN/apache-tomcat-8.5.40.zip
	mv apache-tomcat-8.5.40 $ARCHIVE_HOME/bin/tomcat-for-openwayback
	#Configure tomcat
	cp $ARCHIVE_HOME/src/regal-install/templates/openwayback-server.xml $ARCHIVE_HOME/bin/tomcat-for-openwayback/conf/server.xml
	rm -rf $ARCHIVE_HOME/bin/tomcat-for-openwayback/webapps/ROOT* 
	#Get openwayback code
	cd $ARCHIVE_HOME/src
	git clone https://github.com/iipc/openwayback.git
	cd -
	cd $ARCHIVE_HOME/src/openwayback
	#Check out tag
	git checkout tags/openwayback-2.2.0
	#Build openwayback
	mvn package -DskipTests
	#Copy build to tomcat
	cp wayback-webapp/target/openwayback-2.2.0.war $ARCHIVE_HOME/bin/tomcat-for-openwayback/webapps/ROOT.war
	#start tomcat
	chmod u+x $ARCHIVE_HOME/bin/tomcat-for-openwayback/bin/*.sh
	$ARCHIVE_HOME/bin/tomcat-for-openwayback/bin/startup.sh
	cd -
	#copy openwayback config
	sleep 5
	cp $ARCHIVE_HOME/src/regal-install/templates/wayback.xml $ARCHIVE_HOME/bin/tomcat-for-openwayback/webapps/ROOT/WEB-INF/
	cp $ARCHIVE_HOME/src/regal-install/templates/BDBCollection.xml $ARCHIVE_HOME/bin/tomcat-for-openwayback/webapps/ROOT/WEB-INF/
	cp $ARCHIVE_HOME/src/regal-install/templates/CDXCollection.xml $ARCHIVE_HOME/bin/tomcat-for-openwayback/webapps/ROOT/WEB-INF/
	#stop tomcat
	$ARCHIVE_HOME/bin/tomcat-for-openwayback/bin/shutdown.sh
}

function installHeritrix(){
	echo "installHeritrix() not implemented yet!"
	unzip $INSTALL_BIN/heritrix-3.1.1-dist.zip
	mv heritrix-3.1.1 $ARCHIVE_HOME/bin/heritrix
}

function installDeepzoomer(){
	echo "installDeepzoomer() not implemented yet!"
}

function installWpull(){
	#https://blog.teststation.org/centos/python/2016/05/11/installing-python-virtualenv-centos-7/
	sudo pip install -U pip
	sudo pip install -U virtualenv
	sudo virtualenv -p /usr/bin/python3 /opt/regal/bin/python3
	sudo /opt/regal/bin/python3/bin/pip3 install tornado==4.5.3
	sudo /opt/regal/bin/python3/bin/pip3 install html5lib==0.9999999
	sudo /opt/regal/bin/python3/bin/pip3 install wpull
}

function installDrush(){
	sudo yum -y install php-pear
	sudo pear channel-discover pear.drush.org
	sudo pear install drush/drush
	drush version
}

function installDrupal(){
	mysql -u root < $INSTALL_CONF/drupal-db.sql
	mysql -u root -Bse "CREATE USER drupal IDENTIFIED BY 'admin';GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, LOCK TABLES, CREATE TEMPORARY TABLES ON drupal.* TO 'drupal'@'localhost' IDENTIFIED BY 'admin';"
	cd $ARCHIVE_HOME	
	tar -xzf $INSTALL_BIN/drupal-7.36.tar.gz
	mv drupal-7.36 $ARCHIVE_HOME/var/drupal
	chmod a+w $ARCHIVE_HOME/var/drupal/sites/default
	cp $INSTALL_CONF/settings.php  $ARCHIVE_HOME/var/drupal/sites/default/settings.php
	mkdir $ARCHIVE_HOME/var/drupal/sites/default/files	
    chmod o+w $ARCHIVE_HOME/var/drupal/sites/default/files
	chcon -R -t httpd_sys_content_rw_t $ARCHIVE_HOME/var/drupal/sites/default/files/
    chcon -R -t httpd_sys_content_rw_t $ARCHIVE_HOME/var/drupal/sites/default/settings.php
	sudo setsebool -P httpd_can_sendmail on
	sudo chmod 755 $ARCHIVE_HOME/var/drupal/sites/default
	sudo chmod 755 $ARCHIVE_HOME/var/drupal/sites/default/settings.php
	cd -
}

function installRegalDrupal(){
	cd $ARCHIVE_HOME/src
	git clone https://github.com/edoweb/regal-drupal.git
    ln -s $ARCHIVE_HOME/src/regal-drupal $ARCHIVE_HOME/var/drupal/sites/all/modules
	cd -
	cd $ARCHIVE_HOME/var/drupal/sites/all/modules/regal-drupal
	git checkout vagrant_driven_stuff
	git submodule update --init
	cd -
	cd $ARCHIVE_HOME/var/drupal/sites/all/modules
	curl https://ftp.drupal.org/files/projects/entity-7.x-1.1.tar.gz | tar xz
	curl https://ftp.drupal.org/files/projects/entity_js-7.x-1.0-alpha3.tar.gz | tar xz
	curl https://ftp.drupal.org/files/projects/ctools-7.x-1.3.tar.gz | tar xz
	php5enmod redland
    service apache2 restart
    ln -s $ARCHIVE_HOME/src/regal-api/public/ $ARCHIVE_HOME/var/drupal/
    cd -
}

function installDrupalThemes(){
	cd $ARCHIVE_HOME/src
	git clone https://github.com/edoweb/edoweb-drupal-theme.git
	git clone https://github.com/edoweb/zbmed-drupal-theme.git
    ln -s $ARCHIVE_HOME/src/edoweb-drupal-theme $ARCHIVE_HOME/var/drupal/sites/all/themes
    ln -s $ARCHIVE_HOME/src/zbmed-drupal-theme  $ARCHIVE_HOME/var/drupal/sites/all/themes
    cd -
}

function configureDrupalLanguages(){
	echo "configureDrupalLanguages() not implemented yet!"
}

function configureDrupal(){
	echo "configureDrupal() not implemented yet!"
}


function createStartStopScripts(){
	cp $SCRIPT_DIR/init.d/* /etc/init.d
	sudo service tomcat6 start;
	sudo service elasticsearch start;
	sudo service etikett start;
	sudo service skos-lookup start;
	sudo service zettel start;
	sudo service thumby start;
	sudo service tomcat-for-openwayback start;
	sudo service tomcat-for-deepzoom start;
	sudo service regal-api start;
}

function defineBootShutdownSequence(){
	sudo update-rc.d tomcat6 defaults 90 27;
	sudo update-rc.d elasticsearch defaults 91 26;
	sudo update-rc.d etikett defaults 92 25;
	sudo update-rc.d skos-lookup defaults 92 25;
	sudo update-rc.d zettel defaults 93 24;
	sudo update-rc.d thumby defaults 93 24 ;
	sudo update-rc.d tomcat-for-openwayback defaults 94 22;
	sudo update-rc.d tomcat-for-deepzoom defaults 95 21;
	sudo update-rc.d regal-api defaults 96 20;
	sudo chkconfig -add tomcat6 35 90 27
}

function configureMonit(){
	echo "configureMonit() not implemented yet!"
}

function configureFirewall(){
	echo "configureFirewall() not implemented yet!"
	#ufw allow http
	#ufw allow https
	#ufw allow ssh
	#ufw enable
	#ufw status
}

function configureElasticsearch(){
	cp -f $ARCHIVE_HOME/conf/elasticsearch.yml /etc/elasticsearch
}

function initialize(){
	curl -iL -uadmin:admin -XPOST http://$BACKEND/tools/etikett -F"data=@$ARCHIVE_HOME/src/regal-api/conf/labels.json" -F"format-cb=Json" 
	curl -iL -uedoweb-admin:admin -XPOST http://$BACKEND/context.json
	curl -iL -uedoweb-admin:admin -XPUT http://$BACKEND/resource/regal:1234 -d'{"contentType":"monograph","accessScheme":"public"}' -H'content-type:application/json'
	curl -iL -uedoweb-admin:admin -XPUT http://$BACKEND/resource/regal:1235 -d'{"parentPid":"regal:1234","contentType":"file","accessScheme":"public"}' -H'content-type:application/json'
	curl -iL -uedoweb-admin:admin -XPUT http://$BACKEND/resource/regal:1235/data -F"data=@$ARCHIVE_HOME/src/regal-api/test/resources/test.pdf;type=application/pdf"
	curl -iL -uedoweb-admin:admin -XPOST "http://$BACKEND/utils/lobidify/regal:1234?alephid=HT018920238"
}


function serverInstallation(){
    cp $ARCHIVE_HOME/src/regal-install/templates/setenv.sh $ARCHIVE_HOME/bin/tomcat-for-openwayback/bin
    cp $ARCHIVE_HOME/conf/setenv.sh $ARCHIVE_HOME/fedora/tomcat/bin   
}


function installRegal(){
    echo "Start Regal installation!"
    sudo locale-gen de_DE.UTF-8
    sudo apt-get -y -q install wget
	downloadBinaries
	installJava8
	installPackages
    createUser
    sudo -i -u $REGAL_USER bash 
	createRegalFolderLayout
	
	downloadRegalSources
    cp $INSTALL_CONF/install.properties $ARCHIVE_HOME/src/regal-install/templates
    createConfigFiles
	configureApache
	installFedora
	installPlay
	postProcess
	installRegalModules
	installProai
	configureRegalModules
	installOpenwayback
	installHeritrix
	installDeepzoomer
	installWpull
	installDrush
	installDrupal
	installRegalDrupal
	installDrupalThemes
	configureDrupalLanguages
	configureDrupal
	configureMonit
	configureFirewall
    configureElasticsearch
	sudo chown -R $REGAL_USER $ARCHIVE_HOME
	createStartStopScripts
	defineBootShutdownSequence
    #serverInstallation
	sleep 30
	initialize
}
