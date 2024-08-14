import requests

BASE = "http://192.168.1.234:5000/"

response = requests.get(BASE + "crypto/Bitcoin")
print(response.json())

response = requests.get(BASE + "crypto")
print(response.json())

response = requests.get(BASE + "stocks/SQQQ")
print(response.json())

response = requests.get(BASE + "stocks")
print(response.json())
