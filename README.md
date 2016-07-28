# Development environment

The `dxm-dev` projects helps you to get all projects related to a specific build of DXM. This project contains references to the correct repository URLs and branches, and will checkout all modules packaged in the standard DXM distribution.

Use the following to get the project from the master branch :
```
git clone git@github.com:Jahia/dxm-dev.git dxm-dev
cd dxm-dev
./checkout-all.sh
```
Note that cloning DXM repository can be quite long.

Other scripts are available :
- `checkout-jahia.sh/.bat` will only check out the core repositories
- `update-all.sh/.bat` update all projects
- `update-jahia.sh/.bat` update only core repositories

## Compiling project

To build the installer :

```install.sh/.bat -P installer```

Installer is generated in jahia-pack-root/package/jahia-installer-package/target/DigitalExperienceManager-*.jar

You can then launch simply using :

```java -jar jahia_pack/package/jahia-installer-package/target/DigitalExperienceManager-*.jar```

### Build and deploy using Jahia Maven Plugin 

1. Copy and customize the settings in `jahia-root/settings.example.xml` into your Maven `settings.xml` file. Also you might want to check the jahia-root/README file if you want to learn more about the deployment process.
2. `install.sh/.bat`
3. `deploy.sh/.bat -P LIST_OF_PROFILES_TO_ACTIVATE`
4. `configure.sh/.bat -P LIST_OF_PROFILES_TO_ACTIVATE`

where LIST_OF_PROFILES_TO_ACTIVATE is something like : jahia-tomcat,jahia-mysql

### If deploying to Tomcat (default) with the Jahia Maven Plugin

Make sure that you modify the catalina startup file to include the following lines.

For Windows in the bin/catalina.bat file :
set CATALINA_OPTS=%CATALINA_OPTS% -Dsun.io.useCanonCaches=false -Xms2048m -Xmx2048m -XX:MaxPermSize=312m -server -Dhibernate.jdbc.use_streams_for_binary=true -verbose:gc -XX:+HeapDumpOnOutOfMemoryError

For Unix/MacOS/Linux in the bin/catalina.sh file:
CATALINA_OPTS="$CATALINA_OPTS -Xms1024m -Xmx1024m -Djava.awt.headless=true -XX:MaxPermSize=256m -server -Dhibernate.jdbc.use_streams_for_binary=true -verbose:gc -XX:+HeapDumpOnOutOfMemoryError"

## Updating projects

When retrieving updates from remote repositories in order to update your local copies, you should always rebase your local changes instead of merging to avoid useless branch merging. You could do it explicitly by using either `git pull --rebase` or `git fetch` `git rebase`. Alternatively, if you want this done automatically for you, you can configure git to do so. See https://coderwall.com/p/tnoiug/rebase-by-default-when-doing-git-pull for more details.

## Notes on project naming

`dxm` is the public repository for DXM Core. 

`dxm-pack` is the public repository for core packaging project. 

`dxm-dev` is the development environment project for community.

## Proposing a patch to the DXM Core team

Even if you don't have write access to the repositories, you can still do a Pull Request to propose your patch. You need to create a fork of the repositories you want to change. Once your fork is created, you will use it to push your changes and create the Pull Request. Pull Request generic usage can be seen at : https://help.github.com/articles/using-pull-requests/

On https://github.com/Jahia/dxm (or another repository page), click on "Fork" button on the top-right. 

Then, add your fork URL to your DXM project. For example, if you forked `dxm`, add the URL in `jahia-root` folder :
```
cd jahia-root
git remote add fork git@github.com:username/dxm.git
```
For `dxm-pack` or `dxm-pack-private`, add the url in `jahia-pack-root`.
For `dxm-ee` add the url in `jahia-ee-root`.

Create a branch for your fix - if possible, name your branch from the Jira ticket. Commit and push your changes to your branch. Once the fix is ready, create the Pull Request from GitHub.
