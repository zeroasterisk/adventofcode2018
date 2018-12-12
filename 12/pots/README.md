# Pots

I am super annoyed at this one.

I don't know why, but my `sum_plants()` function works fine on the test strings,
but it doesn't work for the longer ones, no matter what I do to it.

After fighting several times with it, I used someone's python solution from reddit and found that the "correct" sum was 4 away from what I was calculating:


```elixir
# should be:

iex> Pots.sum_plants("............................##.##.##.#..##.#......#...#..#.#..##.#..##.#..##.#.....#...#..#.#..##.#..##.#..##.#...#..#..##.#..##.#..##.#..##.#..##.#......", -31)
3059


# I got

iex> Pots.sum_plants("............................##.##.##.#..##.#......#...#..#.#..##.#..##.#..##.#.....#...#..#.#..##.#..##.#..##.#...#..#..##.#..##.#..##.#..##.#..##.#......", -31)
3055
```

I still don't know how or why, and would like to fix it.

Otherwise, this was a fun one and very much like a "game of life" with the same (simpler) patterns emerging.

## Usage

```
mix deps.get
iex -S mix

iex> Pots.main :p1
iex> Pots.main :p2
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `Pots` to your list of dependencies in `mix.exs`:

```elixir
\@deps [
  { :Pots, "~> 0.1.0" }
]
end
```


https://opensource.org/licenses/MIT

Copyright 2018 Alan Blount @zeroasterisk

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
