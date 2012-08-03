module Adcloud
  
  class Advertisement < Adcloud::Entity
    attr_accessor :errors

    attribute :id, Integer
    attribute :product_id, Integer
    attribute :type, String
    attribute :advertisement_design_id, Integer
    attribute :target_url, String
    attribute :name, String
    attribute :logo, Boolean
    attribute :image_text, Boolean
    attribute :flash, Boolean
    attribute :display, Boolean
    attribute :tag, Boolean
    attribute :postview_type, Integer
    attribute :tag_html, String
    attribute :image_alt, String
    attribute :text_headline, String
    attribute :text_body, String
    attribute :text_link, String
    attribute :postview_url, String
    attribute :keywords, Array
    attribute :exclusion_keywords, Array
    attribute :machine_keywords, Array
    attribute :locations, Array
    attribute :modified, DateTime
    attribute :created, DateTime
    attribute :_meta, Hash

    def errors
      @errors ||= []
    end

    def self.all(params = {}, page = 1, per_page = 50)
      result = connection.get("advertisements", :filter => params, :page => page, :per_page => :per_page)
      result["items"].map {| raw_advertisement | Advertisement.new(raw_advertisement) }
    end

    def self.find(id)
      result = connection.get("advertisements/#{id}")
      Advertisement.new(result)
    end

    def self.create(params={})
      result = connection.post("advertisements", params)
      result
    end

    # def validate(params={})
    #   result = connection.get("advertisements/validate", :advertisement => params)
    #   result
    # end

  end
end
