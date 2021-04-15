# frozen_string_literal: true

require_relative 'api'
require_relative 'cotation_table'
require_relative 'resume_table'

# Bitcoin class
class Bitcoin
  extend Api

  days_to_show = ARGV[0] ? ARGV[0].split('=')[1].to_i : 7

  end_date = Date.today.strftime('%Y-%m-%d')
  start_date = (Date.today - days_to_show).strftime('%Y-%m-%d')

  data = get_cotation(start_date, end_date)['bpi']

  resume_table = ResumeTable.new(data)

  cotation_table = CotationTable.new(data, days_to_show)

  puts ''
  puts cotation_table.render
  puts ''
  puts resume_table.render
end
