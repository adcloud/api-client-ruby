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

    def meta
      self._meta
    end

    def errors
      @errors ||= []
    end

    def self.all(params={})
      result = connection.get("campaigns", :filter => params)
      result["items"].map {| raw_campaign | Campaign.new(raw_campaign) }
    end

    def self.find(id)
      result = connection.get("campaigns/#{id}")
      Campaign.new(result)
    end

    def self.create(params={})
      result = connection.post("campaigns", params)
      result
    end

    def self.validate(params={})
      result = connection.get("validate", :campaign => params)
      result
    end

  end
end
