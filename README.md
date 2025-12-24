# Advent of Code 2025 :santa: :christmas_tree:

## Quickstart

Install [Spork](https://github.com/janet-lang/spork) and start REPL:

```shell
$ jpm --local deps
$ jpm -l janet -e "(import spork/netrepl) (netrepl/server)"
```

Start file watcher and re-run a specific day

```shell
$ set day "d19"; fd -e janet -e txt --no-ignore | entr -c -s "janet $day/main.janet < $day/in.txt"
```

## Progress (5/12)

|     | Done   | Solution Comment                                                                             |
| --- | ------ | -------------------------------------------------------------------------------------------- |
| 1   | :bell: | [Link](https://old.reddit.com/r/adventofcode/comments/1pb3y8p/comment/nrq6fdq)               |
| 2   | :bell: | [Link](https://old.reddit.com/r/adventofcode/comments/1pbzqcx/comment/nrxn219)               |
| 3   | :bell: | [Link](https://old.reddit.com/r/adventofcode/comments/1pcvaj4/2025_day_3_solutions/nsg2ufz/) |
| 4   | :bell: | [Link](https://old.reddit.com/r/adventofcode/comments/1pdr8x6/comment/ns7rsu5)               |
| 5   | :bell: | [Link](https://old.reddit.com/r/adventofcode/comments/1pemdwd/2025_day_5_solutions/nvq60ef/) |
| 6   | :zzz:  |                                                                                              |
| 7   | :zzz:  |                                                                                              |
| 8   | :zzz:  |                                                                                              |
| 9   | :zzz:  |                                                                                              |
| 10  | :zzz:  |                                                                                              |
| 11  | :zzz:  |                                                                                              |
| 12  | :zzz:  |                                                                                              |

## Make Reddit Code Snippet

For longer code snippets, use https://topaz.github.io/paste/. If it's short enough, do this:

```
$ cat code | sed 's/^/    /' | xsel -b
$ cat code | sed 's/^/    /' | pbcopy
```

To copy snippets from code directly, select it and then run:

```
:'<,'>w !sed 's/^/    /' | pbcopy
```

## Reddit Comment Template

```text
[LANGUAGE: Janet]

26 lines with `tokei` when formatting with `janet-format` (from Spork).

- [GitHub Repository](https://github.com/cideM/aoc2025-janet)
- [Topaz Paste]()
```

## Disable Copilot

Add `set exrc` to your Neovim configuration, then `echo 'let g:copilot_enabled=v:false' > .nvimrc`, open the file and `:trust` it.
