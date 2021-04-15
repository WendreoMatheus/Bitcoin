# frozen_string_literal: true

require 'colorize'

# Modulo das moedas
module Coin
  def coin_status(first, last)
    last > first ? '🡅'.green : '🡇'.red
  end

  def coin_variation(first, last)
    format_value(last - first)
  end

  def coin_valorization(first, last)
    total = (((last * 100) / first) - 100)
    format_value(total)
  end

  def biggest_value(data)
    value = data.values.first

    data.each_value { |x| value = x > value ? x : value }

    value.round(2).to_s
  end

  def lowest_value(data)
    value = data.values.first

    data.each_value { |x| value = x < value ? x : value }

    value.round(2).to_s
  end

  def format_value(value)
    value.positive? ? "+#{value.round(2)}".green : value.round(2).to_s.red
  end
end
