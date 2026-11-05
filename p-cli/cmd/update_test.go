package cmd

import (
	"bytes"
	"errors"
	"reflect"
	"testing"
)

type call struct {
	name string
	args []string
}

type fakeRunner struct {
	calls    []call
	lookPath map[string]string
	runErr   error
}

func (f *fakeRunner) Run(name string, args ...string) error {
	f.calls = append(f.calls, call{name: name, args: args})
	return f.runErr
}

func (f *fakeRunner) LookPath(file string) (string, error) {
	if path, ok := f.lookPath[file]; ok {
		return path, nil
	}
	return "", errors.New("not found")
}

func TestRunUpdateRunsAptUpdateThenUpgrade(t *testing.T) {
	r := &fakeRunner{}
	var out bytes.Buffer

	if err := runUpdate(r, updateOptions{}, &out); err != nil {
		t.Fatalf("runUpdate() erro = %v", err)
	}

	want := []call{
		{name: "sudo", args: []string{"apt", "update", "-y"}},
		{name: "sudo", args: []string{"apt", "upgrade", "-y"}},
	}
	if !reflect.DeepEqual(r.calls, want) {
		t.Fatalf("comandos = %#v, quer %#v", r.calls, want)
	}
}

func TestRunUpdateAllIncludesOpencodeAndBrew(t *testing.T) {
	r := &fakeRunner{lookPath: map[string]string{
		"opencode": "/usr/bin/opencode",
		"brew":     "/home/linuxbrew/.linuxbrew/bin/brew",
	}}
	var out bytes.Buffer

	if err := runUpdate(r, updateOptions{All: true}, &out); err != nil {
		t.Fatalf("runUpdate() erro = %v", err)
	}

	want := []call{
		{name: "sudo", args: []string{"apt", "update", "-y"}},
		{name: "sudo", args: []string{"apt", "upgrade", "-y"}},
		{name: "opencode", args: []string{"upgrade"}},
		{name: "brew", args: []string{"update"}},
		{name: "brew", args: []string{"upgrade"}},
	}
	if !reflect.DeepEqual(r.calls, want) {
		t.Fatalf("comandos = %#v, quer %#v", r.calls, want)
	}
}

func TestRunUpdateAllSkipsMissingTools(t *testing.T) {
	r := &fakeRunner{lookPath: map[string]string{
		"opencode": "/usr/bin/opencode",
	}}
	var out bytes.Buffer

	if err := runUpdate(r, updateOptions{All: true}, &out); err != nil {
		t.Fatalf("runUpdate() erro = %v", err)
	}

	want := []call{
		{name: "sudo", args: []string{"apt", "update", "-y"}},
		{name: "sudo", args: []string{"apt", "upgrade", "-y"}},
		{name: "opencode", args: []string{"upgrade"}},
	}
	if !reflect.DeepEqual(r.calls, want) {
		t.Fatalf("comandos = %#v, quer %#v", r.calls, want)
	}
}

func TestRunUpdateDryRunPrintsWithoutExecuting(t *testing.T) {
	r := &fakeRunner{}
	var out bytes.Buffer

	if err := runUpdate(r, updateOptions{DryRun: true}, &out); err != nil {
		t.Fatalf("runUpdate() erro = %v", err)
	}

	if len(r.calls) != 0 {
		t.Fatalf("nenhum comando deveria ser executado, mas foi: %#v", r.calls)
	}

	want := "sudo apt update -y\nsudo apt upgrade -y\n"
	if out.String() != want {
		t.Fatalf("saída = %q, quer %q", out.String(), want)
	}
}
