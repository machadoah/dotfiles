package cmd

import (
	"bytes"
	"strings"
	"testing"
)

func TestRunDoctorReportsFoundAndMissingTools(t *testing.T) {
	r := &fakeRunner{lookPath: map[string]string{
		"git":      "/usr/bin/git",
		"gh":       "/usr/bin/gh",
		"zsh":      "/usr/bin/zsh",
		"go":       "/usr/bin/go",
		"uv":       "/usr/bin/uv",
		"opencode": "/usr/bin/opencode",
	}}
	var out bytes.Buffer

	if err := runDoctor(r, &out); err != nil {
		t.Fatalf("runDoctor() erro inesperado = %v", err)
	}

	for _, want := range []string{"✓ git", "✓ opencode", "✗ zed"} {
		if !strings.Contains(out.String(), want) {
			t.Fatalf("saída deveria conter %q:\n%s", want, out.String())
		}
	}
}

func TestRunDoctorFailsWhenRequiredToolMissing(t *testing.T) {
	r := &fakeRunner{lookPath: map[string]string{
		"git": "/usr/bin/git",
	}}
	var out bytes.Buffer

	err := runDoctor(r, &out)
	if err == nil {
		t.Fatal("runDoctor() deveria falhar com ferramenta obrigatória ausente")
	}
	if !strings.Contains(err.Error(), "gh") {
		t.Fatalf("erro deveria mencionar gh, veio: %v", err)
	}
	if !strings.Contains(out.String(), "✗ gh") {
		t.Fatalf("saída deveria marcar gh como ausente:\n%s", out.String())
	}
}
