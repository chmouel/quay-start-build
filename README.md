Start a build in quay
=====================


This was designed for openshfit catalog to trigger a new build every night from the latest but this can be slurped for some other projects.

It uses quay API and kubernetes cron to periodically kick the job on quay.

## Build this image

You need to access to the quay repo `openshift-pipeline/` or adjust the variable in Makefile and then run :

`make`

it would by default do a `build` and `push`

## Install the CronJob into a K8 cluster

just make sure you have the secret token (makefile would tell you what to do if you haven't) and run :

```
make install
````

adjust the template if you need to do some customization, this is mostly tailored to generate the image for the tekton catalog.

## Demo

![Screenshot demo](./screenshot.png)

## Debug

You can run the container script verbosly (set -x in shell) with this :

```
oc set env cronjob/<cronjob> SCRIPT_DEBUG=true
```

To run a cronjob manually you can use this nifty trick :

```
kubectl create job --from=cronjob/<name of cronjob> <name of job>
```

(you may have to use `oc` command on openshift)

If nothing happened during the night then go over your build history for example : 

https://quay.io/repository/openshift-pipeline/openshift-cli?tab=builds

click on red cross to see what was the build error,


