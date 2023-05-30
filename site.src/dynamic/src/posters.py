#!/usr/bin/python3

# ID,Title,First Name,Last Name,Position,Organization,Primary Address
# - City,Primary Address - Country,Primary Email,Additional
# Email,Paper Title,Paper Number,Presentation Status,Presentation
# Type,Theme,Presenting Author Names,Rest of the
# authors,Registered,Bio,Final abstract,Day (Poster)

import csv

def posters_of_day(day):
    for row in csv_sorted:
        if row['Presentation Type'] == 'Poster' and row['Day (Poster)'] == day:
            PaperTitle = row["Paper Title"].replace("\n","")
            print(f'### {row["First Name"]} {row["Last Name"]} -- {PaperTitle}')
            print(f'')

            # Format the (city, country) string
            city    = row["Primary Address - City"]
            country = row["Primary Address - Country"]
            if city == "" and country == "":
                location = ""
            elif city == "":
                location = country
            elif country == "":
                location = city
            else:
                location = city+", "+country

            # Format affiliation, city, etc.
            if row["Organization"] == "" and location == "":
                orgaloc = ""
            elif row["Organization"] == "":
                orgaloc = " ("+location+")"
            elif location == "":
                orgaloc = " ("+row["Organization"]+")"
            else:
                orgaloc = " ("+row["Organization"]+", "+location+")"

            # Format the full list of authors.
            print(f'{row["First Name"]} {row["Last Name"].strip()}{orgaloc}')
            if row['Rest of the authors'] != "":
                print(f', {row["Rest of the authors"]}.')

            # Format the poster location on the conf. floor.
            print(f'\n*Location: {row["MR"]} #{row["Poster board"].strip()}*')

            # Format abstract and bio.
            if row['Final abstract'] != "":
                print(f'\n**Summary**\n\n{row["Final abstract"]}')
            if row['Bio'] != "":
                print(f'\n*Bio*\n\n*{row["Bio"]}*')
            print(f'\n')


with open('gdocs/authors-info.csv') as csv_file:
    csv_reader = csv.DictReader(csv_file, delimiter=',')
    csv_sorted = sorted(csv_reader, key=lambda row: row['Last Name'].lstrip(" abcdefghijklmnopqrstuvwxyz"))
    line_count = 0
    print(f'')
    print(f'## Posters on Display Tuesday June 6th')
    print(f'')
    print(f'Presenters are expected to be with their poster during the morning break, lunch and afternoon break, as well as during the early evening cocktail on Tuesday 6.')
    print(f'')
    posters_of_day('Tue')
    print(f'')
    print(f'## Posters on Display Wednesday June 7th')
    print(f'')
    print(f'Presenters are expected to be with their poster during the morning break, lunch and afternoon break.')
    print(f'')
    posters_of_day('Wed')
    print(f'')
    print(f'## Posters on Display Thursday June 8th')
    print(f'')
    print(f'Presenters are expected to be with their poster during the morning break, lunch and afternoon break.')
    print(f'')
    posters_of_day('Thu')
