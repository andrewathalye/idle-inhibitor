Idle Inhibitor
==============

A simple Wayland idle inhibitor program written in Ada.

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

Nix users can download https://www.github.com/andrewathalye/nix-ada first and use that with the `shell.nix` file to develop.

Installation
------------
```
nix-shell
prefix=<installation prefix> ninja install
```

A proper Nix package hasn’t been made because there doesn’t appear? to be a need.
Make an Issue if you’d like one and it can be put together fairly quickly.

Development
-----------
```
nix-shell
ninja generate
gprbuild
```
