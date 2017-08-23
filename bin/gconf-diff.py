#!/usr/bin/env python

### Copyright (C) 2006 Robert Bradford <rob@robster.org.uk>

### This program is free software; you can redistribute it and/or modify
### it under the terms of the GNU General Public License as published by
### the Free Software Foundation; either version 2 of the License, or
### (at your option) any later version.

### This program is distributed in the hope that it will be useful,
### but WITHOUT ANY WARRANTY; without even the implied warranty of
### MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
### GNU General Public License for more details.

### You should have received a copy of the GNU General Public License
### along with this program; if not, write to the Free Software
### Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

###
### Recursively searches from a path looking for gconf keys that either have
### different values to the schema or those that don't have a matching schema.
###
### Usage:
### ./gconf-diff <start path>
### If no start path is given then it starts in /
###


import gconf, sys

# Get the default gconf client

client = gconf.client_get_default()

def do_entries(path):

  # Get all the entries in the directory
  entries = client.all_entries(path)

  # If the directory is non-empty
  if entries != ():

    for entry in entries:

      # Need the key to be useful
      key = entry.key

      # Get the default 
      default = client.get_default_from_schema(key)

      # If no schema default == None
      if default == None:
        print "Key without schema: %s" % key
      else:

        # Get the values of both our the default and our version.
        # These are converted to strings for comparison
        value = entry.get_value().to_string()
        defvalue = default.to_string()

        if (value != defvalue):
          print "Key with different value: %s - %s (default: %s)" % (key, value,
              defvalue)

def do_directory(path):

  # Now we deal with the contents of the directordy
  do_entries(path)

  # Recurse
  directories = client.all_dirs(path)

  for directory in directories:

    # Don't do the /schemas directory
    if (directory != "/schemas"):
      do_directory(directory)

if (len(sys.argv) == 2):
  do_directory(sys.argv[1])
else:
  do_directory("/")

