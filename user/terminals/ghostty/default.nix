
{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    package = pkgs.ghostty;

    # Enable for whichever shell you plan to use!
    enableBashIntegration = true;
    # enableFishIntegration = true;
    # enableZshIntegration = true;

    settings = {
      theme = "Argonaut";
      
      keybind = [
        "ctrl+g=reload_config"

        # Splits
        "ctrl+up=new_split:up"
        "ctrl+down=new_split:down"
        "ctrl+left=new_split:left"
        "ctrl+right=new_split:right"

        # Tmux-like bindings
        "ctrl+b>q=quit"
        "ctrl+b>c=new_tab"
        "ctrl+b>p=previous_tab"
        "ctrl+b>n=next_tab"
        "ctrl+b>o=toggle_tab_overview"
        "ctrl+b>l=goto_split:next"
        "ctrl+b>h=goto_split:previous"
        "ctrl+b>x=close_surface"
        "ctrl+b>equal=equalize_splits"
        "ctrl+b>r=reload_config"

        # Resizing
        "ctrl+shift+h=resize_split:left,10"
        "ctrl+shift+l=resize_split:right,10"
        "ctrl+shift+k=resize_split:up,10"
        "ctrl+shift+j=resize_split:down,10"
      ];

      "font-family" = "JetBrainsMono NF Medium";
      "window-decoration" = false;
      "mouse-hide-while-typing" = true;
      "window-padding-x" = 4;
      "window-padding-y" = 8;

      "clipboard-read" = "allow";
      "clipboard-paste-protection" = false;

      "font-size" = 14;
      fullscreen = false;
      "background-opacity" = 0.85;

      # Dimensions
      "window-height" = 80;
      "window-width" = 300;

      "shell-integration-features" = "no-cursor";
    };
  };
}
