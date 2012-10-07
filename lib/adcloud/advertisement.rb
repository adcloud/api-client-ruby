module Adcloud
  class Advertisement < Adcloud::Entity
    attribute :id, Integer
    attribute :product_id, Integer
    attribute :campaign_id, Integer
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
  end
end
