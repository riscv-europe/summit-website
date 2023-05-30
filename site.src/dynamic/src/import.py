#!/usr/bin/python3

import os
import shutil
import csv

import_dir = '/media/sf_FromToLinux/RISC-V-Summit-2023/Slides-Posters/abstracts'
reposi_dir = '../media/proceedings'

def import_file(import_pdf,reposi_pdf):
    import_path = import_dir+"/"+import_pdf
    reposi_path = reposi_dir+"/"+reposi_pdf
    print(f'Moving file from "{import_path}" to "{reposi_path}"')
    # shutil.move(import_path,reposi_path)

for import_pdf in os.listdir(import_dir):
    with open('gdocs/authors-info.csv') as database_file:
        found = False
        database_reader = csv.DictReader(database_file, delimiter=',')
        for contrib in database_reader:
            if import_pdf.replace('.pdf','') == contrib['BaseName']:
                import_file(import_pdf,contrib['BaseFileName'])
                found = True
                continue
        if not found:
            print(f'Orphan: "{import_pdf}"')
