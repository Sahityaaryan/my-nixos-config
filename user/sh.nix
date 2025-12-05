{config, pkgs, ...} :

let 
   myAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      cls = "clear";
      go = "cd";
      rebuild-home-manager = "cd ~/.dotfiles && home-manager switch --flake .#sahitya-nixos-user";
      rebuild-system = "cd ~/.dotfiles && sudo nixos-rebuild switch --flake .#sahitya-nixos";
      go-ll = "cd ~/Desktop/my-space/learning/learning/";
      go-l = "cd ~/Desktop/my-space/learning/";
      go-config = "cd ~/.dotfiles";
      go-config-user = "cd ~/.dotfiles/user";
      go-config-system= "cd ~/.dotfiles/system";
   };

   in
   {
     programs.bash = {
	enable = true;
	shellAliases = myAliases;
     };
   }
