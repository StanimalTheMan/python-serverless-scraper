import requests
import pandas as pd
import boto3
import io 
from bs4 import BeautifulSoup

s3 = boto3.client('s3')

# def save_file(keypath, string_io_file):
#     s3.put_object(Bucket='cfe-lambda-jiggy', Body=string_io_file, Key=keypath)

def scrape_event():
    r = requests.get("https://www.baseball-reference.com/players/t/troutmi01.shtml")
    if r.status_code in range(200, 299):
        html = r.text
        soup = BeautifulSoup(html, 'html.parser')
        table = soup.find('table', id="batting_standard")

        header = []
        rows = []
        for i, row in enumerate(table.find_all('tr')):
            if i == 0:
                header = [el.text.strip() for el in row.find_all('th')]
            else:
                break
        for row in table.find_all('tr', {"class": "full"}):
            rows.append([el.text.strip() for el in row.find_all('th')] + [el.text.strip() for el in row.find_all('td')])

        df = pd.DataFrame(rows, columns=header)
        towrite = io.StringIO()
        df.to_csv(towrite, index=False)
        towrite.seek(0)
        bytes_data = towrite.getvalue()
        keypath = 'scraped/mike-trout-batting.csv'
        s3.put_object(Bucket='cfe-lambda-jiggy', Body=bytes_data, Key=keypath)