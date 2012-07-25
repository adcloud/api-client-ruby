module Adcloud

  class Campaign < Adcloud::Entity
    attr_accessor :errors

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
    attribute :start_date, DateTime
    attribute :end_date, DateTime
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
      @errors ||= []
    end

    def self.all(filter_params={})
      result = connection.get("campaigns", :filter => filter_params)
      result["items"].map {| raw_campaign | Campaign.new(raw_campaign) }
    end

    def self.find(id)
      result = connection.get("campaigns/#{id}")
      Campaign.new(result)
    end

    # def create
    #   status = Adcloud::HttpClient.post('create_campaign', self.campaign_attributes)
    #   response = case status.code 
    #   when 201
    #     true
    #   else 442 # request contains inacceptable advertisement attributes
    #     self.errors = JSON.parse(response.body)
    #     false
    #   end
    # end
    
    # Should we have a method that validates attributes of an object ?
    # campaign = Adcloud::Campaign.new({:name => 'meine campagnie', :produkt_name => 'schuhe', :budget => 100})
    # campaign.valid_attributes({:name => 'meine campagnie', :produkt_name => 'schuhe'})
    # Returns: true/false
    #
    #   false: campaign.errors => [:produkt_name => {false, msg}, :name => {false, msg}]
    #   true: campaign.errors => []
    #
    # def validate_attributes(attr = {})
    #   c = Campaign.new(attr)
    #   unless c.valid?
    #     c.errors.each do |e|
    #        e.keys
    #     end
    #   end
    # end

    # Validates the whole object
    # def valid?
    #   status = Adcloud::HttpClient.post('validate_campaign', self.campaign_attributes)
    #   response = case status.code 
    #   when 200
    #     true
    #   else 442 # request contains inacceptable advertisement attributes
    #     self.errors = JSON.parse(response.body)
    #     false
    #   end
    # end

  end
end
