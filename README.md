Basic Qbs Build Environment 
===========================

This docker image provides a Linux environment based upon Ubuntu 16.04 for
building applications with Qbs. It may serve as a foundation for various build
environments.

The image is available on docker hub: https://hub.docker.com/r/rweickelt/qbs


Included packages
-----------------

- Git 2.7.4
- Qt 5.9.3
- Qbs 1.9.1
- Gcc 5.4.0
- Make 

How to use
----------

Pull from docker hub: 

```
docker pull rweickelt/qbs:latest
```

Changelog
---------

1.9.1-1 (2017-11-27):

- Initial release
