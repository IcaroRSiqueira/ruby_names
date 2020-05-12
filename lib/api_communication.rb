class ApiCommunication

  def self.check_status(code)
    unless code.to_i == 200
      raise "Sem conexão com o servidor no momento."
    end
  end

  def self.get_response(url)
    uri = URI.parse(URI.escape(url))
    response = Net::HTTP.get_response(URI.parse(URI.escape(url)))
    ApiCommunication.check_status(response.code)
    JSON.parse(response.body, symbolize_names: true)
  end
end
