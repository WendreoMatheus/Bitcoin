# frozen_string_literal: true

require_relative 'coin'

# Tabela de resumo
class ResumeTable < Table
  attr_accessor :first_value, :last_value

  def initialize(data)
    title = 'Resumo do Periodo'
    align = { center: [0], right: [1, 2, 3, 4, 5, 6] }
    headings = ['Status', 'Valor Inicial($)', 'Valor Final($)', 'Maior Valor($)',
                'Menor Valor($)', 'Variação (%)', 'Valorização ($)']
    first_value = data.values.first
    last_value = data.values.last

    super(title, headings, generate_data(data, first_value, last_value), align)
  end

  def generate_data(data, first_value, last_value)
    extend Coin
    [[
      coin_status(first_value, last_value),
      first_value,
      last_value,
      biggest_value(data),
      lowest_value(data),
      coin_variation(first_value, last_value),
      coin_valorization(first_value, last_value)
    ]]
  end
end
