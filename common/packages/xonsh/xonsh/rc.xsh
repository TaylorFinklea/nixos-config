execx($(starship init xonsh))
execx($(zoxide init xonsh))
exec($(carapace _carapace xonsh))

aliases['zz'] = 'zi'

$VI_MODE = True
$PROMPT = $(starship prompt)
$XONSH_UPDATE_PROMPT_ON_KEYPRESS = True
