package runner

import (
	"os"
	"os/exec"
)

// Runner executa comandos e resolve binários no PATH.
type Runner interface {
	Run(name string, args ...string) error
	LookPath(file string) (string, error)
}

// System é a implementação real, usando o sistema operacional.
type System struct{}

func (System) Run(name string, args ...string) error {
	cmd := exec.Command(name, args...)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}

func (System) LookPath(file string) (string, error) {
	return exec.LookPath(file)
}
