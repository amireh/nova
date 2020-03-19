The profile is stored in `.env/`, which exports the variable `FOO` and is
pointed to by default via the `.novarc` file. Any time you run `nova` 
without passing `-p .env/`, it will use that profile.

You can run the program by passing it through `nova` first:

    nova -- ./program
