## Install nim

Follow the steps at https://nim-lang.org/install_unix.html instead of `brew install nim` as the `brew` approach doesn't install `testament`.

Create file `~/.config/nim/config.nims` and enter the following:

```nims
switch("out", "/tmp/") # compiles to this folder
```

## inim - interactive nim

nimble install inim

Add the following to `~/.zshrc`:

```
export PATH=$HOME/.nimble/bin:$PATH
```

## For `db_postgres` to work

Assumes `libpq.dylib` is reachable.

```sh
brew install libpq

# obtain the location of the library
brew info libpq

ln -s /usr/local/opt/libpq/lib/libpq.dylib /usr/local/lib/
```

## Visual Studio Code

Install Visual Studio Code extensions:

- https://marketplace.visualstudio.com/items?itemName=nimsaem.nimvscode
- https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner (alternatively, press F6 and nimsaem.nimvscode will run the selected file)

To have Code Runner run in the terminal (to accept user input for example), search for "runinterm" in settings for the Run in Terminal setting, and set that to True.

To compile & run with Code Runner extension: `control+option+n`.

To stop: `control+option+m`.

To format the file, `shift+option+f`.

## Code maintenance

To clear the `out` folder, run:

```sh
make clearout
```

To quick commit:

```sh
make gp
```

## Older, manual steps

Run vscode build task:

```
shift+cmd+b
```

Format the file:

```sh
nimpretty helloworld.nim
```

Compile source into an `out` subfolder and run it:

```sh
nim c --verbosity=0 --out=out/ -r helloworld.nim

# or

# read config from root folder's nim.cfg file
nim c -r helloworld.nim
```
