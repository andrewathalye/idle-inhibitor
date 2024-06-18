{ stdenv

# Native
, gnat
, gprbuild
, ninja
, wayland-ada-scanner

# Deps
, wayland-ada
}:

stdenv.mkDerivation {
   pname = "idle-inhibitor";
   version = "1.0";
   src = ./.;
   
   nativeBuildInputs = [
      gprbuild
      gnat
      ninja
      wayland-ada-scanner
   ];

   buildInputs = [
      wayland-ada
   ];

   buildPhase = ''
      runHook preBuild
      ninja
      runHook postBuild
   '';

   installPhase = ''
      prefix=$out ninja install
   '';
}
