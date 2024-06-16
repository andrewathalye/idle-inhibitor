Idle Inhibitor
==============

A simple Wayland idle inhibitor program written in Ada.

Run the program with no arguments to see the recommended usage.

Dependencies
------------
```
GPRBuild
GNAT
Ninja
(libadalang-tools)
wayland-ada (wayland-ada-scanner and wayland-ada-client)
(gnatstudio)
(ada-language-server)
```

Install
-------
```
$ ninja
$ prefix=<prefix> ninja install
```

Development
-----------
```
$ ninja generate
$ gprbuild
```
