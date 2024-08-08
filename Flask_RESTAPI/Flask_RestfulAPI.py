from flask import Flask
from flask_restful import Api, Resource
import requests
import pandas as pd

app = Flask(__name__)
api = Api(app)

API_KEY_CRYPTO = '4b63ad08-de18-4768-933d-7730186e8ac6'
url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'

headers = {
    'Accepts': 'application/json',
    'X-CMC_PRO_API_KEY': API_KEY_CRYPTO,
}

parameters = {
    'start': '1',
    'limit': '10',
    'convert': 'USD'
}

class topCryptoData(Resource):
    def get(self):
        response = requests.get(url, headers=headers, params=parameters)
        data = response.json()

        # Extracting the relevant data with prices rounded to four decimal places
        crypto_data = []
        for currency in data['data']:
            price = currency['quote']['USD']['price']
            formatted_price = round(price, 4)
            crypto_data.append({
                'Name': currency['name'],
                'Price (USD)': formatted_price
            })

        return crypto_data

class specificCryptoData(Resource):
    def get(self, cryptoName):
        response = requests.get(url, headers=headers, params=parameters)
        data = response.json()

        # Finding the specific cryptocurrency
        for currency in data['data']:
            if currency['name'].lower() == cryptoName.lower():
                price = currency['quote']['USD']['price']
                formatted_price = round(price, 4)
                return {
                    'Name': currency['name'],
                    'Price (USD)': formatted_price
                }

        return {'message': 'Cryptocurrency not found'}, 404
    
    
# Replace 'YOUR_API_KEY_STOCK' with your actual Alpha Vantage API key
API_KEY_STOCK = 'CKH4VL53A70XYEJL'
base_url = 'https://www.alphavantage.co/query'

# Define the tickers for the top 5 stocks and top 5 ETFs
stock_tickers = ['AAPL', 'MSFT', 'GOOGL', 'AMZN', 'TSLA']
etf_tickers = ['SPY', 'IVV', 'VOO', 'QQQ', 'VTI']

def get_current_price(ticker):
    params = {
        'function': 'GLOBAL_QUOTE',
        'symbol': ticker,
        'apikey': API_KEY_STOCK
    }
    response = requests.get(base_url, params=params)
    data = response.json()
    return round(float(data['Global Quote']['05. price']), 4)

class StockData(Resource):
    def get(self):
        stock_data = [{'Symbol': ticker, 'Price (USD)': get_current_price(ticker)} for ticker in stock_tickers]
        etf_data = [{'Symbol': ticker, 'Price (USD)': get_current_price(ticker)} for ticker in etf_tickers]
        return {'stocks': stock_data, 'etfs': etf_data}

class SpecificStockData(Resource):
    def get(self, tickerSymbol):
        try:
            price = get_current_price(tickerSymbol)
            return {'Symbol': tickerSymbol, 'Price (USD)': price}
        except KeyError:
            return {'message': 'Stock or ETF not found'}, 404


api.add_resource(topCryptoData, '/crypto')
api.add_resource(specificCryptoData, '/crypto/<string:cryptoName>')
api.add_resource(StockData, '/stocks')
api.add_resource(SpecificStockData, '/stocks/<string:tickerSymbol>')

if __name__ == '__main__':
    app.run(debug=True)
