# pawk: "Like Awk, but in Python"

## About

The venerable tool Awk shows it's very useful to easily write one-liners
to process input files, one line at a time. The only downside for me is
that I don't use it enough to remember the Awk language from one time
to the next.

Wouldn't it be nice to have an Awk-inspired tool, but where the language
is Python? This is what "pawk" is about.

## Overview

At its heart, the tool will read a file and run the Python you provided on
every line. You can also specify code to run before or after the loop.
Since your code is put directly into the program, you can use `continue` or
`break` to go to the next line or stop processing.

The program will also parse `csv`, `tsv` or `parquet` files if given as input
so you don't have to worry about things like commas in quoted strings in your
csv.

There are a few more niceties, use `pawk --help` to see a list. 

## Usage examples

```
# Print $PATH on separate lines
echo $PATH | pawk -F: 'print("\n".join(words))'
```

```
# count lines
cat README.md | pawk --start 'c=0' --each 'c+=1' --end 'print(f"line count: {c}")'
```

```
# count lines too, but rely on single-letter variables auto-initialization (to 0)
# Also, show --file is an option.
pawk --file README.md 'c+=1' --end 'print(f"line count: {c}")'
```

```
# multi-line commands work, but you have to obey Python's indentation rules.
pawk --file README.md --each 'if line.startswith("```"): a = not a; continue
if a:
  print("    " + line)
else:
  print(line)'
```

```
# Format text into two columns
pawk 'if not d: old_line=line;d=1' 'else: print(f"{old_line[:40]:<40}{line[:40]}");d=0 ' --last 'if d: print(old_line)'
```

## Installation

Make the venv and pip install the requirements like this:

```
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install --upgrade pip
$ pip install -r requirements.txt
$ deactivate
```

Then put a symlink to `pawk` somewhere in your PATH. Something like this:

```
$ ln -s $(pwd)/pawk ~/bin/pawk
```

You can then run `pawk` directly. Try the help command!

```
$ pawk --help
```

## Notes

There is another tool also called "Pawk." We got the same inspiration but the two
efforts are otherwise separate.
