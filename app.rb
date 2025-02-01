require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "json"
require "http"

EXCHANGE_API_KEY = ENV.fetch("EXCHANGE_API_KEY")

currency_list_url = "https://api.exchangerate.host/list?access_key=#{EXCHANGE_API_KEY}"
currency_list_raw = HTTP.get(currency_list_url)
currency_list_parsed = JSON.parse(currency_list_raw)
currencies_hash = currency_list_parsed.fetch("currencies")

currency_list = []
currencies_hash.each do |currency, _|
  currency_list.append(currency)
end


get("/") do
  @currency_list = currency_list
  
  erb(:home)
end

get("/:currency1") do
  @currency1 = :currency1
  @currency_list = currency_list

  erb(:step_one)
end

get("/:currency2") do
  @currency_list = currency_list

  erb(:step_two)
end
