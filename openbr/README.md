## Intro

This project contains a Dockerfile that builds [OpenBR](http://www.openbiometrics.org/), then exposes the runtime.  See the [Dockerfile](Dockerfile) for an explanation of the build process.

The build process is adapted from OpenBR's [linux installation](http://openbiometrics.org/doxygen/latest/linux_gcc.html) instructions.  The Dockerfile and Git project are inspired by the [golang Dockerfiles](https://registry.hub.docker.com/_/golang/).

Feel free to suggest any improvements to the Dockerfile.

## Using this image

The image built from this project is intended to be used as a runtime for the openbr command-line.  Building the image is done from scratch, and can take a long time (about 30 minutes).

```
docker build -t openbr .
docker run -it --rm --name my-running-openbr openbr [br command-line flags]
```

For something realistic, you will probably bind/mount a local directory to your Docker container.

```
$> ls
me.jpg you.jpg
$> docker run --rm -v "$PWD":/usr/images:rw -w /usr/images openbr \
    -algorithm FaceRecognition -compare me.jpg you.jpg
Set algorithm to FaceRecognition
Loading FaceRecognition
Comparing me.jpg and you.jpg
Enrolling me.jpg to me2nC3iRz.mem
100.00%  ELAPSED=00:00:00  REMAINING=00:00:00  COUNT=1
100.00%  ELAPSED=00:00:00  REMAINING=00:00:00  COUNT=1
0.581105
```
