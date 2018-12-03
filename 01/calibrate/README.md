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
