{ config, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Nusk-Rbb";
        email = "nuskrbb1741dn@gmail.com";
      };
      init.defaultBranch = "main";
      core.editor = "vim";
      commit.template = "${config.xdg.configHome}/github/commit_template";
    };

    ignores = [
      ".DS_Store"
      "*.swp"
      ".env"
      ".direnv"
      "node_modules"
      ".vscode"
      ".idea"
      "**/.claude/settings.local.json"
    ];
  };

  home.file.".config/github/commit_template".source = ../config/git/commit_template;
}
