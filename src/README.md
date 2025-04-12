# fools2025 source code

This is the source for [TheZZAZZGlitch's April Fools Event 2025](https://zzazzdzz.github.io/fools2025/).

## Build instructions

Make sure you're in the project's current directory. Compress and generate text:

```
python3 tools/mktext.py
```

Assemble to an object file:

```
rgbasm main.asm -o main.o
```

Link the object file and create a save file:

```
rgblink -n fools2025.sym -O base.sav -o fools.sav -x main.o
```

Fix save file checksums:

```
python3 tools/savfix.py
```

The resulting *fools.sav* can be loaded in an emulator.