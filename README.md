Taskwarrior Server Environment
==============================

Taskd docker image.
Automated builds are available here:
https://hub.docker.com/r/mrdaemon/taskd/

How 2 Build?
------------
You most likely shouldn't, but if you insist:

Building requires docker edge builds (tested on at least 17.07) for the
`FROM image AS name` directive, allowing an intermediate image for builds.

If that fails for you, your version of docker is too old to be useful.

Checkout submodules:

```
$ git submodule update --init
```

Build the image
```
$ docker build -t taskd .
```

How 2 Run?
----------
See the docker-compose file in `tools/` for an example.
The taskd data must be available as a docker volume at `/var/taskd`, and must
be writable by the uid/gid you run the container as.

Every new run will create a fresh example configuration under `example/` in
that docker volume, you can use this to populate your own, but optimally
you will have done this beforehand.

Can I Use this in production?
-----------------------------
Please don't, unless you feel like vetting it and maintaining it yourself.
Or you don't mind russian backdoors. This is probably only useful as reference.

Do YOU use this in production?
------------------------------
Maybe. But then again I made it, so that absolves me of any plebbery.

Why Docker?
------------
Because I'm dumb, but circumstances make this fitting.
Don't do it.

Also Docker is plebware and I'm a cranky old fart who misses solaris zones.

