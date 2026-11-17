#!/usr/bin/env python3
"""Validate each original root in isolation, without backend or AWS access."""
import argparse
import os
from pathlib import Path
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
STACKS = ("aws-base", "aws-base-accounts-init", "aws-github-roles")


def run(command, directory, environment):
    print("+ " + " ".join(command), flush=True)
    subprocess.run(command, cwd=directory, env=environment, check=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("stack", nargs="?", choices=STACKS)
    parser.add_argument("--cli", default="tofu", help="OpenTofu executable (default: tofu)")
    args = parser.parse_args()
    executable = shutil.which(args.cli)
    if executable is None:
        parser.error("OpenTofu is required; install the version documented in README.md")
    environment = {
        key: value for key, value in os.environ.items()
        if not key.startswith(("AWS_", "TF_VAR_", "TF_CLI_ARGS"))
        and key not in ("TF_DATA_DIR", "TF_WORKSPACE", "TF_CLI_CONFIG_FILE")
    }
    environment.update({"TF_IN_AUTOMATION": "true", "TF_INPUT": "false",
                        "AWS_EC2_METADATA_DISABLED": "true"})
    for stack in ((args.stack,) if args.stack else STACKS):
        print("\nValidating " + stack, flush=True)
        run([executable, "fmt", "-check", "-diff", "-recursive", stack], ROOT, environment)
        with tempfile.TemporaryDirectory(prefix="aws-platform-validation-") as temporary:
            directory = Path(temporary) / stack
            shutil.copytree(ROOT / stack, directory,
                            ignore=shutil.ignore_patterns(".terraform", "*.tfstate*", "*.tfplan",
                                                         "*.plan", "*.tfvars", "*.tfvars.json",
                                                         "backend.hcl", "backend.local.hcl"))
            # Parse/format-check example inputs without ever initializing their backend.
            shutil.copyfile(directory / "terraform.tfvars.example", directory / "terraform.tfvars")
            backend = directory / "backend.hcl.example"
            if backend.exists():
                shutil.copyfile(backend, directory / "backend.tfvars")
            configuration = Path(temporary) / "empty.tfrc"
            configuration.write_text("")
            env = dict(environment, AWS_CONFIG_FILE=str(Path(temporary) / "no-aws-config"),
                       AWS_SHARED_CREDENTIALS_FILE=str(Path(temporary) / "no-aws-credentials"),
                       TF_CLI_CONFIG_FILE=str(configuration))
            run([executable, "fmt", "-check", "-diff", "-recursive", "."], directory, env)
            run([executable, "init", "-backend=false", "-input=false", "-lockfile=readonly"], directory, env)
            run([executable, "validate", "-no-color"], directory, env)
    print("\nAll selected stacks validated. No plan or apply was run.")


if __name__ == "__main__":
    main()
