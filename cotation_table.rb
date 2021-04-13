# frozen_string_literal: true

require_relative 'coin'
require_relative 'table'

# Tabela de Cotacao
class CotationTable < Table
  def initialize(title, headings, rows, align)
    super(title, headings, generate_rows(rows), align)
  end

  private

  def generate_rows(bpi)
    extend Coin

    bpi.map.with_index do |(data, value), i|
      [
        Date.parse(data).strftime('%d/%m/%y'),
        "$#{value.to_f}",
        coin_valorization(bpi, bpi.keys, i),
        coin_variation(bpi, bpi.keys, i),
        coin_status(bpi, bpi.keys, i)
      ]
    end
  end
end
