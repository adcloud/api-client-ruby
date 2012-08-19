module Adcloud

  class Campaign < Adcloud::Entity
    attr_accessor :errors

    attribute :_meta, Hash
    attribute :id, Integer
    attribute :bidding_enabled, Boolean
    attribute :name, String
    attribute :customer_id, Integer
    attribute :company_id, Integer
    attribute :company_name, String
    attribute :product_id, Integer
    attribute :product_name, String
    attribute :status, Integer
    attribute :language_id, Integer
    attribute :start_date, Date
    attribute :end_date, Date
    attribute :delivery_boost, Float
    attribute :frequency_capping, Integer
    attribute :frequency_capping_days, Integer
    attribute :cookie_lifetime, Integer
    attribute :cookie_lifetime_view, Integer
    attribute :fallback, Boolean
    attribute :keywords, String
    attribute :exclusion_keywords, Array
    attribute :keyword_lifetime, Integer
    attribute :comment, String
    attribute :budget_limit, Float
    attribute :budget_limit_allowed, Boolean
    attribute :unit_price_maximum, Float
    attribute :locations, Array
    attribute :type, Integer
    attribute :delivery_external, Boolean
    attribute :delivery_internal, Boolean
    attribute :delivery_type, Integer
    attribute :deactivated_on, DateTime
    attribute :modified, DateTime
    attribute :created, DateTime
    # attribute :fixed_price, # missing
    # attribute :mobile_targeting, # missing


    #
    # Static class methods
    #

    # @return [Array<Campaign>] Campaigns matching the criteria or all
    def self.all(filter = {}, page = 1, per_page = 50)
      result = connection.get("campaigns", :filter => filter, :page => page, :per_page => per_page)
      result["items"].map {| raw_campaign | Campaign.new(raw_campaign) }
    end

    # @return [Campaign] The campaign with the unique identifier
    def self.find(id)
      result = connection.get("campaigns/#{id}")
      Campaign.new(result)
    end

    # @return [Campaign] Object has errors when creation failed
    def self.create(params = {})
      campaign = Campaign.new(params)
      campaign.create
      campaign
    end


    #
    # Instance methods
    #

    # @return [Hash] Errors hash
    def errors
      @errors ||= {}
    end

    # @return [Boolean] True when successfully created - otherwise false
    def create
      result = connection.post('campaigns', { :campaign => attributes_for_create })
      self.id = result['id']
      true
    rescue Adcloud::BadRequestError => ex
      derive_errors_from_error(ex)
      false
    end

    # @return [void] Validate the campaign against the api
    def validate
      result = connection.get("campaigns/validate", self.attributes)
      if result && result["_meta"] && result["_meta"]["status"] == 226
        @errors = self.errors.merge(result["_meta"]["details"])
      else
        raise AdcloudUnknownAPIError::InvalidApiResponse.new('Empty repsonse for campaign validation')
      end
    end

    # @return [Boolean] True when campaign is valid - otherwise false
    def valid?
      self.validate
      self.errors.empty?
    end


    private

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
