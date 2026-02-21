{config, pkgs, ...} :

let 
   myAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      cls = "clear";
      nv = "nvim";
      p = "python";
      code = "codium";
      go = "cd";
      rebuild-home-manager = "cd ~/.dotfiles && home-manager switch --flake .#sahitya-nixos-user";
      rebuild-system = "cd ~/.dotfiles && sudo nixos-rebuild switch --flake .#sahitya-nixos";
      go-ll = "cd ~/Desktop/my-space/learning/learning/";
      go-l = "cd ~/Desktop/my-space/learning/";
      go-config = "cd ~/.dotfiles";
      go-code = "cd ~/Desktop/my-space/coding && codium .";
      go-config-user = "cd ~/.dotfiles/user";
      go-config-system= "cd ~/.dotfiles/system";
      nvi-config = "cd ~/.dotfiles && nvim .";
      go-space = "cd ~/Desktop/my-space/";
   };

   in
   {
     programs.bash = {
	enable = true;
	shellAliases = myAliases;
     };
   }
