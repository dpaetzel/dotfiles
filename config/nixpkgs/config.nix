{
  allowUnfree = true;
  android_sdk.accept_license = true;

  # The variable super refers to the Nixpkgs set before the overrides are
  # applied and self refers to it after the overrides are applied.
  # (https://stackoverflow.com/a/36011540/6936216)
  packageOverrides = super: let self = super.pkgs; in {
    profiledHaskellPackages = self.haskellPackages.override {
      overrides = self: super: {
        mkDerivation = args: super.mkDerivation (args // {
          enableLibraryProfiling = true;
        });
      };
    };
    # audacity221 = super.audacity.overrideDerivation (old: {
    alsaLib116 = super.alsaLib.overrideAttrs (oldAttrs: rec {
      name = "alsa-lib-1.1.6";
      src = self.fetchurl {
        url = "mirror://alsa/lib/${name}.tar.bz2";
        sha256 = "096pwrnhj36yndldvs2pj4r871zhcgisks0is78f1jkjn9sd4b2z";
      };
    });
    audacity221 = (super.audacity.override { alsaLib = self.alsaLib116; }).overrideAttrs (oldAttrs: rec {
      # alsaLib = self.alsaLib116;
      # buildInputs = with super.pkgs; [
      #   file gettext wxGTK30 expat alsaLib
      #   libsndfile soxr libid3tag libjack2 lv2 lilv serd sord sratom suil gtk2
      #   ffmpeg libmad lame libvorbis flac soundtouch
      #   autoconf automake libtool # for the preConfigure phase
      # ];
      version = "2.2.1";
      name = "audacity-${version}";
      src = self.fetchurl {
        url = "https://github.com/audacity/audacity/archive/Audacity-${version}.tar.gz";
        sha256 = "1n05r8b4rnf9fas0py0is8cm97s3h65dgvqkk040aym5d1x6wd7z";
      };
    });
# .override { alsaLib = self.alsaLib116; }
  };

  # TODO old, unsure whether OK
  # packageOverrides = pkgs : rec {
  #   python36Packages = pkgs.python36Packages.override (oldAttrs: rec {
  #     # tests fail but libraries work(?)
  #     overrides = self : super : rec {
  #       pyflakes = super.pyflakes.override(z: rec {
  #         doCheck = false;
  #         doInstallCheck = false;
  #       });
  #       whoosh = super.whoosh.override(z: rec {
  #         doCheck = false;
  #         doInstallCheck = false;
  #       });
  #     };
  #   });
  # };
}
