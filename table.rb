# frozen_string_literal: true

require 'terminal-table'

require_relative 'coin'

# Tabela
class Table
  def initialize(title, headings, data, align = nil)
    @title = title
    @headings = headings
    @rows = generate_rows(data)
    @align = align
  end

  def render
    table = Terminal::Table.new
    table.title = @title
    table.headings = @headings
    table.rows = @rows

    align_table(table)
  end

  private

  # Align columns to center and left
  def align_table(table)
    @align.each_key do |key|
      @align[key.to_sym].each { |x| table.align_column(x, key.to_sym)}
    end

    table
  end

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
