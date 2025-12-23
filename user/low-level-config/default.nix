{pkgs, ...}:{

 home.packages = with pkgs;[

    gnumake
    unzip
    file
    uv
    python3
    git
    gcc
    wl-clipboard
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    yarn
    nodejs
    stylua
    
  ]; 
  

}
