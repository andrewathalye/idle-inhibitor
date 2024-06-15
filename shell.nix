{
  nix ? import ../nix-ada {}
}:

let
   pkgs = nix.adapkgs;
in
pkgs.mkShell {
   nativeBuildInputs = [
      pkgs.gprbuild  
      pkgs.gnat
      pkgs.ninja
      nix.libadalang-tools
      nix.wayland-ada-scanner
      nix.gnatstudio
      nix.ada-language-server
   ];
      
   buildInputs = [ nix.wayland-ada ];
}
