module Adcloud

  class Entity

    def self.connection
      @connection ||= Connection.new
    end

    def connection
      self.class.connection
    end

  end

end