# frozen_string_literal: true

require 'terminal-table'
require 'colorize'

require_relative 'coin'
require_relative 'api'

# Bitcoin class
class Bitcoin
  extend Coin
  extend Api

  headings = ['Data', 'Valor do Bitcoin', 'Valorização', 'Variação', '₿']
  center_columns = [0, 4]
  right_columns = [1, 2, 3]

  days_to_show = ARGV[0] ? ARGV[0].split('=')[1].to_i : 7

  end_date = Date.today.strftime('%Y-%m-%d')
  start_date = (Date.today - days_to_show).strftime('%Y-%m-%d')

  bpi = get_cotation(start_date, end_date)['bpi']

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

  # Configuracoes da tabela
  table = Terminal::Table.new
  table.title = "Cotação Bitcoins dos ultimos #{days_to_show} dias"
  table.headings = headings
  table.rows = table_data

  # Align columns to center and left
  center_columns.each { |x| table.align_column(x, :center) }
  right_columns.each { |x| table.align_column(x, :right) }

  puts table
end
