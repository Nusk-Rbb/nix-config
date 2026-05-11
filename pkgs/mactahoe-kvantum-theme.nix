{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  pname = "mactahoe-kvantum-theme";
  version = "0-unstable-2026-02-20";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "MacTahoe-kde";
    rev = "4c0ad8fe730d32c892c84ab0dcf9a104a6fd466d";
    hash = "sha256-6saJ9t1KZeIkCwR6ePKSnJxSsba0XRmck8g8/JDuuBE=";
  };

  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    runHook preInstall

    for variant in MacTahoe MacTahoeDark; do
      install -Dm644 "Kvantum/MacTahoe/$variant.kvconfig" \
        "$out/share/Kvantum/$variant/$variant.kvconfig"
      install -Dm644 "Kvantum/MacTahoe/$variant.svg" \
        "$out/share/Kvantum/$variant/$variant.svg"
    done

    runHook postInstall
  '';

  meta = with lib; {
    description = "MacOS Tahoe-like Kvantum theme for Qt apps";
    homepage = "https://github.com/vinceliuice/MacTahoe-kde";
    license = licenses.lgpl3Only;
    platforms = platforms.unix;
  };
}
