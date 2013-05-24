module Adcloud
  class Report
    include Virtus

    attribute :_meta, Hash
    attribute :items, Array[Adcloud::ReportEntry]

    class << self
      attr_accessor :api_endpoint, :connection

      def find_by_date(date)
        result = connection.get(self.api_endpoint, { filter: { date: date.to_s }, new_backend: true })
        return self.new(result)
      end

      def find_all_by_date(date, booking_ids=[])
        paged_items = []
        total_pages = 1
        retry_count = 0
        page_result = nil
        status = 200

        page = 0
        begin
          page += 1
          search_params = { filter: { date: date.to_s }, page: page, per_page: Entity::MAX_PER_PAGE, new_backend: true }
          if booking_ids
            search_params[:filter][:booking_id] = booking_ids
            search_params[:new_backend] = false
          end

          raw_result = connection.get(self.api_endpoint, search_params)

          total_pages = raw_result['_meta']['total_pages']
          page_result = self.new(raw_result)
          paged_items += page_result.items
        rescue => ex
          if retry_count < 5
            retry
          else
            status = 501
            paged_items = []
          end
          retry_count += 1
        end while page < total_pages

        page_result = self.new({_meta: {}, items: []}) if page_result.nil?
        page_result._meta[:status] = status
        page_result.items = paged_items
        page_result
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