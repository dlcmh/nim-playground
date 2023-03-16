## Visual Studio Code

Install Visual Studio Code extensions:

- https://marketplace.visualstudio.com/items?itemName=nimsaem.nimvscode
- https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner (alternatively, press F6 and nimsaem.nimvscode will run the selected file)

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
