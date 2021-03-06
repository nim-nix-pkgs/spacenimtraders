{
  description = ''API wrapper for the game spacetraders (https://spacetraders.io)'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-spacenimtraders-0_2_0.flake = false;
  inputs.src-spacenimtraders-0_2_0.ref   = "refs/tags/0.2.0";
  inputs.src-spacenimtraders-0_2_0.owner = "ire4ever1190";
  inputs.src-spacenimtraders-0_2_0.repo  = "SpaceNimTraders";
  inputs.src-spacenimtraders-0_2_0.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-spacenimtraders-0_2_0"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-spacenimtraders-0_2_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}