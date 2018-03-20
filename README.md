Basic Qbs Build Environment
===========================

This docker image provides a Linux environment based upon Ubuntu 16.04 for
building applications with Qbs. It may serve as a foundation for various build
environments.

The image is available on docker hub: https://hub.docker.com/r/rweickelt/qbs


Included packages
-----------------

- Git 2.7.4
- Qt 5.9.4
- Qbs 1.10.1
- Gcc 5.4.0
- Make

How to use
----------

Pull the latest version from docker hub:

```sh
docker pull rweickelt/qbs:latest
```

Execute qbs on a file in the current directory:

```sh
docker run -v ${PWD}:/myproject rweickelt/qbs \
    install -f /myproject.qbs --install-root /myproject/results \
    profile:qt5
```

This mounts the current directory as ``/myproject`` inside the docker
container and executes qbs on it. The build result is written to
``/myproject/results`` and hence, into a subfolder ``results`` in the current directory.


Changelog
---------

1.10.1-1 (2018-03-20):

- Update Qbs version 1.10.1
- Update Qt version to 5.9.4

1.9.1-1 (2017-11-27):

- Initial release
