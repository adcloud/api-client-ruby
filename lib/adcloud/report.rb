module Adcloud
  class Report
    include Virtus
    include EndlessPages

    attribute :_meta, Hash
    attribute :items, Array[Adcloud::ReportEntry]

    class << self
      attr_accessor :api_endpoint, :connection

      def find_by_date(date)
        result = connection.get(self.api_endpoint, { filter: { date: date.to_s }, new_backend: true })
        return self.new(result)
      end

      def find_all_by_date(date, booking_ids=[])
        params = { filter: { date: date.to_s }, :per_page => Entity::MAX_PER_PAGE, new_backend: true }

        if booking_ids
          params[:filter][:booking_id] = booking_ids
          params[:new_backend] = false
        end

        endless_pages(endpoint_url: self.api_endpoint, params: params)
      end

      def api_endpoint
        @api_endpoint ||= self.name.demodulize.tableize
      end

    end

    # Define this after class methods are added
    self.api_endpoint = 'reports/advertiser'
  end
end