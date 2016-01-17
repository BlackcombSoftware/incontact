require 'httparty'
require 'faraday'
require 'base64'
require 'json'

module InContactApi
  class Connection
    class << self
      def setup
        conn = Faraday.new(:url => Configs.url) do |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
      end

      def authorization
        response = setup.post do |req|
          req.url '/InContactAuthorizationServer/Token'
          req.headers["accept-encoding"] = "none"
          req.headers["Content-Type"]  = "application/json; charset=utf-8"
          req.headers["Authorization"] = "basic #{Configs.key}"
          req.body = Configs.request_body
        end
        result = JSON.parse(response.body)
        token = result["access_token"]

        {:uri => result["resource_server_base_uri"], :token => token}
      end

      def base
        api_conn = Faraday.new(:url => authorization[:uri]) do |faraday|
          faraday.headers["accept-encoding"] = "none"
          faraday.headers["Authorization"] = "bearer #{authorization[:token]}"
          faraday.headers["Content-Type"]  ="application/x-www-form-urlencoded"
          faraday.headers["Data-Type"] = "json"
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
      end
    end
  end

  class Configs
    class << self
      def url
        ENV["IC_API_TOKEN_URL"] || "https://api.incontact.com"
      end

      def key
        application_name = ENV["IC_APPLICATION_NAME"].gsub("\n", "")
        vendor = ENV["IC_VENDOR_NAME"].gsub("\n", "")
        unit = ENV["IC_BUSINESS_UNIT"].gsub("\n", "")
        Base64.encode64("#{application_name}@#{vendor}:#{unit}").gsub("\n", "")
      end

      def request_body
        body = {
          grant_type: ENV["IC_GRANT_TYPE"] || 'password',
          username: ENV["IC_USERNAME"],
          password: ENV["IC_PASSWORD"],
          scope: ENV["IC_SCOPE"] || ''
        }.to_json
        body.to_s
      end
    end
  end
end
