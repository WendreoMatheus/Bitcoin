# frozen_string_literal: true

require_relative 'coin'
require_relative 'table'

# Tabela de Cotacao
class CotationTable < Table
  def initialize(data, days_to_show)
    headings = ['Data', '($) Valor do Bitcoin', '($) Valorização', '(%) Variação', '₿']
    title = days_to_show == 7 ? 'Cotação do Bitcoin da Semana' : "Cotação Bitcoin dos ultimos #{days_to_show} dias"

    # Alinha as colunas a alguma posicao de acordo com sua numeracao
    align = {
      center: [0, 4],
      right: [1, 2, 3]
    }

    super(title, headings, generate_rows(data), align)
  end

  private

  def generate_rows(bpi)
    extend Coin

    bpi.map.with_index do |(data, value), i|
      first_value = bpi[bpi.keys[i - 1]]
      last_value = bpi[bpi.keys[i]]
      [
        Date.parse(data).strftime('%d/%m/%y'),
        value.round(2),
        i.zero? ? '0.00' : coin_valorization(first_value, last_value),
        i.zero? ? '0.00' : coin_variation(first_value, last_value),
        i.zero? ? '' : coin_status(first_value, last_value)
      ]
    end
  end
end
