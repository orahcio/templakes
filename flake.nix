{
  description = "Minha coleção de modelos para ambiente de desenvolvimento no nix.";

  outputs = {self, nixpkgs}:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        just
      ];
    };

    templates = {
      latex = {
        path = ./latex;
        description = "Template para escrita de documentos LaTeX";
        welcomeText = ''
          Digite documentos do LaTex neste ambiente.
        '';
      };
      context ={
        path = ./context;
        description = "Modelo para escrita de documentos ConTeXt";
        welcomeText = ''
          Digite documentos do ConTeXt neste ambiente.
        '';
      };
    };
  }
}