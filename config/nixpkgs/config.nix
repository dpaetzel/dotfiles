{
  allowUnfree = true;
  allowBroken = true;
  android_sdk.accept_license = true;
  # TODO This is in my system config already, do i really need it here, too?
  # nixpkgs.config = {
  #   packageOverrides = super: let self = super.pkgs; in {
  #     profiledHaskellPackages = self.haskellPackages.override {
  #       overrides = self: super: {
  #         mkDerivation = args: super.mkDerivation (args // {
  #           enableLibraryProfiling = true;
  #         });
  #       };
  #     };
  #   };
  # };
  packageOverrides = super: let self = super.pkgs; in {
    vdirsyncer = super.vdirsyncer.overrideAttrs(oldAttrs: rec {
      patches = # oldAttrs.patches ++
        [(self.fetchpatch {
          url = https://github.com/pimutils/vdirsyncer/pull/788.patch;
          sha256 = "0vl942ii5iad47y63v0ngmhfp37n30nxyk4j7h64b95fk38vfwx9";
        })];
      }
    );
    rEnv = super.rWrapper.override {
      packages = with self.rPackages; [
        ggplot2
        optparse
      ];
    };
  };
}
