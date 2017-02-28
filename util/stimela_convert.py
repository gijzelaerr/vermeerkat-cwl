#!/usr/bin/env python3

import json
import sys

if len(sys.argv) != 2:
    print("usage: {} <stimelascript>".format(sys.argv[0]))
    sys.exit(1)

# Available primitive types are string, int, long, float, double, and null; complex types are array and record; in addition there are special types File, Directory and Any.
typemap = {
        'file': 'File{}',
        'str': 'string{}',
        'bool': 'boolean{}',
        'float': 'float{}',
        'int': 'int{}',
}

parsed = json.load(open(sys.argv[1]))
for param in parsed['parameters']:
    print("  {}:".format(param['name']))

    # sphe style optional
    if 'default' in param and param['default'] == None:
        optional = "?"
    else:
        optional = ""

    type_ = param['dtype']
    if "choices" in param:
        print("    type:")
        if optional:
            print("      - \"null\"")
        print("      - type: enum")
        print("        symbols: [{}]".format(", ".join(param['choices'])))
    elif type(type_) in (unicode, str):
        if type_.startswith('list:'):
            print("    type:")
            print("    - type: array")
            print("      items: {}".format(type_[5:].format("")))
        else:
            print("    type: {}".format(typemap[type_].format(optional)))
    elif type(type_) in (list, tuple):
        print("    # warning: found multiple types. please verify")
        print("    type:")
        if optional:
            print("      - \"null\"")
        for subtype in type_:
            if subtype.startswith('list:'):
                print("      - type: array")
                print("        items: {}".format(subtype[5:].format("")))
            else:
                print("      - {}".format(typemap[subtype].format("")))
    else:
        raise Exception(type(type_))

    print("    doc: \"{}\"".format(param['info']))

    if 'default' in param and param['default'] != None:
        print("    default: {}".format(param['default']))

    
