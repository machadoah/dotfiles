package cmd

import (
	"github.com/machadoah/dotfiles/p-cli/internal/runner"
	"github.com/spf13/cobra"
)

func newOpencodeCmd(r runner.Runner) *cobra.Command {
	return &cobra.Command{
		Use:                "opencode [args...]",
		Short:              "Executa comandos do opencode",
		Long:               "Repassa todos os argumentos para o binário do opencode. Ex.: p-cli opencode plugin add superpowers",
		DisableFlagParsing: true,
		RunE: func(cmd *cobra.Command, args []string) error {
			if len(args) == 0 {
				return cmd.Help()
			}
			return r.Run("opencode", args...)
		},
	}
}
