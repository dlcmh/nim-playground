Install Visual Studio Code extensions:

- https://marketplace.visualstudio.com/items?itemName=kosz78.nim
- https://marketplace.visualstudio.com/items?itemName=wk-j.save-and-run

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
