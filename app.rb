require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "json"
require "http"

EXCHANGE_API_KEY = ENV.fetch("EXCHANGE_API_KEY")

currency_list_url = "https://api.exchangerate.host/list?access_key=#{EXCHANGE_API_KEY}"
currency_list_raw = HTTP.get(currency_list_url)
currency_list_parsed = JSON.parse(currency_list_raw)


get("/") do
  # url = currency_list_url
  currency_list_raw = HTTP.get(currency_list_url)
  @currency_list_parsed = JSON.parse(currency_list_raw)
  @key = EXCHANGE_API_KEY

  @currencies = @currency_list_parsed.fetch("currencies")

  @currency_list = []
  @currencies.each do |currency, location|
    @currency_list.append(currency)
  end
  
  erb(:home)
end
