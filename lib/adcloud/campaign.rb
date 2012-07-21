module Adcloud

  class Campaign < Adcloud::Entity

    attr_accessor :errors

    # field :id
    # field :bidding_enabled
    # field :name
    # field :customer_id
    # field :company_id
    # field :company_name
    # field :product_id
    # field :product_name
    # field :status
    # field :language_id
    # field :start_date
    # field :end_date
    # field :delivery_boost
    # field :frequency_capping
    # field :frequency_capping_days
    # field :cookie_lifetime
    # field :cookie_lifetime_view
    # field :fallback
    # field :keywords
    # field :exclusion_keywords
    # field :keyword_lifetime
    # field :comment
    # field :budget_limit
    # field :budget_limit_allowed
    # field :unit_price_maximum
    # field :locations
    # field :type
    # field :delivery_external
    # field :delivery_internal
    # field :delivery_type
    # field :deactivated_on
    # field :modified
    # field :created

    # field :fixed_price, # missing
    # field :mobile_targeting, # missing

    def errors
      @errors ||= []
    end

    def self.all(filter_params={})
      response = connection.get("campaigns", :filter => filter_params)
      if response.success?
        JSON.parse(response.body)["items"].map do |raw_campaign|
          raw_campaign
        end
      elsif response.status == 400
        raise InvalidFilter.new(JSON.parse(response.body)["_meta"])
      else
        raise InvalidRequest.new(JSON.parse(response.body)["_meta"])
      end
    end

    def self.find(id)
      response = connection.get("campaigns/#{id}")
      if response.success?
        # Campaign.new(JSON.parse(response.body))
        JSON.parse(response.body)
      elsif response.status == 404
        raise NotFound.new(JSON.parse(response.body)["_meta"])
      else
        raise InvalidRequest.new(JSON.parse(response.body)["_meta"])
      end
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
