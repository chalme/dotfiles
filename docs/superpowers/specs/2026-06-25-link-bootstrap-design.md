# Link Bootstrap Design

## Goal

Add a small, safe bootstrap entrypoint that only manages symlinks from this repository into `$HOME`.

This first version is intentionally narrow:

- no package installation
- no `mackup restore`
- no machine-specific IDE customization
- no automatic file discovery

The purpose is to make the repository usable as a repeatable "link my baseline config into the system" step.

## Scope

The initial managed set is:

- `.vimrc` -> `~/.vimrc`
- `.mackup.cfg` -> `~/.mackup.cfg`

More mappings can be added later by extending the script's internal manifest.

## Approach

Use a manifest-driven shell script.

The script will define a small list of source-to-target mappings and iterate through them. This keeps the implementation explicit and low-risk while remaining easy to extend as the repo grows.

Recommended filename:

- `link.sh`

This keeps its purpose clear and avoids implying that it performs full machine bootstrap.

## Behavior

When the script runs:

1. resolve the repository root based on the script location
2. verify that each declared source file exists inside the repository
3. for each mapping, inspect the target path in `$HOME`
4. apply one of the following actions:

- if the target does not exist, create the symlink
- if the target is already a symlink to the expected repository file, skip it
- if the target exists but is not the expected symlink, move it to a timestamped backup and then create the symlink

## Backup Strategy

When replacing an existing target, create a backup in place using a timestamp suffix.

Example:

- `~/.vimrc.backup.20260625-010500`

This keeps recovery simple and avoids destructive behavior.

## Logging

The script should print one clear line per action so it is easy to audit what happened.

Expected message types:

- `LINKED`
- `SKIPPED`
- `BACKED UP`
- `ERROR`

At the end, the script should print a short summary or success line.

## Error Handling

The script should fail fast on shell errors and undefined variables.

Recommended shell behavior:

- `set -euo pipefail`

Validation rules:

- if a declared repository source file does not exist, stop with an error
- if the repository root cannot be resolved, stop with an error
- if backup or symlink creation fails, stop with an error

## Design Constraints

- use only standard shell behavior available on macOS
- keep the script readable and short
- prefer explicit mappings over clever discovery
- make repeated runs safe
- avoid touching anything outside the declared mapping list

## Documentation Changes

Update the repository docs so the new script is discoverable:

- add `link.sh` to the repository map in `README.md`
- mention it in the quick start flow
- document its scope in `docs/bootstrap.md`

## Testing Plan

Manual verification is enough for the first version.

Recommended checks:

1. run the script when no target files exist
2. run it a second time and confirm expected symlinks are skipped
3. replace one target with a normal file and confirm backup plus relink behavior
4. confirm resulting symlinks point to this repository

## Out of Scope

These are intentionally deferred:

- package installation
- `brew.sh` orchestration
- `install.sh` orchestration
- `dev.sh` orchestration
- interactive prompts
- bulk linking of every dotfile in the repository

## Success Criteria

The design is successful if:

- a new machine can link the selected baseline files into `$HOME` with one command
- rerunning the script does not break existing correct links
- local existing files are preserved via backup before replacement
- the repository documentation makes the entrypoint easy to find
