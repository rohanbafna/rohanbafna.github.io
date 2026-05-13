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
        in
        pkgs.mkShell {
          buildInputs = [ gems ];
        };
    };
}
