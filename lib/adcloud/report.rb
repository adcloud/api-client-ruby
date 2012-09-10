module Adcloud
  class Report
    include Virtus

    attribute :_meta, Hash
    attribute :items, Array[Adcloud::ReportEntry]

    class << self
      attr_accessor :api_endpoint, :connection

      def find_by_date(date)
        result = connection.get(self.api_endpoint, { filter: { date: date.to_s } })
        return self.new(result)
      end

      def api_endpoint
        @api_endpoint ||= self.name.demodulize.tableize
      end

      def connection
        @connection ||= Connection.new
      end
    end

    # Define this after class methods are added
    self.api_endpoint = 'reports/advertiser'
  end
end