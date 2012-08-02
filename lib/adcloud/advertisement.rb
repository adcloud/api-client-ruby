module Adcloud
  
  class Advertisement < Adcloud::Entity

    attribute :id
    attribute :product_id
    attribute :type
    attribute :advertisement_design_id
    attribute :target_url
    attribute :name
    attribute :logo
    attribute :image_text
    attribute :flash
    attribute :display
    attribute :tag
    attribute :postview_type
    attribute :tag_html
    attribute :image_alt
    attribute :text_headline
    attribute :text_body
    attribute :text_link
    attribute :postview_url
    attribute :keywords
    attribute :exclusion_keywords
    attribute :machine_keywords
    attribute :locations
    attribute :modified
    attribute :created
    attribute :_meta

    def errors
      @errors ||= []
    end

    def self.all(params={})
      result = connection.get("campaigns", :filter => params)
      result["items"].map {| raw_advertisement | Advertisement.new(raw_advertisement) }
    end

    def self.find(id)
      result = connection.get("advertisements/#{id}")
      Campaign.new(result)
    end

    def self.create(params={})
      result = connection.post("advertisements", params)
      result
    end

  end
end
