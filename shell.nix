{ pkgs ? import <nixpkgs> {}
, nix-ada ? import ../nix-ada/default.nix {}
}:

pkgs.mkShell {
   nativeBuildInputs = [
      nix-ada.gprbuild  
      nix-ada.gnat
      pkgs.ninja
      nix-ada.libadalang-tools
      nix-ada.wayland-ada-scanner
      nix-ada.gnatstudio
      nix-ada.ada-language-server
   ];
      
   buildInputs = [ nix-ada.wayland-ada ];
}
