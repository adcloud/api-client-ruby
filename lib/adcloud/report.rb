module Adcloud
  
  class Base

    def connection
      # @connection ||= Connection.new(....)
    end

  end

  class Report < Base

    def find(id)
      # connection.get("/reports/", :id => id)
    end
    
  end
end
