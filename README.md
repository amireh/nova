# nova

Nova is a __file-based__ environment variable manager. A logical group of
variables is referred to as a _profile_ which can be evaluated by Nova to
eventually land in your \[program's\] environment.

A profile is a regular directory containing a file for each environment variable
it provides:

    test/profiles/default
    ├── 10-CONSUL_HTTP_ADDR
    ├── 10-CONSUL_HTTP_DATACENTER
    └── 20-CONSUL_PATH

Unlike `.env` files, the values of these variables are computed by scripts so
they are not limited to static values.  Additionally, the order in which Nova
evaluates the scripts can be controlled to compute dependent values.

Because profiles are directories of files, syncing them between multiple
machines and sharing them with others is easy.

## Installation

You could use the installer to download the `nova` binary to `~/.nova`:

    wget -O- https://github.com/amireh/nova/master/nova-installer | bash

Or you could do it manually with Git:

```bash
git clone https://github.com/amireh/nova ~/.nova &&
echo 'export PATH="$HOME/.nova/bin:$PATH"' >> ~/.profile
```

If you choose to install Nova in a place other than `~/.nova`, export `NOVA_DIR`
accordingly.

Remember to restart your shell to reflect the change to `PATH`.

## Usage

    nova [-p|--profile DIR]
         [--no-rc] [--debug] [--export]
         [--]
         [program...]

A profile must be specified either on the command-line with `-p` or in the file
`.novarc`. When it is not specified, or does not exist, Nova exits with 1.

### `-p|--profile FILENAME`

The name of the profile to use or a full path to it. Profiles are available in `$NOVA_DIR/profiles`.

### `-e|--extra-file FILE`

Load values from a file like `.env` ([dotenv]) if it's present. **This will load
values only for the variables listed in the profile**.

Precedence goes to:

1. variables in the current environment
2. variables in an evaluated file
3. variables in the profile

### `--no-rc`

Do not look for and use the `.novarc` file.

### `--`

Stop parsing Nova command-line parameters and forward to the program. Use this
if an Nova parameter conflicts with a parameter of the program you want to run.

### `program...`

The program to execute with the loaded profile. When omitted, Nova will print
the current profile values and exit with 0.

`program` can be your shell program (like `bash`) if you want to drop into a
shell with the profile loaded.

## Profiles

A profile is a directory under `$NOVA_DIR/profiles` containing a shell script
for each environment variable. The script must print the value to the special
file descriptor `3`:

    echo my_value >&3

Files are evaluated by lexicographical order -- you can control their evaluation
order by prefixing their names with digits followed by a dash (`-`) and Nova
will strip that prefix from the variable name.

In the following example profile, the scripts for `VAULT_TOKEN` and
`CONSUL_HTTP_TOKEN` will have access to the values of the variables before them:

    .nova
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

Nova will look for a file named `.novarc` starting from the current directory
(`$PWD`) all the way up to the root folder. When present, that file may contain
command-line options for Nova such as `--profile`.

You can disable this behavior by passing `--no-rc`.

## Sharing profiles

Since profiles are regular directories and files, you can use any archiver such
as `tar` to share them with others.

For example, to share the profile `abc` with someone, I would first archive it:

    tar -C ~/.nova -cf ~/nova-abc.tar ./profiles/abc

Then upload it somewhere, ask the person to download it and to install it as
such:

    tar -C "${NOVA_DIR:-$HOME/.nova}" -xf nova-abc.tar

[dotenv]: https://github.com/motdotla/dotenv
