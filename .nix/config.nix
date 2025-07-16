{
  ## DO NOT CHANGE THIS
  format = "1.0.0";
  ## unless you made an automated or manual update
  ## to another supported format.

  ## The attribute to build from the local sources,
  ## either using nixpkgs data or the overlays located in `.nix/rocq-overlays`
  ## and `.nix/coq-overlays`
  ## Will determine the default main-job of the bundles defined below
  attribute = "mycompiler";

  default-bundle = "default";

  ## When generating GitHub Action CI, one workflow file
  ## will be created per bundle
  bundles.default = {
    ## You can override Rocq and other Rocq rocqPackages
    # rocqPackages.rocq-core.override.version = "9.0";

    coqPackages.coq.override.version = "8.20";
  };

  ## Cachix caches to use in CI
  ## Below we list some standard ones
  cachix.coq = {};
  cachix.math-comp = {};
  cachix.coq-community = {};
}
