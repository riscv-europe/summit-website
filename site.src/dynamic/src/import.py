#!/usr/bin/python3

import os
import shutil
import csv

import_dir = '/media/sf_FromToLinux/RISC-V-Summit-2023/Slides-Posters/abstracts'
reposi_dir = '../media/proceedings/posters'

def import_file(import_pdf,reposi_pdf):
    import_path = import_dir+"/"+import_pdf
    reposi_path = reposi_dir+"/"+reposi_pdf
    print(f'Moving file from "{import_path}" to "{reposi_path}"')
    # shutil.move(import_path,reposi_path)

# We loop over all the PDF files of the abstracts.
for import_pdf in os.listdir(import_dir):

    # Open the spreadhseet database.
    with open('gdocs/authors-info.csv') as database_file:
        found = False
        database_reader = csv.DictReader(database_file, delimiter=',')

        # We loop over the contribs from the spreadsheet.
        for contrib in database_reader:
            # The current contrib is not the right one. Iterate to the
            # next one.
            if not contrib['BaseName'] == import_pdf.replace('.pdf',''):
                continue

            # This is the expected contribution.
            found = True
            if contrib['HasAbstract'] == 'Y':
                import_file(import_pdf,contrib['BaseFileName']+"-abstract.pdf")
            else:
                # This is a new contribution, not yet marked as having
                # an abstract. Should be fixed in the spreadsheet.
                print(f'No yet marked as having an abstract: "{import_pdf}"')
            break

        # We exhausted the spreadsheet and dit not found the contrib
        # correspondingto the abstract.  Must be missing from the
        # sheet, or the contrib is not nale properly.
        if not found:
            print(f'Not found in spreadsheet: "{import_pdf}"')
