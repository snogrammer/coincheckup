# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'
require 'coincheckup/version'
require 'http'
require 'nokogiri'

class CoinCheckup
  BASE_URL = 'https://coincheckup.com'
  BASE_VERSION = '201802131829'
  DATA_URL = "#{BASE_URL}/data/prod"

  class << self
    # @param coin_id [String] coincheckup.com Coin id
    # @return [Hash] Coin analysis information
    # @see https://coincheckup.com/data/prod/201802101711/assets/bitcoin.json
    def analysis(coin_id)
      url = "#{DATA_URL}/#{data_version}/assets/#{coin_id}.json"
      resp = HTTP.get(url)
      j = JSON.parse(resp.body.to_s)
      json = j.deep_transform_keys(&:underscore).deep_symbolize_keys
      json[:code] = resp.code
      json[:data_version] = data_version
      json
    rescue StandardError
      {
        code: 404,
        error: 'Not Found',
        message: "invalid coin_id: #{coin_id}"
      }
    end

    def categories
      url = "#{DATA_URL}/#{data_version}/categories-tags.json"
      resp = HTTP.get(url)
      j = JSON.parse(resp.body.to_s)

      assets = j.each_with_object([]) do |(k, v), arr|
        v.deep_symbolize_keys!
        v[:id] = v[:type]
        v[:type] = k
        v[:count] = v[:coins].count
        arr << v
      end

      {
        code: resp.code,
        count: j.count,
        data_version: data_version,
        categories: assets
      }
    end

    private

    # Returns data version for queries
    # @note defaults to BASE_VERSION if version cannot be found
    # @return [String] @@data_version
    def data_version
      @@data_version ||= (latest_version(BASE_VERSION).presence || BASE_VERSION)
    end

    # Extract latest data version from html
    # @param version [String] Prod data version
    # @return [String] Latest prod data version used for json requests
    def latest_version(version)
      time = parse_time(version)
      return version if time&.today?

      resp = HTTP.get(BASE_URL)
      html = Nokogiri::HTML(resp.body.to_s)
      data_uri = html.css('head script:contains("DATA_URI")')&.text[/var DATA_URI \= \'(.+)\'/, 1]
      new_version = data_uri[/prod\/(.+)\//, 1]
      new_version.presence || version
    end

    # Data version check
    # @return [Boolean] Returns true if @@data_version is today
    def current_data_version?
      Time.parse(@@data_version).today?
    end

    # Returns parsed timestamp
    # @param time [String]
    # @return [Time] Returns Time object or nil
    def parse_time(time)
      Time.parse(time)
    rescue StandardError
      nil
    end
  end # self
end
