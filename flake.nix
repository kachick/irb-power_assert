{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          # Require CC to build io-console
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              bashInteractive
              findutils # xargs
              nixfmt-rfc-style
              nil

              ruby_3_4
              # Required to build psych via irb dependency
              # https://github.com/kachick/irb-power_assert/issues/116
              # https://github.com/ruby/irb/pull/648
              libyaml

              tree

              dprint
              typos
            ];
          };
        }
      );
    };
}
