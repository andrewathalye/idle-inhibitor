{
   inputs.nix-ada.url = "github:andrewathalye/nix-ada/v1.1";

   outputs = { self, nix-ada }:
   let
      nix-ada_s = nix-ada.packages.x86_64-linux;
   in
   with nix-ada_s;
   {
      devShells.x86_64-linux.default = import ./shell.nix { pkgs = pkgs; nix-ada = nix-ada_s; };
      packages.x86_64-linux.default = pkgs.callPackage ./default.nix { inherit wayland-ada-scanner wayland-ada;  };
   };
}
