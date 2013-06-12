module EndlessPages
  extend ActiveSupport::Concern

  module ClassMethods

    def endless_pages(opts = {}, &block)
      @opts = opts
      perform(&block)
    end

    def conn
      @opts[:connection] ||= Adcloud::Connection.new
    end

    def endpoint
      @opts[:endpoint_url] ||= self.endpoint_url
      raise "You must either pass endpoint_url into endless_pages OR define a class method .endpoint_url" unless @opts[:endpoint_url]
      @opts[:endpoint_url]
    end

    def params
        @opts[:params] ||= {}
    end

    def perform(&block)
      paged_items = []

      page = params[:page] ||= 1
      page = 1 if page == 0

      total_pages = 1
      retry_count = 0
      page_result = params[:page_result] ||= []

      begin
        Adcloud::logger.debug "Page: #{page}"

        params[:page] = page

        raw_result = conn.get(endpoint, params)
        total_pages = raw_result['_meta']['total_pages']
        Adcloud::logger.debug "total_pages: #{total_pages}"
        page_result = self.new(raw_result) # your service class needs to include Virtus
        # if a block is provided then start returning results right away
        page_result.items.each do |item|
          block.call(item)
        end if block

        paged_items += page_result.items
        page += 1
      rescue => ex
        if retry_count <= 5
          retry
        else
          Adcloud.logger.error { "API Exception #{ex}" }
          raise ApiError, "Connection failed"
        end
        retry_count += 1
      end while page <= total_pages
      Adcloud::logger.debug "Items: #{paged_items.length}"
      paged_items
    end

  end
end
