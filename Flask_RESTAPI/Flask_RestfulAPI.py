from flask import Flask
from flask_restful import Api, Resource
from flask_cors import CORS
import requests

app = Flask(__name__)
api = Api(app)
CORS(app)  # Enable CORS

# Crypto API setup
API_KEY_CRYPTO = '4b63ad08-de18-4768-933d-7730186e8ac6'
crypto_url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'
crypto_headers = {
    'Accepts': 'application/json',
    'X-CMC_PRO_API_KEY': API_KEY_CRYPTO,
}
crypto_parameters = {
    'start': '1',
    'limit': '10',
    'convert': 'USD'
}

# Stock API setup
API_KEY_STOCK =  'MV6OU4A2A9VWGNSO'
# 'RCD8LXSJ56ZWEK0S'
# 'CKH4VL53A70XYEJL'
stock_base_url = 'https://www.alphavantage.co/query'
stock_tickers = ['AAPL', 'MSFT', 'GOOGL', 'AMZN', 'TSLA']
etf_tickers = ['SPY', 'IVV', 'VOO', 'QQQ', 'VTI']

def get_current_price(ticker):
    params = {
        'function': 'GLOBAL_QUOTE',
        'symbol': ticker,
        'apikey': API_KEY_STOCK
    }
    response = requests.get(stock_base_url, params=params)
    data = response.json()
    
    # Debugging: Print the data to see the response structure
    print(f"API Response for {ticker}: {data}")
    
    # Handle cases where 'Global Quote' key is missing
    if 'Global Quote' in data and '05. price' in data['Global Quote']:
        return round(float(data['Global Quote']['05. price']), 4)
    else:
        raise KeyError(f"No price data found for {ticker}")

class TopCryptoData(Resource):
    def get(self):
        response = requests.get(crypto_url, headers=crypto_headers, params=crypto_parameters)
        data = response.json()

        crypto_data = []
        for currency in data.get('data', []):
            price = currency['quote']['USD']['price']
            formatted_price = round(price, 4)
            crypto_data.append({
                'Name': currency['name'],
                'Price (USD)': formatted_price
            })

        return crypto_data

class SpecificCryptoData(Resource):
    def get(self, cryptoName):
        response = requests.get(crypto_url, headers=crypto_headers, params=crypto_parameters)
        data = response.json()

        for currency in data.get('data', []):
            if currency['name'].lower() == cryptoName.lower():
                price = currency['quote']['USD']['price']
                formatted_price = round(price, 4)
                return {
                    'Name': currency['name'],
                    'Price (USD)': formatted_price
                }

        return {'message': 'Cryptocurrency not found'}, 404

class StockData(Resource):
    def get(self):
        try:
            stock_data = [{'Symbol': ticker, 'Price (USD)': get_current_price(ticker)} for ticker in stock_tickers]
            etf_data = [{'Symbol': ticker, 'Price (USD)': get_current_price(ticker)} for ticker in etf_tickers]
            return {'stocks': stock_data, 'etfs': etf_data}
        except KeyError as e:
            return {'message': str(e)}, 404

class SpecificStockData(Resource):
    def get(self, tickerSymbol):
        try:
            price = get_current_price(tickerSymbol)
            return {'Symbol': tickerSymbol, 'Price (USD)': price}
        except KeyError:
            return {'message': 'Stock or ETF not found'}, 404

api.add_resource(TopCryptoData, '/crypto')
api.add_resource(SpecificCryptoData, '/crypto/<string:cryptoName>')
api.add_resource(StockData, '/stocks')
api.add_resource(SpecificStockData, '/stocks/<string:tickerSymbol>')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
