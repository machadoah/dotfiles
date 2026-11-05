package cmd

import (
	"fmt"

	"github.com/machadoah/dotfiles/p-cli/internal/runner"
	"github.com/spf13/cobra"
)

var version = "dev"

func NewRootCmd(r runner.Runner) *cobra.Command {
	root := &cobra.Command{
		Use:           "p-cli",
		Short:         "Utilitário pessoal de linha de comando",
		Long:          "p-cli centraliza tarefas do dia a dia: atualizações do sistema, opencode e diagnóstico do ambiente.",
		Version:       version,
		SilenceUsage:  true,
		SilenceErrors: true,
	}

	root.AddCommand(
		newUpdateCmd(r),
		newOpencodeCmd(r),
		newDoctorCmd(r),
		newVersionCmd(),
	)

	return root
}

func newVersionCmd() *cobra.Command {
	return &cobra.Command{
		Use:   "version",
		Short: "Mostra a versão do p-cli",
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Fprintln(cmd.OutOrStdout(), version)
		},
	}
}
