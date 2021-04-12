# frozen_string_literal: true

require 'colorize'

# Modulo das moedas
module Coin
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
end
