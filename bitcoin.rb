# frozen_string_literal: true

require 'rest-client'
require 'json'
require 'terminal-table'
require 'colorize'

def coin_status(bpi, keys, index)
  return '' if index.zero?

  bpi[keys[index]] > bpi[keys[index - 1]] ? '🡅'.green : '🡇'.red
end

def coin_variation(bpi, keys, index)
  return '$0.00' if index.zero?

  total = bpi[keys[index]] - bpi[keys[index - 1]]
  "$#{total.round(2)}"
end

def coin_valorization(bpi, keys, index)
  return '0%' if index.zero?

  total = ((bpi[keys[index]] - bpi[keys[index - 1]]) * 100) / bpi[keys[index]]
  "#{total.round(2)}%"
end

url = 'https://api.coindesk.com/v1/bpi/historical/close.json'

headings = ['Data', 'Valor do Bitcoin', 'Valorização', 'Variação', '₿']

days_to_show = ARGV[0] ? ARGV[0].split('=')[1].to_i : 7

end_date = Date.today.strftime('%Y-%m-%d')
start_date = (Date.today - days_to_show).strftime('%Y-%m-%d')

params = "?start=#{start_date}&end=#{end_date}"

response = RestClient.get "#{url}#{params}", {
  content_type: :json,
  accept: :json
}

bpi = JSON.parse(response.body)['bpi']

bpi_keys = bpi.keys

table_data = bpi.map.with_index do |(data, value), i|
  [
    Date.parse(data).strftime('%d/%m/%y'),
    "$#{value.to_f}",
    coin_valorization(bpi, bpi_keys, i),
    coin_variation(bpi, bpi_keys, i),
    coin_status(bpi, bpi_keys, i)
  ]
end

puts Terminal::Table.new title: "Cotação Bitcoins dos ultimos #{days_to_show} dias", headings: headings, rows: table_data
