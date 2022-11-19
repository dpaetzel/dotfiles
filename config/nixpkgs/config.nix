{
  allowUnfree = true;
  allowBroken = true;
  android_sdk.accept_license = true;
  packageOverrides = super: let self = super.pkgs; in {
    rEnv = super.rWrapper.override {
      packages = with self.rPackages; [
        ggplot2
        optparse
      ];
    };
  };
}
