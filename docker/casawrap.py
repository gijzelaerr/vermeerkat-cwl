#!/usr/bin/env python

import sys
import re
from os import path, getcwd
import drivecasa

import json


def log2term(result):
    if result[1]:
        err = '\n'.join(result[1] if result[1] else [''])
        failed = err.lower().find('an error occurred running task')>=0
        if failed:
            raise RuntimeError('CASA Task failed. See error message above')
        sys.stdout.write('WARNING:: SEVERE messages from CASA run')

if __name__ == '__main__':
    if len(sys.argv) < 3:
        help()

    task = sys.argv[1]
    parameters = json.load(open('parameters.json'))

    # this is a bug in cwltool, it shouldnt be there
    for i in ['job_order']:
        if i in parameters:
            parameters.pop(i)

    # these are the fields that are marked as writable, and are copied or
    # linked to the work folder (current work dir)
    for i in ['vis']:
        if i in parameters:
            parameters[i] = path.join(getcwd(), path.basename(parameters[i]['path']))

    args = {}
    for (k, v) in parameters.items():
        if v not in (None, ""):  #  Skip empty fields
            if type(v) == dict:
               new_v  =  v['path']
            else:
               new_v = v

            # casa can't handle unicode
            if type(new_v) == unicode:
                args[str(k)] = str(new_v)
            else:
                args[str(k)] = new_v


    script = ['{0}(**{1})'.format(task, args)]
    print(script)
    casa = drivecasa.Casapy(log2term=True, echo_to_stdout=True, timeout=24*3600*10)
    result = casa.run_script(script, raise_on_severe=False)
