# frozen_string_literal: true

require_relative 'api'
require_relative 'table'

# Bitcoin class
class Bitcoin
  extend Api

  days_to_show = ARGV[0] ? ARGV[0].split('=')[1].to_i : 7

  headings = ['Data', 'Valor do Bitcoin', 'Valorização', 'Variação', '₿']
  title = "Cotação Bitcoins dos ultimos #{days_to_show} dias"

  # Alinha as colunas a alguma posicao de acordo com sua numeracao
  align = {
    center: [0, 4],
    right: [1, 2, 3]
  }

  end_date = Date.today.strftime('%Y-%m-%d')
  start_date = (Date.today - days_to_show).strftime('%Y-%m-%d')

  data = get_cotation(start_date, end_date)['bpi']

  table = Table.new(title, headings, data, align)

  puts ''
  puts table.render
  puts ''
end
