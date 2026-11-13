# gitterrace/homebrew-tap

Homebrew formula for [gitterrace](https://gitterrace.dev), a local, read-only git browser: code,
history and insights, offline, in one binary.

## Install

```bash
brew install gitterrace/tap/gitterrace
```

Installs `git-terrace`; git runs it as `git terrace`. Homebrew checks the binary against the
sha256 in the formula.

## Upgrade

```bash
brew update && brew upgrade gitterrace
```

## Uninstall

```bash
brew uninstall gitterrace && brew untap gitterrace/tap
```

## Formulae

| Formula      | Description                                                         |
| ------------ | ------------------------------------------------------------------- |
| `gitterrace` | A local, read-only git browser: code, history and insights, offline |

## How it works

Each tagged release of [gitterrace](https://github.com/gitterrace/gitterrace), from v0.1.0 on,
writes `Formula/gitterrace.rb` here. The release workflow generates it with
[cargo-dist](https://opensource.axo.dev/cargo-dist/). Edit nothing in `Formula/` by hand: the next
release replaces it.

Issues belong in the [gitterrace repository](https://github.com/gitterrace/gitterrace/issues).

## License

MIT, like [gitterrace](https://github.com/gitterrace/gitterrace/blob/main/LICENSE).
