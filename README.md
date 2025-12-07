# Dotfiles

Esse repositório contém meus arquivos de configuração pessoal (dotfiles) para diversos aplicativos e ferramentas que utilizo no meu ambiente de desenvolvimento e pessoal.

## Estrutura do Repositório

- `install/`: Scripts de instalação para configurar o ambiente.
- `languages/`: Configurações específicas para linguagens de programação.

## Instalação

Para instalar os dotfiles, clone este repositório e execute o script de instalação:

1.  Clone o repositório:

```bash
gh repo clone machadoah/dotfiles
```

2.  Navegue até o diretório de instalação:

```bash
cd dotfiles/install
```

3.  Execute o script de pré-instalação para Linux:

```bash
bash linux-pre-insitall.sh
```

Nele será instalado e configurado:

- Git
- GitHub CLI
- ZSH

4.  Após a execução do script, o sistema será reiniciado automaticamente para aplicar as mudanças.

5.  Após o reinício, você deve executar o script principal de instalação:

```bash
bash linux-install.sh
```

Nele será configurado:

- Oh My Zsh
- Plugins do ZSH
- Startship

### Instalação de Linguagens

Para instalar as linguagens de programação, execute os scripts correspondentes no diretório `languages/`. Por exemplo, para instalar Python:

```bash
bash languages/python-install.sh
```

> [!NOTE]
> Analise os scripts antes de executá-los para garantir que atendam às suas necessidades e não causem conflitos com sua configuração atual.
> Os scripts seguem a instalação de um setup que eu utilizo.
> Por exemplo, o script de Python instala o `UV`, outras pessoas podem querer utilizar `pipx` + `poetry` + `pyenv` ou outras ferramentas.
> Assim, como no Node, instalo o `nvm`, e também o `bun`.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests para melhorias, sugestões ou correções.

## Licença

Este projeto está licenciado sob a Licença Unlicense. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
