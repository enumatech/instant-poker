{ pkgs, python }:

self: super: {

  "attrs" = python.overrideDerivation super."attrs" (old: {
    propagatedBuildInputs = [
      self."coverage"
      self."six"
    ];
  });

}
