{ pkgs, ... }:

let
  mtools = ps: with ps; [(
    buildPythonPackage rec {
      pname = "mtools";
      version = "1.7.2";
      src = fetchPypi {
        inherit pname version;
        sha256 = "sha256-zhlb7++Fo6punlHY3B0TARuICSQPWRTYFVBq25RWrLw=";
      };

      doCheck = false;
      propagatedBuildInputs = with pkgs.python3Packages; [
      # Specify dependencies
        numpy
        od
        python-dateutil
        matplotlib
        packaging
        pymongo
        psutil
      ];
    }
  )];
in
{
   home.packages = [
     (pkgs.python3.withPackages mtools)
   ];
}
