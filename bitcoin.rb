require 'rest-client'
require 'json'
require 'terminal-table'
require 'colorize'

def coin_status bpi, keys, index;(index > 0 ? (bpi[keys[index]] > bpi[keys[index - 1]] ? "🡅".green : "🡇".red) : "") end

url = 'https://api.coindesk.com/v1/bpi/historical/close.json'

days_to_show = ARGV[0] ? ARGV[0].split("=")[1].to_i : 7 

end_date = Date.today.strftime("%Y-%m-%d")
start_date = (Date.today - days_to_show).strftime("%Y-%m-%d")

params = "?start=#{start_date}&end=#{end_date}"

response = RestClient.get "#{url}#{params}", {
    content_type: :json,
    accept: :json
}

bpi = JSON.parse(response.body)["bpi"]

bpi_keys = bpi.keys

table_data = bpi.map.with_index do |(data, value), i|
    [
        Date.parse(data).strftime("%d/%m/%y"),
        "$#{value.to_f}",
        "",
        coin_status(bpi, bpi_keys, i),
    ]
end

table = Terminal::Table.new :headings => ['Data', 'Valor do Bitcoin', 'Variação', '₿'], :rows => table_data

puts table