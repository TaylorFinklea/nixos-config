{ pkgs }:

let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    python-telegram-bot
    openai
    click
  ]);
in
pkgs.writeShellScriptBin "writing-tools" ''
  # Get the source code
  TOOLS_DIR="$HOME/.local/share/writing-tools"

  if [ ! -d "$TOOLS_DIR" ]; then
    ${pkgs.git}/bin/git clone https://github.com/theJayTea/WritingTools.git "$TOOLS_DIR"
  fi

  # Run the appropriate script based on the first argument
  case "$1" in
    "gpt")
      ${pythonEnv}/bin/python "$TOOLS_DIR/gpt/gpt.py" "''${@:2}"
      ;;
    "tg")
      ${pythonEnv}/bin/python "$TOOLS_DIR/telegram/tg.py" "''${@:2}"
      ;;
    *)
      echo "Usage: writing-tools [gpt|tg] [arguments]"
      echo "  gpt: Use GPT tools"
      echo "  tg:  Use Telegram tools"
      exit 1
      ;;
  esac
''
