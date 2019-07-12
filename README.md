Launch quay repository trigger

This is mostly for openshfit catalog to trigger new build every night

It uses quay API and kubernetes cron to periodically executre

just make sure you have the secret token (makefile would tell you what to do if you haven't) and run :

```
make install
````

You can adjust stuff from the job template
