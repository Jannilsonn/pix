require 'dotenv/load'
require 'faraday'
require 'faraday_middleware'

class Client
  class << self
    def post(path:, params:)
      errors = verify_data(path, params)
      return errors unless errors[:errors].empty?

      api_request('post', path, params)
    end

    private

    def api_request(method, path, params)
      url = "#{api_uri}/#{path}"

      connection.send(method, url, params, headers)
    end

    def connection
      Faraday.new(api_uri) do |f|
        f.request :json
        f.response :json
        f.adapter :net_http
      end
    end

    def headers
      { 'Authorization' => "Bearer #{ENV['API_TOKEN']}" }
    end

    def api_uri
      "#{ENV['API_BASE_URL']}/#{ENV['API_VERSION']}"
    end

    def verify_data(path, params)
      errors = { errors: [] }
      
      errors[:errors] << "path can't be blank" if path.empty?
      errors[:errors] << "params can't be blank" if params.empty?

      errors
    end
  end
end