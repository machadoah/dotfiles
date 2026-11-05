package cmd

import (
	"bytes"
	"io"
	"reflect"
	"strings"
	"testing"
)

func TestOpencodePassesArgsThrough(t *testing.T) {
	r := &fakeRunner{}
	cmd := newOpencodeCmd(r)
	cmd.SetArgs([]string{"plugin", "add", "superpowers"})
	cmd.SetOut(io.Discard)
	cmd.SetErr(io.Discard)

	if err := cmd.Execute(); err != nil {
		t.Fatalf("Execute() erro = %v", err)
	}

	want := []call{{name: "opencode", args: []string{"plugin", "add", "superpowers"}}}
	if !reflect.DeepEqual(r.calls, want) {
		t.Fatalf("comandos = %#v, quer %#v", r.calls, want)
	}
}

func TestOpencodeWithoutArgsShowsHelp(t *testing.T) {
	r := &fakeRunner{}
	cmd := newOpencodeCmd(r)
	var out bytes.Buffer
	cmd.SetOut(&out)
	cmd.SetErr(&out)
	cmd.SetArgs([]string{})

	if err := cmd.Execute(); err != nil {
		t.Fatalf("Execute() erro = %v", err)
	}

	if len(r.calls) != 0 {
		t.Fatalf("nenhum comando deveria ser executado, mas foi: %#v", r.calls)
	}
	if !strings.Contains(out.String(), "opencode") {
		t.Fatalf("ajuda deveria mencionar opencode, saída = %q", out.String())
	}
}
