import requests
from bs4 import BeautifulSoup
import pandas as pd
import re
import time

# Initialize lists to store data
usernames = []
dates = []
ratings = []
comments = []
useful = []
funny = []
cool = []

# Create a list of page numbers
page_sequence = list(range(0, 801, 10))

# Function to extract extra information
def extra_info_extract(ei, txt):
    match = re.search(f'{txt}.*?(\d+)', ei)
    if match:
        return int(match.group(1))
    else:
        return 0

# Loop through pages
for i in page_sequence:
    # Construct the URL
    url = f'https://www.yelp.com/biz/fogo-de-ch%C3%A3o-brazilian-steakhouse-san-diego-3?sort_by=date_asc&start={i}'

    # Send a GET request
    response = requests.get(url)

    if response.status_code != 200:
        print(f"Failed to retrieve page {i}")
        continue

    # Parse the HTML content
    soup = BeautifulSoup(response.content, 'html.parser')

    # Extract data from the page
    user_passports = soup.find_all(class_='user-passport-info')
    review_contents = soup.find_all(class_='review-content')
    ratings_divs = soup.find_all(class_='i-stars')

    for user_passport, review_content, rating_div in zip(user_passports, review_contents, ratings_divs):
        # Extract username
        username = user_passport.find('a', class_='user-display-name').get_text(strip=True)

        # Extract date
        date = user_passport.find(class_='rating-qualifier').get_text(strip=True)

        # Extract rating
        rating = float(rating_div['title'].split()[0])

        # Extract comment
        comment = review_content.p.get_text(strip=True)

        # Extract extra information
        extra_info = review_content.find(class_='review-footer').find_all('button')
        useful_count = extra_info_extract(str(extra_info[0]), 'Useful')
        funny_count = extra_info_extract(str(extra_info[1]), 'Funny')
        cool_count = extra_info_extract(str(extra_info[2]), 'Cool')

        # Append data to lists
        usernames.append(username)
        dates.append(date)
        ratings.append(rating)
        comments.append(comment)
        useful.append(useful_count)
        funny.append(funny_count)
        cool.append(cool_count)

    # Add a delay to avoid overloading the server
    time.sleep(15)

# Create a DataFrame from the lists
df = pd.DataFrame({
    'username': usernames,
    'dates': dates,
    'rating': ratings,
    'comment': comments,
    'useful': useful,
    'funny': funny,
    'cool': cool
})

# Save the DataFrame to a CSV file
df.to_csv('../data/processed/yelp_review_fogo.csv', index=False)
