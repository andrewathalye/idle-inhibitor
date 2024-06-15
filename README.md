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

Nix users can download https://www.github.com/andrewathalye/nix-ada first and use that with the `shell.nix` file to develop.

Development
-----------
```
$ nix-shell # Or manually install dependencies
$ ninja generate
$ gprbuild
```
