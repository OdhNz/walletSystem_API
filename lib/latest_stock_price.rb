require 'net/http'
require 'json'

class LatestStockPrice
  API_URL = 'https://latest-stock-price.p.rapidapi.com/'

  def initialize(api_key)
    @api_key = api_key
  end

  def price(symbol)
    response = make_request('price', symbol)
    JSON.parse(response.body)
  end

  def prices(symbols)
    response = make_request('prices', symbols.join(','))
    JSON.parse(response.body)
  end

  def price_all
    response = make_request('price_all')
    JSON.parse(response.body)
  end

  private

  def make_request(endpoint, query = nil)
    url = URI("#{API_URL}/#{endpoint}?#{query}")
    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'latest-stock-price.p.rapidapi.com'
    request["x-rapidapi-key"] = @api_key

    http.request(request)
  end
end