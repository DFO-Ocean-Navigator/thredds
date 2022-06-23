# thredds

* Create and run a docker instance of Unidata's TDS software on the host system.

```console
docker run --cpus=4 --memory=4GB -d -p 8080:8080 -v /store/hpfx.collab.science.gc.ca:/store/hpfx.collab.science.gc.ca --name thredds unidata/thredds-docker:5.3
```

* Update the container's instance of the /usr/local/tomcat/content/thredds/threddsConfig.xml configuration file by replacing the items on the left with those on the right.

```console
    <name>THREDDS</name>                     |     <name>Ocean Navigator TDS</name>
      <organization>My Group</organization>  |       <organization>Ocean Navigator Group</organization>
      <email>support@my.group</email>        |       <email>DFO.OceanNavigator-NavigateurOcean.MPO@dfo-mpo.g
      <name>My Group</name>                  |       <name>Ocean Navigator Group</name>
      <webSite>http://www.my.site/</webSite> |       <webSite>https://www.digitaloceans.ca</webSite>
      <logoUrl>myGroup.gif</logoUrl>         |       <logoUrl></logoUrl>
      <logoAltText>My Group</logoAltText>    |       <logoAltText>Ocean Navigator Group</logoAltText>

```

* Restart the thredds container by issuing the command

```console 
docker restart thredds
```

* On the host system perform a git clone of the thredds repo.

```console
git clone https://github.com/DFO-Ocean-Navigator/thredds.git 
```

* the following crontab entry is being used to keep the TDS service updated on [www.digitaloceans.ca](https://www.digitaloceans.ca/thredds/catalog/catalog.html)

```console
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
01 06,12,18 * * * ${HOME}/thredds/build-catalog/build-thredds-catalog.sh ; docker cp ${HOME}/thredds/build-catalog/catalog.xml thredds:/usr/local/tomcat/content/thredds/catalog.xml ; docker restart thredds
```

* to install an entry in a user's crontab. Run the command

```console
crontab ${HOME}/thredds/build-catalogue/crontab.txt
```
