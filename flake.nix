{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/86c33dba3b5fc3e8cd3d02716d9ba048af7ed254";
    nixpkgs-ruby.url = "github:bobvanderlinden/nixpkgs-ruby";
    nixpkgs-ruby.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-ruby, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        ruby = nixpkgs-ruby.lib.packageFromRubyVersionFile {
          file = ./.ruby-version;
          inherit system;
        };
      in
      {
        devShells.default = with pkgs;
          mkShell {
            buildInputs = [
              ruby
              tree
              nil
              nixpkgs-fmt
              dprint
              typos
            ];
          };
      });
}
