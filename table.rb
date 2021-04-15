# frozen_string_literal: true

require 'terminal-table'

require_relative 'coin'

# Tabela
class Table
  def initialize(title, headings, rows, align = nil)
    @title = title
    @headings = headings
    @rows = rows
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
    return table if @align.nil?

    @align.each_key do |key|
      @align[key.to_sym].each { |x| table.align_column(x, key.to_sym) }
    end

    table
  end
end
