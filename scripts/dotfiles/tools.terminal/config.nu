$env.PROMPT_COMMAND = { || 
    let dir = (pwd)
    $"($dir)\n" 
}
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"


# https://github.com/wezterm/wezterm/issues/2779#issuecomment-3183793320
$env.config.shell_integration = {
  osc2: true
  osc7: true
  osc8: true
  osc9_9: true
  osc133: false
  osc633: true
  reset_application_mode: true
}
