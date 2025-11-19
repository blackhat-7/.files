#!/bin/sh

# Exit immediately if any command fails
set -e

# Check if either flake.nix or .envrc already exists
if [ -f "flake.nix" ] || [ -f ".envrc" ]; then
  echo "Error: 'flake.nix' or '.envrc' already exists in this directory." >&2
  exit 1
fi

# Create the flake.nix file
cat > flake.nix << 'EOF'
{
  description = "A simple flake for a project development environment";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          # Add your desired packages here
          buildInputs = with pkgs; [
            pkgs.python311
            (pkgs.python311.withPackages (ps: with ps; [
              pip
              pandas
              numpy
            ]))
          ];

          # Set your environment variables here
          GREETING = "hello from flake.nix";
        };
      }
    );
}
EOF

# Create the .envrc file
echo "use flake" > .envrc

echo "Successfully created flake.nix and .envrc files."
# echo
# echo "IMPORTANT: Nix flakes require a Git repository to track files."
# echo "Please run the following commands to initialize Git:"
# echo
# echo "  git init"
# echo "  git add flake.nix .envrc"
# echo "  direnv allow"
# echo
