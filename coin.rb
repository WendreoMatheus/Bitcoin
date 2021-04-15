# frozen_string_literal: true

require 'colorize'

# Modulo das moedas
module Coin
  def coin_status(bpi, keys, index)
    return '' if index.zero?

    bpi[keys[index]] > bpi[keys[index - 1]] ? '🡅'.green : '🡇'.red
  end

  def coin_variation(bpi, keys, index)
    return '0.00' if index.zero?

    total = (bpi[keys[index]] - bpi[keys[index - 1]]).round(2)
    total.positive? ? "+#{total}".green : total.to_s.red
  end

  def coin_valorization(bpi, keys, index)
    return '0' if index.zero?

    current  = bpi[keys[index]]
    previous = bpi[keys[index - 1]]

    total = (((current * 100) / previous) - 100).round(2)
    total.positive? ? "+#{total}".green : total.to_s.red
  end
end
