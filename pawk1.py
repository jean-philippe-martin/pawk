"""
Pawk: Awk-inspired, in Python.

This file takes your settings and outputs a Python program to run.
Use the pawk shell script as the main entry point instad of this.
"""
import sys
import textwrap

def usage():
    print('''usage: pawk [options] [Python code] < input_file

Will run the Python code for each line of the file.
The variable "line" will be set for the current line,
and the array "words" will contain the individual words.
Options include e.g. -F: to split on ":" instead of space.

Options:

--dry-run      : print the generated Python program and exit without
                 running it. Also answers to --dryrun and --dry_run.
--begin <code> : run this code before opening the input file.
                 also answers to --first, --start, or --before.
--each <code>  : run this code on each line (the "--each" is optional)
                 multi-line code is OK.
--end <code>   : run this code after closing the input file.
                 also answers to --last, --finish, or --after.
--file <fname> : read from fname instead of stdin.
                 File names ending in ".csv" will trigger CSV parsing,
                 similarly for ".tsv" and ".parquet".
-F<separator>  : use the given single-letter separator instead of space
                 to split the line into words. For example: -F;
                 also answers to --field <separator>, which allows for
                 longer separators.
--header       : indicates the file has a header. The first line will be read
                 outside of the loop and its words put in the "header" variable.
                 Also answers to -H.
--help         : print this message.
--print <code> : run "print(code)" on each line.

Before calling your code, variable "line" is set to the contents of the
current line, and "words" is that line split using the given separator.
Single-letter variables (a-z) are already initialized to 0 for you,
as well as "total" and "count" (all set to 0).

If the filename ends in '.csv', '.tsv' or '.parquet',
then a corresponding reader is used, and "words" are the parsed line.
Variable "line" is still  present but it's just ','.join(words) rather
than the original line. In that mode the passed separator is ignored.
If the file has a header then variable "header" holds them in a list
and the "word" variable is set, it's a dictionary mapping from the column
name to its value for the current line.

If the filename ends in '.json' or '.toml' then again the corresponding
reader is used, except that now each "line" is a dictionary (and "word"
is an alias for it). The JSON file is expected to be either a dictionary or
an array of dictionaries. 
''', file=sys.stderr)
    sys.exit(1)

def main():
    start_command = ''
    end_command = ''
    command = ''
    separator = ' '
    skip = False
    filename = ''
    dryrun = False
    has_header = False
    if len(sys.argv)<=1:
        help()
        return
    for i in range(1, len(sys.argv)):
        if skip:
            skip = False
            continue
        arg = sys.argv[i]
        if arg.startswith('-F') and len(arg)==3:
            separator = arg[2]
            continue
        if arg.lower()=='--help':
            usage()
            return
        if arg.lower()=='--each':
            if command: command += '\n'
            command += sys.argv[i+1]
            skip = True
        if arg.lower()=='--print':
            if command: command += '\n'
            command += f'print({sys.argv[i+1]})'
            skip = True
        if arg.lower() in ['--start', '--begin', '--first', 
            '--before', '--introduction', '--prelude', '--foreword']:
            if start_command: start_command += '\n'
            start_command += sys.argv[i+1]
            skip = True
        if arg.lower() in ['--finish', '--end', '--last', 
            '--after', '--conclusion', '--epilogue', '--afterword']:
            if end_command: end_command += '\n'
            end_command += sys.argv[i+1]
            skip = True
        if arg.lower()=='--field' or arg=='-F':
            separator = sys.argv[i+1]
            skip = True
        if arg.lower() in ['--file', '--input']:
            filename = sys.argv[i+1]
            file = f'open("{sys.argv[i+1]}", "r")'
            skip = True
        if arg.lower() in ['--dry-run', '--dryrun', '--dry_run']:
            dryrun = True
        if arg.lower() in ['--header'] or arg=='-H':
            has_header = True
            continue
        if not arg.startswith('--'):
            if command: command += '\n'
            command += arg
    if not command and not start_command and not end_command:
        help()
        return
    command = command or ''
    ___command=textwrap.indent(command,'    ')
    if filename:
        file=f'open("{filename}", "r")'
    else:
        file='sys.stdin'
    open_file=f'with {file} as file:'
    mode='text'
    if filename.lower().endswith('.csv'): mode='csv'
    if filename.lower().endswith('.tsv'): mode='tsv'
    if filename.lower().endswith('.parquet'): mode='parquet'
    if filename.lower().endswith('.json'): mode='json'
    if filename.lower().endswith('.toml'): mode='toml'
    if filename.lower().endswith('.yaml'): mode='yaml'
    if mode=='csv':
        if filename:
            file=f'open("{filename}", "r", newline="")'
        fileoverride=f'file=csv.reader(file)'
    elif mode=='tsv':
        if filename:
            file=f'open("{filename}", "r", newline="")'
        fileoverride=f'file=csv.reader(file, delimiter="\t")'
    elif mode=='parquet':
        start_command = f'import pyarrow.parquet as pq\n{start_command}'
        open_file=f'table=pq.read_table("{filename}")\nfor _foo in [1]:'
        fileoverride='file=range(len(table.columns[0]))'
        fileoverride+='; header=[table.field(c).name for c in range(len(table.columns))]'
    elif mode=='toml':
        start_command = f'import toml\n{start_command}'
        fileoverride = 'file = [toml.load(file)]'
    elif mode=='json':
        fileoverride='''file=json.load(file);
if isinstance(file, dict):
    file=[file]'''
    elif mode=='yaml':
        start_command = 'from ruamel.yaml import YAML\n' + start_command;
        start_command += '\nyaml=YAML(typ="safe");'
        fileoverride='file=yaml.load(file)'
    else:
        fileoverride=''
        mode='text'
    _fileoverride=textwrap.indent(fileoverride,'  ')
    program = f'''
import csv, datetime, json, re, sys
import collections
from collections import defaultdict
a=b=c=d=e=f=g=h=i=j=k=l=m=n=o=p=q=r=s=t=u=v=w=x=y=z=0
total=count=0
NR=0
header=None
word={{}}
mode='{mode}'
{start_command}
{open_file}
{_fileoverride}
  for line in file:
    NR += 1 # for awk compatibility. 
    if mode=='text':
        line = line.strip()
        words = line.split("{separator}")
        if header:
            word=dict(zip(header,words))
    elif mode=='parquet':
        words=[str(col[line]) for col in table.columns]
        word=dict(zip(header,words))
        line=','.join(words)
    elif mode=='json' or mode=='toml' or mode=='yaml':
        words=list(line.values())
        header=list(line.keys())
        word=line
    else:
        words = line
        line = ','.join(words)
        if header:
            word=dict(zip(header,words))
    if NR==1 and {has_header} and mode!='parquet' and header is None:
        header = [w.strip() for w in words]
        NR=0
        continue
    NF = len(words) # for awk compatibility.
{___command}
{end_command}
'''
    if dryrun:
        print(program, file=sys.stderr)
        sys.exit(1)
    print(program)


main()
