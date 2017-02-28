import sys
from itertools import izip

def pairwise(iterable):
    "s -> (s0, s1), (s2, s3), (s4, s5), ..."
    a = iter(iterable)
    return izip(a, a)

def help():
    print("usage: {} --key=value:type [--key2 value [...]]".format(sys.argv[0]))
    sys.exit(1)

if len(sys.argv) == 1 or len(sys.argv) % 2 != 1:
    help()

arguments = sys.argv[1:]

if len(arguments) % 2 != 0:
    help()

d = {}
for key, value in pairwise(arguments):

    # key needs to start with --
    if not key[:2] == "--":
        help()

    d[key[2:]] = value

print(d)

