package cmd

import (
	"bytes"
	"strings"
	"testing"
)

func TestRootCmdHasExpectedSubcommands(t *testing.T) {
	root := NewRootCmd(&fakeRunner{})

	for _, name := range []string{"update", "opencode", "doctor", "version"} {
		found := false
		for _, command := range root.Commands() {
			if command.Name() == name {
				found = true
				break
			}
		}
		if !found {
			t.Fatalf("subcomando %q não encontrado", name)
		}
	}
}

func TestRootCmdWiresUpdateFlags(t *testing.T) {
	r := &fakeRunner{lookPath: map[string]string{
		"opencode": "/usr/bin/opencode",
		"brew":     "/home/linuxbrew/.linuxbrew/bin/brew",
	}}
	root := NewRootCmd(r)
	var out bytes.Buffer
	root.SetOut(&out)
	root.SetErr(&out)
	root.SetArgs([]string{"update", "--all", "--dry-run"})

	if err := root.Execute(); err != nil {
		t.Fatalf("Execute() erro = %v", err)
	}

	want := "sudo apt update -y\nsudo apt upgrade -y\nopencode upgrade\nbrew update\nbrew upgrade\n"
	if out.String() != want {
		t.Fatalf("saída = %q, quer %q", out.String(), want)
	}
}

func TestVersionCmdPrintsVersion(t *testing.T) {
	original := version
	version = "1.2.3"
	t.Cleanup(func() { version = original })

	cmd := newVersionCmd()
	var out bytes.Buffer
	cmd.SetOut(&out)
	cmd.SetArgs([]string{})

	if err := cmd.Execute(); err != nil {
		t.Fatalf("Execute() erro = %v", err)
	}
	if strings.TrimSpace(out.String()) != "1.2.3" {
		t.Fatalf("saída = %q, quer %q", out.String(), "1.2.3")
	}
}
