#!/usr/bin/python3

# Columns are: ID, Title, First Name, Last Name, Position,
# Organization, Primary Address - City, Primary Address - Country,
# Primary Email, Additional Email, Paper Title, Paper Number,
# Presentation Status, Presentation Type, Theme, Presenting Author
# Names, Registered, Bio, Final abstract

import csv


with open('gdocs/authors-info.csv') as csv_file:
    csv_reader = csv.DictReader(csv_file, delimiter=',')
    csv_sorted = sorted(csv_reader, key=lambda row: row['Last Name'].lstrip(" abcdefghijklmnopqrstuvwxyz"))
    line_count = 0
    for row in csv_sorted:
        if row['Presentation Type'] == 'Poster':
            PaperTitle = row["Paper Title"].replace("\n","")
            print(f'### {row["First Name"]} {row["Last Name"]} -- {PaperTitle}')
            print(f'')

            # Format the (city, country) string
            city    = row["Primary Address - City"]
            country = row["Primary Address - Country"]
            if city == "" and country == "":
                location = ""
            elif city == "":
                location = " ("+country+")."
            elif country == "":
                location = " ("+city+")."
            else:
                location = " ("+city+", "+country+")."

            print(f'{row["First Name"]} {row["Last Name"]} -- {row["Organization"]}{location}')
            if row['Final abstract'] != "":
                print(f'\n**Summary**\n')
                print(f'{row["Final abstract"]}')
            if row['Bio'] != "":
                print(f'\n*Bio*\n')
                print(f'{row["Bio"]}')
            print(f'')
            print(f'')
