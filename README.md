# dotfiles

zsh configuration: `zshenv`, `zprofile`, `zshrc`.

## Install

```bash
git clone https://github.com/OxFrancesco/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
exec zsh
```

`install.sh` symlinks the three zsh files into `$HOME` (backing up anything it replaces) and creates `~/.zshrc.private` if missing.

## Secrets

API keys and machine-local env vars live in `~/.zshrc.private` (chmod 600), sourced at the end of `zshrc`. That file is gitignored and never leaves the machine. See `zsh/zshrc.private.example` for the expected format.

## External dependencies

Everything below is optional — each reference in `zshrc` is guarded, so a missing tool just means that feature is skipped.

- [Homebrew](https://brew.sh) (via `zprofile`)
- `fzf`, `zoxide`, `atuin`, `eza`, `thefuck` — `brew install fzf zoxide atuin eza thefuck`
- [Bun](https://bun.sh), [Foundry](https://getfoundry.sh), Rust (cargo env)
- tmux wrapper + completion, `gh` + `jq` (git/PR prompt segment)
