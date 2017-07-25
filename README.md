# Development environment

The `dxm-dev` projects helps you to get all projects related to a specific build of DXM. This project contains references to the correct repository URLs and branches, and will checkout all modules packaged in the standard DXM distribution.

Use the following to get the project from the master branch :
```
git clone https://github.com/Jahia/dxm-dev.git dxm-dev
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

```install.sh/.bat installer```

Installer is generated in jahia-pack-root/package/jahia-installer-package/target/DigitalExperienceManager-*.jar

You can then launch simply using :

```java -jar jahia-pack-root/package/jahia-installer-package/target/DigitalExperienceManager-*.jar```

### Build and deploy using Jahia Maven Plugin 

1. Copy and customize the settings in `jahia-root/settings.example.xml` into your Maven `settings.xml` file. Also you might want to check the jahia-root/README file if you want to learn more about the deployment process.
2. `install.sh/.bat`
3. `deploy.sh/.bat LIST_OF_PROFILES_TO_ACTIVATE`
4. `mvn jahia:configure -P LIST_OF_PROFILES_TO_ACTIVATE`

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

On https://github.com/Jahia/dxm (or another repository page), click on "Fork" button on the top-right. Jahia Employees can directly fork -private repositories instead of public mirrors.

Once you have forked the project, you clone it locally as you would normally do:
```
git clone git@github.com:username/dxm.git
```
This will create a `dxm` directory on your system.

Once you have forked and locally cloned the project, you need to tell git about the upstream version of your fork. 
When you clone a repository locally, git records the remote repository from which the local copy was cloned so that it 
knows where to fetch and push code. You can retrieve the list of remote repositories your local copy knows about by 
performing `git remote -v`, which will list the name of known remotes as well as their associated fetch and push 
URIs (usually, both the same). By default, the remote repository from which you cloned is named `origin`. So, in the 
above example where you cloned your `dxm` fork, performing `git remote -v` will result in the following result:
```
origin	git@github.com:username/dxm.git (fetch)
origin	git@github.com:username/dxm.git (push)
```

Since your local repository is a clone of your fork, you need to be able to make sure it is up to date with the 
latest version of the upstream repository. The way to do this is to tell git about another remote source of code: the
 upstream repository. As you might have guessed, you do this by adding letting your local copy know about another 
 remote by performing `git remote add <name of the remote> <uri of the remote>`. With this setup, we recommend using 
 `upstream` as the remote name for the upstream remote repository, as follows:
 `git remote add upstream git@github.com:Jahia/dxm.git`. `git remote -v` then produces the following result:
```
origin	git@github.com:username/dxm.git (fetch)
origin	git@github.com:username/dxm.git (push)
upstream	git@github.com:Jahia/dxm.git (fetch)
upstream	git@github.com:Jahia/dxm.git (push)
```

Alternatively, you could rename the upstream version `origin` and rename your fork `fork` by performing:
```
git remote rename origin fork;
git remote rename upstream origin
```

In the end, it doesn't matter how your remotes are called as long as you know which is which! Remember to perform 
these operations for each repository you fork and clone locally and for which you want to provide patches. You can 
read more about remotes and how to work with them at: https://help.github.com/articles/working-with-forks/

In the setup where you fork is called `origin` and the upstream repository is called `upstream`, the process to issue
a pull request to provide a patch is as follows:

- Create a branch for your fix, naming it after the JIRA ticket associated with the fix if possible, e.g. 
`git checkout -b QA-1234`
- Add the necessary code (with tests if possible) and commit it to your branch
- Make sure your fork and branch is up to date with respect to the latest changes in the upstream version by 
pulling the latest changes from upstream into your branch:
```
git fetch upstream # fetch the latest version of the code from the upstream repository
git checkout master 
git merge upstream/master # sync your fork's master with the upstream version (might want to push to origin to update
 your fork afterwards)
git checkout QA-1234 # switch to your patch branch
git merge master # sync changes from master
```
- Fix any conflicts
- Once you're satisfied with your patch, push it to your remote fork: `git push origin QA-1234`. This will create a 
new `QA-1234` branch in your remote repository (your fork).
- Go to github and browse the upstream version of the repository you want to provide a patch for. It should detect 
that you pushed a new branch to your fork and offer you to create a pull request for that change.

You can learn about the process and philosophy behind collaborating via pull requests by reading: 
https://help.github.com/categories/collaborating-on-projects-using-issues-and-pull-requests/


## Tested With

[<img src="https://cloud.githubusercontent.com/assets/7864462/12837037/452a17c6-cb73-11e5-9f39-fc96893bc9bf.png" alt="Browser Stack Logo" width="300">](https://www.browserstack.com/)
