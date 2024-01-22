{ fetchFromGitHub
, lib
, makeWrapper
, stdenv
, hyprland
, bash
}:

stdenv.mkDerivation {
  pname = "hyprevents";
  version = "unstable-2024-01-15";

  src = fetchFromGitHub {
    owner = "vilari-mickopf";
    repo = "hyprevents";
    rev = "09b54e782bfe04dc29a01238e559822afdb23d94";
    hash = "sha256-YlTPZK2tbY9MowtKV387o7GGaTchUFN2KpOJKi9zKcI=";
  };

  strictDeps = true;
  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ bash ];

  dontBuild = true;
  installPhase = ''
    runHook preInstall

    export PREFIX="$out"
    make install

    wrapProgram "$out/bin/hyprevents" \
      --prefix PATH : "$out/bin:${lib.makeBinPath [ hyprland ]}"

    runHook postInstall
  '';
  passthru.scriptName = "hyprevents";

  meta = with lib; {
    description = "Invoke shell functions in response to Hyprland socket2 events. Forked from hyprwm";
    homepage = "https://github.com/vilari-mickopf/hyprevents";
    maintainers = with maintainers; [ pacificviking ];
    platforms = platforms.linux;
    mainProgram = "hyprevents";
  };
}
