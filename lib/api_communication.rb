class ApiCommunication

  def self.check_status(code)
    unless code.to_i == 200
      raise "Sem conexão com o servidor no momento."
    end
  end
end
