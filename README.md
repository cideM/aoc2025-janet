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

## Progress (1/12)

|     | Janet  | Solution Comment                                                               |
| --- | ------ | ------------------------------------------------------------------------------ |
| 1   | :bell: | [Link](https://www.reddit.com/r/adventofcode/comments/1pb3y8p/comment/nrq6fdq) |
| 2   | :zzz:  |                                                                                |
| 3   | :zzz:  |                                                                                |
| 4   | :zzz:  |                                                                                |
| 5   | :zzz:  |                                                                                |
| 6   | :zzz:  |                                                                                |
| 7   | :zzz:  |                                                                                |
| 8   | :zzz:  |                                                                                |
| 9   | :zzz:  |                                                                                |
| 10  | :zzz:  |                                                                                |
| 11  | :zzz:  |                                                                                |
| 12  | :zzz:  |                                                                                |
| 13  | :zzz:  |                                                                                |
| 14  | :zzz:  |                                                                                |
| 16  | :zzz:  |                                                                                |
| 17  | :zzz:  |                                                                                |
| 18  | :zzz:  |                                                                                |
| 19  | :zzz:  |                                                                                |
| 20  | :zzz:  |                                                                                |
| 21  | :zzz:  |                                                                                |
| 22  | :zzz:  |                                                                                |
| 23  | :zzz:  |                                                                                |
| 24  | :zzz:  |                                                                                |
| 25  | :zzz:  |                                                                                |

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

26 lines with `wc -l`.

- [GitHub Repository](https://github.com/cideM/aoc2025-janet)
- [Topaz Paste]()
```

## Disable Copilot

Add `set exrc` to your Neovim configuration, then `echo 'let g:copilot_enabled=v:false' > .nvimrc`, open the file and `:trust` it.
