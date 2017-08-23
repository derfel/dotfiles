# To get -> for i in $(seq -w 1 124) ; do wget -O $i.html http://www.studiok.it/comuni/castelnuovoscrivia/albo/allegati.php?did=MES0000000$i\2013 ; done

from BeautifulSoup import BeautifulSoup


def analyze(name):
	f=file(name)

	s = BeautifulSoup(f.read(50000))

	return s.find('textarea').next


import os

path = '.'
listing = os.listdir(path)
for infile in listing:
	print 'current file is:', infile, analyze(infile)

