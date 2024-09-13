class AuAbnClient
  require 'net/http'

  def initialize(tin)
    @base_uri = 'http://localhost:8080'
    @tin = tin
  end

  def validate
    get("/queryABN", query: { abn: @tin })
  end

  private

  def get(path, query: {})
    send_request(Net::HTTP::Get, path, query: query)
  end

  def send_request(klass, path, body: {}, query: {})
    uri = URI("#{@base_uri}#{path}")
    uri.query = URI.encode_www_form(query) if query.present?

    https = Net::HTTP.new(uri.host, uri.port)
    https.read_timeout = 180

    headers = {'Content-Type' => 'application/json' }

    request = klass.new(uri.request_uri, headers)
    response = https.request(request)

    if response.code == "200"
      { body: response.body, error: nil }
    elsif response.code == "404"
      { body: response.body, error: 'business is not registered' }
    elsif response.code == "500"
      { body: response.body, error: "registration API could not be reached"}
    else
      { body: response.body, error: "unknown error"}
    end
  end
end
