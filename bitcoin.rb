require 'rest-client'
require 'json'

url = 'https://api.coindesk.com/v1/bpi/historical/close.json'

days_to_show = ARGV[0] ? ARGV[0].split("=")[1].to_i : 7 

end_date = Date.today.strftime("%Y-%m-%d")
start_date = (Date.today - days_to_show).strftime("%Y-%m-%d")

params = "?start=#{start_date}&end=#{end_date}"

response = RestClient.get "#{url}#{params}", {
    content_type: :json,
    accept: :json
}

puts response.body