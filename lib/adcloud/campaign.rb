module Adcloud
  
  campaign_attributes = [
    :id,
    :bidding_enabled, #x
    :name, #x
    :customer_id,
    :company_id, 
    :company_name,
    :product_id, #x
    :product_name,
    :status, #x
    :language_id, #x
    :start_date, #x
    :end_date, #x
    :delivery_boost, #x
    :frequency_capping, #x
    :frequency_capping_days, #x
    :cookie_lifetime, #x
    :cookie_lifetime_view, #x
    :fallback, #x
    :keywords, #x
    :exclusion_keywords, #x
    :keyword_lifetime, #x
    :comment, #x
    :bookkeeping_reference, #x
    :budget_limit, #x
    :unit_price_maximum, #x
    :locations, #x
    :type, #x
    :delivery_external, #x
    :delivery_internal, #x
    :delivery_type, #x
    :deactivated_on, #x
    :modified, #x
    :created, #x
    # :discount, # missing 
    # :limit_allowed, # missing
    # :fixed_price, # missing
    # :external_link, # missing
    # :mobile_targeting, # missing
  ]

  class Campaign < Struct.new(*campaign_attributes)

    attr_accessor :errors

    def errors
      @errors ||= {}
    end

    # Should we have a method that validates attributes of an object ?
    # campaign = Adcloud::Campaign.new({:name => 'meine campagnie', :produkt_name => 'schuhe', :budget => 100})
    # campaign.valid_attributes({:name => 'meine campagnie', :produkt_name => 'schuhe'})
    # Returns: true/false
    #
    #   false: campaign.errors => [:produkt_name => {false, msg}, :name => {false, msg}]
    #   true: campaign.errors => []
    #
    # def valid_attributes(attr = {})
    #   # ....
    # end

    # Validates the whole object
    def valid?
      # status = Adcloud::HttpClient.post('validate_campaign', self.campaign_attributes)
      # response = case status.code 
      # when 200
      #   true
      # else 442 # request contains inacceptable advertisement attributes
      #   self.errors = JSON.parse(response.body)
      #   false
      # end
    end

    def create
      # status = Adcloud::HttpClient.post('create_campaign', self.campaign_attributes)
      # response = case status.code 
      # when 201
      #   true
      # else 442 # request contains inacceptable advertisement attributes
      #   self.errors = JSON.parse(response.body)
      #   false
      # end
    end

  end
end
