
import sys

f = open(sys.args[0])
fo = open((sys.args[1], "w")


skip = False


for line in f:
	if not skip:
		fo.write(line)
	else:
		skip = False

	if line.startswith("0"):
		skip = True


