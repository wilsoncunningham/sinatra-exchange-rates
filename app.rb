require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "json"
require "http"

EXCHANGE_API_KEY = ENV.fetch("EXCHANGE_API_KEY")


get("/") do
  currency_list_url = "https://api.exchangerate.host/list?access_key=#{EXCHANGE_API_KEY}"
  currency_list_raw = HTTP.get(currency_list_url)
  currency_list_parsed = JSON.parse(currency_list_raw)
  currencies_hash = currency_list_parsed.fetch("currencies")

  @currency_list = []
  currencies_hash.keys.each do |currency|
    @currency_list.append(currency)
  end
  
  erb(:home)
end

get("/:currency1") do
  currency_list_url = "https://api.exchangerate.host/list?access_key=#{EXCHANGE_API_KEY}"
  currency_list_raw = HTTP.get(currency_list_url)
  currency_list_parsed = JSON.parse(currency_list_raw)
  currencies_hash = currency_list_parsed.fetch("currencies")

  @currency_list = []
  currencies_hash.keys.each do |currency|
    @currency_list.append(currency)
  end

  erb(:step_one)
end

get("/:currency1/:currency2") do
  @currency1 = params.fetch("currency1")
  @currency2 = params.fetch("currency2")

  exchange_url = "https://api.exchangerate.host/convert?from=#{@currency1}&to=#{@currency2}&amount=1&access_key=#{EXCHANGE_API_KEY}"
  exchange_raw = HTTP.get(exchange_url)
  exchange_parsed = JSON.parse(exchange_raw)

  @result = exchange_parsed.fetch("result")
  erb(:step_two)
end
