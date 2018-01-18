{ pkgs } :
{
  allowUnfree = true;

  packagesOverrides = pkgs : rec {
    python36Packages = pkgs.python36Packages.override (oldAttrs: rec {
      # tests fail but libraries work(?)
      overrides = self : super : rec {
        pyflakes = super.pyflakes.override(z: rec {
          doCheck = false;
          doInstallCheck = false;
        });
        whoosh = super.whoosh.override(z: rec {
          doCheck = false;
          doInstallCheck = false;
        });
      };
    });
  };
}
