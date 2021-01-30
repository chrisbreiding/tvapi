module Source
  require "open-uri"
  require "json"

  @@jwt = nil

  def self.request(url)
    api_key = ENV["source_api_key_v3"]
    throw "No API Key provided for thetvdb" unless api_key

    unless @@jwt
      login()
    end

    make_request(url)
  end

  def self.base_url
    "https://thetvdb.com/"
  end

  def self.api_url
    "https://api.thetvdb.com/"
  end

  private

  def self.login_url
    "#{api_url}login"
  end

  def self.login()
    body = {
      "apikey" => ENV["source_api_key_v3"],
      "userkey" => ENV["source_userkey"],
      "username" => ENV["source_username"]
    }.to_json

    uri = URI.parse(login_url)
    headers = {
      "Content-Type" => "application/json",
      "Accept" => "application/json"
    }
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, headers)
    request.body = body

    response = http.request(request)

    @@jwt = JSON.parse(response.body)["token"]
  end

  def self.make_request(url, attempt = 0)
    unless @@jwt
      print("Can not make request, no JWT")

      return
    end

    open(
      URI.escape(url),
      "Accept" => "application/json",
      "Authorization" => "Bearer #{@@jwt}",
    ) do |response|
      return { "data" => [] } if attempt > 10

      status = response.status[0]

      if status == "401"
        login()

        return make_request(url, attempt + 1)
      end

      return JSON.parse(response.read)
    end
  end

end
