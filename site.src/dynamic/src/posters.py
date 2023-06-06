#!/usr/bin/python3

# ID,Title,First Name,Last Name,Position,Organization,Primary Address
# - City,Primary Address - Country,Primary Email,Additional
# Email,Paper Title,Paper Number,Presentation Status,Presentation
# Type,Theme,Presenting Author Names,Rest of the
# authors,Registered,Bio,Final abstract,Day (Poster)

import csv

def posters_of_day(day):
    for row in csv_sorted:
        if (row['Presentation Type'] == 'Poster' or row['Presentation Type'] == 'Oral') and row['Day (Poster)'] == day:
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
            print(f'\n*Poster #{row["Poster board"].strip()} in {row["MR"]} on')

            day = row['Day (Poster)']
            if day == "Tue":
                print(f'Tue 6th.*')
            elif day == "Wed":
                print(f'Wed 7th.*')
            elif day == "Thu":
                print(f'Thu 8th.*')

            media = []

            # Format the links to abstracts and posters."
            if row['HasAbstract'] == 'Y':
                media.append(f'[extended abstract](media/proceedings/posters/{row["BaseFileName"]}-abstract.pdf)')

            if row['HasPoster'] == 'Y':
                media.append(f'[poster](media/proceedings/posters/{row["BaseFileName"]}-poster.pdf)')

            if not media == []:
                if len(media) == 1:
                    print(f'*Link: {", ".join(media)}.*')
                elif len(media) == 2:
                    print(f'*Links: {", ".join(media)}.*')

            print(f'')

            # Format abstract and bio.
            if row['Final abstract'] != "":
                print(f'\n**Summary**\n\n{row["Final abstract"]}')
            if row['Bio'] != "":
                print(f'\n*Bio*\n\n*{row["Bio"]}*')
            print(f'\n')


with open('gdocs/authors-info.csv') as csv_file:
    csv_reader = csv.DictReader(csv_file, delimiter=',')
    csv_sorted = sorted(csv_reader, key=lambda row: int(row['Poster board']) )
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
