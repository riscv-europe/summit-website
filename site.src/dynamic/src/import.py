#!/usr/bin/python3

import os
import shutil
import csv

import_root = '/media/sf_FromToLinux/RISC-V-Summit-2023/Slides-Posters/media-files'
reposi_root = '../media/proceedings'


def import_file(src,dst):
    i = 0
    # print(f'Moving file from "{src}" to "{dst}"')
    shutil.move(src,dst)

    
# For posters sessions, import PDF files for abstracts and poster.
def scan_posters_from_posters_session():
    with open('gdocs/authors-info.csv') as contribs_file:
        contribs = csv.DictReader(contribs_file, delimiter=',')

        # Iterate over all contribs of the spreadsheet.
        for contrib in contribs:

            # If it is not a poster from a posters session, drop it.
            if not contrib['Presentation Type'] == 'Poster':
                continue

            # This is a pure poster.

            # Import the contrib's abstract, if there is one.
            if os.path.isfile(import_root+"/posters/abstracts/"+contrib['BaseName']+".pdf"):
                import_file(  import_root+'/posters/abstracts/'+contrib['BaseName']+'.pdf',
                              reposi_root+'/posters/'+contrib['BaseFileName']+'-abstract.pdf')
            else:
                print(f"No abstract: {contrib['BaseName']}.")

            # Import the contrib's poster, if there is one.
            if os.path.isfile(import_root+"/posters/posters/"+contrib['BaseName']+".pdf"):
                import_file(  import_root+'/posters/posters/'+contrib['BaseName']+'.pdf',
                              reposi_root+'/posters/'+contrib['BaseFileName']+'-poster.pdf')
            else:
                print(f"No poster  : {contrib['BaseName']}.")


scan_posters_from_posters_session()
    
# # We loop over all the PDF files of the abstracts.
# for import_pdf in os.listdir(import_dir):

#     # Open the spreadhseet database.
#     with open('gdocs/authors-info.csv') as database_file:
#         found = False
#         database_reader = csv.DictReader(database_file, delimiter=',')

#         # We loop over the contribs from the spreadsheet.
#         for contrib in database_reader:
#             # The current contrib is not the right one. Iterate to the
#             # next one.
#             if not contrib['BaseName'] == import_pdf.replace('.pdf',''):
#                 continue

#             # This is the expected contribution.
#             found = True
#             if contrib['HasAbstract'] == 'Y':
#                 import_file(import_pdf,contrib['BaseFileName']+"-abstract.pdf")
#             else:
#                 # This is a new contribution, not yet marked as having
#                 # an abstract. Should be fixed in the spreadsheet.
#                 print(f'No yet marked as having an abstract: "{import_pdf}"')
#             break

#         # We exhausted the spreadsheet and dit not found the contrib
#         # correspondingto the abstract.  Must be missing from the
#         # sheet, or the contrib is not nale properly.
#         if not found:
#             print(f'Not found in spreadsheet: "{import_pdf}"')

