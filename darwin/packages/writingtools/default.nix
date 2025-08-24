{ stdenv, lib, fetchurl, makeWrapper, coreutils }:
stdenv.mkDerivation rec {
  pname = "writingtools";
  version = "Win_v6+macOS_v1.0"; # Replace with the desired version from the releases

  src = fetchurl {
    url = "https://github.com/theJayTea/WritingTools/releases/download/${version}/Writing.Tools.macOS.v1.0.dmg";
    hash = "sha256-82qwJ4ABjskg/x6jvIE1An+X19XP2jtNtdpCO5ihdV8="; # Replace with the actual sha256 of the DMG
  };

  #nativeBuildInputs = [ undmg ];
  sourceRoot = ".";
  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    # Mount the DMG
    dmg=$(hdiutil attach -nobrowse -noverify -noautoopen "$src")
    volume=$(echo "$dmg" | grep "/Volumes/" | awk '{print $NF}')

    # Copy the application
    mkdir -p "$out/Applications/WritingTools.app"
    cp -R "$volume/WritingTools.app/." "$out/Applications/WritingTools.app"

    # Fix permissions (make executable)
    chmod +x "$out/Applications/WritingTools.app/Contents/MacOS/WritingTools"
    # wrap the binary with needed libraries to make it run properly on NixOS
    wrapProgram "$out/Applications/WritingTools.app/Contents/MacOS/WritingTools" \
      --prefix PATH : "${lib.makeBinPath [ coreutils ]}"

    # Unmount the volume
    hdiutil detach "$volume"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Writing Tools is an Apple Intelligence-inspired application for Windows, Linux, and macOS that supercharges your writing with an AI LLM (cloud-based or local)";
    homepage = "https://github.com/theJayTea/WritingTools";
    license = licenses.gpl3Only;
    platforms = platforms.darwin;
    maintainers = with maintainers; [ tfinklea ];
    mainProgram = "WritingTools";
  };
}
