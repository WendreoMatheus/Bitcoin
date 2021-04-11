# frozen_string_literal: true

require 'rest-client'
require 'json'

# Api Module
module Api
  def get_cotation(start_date, end_date)
    url = 'https://api.coindesk.com/v1/bpi/historical/close.json'
    params = "?start=#{start_date}&end=#{end_date}"

    response = RestClient.get "#{url}#{params}", {
      content_type: :json,
      accept: :json
    }

    JSON.parse(response.body)
  end
end
