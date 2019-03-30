# envy

Envy is a file-based environment variable manager. You create profiles of
variables in the form of directories and files to switch between them based on
the task at hand.

How the values are computed is up to you; Envy merely delegates to your shell
scripts.

## Installation

You could use the installer to download the `envy` binary to `~/.envy`:

    wget -O- https://github.com/amireh/envy/master/envy-installer | bash

Or you could do it manually with Git:

```bash
git clone https://github.com/amireh/envy ~/.envy &&
echo 'export PATH="$HOME/.envy/bin:$PATH"' >> ~/.profile
```

If you choose to install Envy in a place other than `~/.envy`, export `ENVY_DIR`
accordingly.

Remember to restart your shell to reflect the change to `PATH`.

## Usage

    envy [-p|--profile FILENAME]
         [-e|--extra-file FILE]         
         [--no-rc]
         [--]
         [program...]

A profile must be specified either on the command-line with `-p` or `--profile`
or in an RC file. When it is not specified, or does not exist, Envy exits with
1.

### `-p|--profile FILENAME`

The name of the profile to use. Profiles are available in `$ENVY_DIR/profiles`.

### `-e|--extra-file FILE`

Load values from a file like `.env` ([dotenv]) if it's present. **This will load
values only for the variables listed in the profile**.

Precedence goes to:

1. variables in the current environment
2. variables in an evaluated file
3. variables in the profile

### `--no-rc`

Do not look for and use the `.envyrc` file.

### `--`

Stop parsing Envy command-line parameters and forward to the program. Use this
if an Envy parameter conflicts with a parameter of the program you want to run.

### `program...`

The program to execute with the loaded profile. When omitted, Envy will print
the current profile values and exit with 0.

`program` can be your shell program (like `bash`) if you want to drop into a
shell with the profile loaded.

## Profiles

A profile is a directory under `$ENVY_DIR/profiles` containing a shell script
for each environment variable. The script must print the value to the special
file descriptor `3`:

    echo my_value >&3

Files are evaluated by lexicographical order -- you can control their evaluation
order by prefixing their names with digits followed by a dash (`-`) and Envy
will strip that prefix from the variable name.

In the following example profile, the scripts for `VAULT_TOKEN` and
`CONSUL_HTTP_TOKEN` will have access to the values of the variables before them:

    .envy
    └── profiles
        └── default
            ├── 10-CONSUL_HTTP_ADDR
            ├── 10-CONSUL_HTTP_DATACENTER
            ├── 10-VAULT_ADDR
            ├── 10-VAULT_USER
            ├── 20-VAULT_TOKEN
            └── 30-CONSUL_HTTP_TOKEN

To disable a variable without removing its file, suffix its filename with tilde
(`~`).

## Working directory options

Envy will look for a file named `.envyrc` starting from the current directory
(`$PWD`) all the way up to the root folder. When present, that file may contain
command-line options for Envy such as `--profile`.

You can disable this behavior by passing `--no-rc`.

## Sharing profiles

Since profiles are regular directories and files, you can use any archiver such
as `tar` to share them with others.

For example, to share the profile `abc` with someone, I would first archive it:

    tar -C ~/.envy -cf ~/envy-abc.tar ./profiles/abc

Then upload it somewhere, ask the person to download it and to install it as
such:

    tar -C "${ENVY_DIR:-$HOME/.envy}" -xf envy-abc.tar

[dotenv]: https://github.com/motdotla/dotenv
