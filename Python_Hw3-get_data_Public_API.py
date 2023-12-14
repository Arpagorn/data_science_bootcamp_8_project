# HW 3 Find Public API and use python to get data
import requests
url = "https://swapi.dev/api/starships/15"

response = requests.get(url)

##if success, status code = 200
response.status_code
import requests
import time

starships = []

for i in range (6):
    url = f"https://swapi.dev/api/starships/{i+5}"
    resp = requests.get(url)
    if resp.status_code == 200:
        data = resp.json()
        starships.append(
            (data["name"],
            data["model"],
            data["manufacturer"])
        )
    else:
        starships.append("error")
    time.sleep(2)

print(starships)
