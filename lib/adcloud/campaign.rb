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

    def errors
      @errors ||= {}
    end

    def self.all(filter = {}, page = 1, per_page = 50)
      result = connection.get("campaigns", :filter => filter, :page => page, :per_page => per_page)
      result["items"].map {| raw_campaign | Campaign.new(raw_campaign) }
    end

    def self.find(id)
      result = connection.get("campaigns/#{id}")
      Campaign.new(result)
    end

    def self.create(params = {})
      campaign = Campaign.new(params)
      campaign.create
      campaign
    end

    def create
      clean_attributes = self.attributes
      clean_attributes.delete(:id)
      clean_attributes.delete(:_meta)
      result = connection.post("campaigns", { :campaign => clean_attributes })
      self.id = result["id"]
      true
    rescue Adcloud::BadRequestError => exception
      @errors = self.errors.merge(exception.details)
      false
    end

    def validate
      result = connection.get("campaigns/validate", self.attributes)
      @errors = self.errors.merge(result["_meta"]["details"]) if result["_meta"]["status"] == 226
    end

    def valid?
      self.validate
      self.errors.empty? 
    end

  end
end
