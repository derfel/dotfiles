#!/usr/bin/env python

import os
import sys

def main():
	basecmd='curl -v -H "Expect:" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" -H "Accept-Language: it-it,it;q=0.8,en-us;q=0.5,en;q=0.3" -H "Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" -e http://www.ossblog.it/wp-admin/gallery_old.php -A "Mozilla/5.0 (X11; U; Linux x86_64; it; rv:1.9.0.7) Gecko/2009030810 Iceweasel/3.0.7 (Debian-3.0.7-1)" -b ~/.blogo_cookies.txt -F "galleryname=%s" -F "gallerydescription=%s" -F "gallerytags=%s"'

	cmd = basecmd % tuple(sys.argv[1:4])

	postid = sys.argv[4]

	files=sys.argv[5:]

	i = 0
	for f in files:
		cmd += ' -F "images%d=@%s;type=image/jpeg" -F "imgdesc%d="' % (i, f, i)
		i += 1

	cmd += ' -F "submit=Upload File" http://www.ossblog.it/wp-admin/gallery_old.php?post_id=%s' % postid

	os.system(cmd)

if __name__ == '__main__':
	main()

