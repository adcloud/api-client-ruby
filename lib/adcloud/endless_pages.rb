module EndlessPages
  extend ActiveSupport::Concern

  module ClassMethods

    def endless_pages(opts = {}, &block)
      @endpoint_url = opts[:endpoint_url] ||= self.endpoint_url
      if not @endpoint_url
        raise "You must define an endpoint_url attr or pass endpoint_url into .pages(endpoint_url: 'http://www.example.com')"
      end
      @params = opts[:params] ||= {}
      @connection = opts[:connection] ||= Adcloud::Connection.new
      perform(&block)
    end

    def perform(&block)
      paged_items = []

      page = @params[:page] ||= 0
      total_pages = @params[:total_pages] ||= 1
      retry_count = @params[:retry_count] ||= 0
      page_result = @params[:page_result] ||= nil

      begin
        begin
          page += 1
          raw_result = @connection.get(@api_endpoint, @params)
          total_pages = raw_result['_meta']['total_pages']

          page_result = self.new(raw_result) # your service class needs to include Virtus
          # if a block is provided then start returning results right away
          page_result.items.each do |item|
            block.call(item)
          end if block
          paged_items += page_result.items

        rescue => ex
          retry if retry_count < 5
        end
      end while page < total_pages
      page_result.items = paged_items
      page_result
    end

  end
end
