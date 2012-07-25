module Adcloud

  class Entity
    include Virtus

    def self.connection
      @connection ||= Connection.new
    end

    def connection
      self.class.connection
    end

  end

end