{
   inputs = {
#      nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
      nixpkgs.url = "github:NixOS/nixpkgs?rev=cc54fb41d13736e92229c21627ea4f22199fee6b";

      nix-ada = {
         url = "github:andrewathalye/nix-ada";
         inputs.nixpkgs.follows = "nixpkgs"; 
      };
   };

   outputs = { self, nixpkgs, nix-ada }:
   let
      nix-ada_s = nix-ada.packages.x86_64-linux;
   in
   with nix-ada_s;
   {
      devShells.x86_64-linux.default = import ./shell.nix { pkgs = pkgs; nix-ada = nix-ada_s; };
      packages.x86_64-linux.default = pkgs.callPackage ./default.nix { inherit wayland-ada-scanner wayland-ada;  };
   };
}
