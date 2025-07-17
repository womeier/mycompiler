{
  lib,
  mkCoqDerivation,
  which,
  coq,
  metacoq,
  pkgs,
  version ? null,
}:

with lib;
mkCoqDerivation {
  pname = "mycompiler";
  inherit version;

  propagatedBuildInputs = [ metacoq pkgs.tree ];
  mlPlugin = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp mycompiler $out/bin
    runHook postInstall
    '';

  meta = {
    description = "Simple compiler to test extraction mechanism";
    maintainers = with maintainers; [ womeier ];
    license = licenses.mit;
  };
}
