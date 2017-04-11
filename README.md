Taskwarrior Server Environment
==============================

taskd docker image

How 2 Build?
------------
You probably shouldn't, but if you insist:

Checkout submodules:

```
$ git submodule update --init
```

Builds on run with the buildenv image as:

```
$ docker build -t buildenv_taskd buildenv/
$ docker run --rm --volume="$(pwd)/src:/usr/src" --volume="$(pwd)/dist:/opt/taskd" buildenv_taskd
```

Binaries will be in `./dist`

Next you can build the Actual Image:

```
$ docker build -t taskd .
```

How 2 Run?
----------

TBD

Can I Use this in production?
-----------------------------
Please don't, unless you feel like vetting it and maintaining it yourself.
Or you don't mind russian backdoors. This is probably only useful as reference.

Why Docker?
------------
Because I'm dumb, but circumstances make this fitting.
Don't do it.

Also Docker is plebware and I'm a cranky old fart who misses solaris zones.

