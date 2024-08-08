import requests

BASE = "http://127.0.0.1:5000/"

response = requests.get(BASE + "crypto/Bitcoin")
response = requests.get(BASE + "crypto")
response = requests.get(BASE + "stocks/SQQQ")
response = requests.get(BASE + "stocks")


print(response.json())
