module Adcloud
  class Campaign < Adcloud::Entity
    TYPES = {
      cpc: 2,
      cpx: 3,
      cpx_plus: 4,
      cpm: 5,
      fixed_daily_costs: 6
    }

    DELIVERY_TYPES = {
      topic: 1,
      channel: 2
    }

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
    attribute :budget_limit_today, Float
    attribute :budget_limit_allowed, Boolean
    attribute :unit_price_maximum, Float
    attribute :locations, Array
    attribute :type, Integer
    attribute :topic_ids, Array
    attribute :delivery_external, Boolean
    attribute :delivery_internal, Boolean
    attribute :delivery_type, Integer
    attribute :deactivated_on, DateTime
    attribute :options, Hash
    attribute :has_end_date, Boolean
    attribute :modified, DateTime
    attribute :created, DateTime

    # @return [void] Validate the campaign against the api
    def validate
      result = connection.get('campaigns/validate', { campaign: self.attributes_for_create })
      if result && result["_meta"] && result["_meta"]["status"] == 226
        @errors = self.errors.merge(result["_meta"]["details"])
      else
        raise AdcloudSucks::InvalidApiResponse.new('Empty response for campaign validation')
      end
    end

    def request_approval!
      result = connection.put("campaigns/#{self.id}/request_approval")
      result && result["_meta"] && result["_meta"]["status"] == 200 || false
    end

    def end!
      result = connection.put("campaigns/#{self.id}/end")
      result && result["_meta"] && result["_meta"]["status"] == 200 || false
    end

    def offer!
      result = connection.put("campaigns/#{self.id}/offer")
      result && result["_meta"] && result["_meta"]["status"] == 200 || false
    end

    # @return [Boolean] True when campaign is valid - otherwise false
    def valid?
      self.validate
      self.errors.empty?
    end
  end
end