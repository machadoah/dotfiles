package cmd

import (
	"fmt"
	"io"
	"strings"

	"github.com/machadoah/dotfiles/p-cli/internal/runner"
	"github.com/spf13/cobra"
)

type doctorCheck struct {
	name     string
	binary   string
	required bool
}

var doctorChecks = []doctorCheck{
	{name: "git", binary: "git", required: true},
	{name: "gh", binary: "gh", required: true},
	{name: "zsh", binary: "zsh", required: true},
	{name: "go", binary: "go", required: true},
	{name: "uv", binary: "uv", required: true},
	{name: "opencode", binary: "opencode", required: true},
	{name: "starship", binary: "starship", required: false},
	{name: "node", binary: "node", required: false},
	{name: "bun", binary: "bun", required: false},
	{name: "java", binary: "java", required: false},
	{name: "zed", binary: "zed", required: false},
	{name: "brew", binary: "brew", required: false},
	{name: "micro", binary: "micro", required: false},
}

func newDoctorCmd(r runner.Runner) *cobra.Command {
	return &cobra.Command{
		Use:   "doctor",
		Short: "Verifica as ferramentas instaladas",
		RunE: func(cmd *cobra.Command, args []string) error {
			return runDoctor(r, cmd.OutOrStdout())
		},
	}
}

func runDoctor(r runner.Runner, out io.Writer) error {
	missing := make([]string, 0)

	fmt.Fprintln(out, "Ferramentas essenciais:")
	for _, check := range doctorChecks {
		if !check.required {
			continue
		}
		if !reportCheck(r, out, check) {
			missing = append(missing, check.name)
		}
	}

	fmt.Fprintln(out)
	fmt.Fprintln(out, "Ferramentas opcionais:")
	for _, check := range doctorChecks {
		if check.required {
			continue
		}
		reportCheck(r, out, check)
	}

	if len(missing) > 0 {
		return fmt.Errorf("faltam ferramentas obrigatórias: %s", strings.Join(missing, ", "))
	}

	return nil
}

func reportCheck(r runner.Runner, out io.Writer, check doctorCheck) bool {
	if _, err := r.LookPath(check.binary); err != nil {
		fmt.Fprintf(out, "  ✗ %s\n", check.name)
		return false
	}

	fmt.Fprintf(out, "  ✓ %s\n", check.name)
	return true
}
