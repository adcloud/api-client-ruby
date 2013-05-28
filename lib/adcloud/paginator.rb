module Adcloud
  class Paginator

    def initialize(endpoint_url, opts = {})
      @endpoint_url = endpoint_url
      @params = opts[:params] ||= {}
      @connection = opts[:connection] ||= Connection.new
    end

    def perform
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
          page_result = self.new(raw_result)
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