package main

import (
	"fmt"
	"os"

	"github.com/machadoah/dotfiles/p-cli/cmd"
	"github.com/machadoah/dotfiles/p-cli/internal/runner"
)

func main() {
	if err := cmd.NewRootCmd(runner.System{}).Execute(); err != nil {
		fmt.Fprintln(os.Stderr, "p-cli:", err)
		os.Exit(1)
	}
}
