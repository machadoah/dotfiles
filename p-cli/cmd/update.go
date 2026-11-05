package cmd

import (
	"fmt"
	"io"
	"strings"

	"github.com/machadoah/dotfiles/p-cli/internal/runner"
	"github.com/spf13/cobra"
)

type updateOptions struct {
	All    bool
	DryRun bool
}

func newUpdateCmd(r runner.Runner) *cobra.Command {
	opts := updateOptions{}

	cmd := &cobra.Command{
		Use:   "update",
		Short: "Atualiza o sistema",
		Long:  "Executa 'sudo apt update -y' e 'sudo apt upgrade -y'. Com --all, também atualiza opencode e Homebrew quando instalados.",
		RunE: func(cmd *cobra.Command, args []string) error {
			return runUpdate(r, opts, cmd.OutOrStdout())
		},
	}

	cmd.Flags().BoolVar(&opts.All, "all", false, "Também atualiza opencode e Homebrew")
	cmd.Flags().BoolVar(&opts.DryRun, "dry-run", false, "Mostra os comandos sem executá-los")

	return cmd
}

func runUpdate(r runner.Runner, opts updateOptions, out io.Writer) error {
	commands := [][]string{
		{"sudo", "apt", "update", "-y"},
		{"sudo", "apt", "upgrade", "-y"},
	}

	if opts.All {
		if _, err := r.LookPath("opencode"); err == nil {
			commands = append(commands, []string{"opencode", "upgrade"})
		}
		if _, err := r.LookPath("brew"); err == nil {
			commands = append(commands,
				[]string{"brew", "update"},
				[]string{"brew", "upgrade"},
			)
		}
	}

	for _, command := range commands {
		line := strings.Join(command, " ")
		if opts.DryRun {
			fmt.Fprintln(out, line)
			continue
		}
		if err := r.Run(command[0], command[1:]...); err != nil {
			return fmt.Errorf("executando %q: %w", line, err)
		}
	}

	return nil
}
