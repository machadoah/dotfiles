# p-cli

CLI pessoal em Go + Cobra para centralizar tarefas do dia a dia.

## Requisitos

- Go 1.27+
- `sudo`/`apt` para o comando `update`
- `opencode` para o pass-through de comandos

## Instalação

```bash
cd p-cli
make install
```

O binário vai para `~/.local/bin/p-cli` (ajustável com `PREFIX=/outro/caminho`).

## Uso

```bash
# Atualiza o sistema (apt update + apt upgrade)
p-cli update

# Também atualiza opencode e Homebrew, se instalados
p-cli update --all

# Mostra os comandos sem executar
p-cli update --dry-run

# Repassa qualquer comando para o opencode
p-cli opencode plugin add superpowers
p-cli opencode plugin list
p-cli opencode upgrade

# Verifica as ferramentas instaladas
p-cli doctor

# Versão
p-cli version
```

## Desenvolvimento

```bash
make test    # go test ./...
make build   # gera bin/p-cli
make install # instala em ~/.local/bin
make clean   # remove bin/
```

## Estrutura

- `main.go` — entrypoint.
- `cmd/` — comandos Cobra (`update`, `opencode`, `doctor`, `version`).
- `internal/runner/` — abstração de execução de comandos e `LookPath`, usada nos testes.

## Completions

```bash
# zsh
p-cli completion zsh > "${fpath[1]}/_p-cli"
```
