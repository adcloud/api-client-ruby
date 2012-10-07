module Adcloud

  class Entity
    include Virtus

    MAX_PER_PAGE = 200

    attr_accessor :errors

    attribute :_meta, Hash

    def connection
      self.class.connection
    end

    def meta
      self._meta
    end

    # @return [Boolean] True when successfully created - otherwise false
    def create
      result = connection.post(self.class.api_endpoint, { self.class.api_name => attributes_for_create })
      if self.respond_to?(:id=) && !result['id'].nil?
        self.id = result['id']
      end
      true
    rescue Adcloud::BadRequestError => ex
      derive_errors_from_error(ex)
      false
    end

    class << self
      attr_accessor :api_endpoint, :connection

      def api_endpoint
        @api_endpoint ||= self.name.demodulize.tableize
      end

      def api_name
        self.name.demodulize.underscore
      end

      def connection
        @connection ||= Connection.new
      end

      # @return [Array] Entities matching the criteria or all
      def all(filter = {}, page = 1, per_page = 50)
        result = connection.get(self.api_endpoint, :filter => filter, :page => page, :per_page => per_page)
        yield result['_meta'] if block_given?
        result["items"].map { |raw_campaign| self.new(raw_campaign) }
      end

      # fetches all objects via pagination. Be careful, this could be a lot!
      def all!(filter = {})
        result = []
        page = 0
        total_pages = 1
        begin
          page += 1
          result += self.all(filter, page, MAX_PER_PAGE) { |meta_data| total_pages = meta_data['total_pages'] }
        end while page < total_pages
        result
      end

      # @return [Object] The entity with the unique identifier
      def find(id)
        result = connection.get("#{self.api_endpoint}/#{id}")
        self.new(result)
      end

      # @return [Enitity] Object has errors when creation failed
      def create(params = {})
        entity = self.new(params)
        entity.create
        entity
      end
    end

    # @return [Hash] Errors hash
    def errors
      @errors || {}
    end

    protected

    # Set the campaign errors from the api response
    def derive_errors_from_error(error)
      @errors = self.errors.merge(error.details)
    end

    # @return [Hash] Attributes without those required for campaign creation
    def attributes_for_create
      self.attributes.reject { |i| [:id, :_meta].include?(i) }
    end

  end

end