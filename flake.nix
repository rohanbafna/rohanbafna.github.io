{
  description = "Personal website, built with Jekyll";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    {
      devShells.x86_64-linux.default =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          gems = pkgs.bundlerEnv {
            name = "website-gems";
            gemdir = ./.;
          };
          # a text file containing the paths to the flake inputs in order to stop
          # them from being garbage collected
          # source: https://gist.github.com/tpwrules/34db43e0e2e9d0b72d30534ad2cda66d
          pleaseKeepMyInputs = pkgs.writeTextDir "bin/.please-keep-my-inputs" (
            builtins.concatStringsSep " " [ nixpkgs ]
          );
        in
        pkgs.mkShell {
          buildInputs = [
            gems
            pleaseKeepMyInputs
          ];
        };
    };
}
