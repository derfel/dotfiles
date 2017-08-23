#!/usr/bin/python3

import os
import sys

def translate_glob(glob, star_matches_slash):
    regex = glob.replace('.', '\\.').replace('?', '.?')
    return regex.replace('*', '.*' if star_matches_slash else '[^/]*')

def find_gitignore(base):
    for root, dirs, files in os.walk(base):
        if '.gitignore' not in files:
            continue
        yield root

def convert_gitignore_line(git_line, basedir):
    git_line = git_line.strip()
    line = git_line
    if line == '' or line.isspace() or line.startswith('#'):
        return None
    if line.startswith('!'):
        raise Exception("We do not support '!' patterns.")
    # trailing slash only matches directories, but hg can't distinguish between
    # the two;  strip it away.
    prefix = ''
    suffix = ''
    if line.endswith('/'):
        line = line.rstrip('/')
        suffix = '(?:/|$)'
    else:
        suffix = '$'
    if line.startswith('/'):
        if basedir == '':
            line = line.lstrip('/')
        prefix = '^'
    #regex = prefix + basedir + translate_glob(line, '/' not in line) + suffix
    regex = prefix + basedir + translate_glob(line, True) + suffix
    if regex.startswith('.*'):
        regex = regex[2:]
    converted = '{:60} # {!r} in {!r}'.format(regex, git_line, basedir)
    return converted

def generate_hgignore(base):
    hgignore = [
        '# auto-generated from .gitignore files by build-hgignore.py',
        'syntax: re',
        '^\\.hgignore$',
    ]
    for path in find_gitignore(base):
        with open(os.path.join(path, '.gitignore')) as ignore_file:
            basedir = os.path.relpath(path, os.path.abspath(base))
            if basedir == '.':
                basedir = ''
            for line in ignore_file:
                translated = convert_gitignore_line(line, basedir)
                if translated:
                    hgignore.append(translated)
    return '\n'.join(hgignore) + '\n'

if __name__ == '__main__':
    try:
        base = sys.argv[1]
    except IndexError:
        print('usage:  build-hgignore.py <repository_path>', file=sys.stderr)
        sys.exit(1)
    hgignore = generate_hgignore(base)
    with open(os.path.join(base, '.hgignore'), 'w') as f:
        f.write(hgignore) 
