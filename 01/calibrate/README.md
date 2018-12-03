# Calibrate

Advent-of-code 2018 calibration

Download [text file of numbers](./input.txt)
Sum them all together.

I decided to do this as a Elixir -> CLI interface, and consume the file as a Stream (for fun).

## Usage

```
$ mix deps.get
$ mix calibrate "./input.txt"
"595 <-- [./input.txt]"
```

Well code changed because the part-b asked for a "first duplicated sum".

```
$ mix calibrate "./input.txt"
"80920 [first duplicated sum: 80598] <-- [./input.txt]"
```

## Testing

This is a throw-away fun project, but I still almost can't write code without tests...

But because Elixir loves me, I've only written doctests, and I still feel ok (not super-well covered, but ok).

```
$ mix test
Compiling 1 file (.ex)
..............

Finished in 0.1 seconds
14 doctests, 0 failures

Randomized with seed 26910
